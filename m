From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v3 1/1] ceph: parallelize all copy-from requests in copy_file_range
Date: Tue, 4 Feb 2020 11:56:57 +0100
Message-ID: <CAOi1vP8vXeY156baexdZY2FWK_F0jHfWkyNdZ90PA+7txG=Qsw@mail.gmail.com>
References: <20200203165117.5701-1-lhenriques@suse.com> <20200203165117.5701-2-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200203165117.5701-2-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 3, 2020 at 5:51 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Right now the copy_file_range syscall serializes all the OSDs 'copy-from'
> operations, waiting for each request to complete before sending the next
> one.  This patch modifies copy_file_range so that all the 'copy-from'
> operations are sent in bulk and waits for its completion at the end.  This
> will allow significant speed-ups, specially when sending requests for
> different target OSDs.
>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c                  | 45 +++++++++++++++++++++-----
>  include/linux/ceph/osd_client.h |  6 +++-
>  net/ceph/osd_client.c           | 56 +++++++++++++++++++++++++--------
>  3 files changed, 85 insertions(+), 22 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 1e6cdf2dfe90..b9d8ffafb8c5 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1943,12 +1943,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>         struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
>         struct ceph_object_locator src_oloc, dst_oloc;
>         struct ceph_object_id src_oid, dst_oid;
> +       struct ceph_osd_request *req;
>         loff_t endoff = 0, size;
>         ssize_t ret = -EIO;
>         u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
>         u32 src_objlen, dst_objlen, object_size;
>         int src_got = 0, dst_got = 0, err, dirty;
> +       unsigned int max_copies, copy_count, reqs_complete = 0;
>         bool do_final_copy = false;
> +       LIST_HEAD(osd_reqs);
>
>         if (src_inode->i_sb != dst_inode->i_sb) {
>                 struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
> @@ -2083,6 +2086,13 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>                         goto out_caps;
>         }
>         object_size = src_ci->i_layout.object_size;
> +
> +       /*
> +        * Throttle the object copies: max_copies holds the number of allowed
> +        * in-flight 'copy-from' requests before waiting for their completion
> +        */
> +       max_copies = (src_fsc->mount_options->wsize / object_size) * 4;
> +       copy_count = max_copies;
>         while (len >= object_size) {
>                 ceph_calc_file_object_mapping(&src_ci->i_layout, src_off,
>                                               object_size, &src_objnum,
> @@ -2097,7 +2107,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>                 ceph_oid_printf(&dst_oid, "%llx.%08llx",
>                                 dst_ci->i_vino.ino, dst_objnum);
>                 /* Do an object remote copy */
> -               err = ceph_osdc_copy_from(
> +               req = ceph_osdc_copy_from(
>                         &src_fsc->client->osdc,
>                         src_ci->i_vino.snap, 0,
>                         &src_oid, &src_oloc,
> @@ -2108,21 +2118,40 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>                         CEPH_OSD_OP_FLAG_FADVISE_DONTNEED,
>                         dst_ci->i_truncate_seq, dst_ci->i_truncate_size,
>                         CEPH_OSD_COPY_FROM_FLAG_TRUNCATE_SEQ);
> -               if (err) {
> -                       if (err == -EOPNOTSUPP) {
> -                               src_fsc->have_copy_from2 = false;
> -                               pr_notice("OSDs don't support 'copy-from2'; "
> -                                         "disabling copy_file_range\n");
> -                       }
> +               if (IS_ERR(req)) {
> +                       err = PTR_ERR(req);
>                         dout("ceph_osdc_copy_from returned %d\n", err);
> +
> +                       /* wait for all queued requests */
> +                       ceph_osdc_wait_requests(&osd_reqs, &reqs_complete);
> +                       ret += reqs_complete * object_size; /* Update copied bytes */

Hi Luis,

Looks like ret is still incremented unconditionally?  What happens
if there are three OSD requests on the list and the first fails but
the second and the third succeed?  As is, ceph_osdc_wait_requests()
will return an error with reqs_complete set to 2...

>                         if (!ret)
>                                 ret = err;

... and we will return 8M instead of an error.

>                         goto out_caps;
>                 }
> +               list_add(&req->r_private_item, &osd_reqs);
>                 len -= object_size;
>                 src_off += object_size;
>                 dst_off += object_size;
> -               ret += object_size;
> +               /*
> +                * Wait requests if we've reached the maximum requests allowed
> +                * or if this was the last copy
> +                */
> +               if ((--copy_count == 0) || (len < object_size)) {
> +                       err = ceph_osdc_wait_requests(&osd_reqs, &reqs_complete);
> +                       ret += reqs_complete * object_size; /* Update copied bytes */

Same here.

> +                       if (err) {
> +                               if (err == -EOPNOTSUPP) {
> +                                       src_fsc->have_copy_from2 = false;

Since EOPNOTSUPP is special in that it triggers the fallback, it
should be returned even if something was copied.  Think about a
mixed cluster, where some OSDs support copy-from2 and some don't.
If the range is split between such OSDs, copy_file_range() will
always return short if the range happens to start on a new OSD.

> +                                       pr_notice("OSDs don't support 'copy-from2'; "
> +                                                 "disabling copy_file_range\n");

This line is over 80 characters but shouldn't be split because it
is a grepable log message.  Also, this message was slightly tweaked
in ceph-client.git, so this patch doesn't apply.

> +                               }
> +                               if (!ret)
> +                                       ret = err;
> +                               goto out_caps;

I'm confused about out_caps.  Since a short copy is still copy which
may change the size, update mtime and ctime times, etc why aren't we
dirtying caps in these cases?

> +                       }
> +                       copy_count = max_copies;
> +               }
>         }
>
>         if (len)
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 5a62dbd3f4c2..0121767cd65e 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -496,6 +496,9 @@ extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>  extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
>  extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
>                                   struct ceph_osd_request *req);
> +extern int ceph_osdc_wait_requests(struct list_head *osd_reqs,
> +                                  unsigned int *reqs_complete);
> +
>  extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
>
>  extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
> @@ -526,7 +529,8 @@ extern int ceph_osdc_writepages(struct ceph_osd_client *osdc,
>                                 struct timespec64 *mtime,
>                                 struct page **pages, int nr_pages);
>
> -int ceph_osdc_copy_from(struct ceph_osd_client *osdc,
> +struct ceph_osd_request *ceph_osdc_copy_from(
> +                       struct ceph_osd_client *osdc,
>                         u64 src_snapid, u64 src_version,
>                         struct ceph_object_id *src_oid,
>                         struct ceph_object_locator *src_oloc,
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b68b376d8c2f..df9f342f860a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4531,6 +4531,35 @@ int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
>  }
>  EXPORT_SYMBOL(ceph_osdc_wait_request);
>
> +/*
> + * wait for all requests to complete in list @osd_reqs, returning the number of
> + * successful completions in @reqs_complete
> + */
> +int ceph_osdc_wait_requests(struct list_head *osd_reqs,
> +                           unsigned int *reqs_complete)
> +{
> +       struct ceph_osd_request *req;
> +       int ret = 0, err;
> +       unsigned int counter = 0;
> +
> +       while (!list_empty(osd_reqs)) {
> +               req = list_first_entry(osd_reqs,
> +                                      struct ceph_osd_request,
> +                                      r_private_item);
> +               list_del_init(&req->r_private_item);
> +               err = ceph_osdc_wait_request(req->r_osdc, req);
> +               if (!err)
> +                       counter++;

I think you want to stop incrementing counter after encountering an
error...

Thanks,

                Ilya
