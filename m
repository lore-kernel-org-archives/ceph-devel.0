From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCHv2 1/1] fs/ceph: More accurate statfs
Date: Thu, 17 Aug 2017 15:14:37 +0200
Message-ID: <CAOi1vP8Vcat8obTeF0EY0FXRzfHigfu2pXiPp+NTrS7xp7xyRQ@mail.gmail.com>
References: <cover.1502892972.git.dfuller@redhat.com> <947dca7132806e5d4e102460efef2b8d938f496f.1502892972.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38379 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdHQNOj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 09:14:39 -0400
Received: by mail-vk0-f68.google.com with SMTP id i133so2741396vka.5
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 06:14:39 -0700 (PDT)
In-Reply-To: <947dca7132806e5d4e102460efef2b8d938f496f.1502892972.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 16, 2017 at 4:19 PM, Douglas Fuller <dfuller@redhat.com> wrote:
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
> index 1deb8810d7c7..324d29ecbe0b 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -49,9 +49,16 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
>         struct ceph_statfs st;
>         u64 fsid;
>         int err;
> +       u64 data_pool;
> +
> +       if (fsc->mdsc->mdsmap->m_num_data_pg_pools == 1) {
> +               data_pool = fsc->mdsc->mdsmap->m_data_pg_pools[0];
> +       } else {
> +               data_pool = CEPH_NOPOOL;
> +       }
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
> index d5a3ecea578d..f52a3a6ce00b 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -133,7 +133,7 @@ void ceph_monc_renew_subs(struct ceph_mon_client *monc);
>  extern int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
>                                  unsigned long timeout);
>
> -extern int ceph_monc_do_statfs(struct ceph_mon_client *monc,
> +extern int ceph_monc_do_statfs(struct ceph_mon_client *monc, u64 data_pool,
>                                struct ceph_statfs *buf);
>
>  int ceph_monc_get_version(struct ceph_mon_client *monc, const char *what,
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 875675765531..63edc6e5f026 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -676,7 +676,8 @@ static void handle_statfs_reply(struct ceph_mon_client *monc,
>  /*
>   * Do a synchronous statfs().
>   */
> -int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
> +int ceph_monc_do_statfs(struct ceph_mon_client *monc, u64 data_pool,
> +                       struct ceph_statfs *buf)
>  {
>         struct ceph_mon_generic_request *req;
>         struct ceph_mon_statfs *h;
> @@ -696,6 +697,7 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
>                 goto out;
>
>         req->u.st = buf;
> +       req->request->hdr.version = cpu_to_le16(2);
>
>         mutex_lock(&monc->mutex);
>         register_generic_request(req);
> @@ -705,6 +707,8 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, struct ceph_statfs *buf)
>         h->monhdr.session_mon = cpu_to_le16(-1);
>         h->monhdr.session_mon_tid = 0;
>         h->fsid = monc->monmap->fsid;
> +       h->contains_data_pool = (data_pool != CEPH_NOPOOL);
> +       h->data_pool = cpu_to_le64(data_pool);
>         send_generic_request(monc, req);
>         mutex_unlock(&monc->mutex);

Applied.

Thanks,

                Ilya
