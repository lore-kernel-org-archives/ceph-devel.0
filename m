From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] ceph: allow object copies across different filesystems
 in the same cluster
Date: Mon, 9 Sep 2019 12:51:55 +0200
Message-ID: <CAOi1vP-3fM8ZTKAOTY0E7ZQUU+wr=TaBhg-=vUWCSDBdFU0WmQ@mail.gmail.com>
References: <87k1ahojri.fsf@suse.com> <20190909102834.16246-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909102834.16246-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Sep 9, 2019 at 12:29 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> OSDs are able to perform object copies across different pools.  Thus,
> there's no need to prevent copy_file_range from doing remote copies if the
> source and destination superblocks are different.  Only return -EXDEV if
> they have different fsid (the cluster ID).
>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> Hi,
>
> Here's the patch changelog since initial submittion:
>
> - Dropped have_fsid checks on client structs
> - Use %pU to print the fsid instead of raw hex strings (%*ph)
> - Fixed 'To:' field in email so that this time the patch hits vger
>
> Cheers,
> --
> Luis
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 685a03cc4b77..4a624a1dd0bb 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1904,6 +1904,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>         struct ceph_inode_info *src_ci = ceph_inode(src_inode);
>         struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
>         struct ceph_cap_flush *prealloc_cf;
> +       struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
>         struct ceph_object_locator src_oloc, dst_oloc;
>         struct ceph_object_id src_oid, dst_oid;
>         loff_t endoff = 0, size;
> @@ -1915,8 +1916,17 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>
>         if (src_inode == dst_inode)
>                 return -EINVAL;
> -       if (src_inode->i_sb != dst_inode->i_sb)
> -               return -EXDEV;
> +       if (src_inode->i_sb != dst_inode->i_sb) {
> +               struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
> +
> +               if (ceph_fsid_compare(&src_fsc->client->fsid,
> +                                     &dst_fsc->client->fsid)) {
> +                       dout("Copying object across different clusters:");
> +                       dout("  src fsid: %pU dst fsid: %pU\n",
> +                            &src_fsc->client->fsid, &dst_fsc->client->fsid);

Hi Luis,

This should be a single dout.

Thanks,

                Ilya
