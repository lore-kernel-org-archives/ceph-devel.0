From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v6 2/7] libceph: allow requests to return immediately on
 full conditions if caller wishes
Date: Tue, 4 Apr 2017 16:55:41 +0200
Message-ID: <CAOi1vP-PrmUgVaSy+NsVrtG5LqPvLzoJUjTUSyLazC5dXcw69A@mail.gmail.com>
References: <20170330180546.11021-1-jlayton@redhat.com> <20170330180707.11137-1-jlayton@redhat.com>
 <20170330180707.11137-2-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35204 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbdDDOzn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Apr 2017 10:55:43 -0400
Received: by mail-vk0-f67.google.com with SMTP id z204so23157408vkd.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Apr 2017 07:55:42 -0700 (PDT)
In-Reply-To: <20170330180707.11137-2-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 30, 2017 at 8:07 PM, Jeff Layton <jlayton@redhat.com> wrote:
> Usually, when the osd map is flagged as full or the pool is at quota,
> write requests just hang. This is not what we want for cephfs, where
> it would be better to simply report -ENOSPC back to userland instead
> of stalling.
>
> If the caller knows that it will want an immediate error return instead
> of blocking on a full or at-quota error condition then allow it to set a
> flag to request that behavior.
>
> Set that flag in ceph_osdc_new_request (since ceph.ko is the only caller)=
,
> and on any other write request from ceph.ko.
>
> A later patch will deal with requests that were submitted before the new
> map showing the full condition came in.
>
> Reviewed-by: "Yan, Zheng=E2=80=9D <zyan@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ceph/addr.c                  | 1 +
>  fs/ceph/file.c                  | 1 +
>  include/linux/ceph/osd_client.h | 1 +
>  net/ceph/osd_client.c           | 7 +++++++
>  4 files changed, 10 insertions(+)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 1a3e1b40799a..7e3fae334620 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1892,6 +1892,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_i=
nfo *ci,
>         err =3D ceph_osdc_start_request(&fsc->client->osdc, rd_req, false=
);
>
>         wr_req->r_mtime =3D ci->vfs_inode.i_mtime;
> +       wr_req->r_abort_on_full =3D true;
>         err2 =3D ceph_osdc_start_request(&fsc->client->osdc, wr_req, fals=
e);
>
>         if (!err)
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 356b7c76a2f1..cff35a1ff53c 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -712,6 +712,7 @@ static void ceph_aio_retry_work(struct work_struct *w=
ork)
>         req->r_callback =3D ceph_aio_complete_req;
>         req->r_inode =3D inode;
>         req->r_priv =3D aio_req;
> +       req->r_abort_on_full =3D true;
>
>         ret =3D ceph_osdc_start_request(req->r_osdc, req, false);
>  out:
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_cli=
ent.h
> index 3fc9e7754a9b..8cf644197b1a 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -187,6 +187,7 @@ struct ceph_osd_request {
>         struct timespec r_mtime;              /* ditto */
>         u64 r_data_offset;                    /* ditto */
>         bool r_linger;                        /* don't resend on failure =
*/
> +       bool r_abort_on_full;                 /* return ENOSPC when full =
*/
>
>         /* internal */
>         unsigned long r_stamp;                /* jiffies, send or check t=
ime */
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 27f14ae69eb7..781048990599 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -961,6 +961,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct=
 ceph_osd_client *osdc,
>                                        truncate_size, truncate_seq);
>         }
>
> +       req->r_abort_on_full =3D true;
>         req->r_flags =3D flags;
>         req->r_base_oloc.pool =3D layout->pool_id;
>         req->r_base_oloc.pool_ns =3D ceph_try_get_string(layout->pool_ns)=
;
> @@ -1626,6 +1627,7 @@ static void maybe_request_map(struct ceph_osd_clien=
t *osdc)
>                 ceph_monc_renew_subs(&osdc->client->monc);
>  }
>
> +static void complete_request(struct ceph_osd_request *req, int err);
>  static void send_map_check(struct ceph_osd_request *req);
>
>  static void __submit_request(struct ceph_osd_request *req, bool wrlocked=
)
> @@ -1635,6 +1637,7 @@ static void __submit_request(struct ceph_osd_reques=
t *req, bool wrlocked)
>         enum calc_target_result ct_res;
>         bool need_send =3D false;
>         bool promoted =3D false;
> +       bool need_abort =3D false;
>
>         WARN_ON(req->r_tid);
>         dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
> @@ -1669,6 +1672,8 @@ static void __submit_request(struct ceph_osd_reques=
t *req, bool wrlocked)
>                 pr_warn_ratelimited("FULL or reached pool quota\n");
>                 req->r_t.paused =3D true;
>                 maybe_request_map(osdc);
> +               if (req->r_abort_on_full)
> +                       need_abort =3D true;
>         } else if (!osd_homeless(osd)) {
>                 need_send =3D true;
>         } else {
> @@ -1685,6 +1690,8 @@ static void __submit_request(struct ceph_osd_reques=
t *req, bool wrlocked)
>         link_request(osd, req);
>         if (need_send)
>                 send_request(req);
> +       else if (need_abort)
> +               complete_request(req, -ENOSPC);
>         mutex_unlock(&osd->lock);
>
>         if (ct_res =3D=3D CALC_TARGET_POOL_DNE)

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
