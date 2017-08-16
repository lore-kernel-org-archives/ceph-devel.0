From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/1] fs/ceph: More accurate statfs
Date: Wed, 16 Aug 2017 14:45:42 +0200
Message-ID: <CAOi1vP_Xo6ZHPu2MKk00JNKymRCDuZFWZUVk9e+O-bzDJzpaCw@mail.gmail.com>
References: <cover.1502823001.git.dfuller@redhat.com> <04d1b74e1f90539a5bea9d737710ab71039e5eab.1502823001.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34565 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdHPMpn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Aug 2017 08:45:43 -0400
Received: by mail-ua0-f193.google.com with SMTP id k43so1699274uaf.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 05:45:43 -0700 (PDT)
In-Reply-To: <04d1b74e1f90539a5bea9d737710ab71039e5eab.1502823001.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 15, 2017 at 8:54 PM, Douglas Fuller <dfuller@redhat.com> wrote:
> Improve accuracy of statfs reporting for Ceph filesystems comprising
> exactly one data pool. In this case, the Ceph monitor can now report
> the space usage for the single data pool instead of the global data
> for the entire Ceph cluster. Include support for this message in
> mon_client and leverage it in ceph/super.
>
> Signed-off-by: Douglas Fuller <dfuller@redhat.com>
> ---
>  fs/ceph/super.c                 | 9 ++++++++-
>  include/linux/ceph/ceph_fs.h    | 2 ++
>  include/linux/ceph/mon_client.h | 2 +-
>  net/ceph/mon_client.c           | 6 +++++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 1deb8810d7c7..75facee8b6d1 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -49,9 +49,16 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
>         struct ceph_statfs st;
>         u64 fsid;
>         int err;
> +       __le64 data_pool;
> +
> +       if (fsc->mdsc->mdsmap->m_num_data_pg_pools == 1) {
> +               data_pool = fsc->mdsc->mdsmap->m_data_pg_pools[0];
> +       } else {
> +               data_pool = CEPH_NOPOOL;
> +       }

Missing cpu_to_le64() here -- data_pool is __le64, while CEPH_NOPOOL
and m_data_pg_pools are in CPU order.

>
>         dout("statfs\n");
> -       err = ceph_monc_do_statfs(&fsc->client->monc, &st);
> +       err = ceph_monc_do_statfs(&fsc->client->monc, data_pool, &st);
>         if (err < 0)
>                 return err;
>
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index d1642a4b4c5e..b422170b791a 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -167,6 +167,8 @@ struct ceph_mon_request_header {
>  struct ceph_mon_statfs {
>         struct ceph_mon_request_header monhdr;
>         struct ceph_fsid fsid;
> +       __u8 contains_data_pool;
> +       __le64 data_pool;
>  } __attribute__ ((packed));
>
>  struct ceph_statfs {
> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
> index d5a3ecea578d..bd4650ab1248 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -133,7 +133,7 @@ void ceph_monc_renew_subs(struct ceph_mon_client *monc);
>  extern int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
>                                  unsigned long timeout);
>
> -extern int ceph_monc_do_statfs(struct ceph_mon_client *monc,
> +extern int ceph_monc_do_statfs(struct ceph_mon_client *monc, __le64 data_pool,
>                                struct ceph_statfs *buf);
>
>  int ceph_monc_get_version(struct ceph_mon_client *monc, const char *what,
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 875675765531..5ef21986074e 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -676,7 +676,8 @@ static void handle_statfs_reply(struct ceph_mon_client *monc,
>  /*
>   * Do a synchronous statfs().
>   */
> -int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
> +int ceph_monc_do_statfs(struct ceph_mon_client *monc, __le64 data_pool,
> +                       struct ceph_statfs *buf)
>  {
>         struct ceph_mon_generic_request *req;
>         struct ceph_mon_statfs *h;
> @@ -696,6 +697,7 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
>                 goto out;
>
>         req->u.st = buf;
> +       req->request->hdr.version = 2;

cpu_to_le16(2)

>
>         mutex_lock(&monc->mutex);
>         register_generic_request(req);
> @@ -705,6 +707,8 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
>         h->monhdr.session_mon = cpu_to_le16(-1);
>         h->monhdr.session_mon_tid = 0;
>         h->fsid = monc->monmap->fsid;
> +       h->contains_data_pool = (data_pool != CEPH_NOPOOL);

... and again here, but the other way around.

> +       h->data_pool = data_pool;

I'd make ceph_monc_do_statfs() take u64 and do cpu_to_le64() here, in
one place.

Thanks,

                Ilya
