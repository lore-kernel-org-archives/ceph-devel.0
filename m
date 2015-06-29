From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: allow custom network namespaces
Date: Mon, 29 Jun 2015 16:33:20 +0300
Message-ID: <CAOi1vP9NDMB0hAtRXyObk=GLQ9PV70kKsT-q4MWcCiv-w1VLNg@mail.gmail.com>
References: <1433941284-12984-1-git-send-email-zhiguohong@tencent.com>
	<1433946856-26824-1-git-send-email-zhiguohong@tencent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37070 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbbF2NdW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 09:33:22 -0400
Received: by wicgi11 with SMTP id gi11so72511133wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 06:33:20 -0700 (PDT)
In-Reply-To: <1433946856-26824-1-git-send-email-zhiguohong@tencent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hong Zhiguo <honkiko@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Hong Zhiguo <zhiguohong@tencent.com>

On Wed, Jun 10, 2015 at 5:34 PM, Hong Zhiguo <honkiko@gmail.com> wrote:
> in current implementaion init_net is always used.
>
> But in most cases, if a user does a rbd map or ceph mount in
> a container, it's expected to use the container network namespace.
>
> This patch saves the container's netns in ceph_options on a rbd map
> or ceph mount. And use the netns other than init_net when creating
> socket. Ref count of the netns is only taken by the ceph_options
> in ceph_client since lifetime of osds and mon is within that of
> ceph_client.
>
> I've tested this patch in docker container with below operations:
> - rbd map
> - write/read on the rbd
> - rbd unmap
>
> Signed-off-by: Hong Zhiguo <zhiguohong@tencent.com>
> ---
>  fs/ceph/mds_client.c           |  3 ++-
>  include/linux/ceph/libceph.h   |  3 +++
>  include/linux/ceph/messenger.h |  4 +++-
>  net/ceph/ceph_common.c         |  7 ++++---
>  net/ceph/messenger.c           | 12 +++++++++---
>  net/ceph/mon_client.c          |  2 +-
>  net/ceph/osd_client.c          |  3 ++-
>  7 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 8080d48..3fb0976 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -440,7 +440,8 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
>         s->s_seq = 0;
>         mutex_init(&s->s_mutex);
>
> -       ceph_con_init(&s->s_con, s, &mds_con_ops, &mdsc->fsc->client->msgr);
> +       ceph_con_init(&s->s_con, s, &mds_con_ops, &mdsc->fsc->client->msgr,
> +                       mdsc->fsc->client->options->netns);
>
>         spin_lock_init(&s->s_gen_ttl_lock);
>         s->s_cap_gen = 0;
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index d73a569..442d9f3 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -22,6 +22,8 @@
>  #include <linux/ceph/osd_client.h>
>  #include <linux/ceph/ceph_fs.h>
>
> +struct net;
> +
>  /*
>   * mount options
>   */
> @@ -46,6 +48,7 @@ struct ceph_options {
>         unsigned long mount_timeout;            /* jiffies */
>         unsigned long osd_idle_ttl;             /* jiffies */
>         unsigned long osd_keepalive_timeout;    /* jiffies */
> +       struct net *netns;
>
>         /*
>          * any type that can't be simply compared or doesn't need need
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index e154994..3b0a314 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -14,6 +14,7 @@
>
>  struct ceph_msg;
>  struct ceph_connection;
> +struct net;
>
>  /*
>   * Ceph defines these callbacks for handling connection events.
> @@ -189,6 +190,7 @@ struct ceph_connection {
>         struct ceph_messenger *msgr;
>
>         atomic_t sock_state;
> +       struct net *netns;
>         struct socket *sock;
>         struct ceph_entity_addr peer_addr; /* peer address */
>         struct ceph_entity_addr peer_addr_for_me;
> @@ -270,7 +272,7 @@ extern void ceph_messenger_init(struct ceph_messenger *msgr,
>
>  extern void ceph_con_init(struct ceph_connection *con, void *private,
>                         const struct ceph_connection_operations *ops,
> -                       struct ceph_messenger *msgr);
> +                       struct ceph_messenger *msgr, struct net *netns);
>  extern void ceph_con_open(struct ceph_connection *con,
>                           __u8 entity_type, __u64 entity_num,
>                           struct ceph_entity_addr *addr);
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 925d0c8..1c42d96 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -269,6 +269,9 @@ static match_table_t opt_tokens = {
>  void ceph_destroy_options(struct ceph_options *opt)
>  {
>         dout("destroy_options %p\n", opt);
> +       if (opt->netns) {
> +               put_net(opt->netns);
> +       }
>         kfree(opt->name);
>         if (opt->key) {
>                 ceph_crypto_key_destroy(opt->key);
> @@ -335,9 +338,6 @@ ceph_parse_options(char *options, const char *dev_name,
>         int err = -ENOMEM;
>         substring_t argstr[MAX_OPT_ARGS];
>
> -       if (current->nsproxy->net_ns != &init_net)
> -               return ERR_PTR(-EINVAL);
> -
>         opt = kzalloc(sizeof(*opt), GFP_KERNEL);
>         if (!opt)
>                 return ERR_PTR(-ENOMEM);
> @@ -501,6 +501,7 @@ ceph_parse_options(char *options, const char *dev_name,
>         }
>
>         /* success */
> +       opt->netns = get_net(current->nsproxy->net_ns);
>         return opt;
>
>  out:
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 967080a..0a62905 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -480,8 +480,8 @@ static int ceph_tcp_connect(struct ceph_connection *con)
>         int ret;
>
>         BUG_ON(con->sock);
> -       ret = sock_create_kern(con->peer_addr.in_addr.ss_family, SOCK_STREAM,
> -                              IPPROTO_TCP, &sock);
> +       ret = __sock_create(con->netns, con->peer_addr.in_addr.ss_family, SOCK_STREAM,
> +                              IPPROTO_TCP, &sock, 0);
>         if (ret)
>                 return ret;
>         sock->sk->sk_allocation = GFP_NOFS;
> @@ -736,7 +736,7 @@ bool ceph_con_opened(struct ceph_connection *con)
>   */
>  void ceph_con_init(struct ceph_connection *con, void *private,
>         const struct ceph_connection_operations *ops,
> -       struct ceph_messenger *msgr)
> +       struct ceph_messenger *msgr, struct net *netns)
>  {
>         dout("con_init %p\n", con);
>         memset(con, 0, sizeof(*con));
> @@ -744,6 +744,12 @@ void ceph_con_init(struct ceph_connection *con, void *private,
>         con->ops = ops;
>         con->msgr = msgr;
>
> +       /*
> +        * don't take extra refcnt of netns here since both mon and osds
> +        * have lifetime within that of ceph_client
> +        */
> +       con->netns = netns;
> +
>         con_sock_state_init(con);
>
>         mutex_init(&con->mutex);
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 9d6ff12..04128af 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -832,7 +832,7 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
>                 goto out_auth_reply;
>
>         ceph_con_init(&monc->con, monc, &mon_con_ops,
> -                     &monc->client->msgr);
> +                     &monc->client->msgr, monc->client->options->netns);
>
>         monc->cur_mon = -1;
>         monc->hunting = true;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 5003367..32d9fa9 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1022,7 +1022,8 @@ static struct ceph_osd *create_osd(struct ceph_osd_client *osdc, int onum)
>         INIT_LIST_HEAD(&osd->o_osd_lru);
>         osd->o_incarnation = 1;
>
> -       ceph_con_init(&osd->o_con, osd, &osd_con_ops, &osdc->client->msgr);
> +       ceph_con_init(&osd->o_con, osd, &osd_con_ops, &osdc->client->msgr,
> +                       osdc->client->options->netns);
>
>         INIT_LIST_HEAD(&osd->o_keepalive_item);
>         return osd;

Hi Hong,

How about the following (link to raw patch below):

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index e154994..3775327 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -8,6 +8,7 @@
 #include <linux/radix-tree.h>
 #include <linux/uio.h>
 #include <linux/workqueue.h>
+#include <net/net_namespace.h>

 #include <linux/ceph/types.h>
 #include <linux/ceph/buffer.h>
@@ -56,6 +57,7 @@ struct ceph_messenger {
  struct ceph_entity_addr my_enc_addr;

  atomic_t stopping;
+ possible_net_t net;
  bool nocrc;
  bool tcp_nodelay;

@@ -267,6 +269,7 @@ extern void ceph_messenger_init(struct ceph_messenger *msgr,
  u64 required_features,
  bool nocrc,
  bool tcp_nodelay);
+extern void ceph_messenger_fini(struct ceph_messenger *msgr);

 extern void ceph_con_init(struct ceph_connection *con, void *private,
  const struct ceph_connection_operations *ops,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index cb7db32..f1a63b1 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -17,7 +17,6 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/nsproxy.h>
-#include <net/net_namespace.h>


 #include <linux/ceph/ceph_features.h>
@@ -131,6 +130,13 @@ int ceph_compare_options(struct ceph_options *new_opt,
  int i;
  int ret;

+ /*
+ * Don't bother comparing options if network namespaces don't
+ * match.
+ */
+ if (!net_eq(current->nsproxy->net_ns, read_pnet(&client->msgr.net)))
+ return -1;
+
  ret = memcmp(opt1, opt2, ofs);
  if (ret)
  return ret;
@@ -335,9 +341,6 @@ ceph_parse_options(char *options, const char *dev_name,
  int err = -ENOMEM;
  substring_t argstr[MAX_OPT_ARGS];

- if (current->nsproxy->net_ns != &init_net)
- return ERR_PTR(-EINVAL);
-
  opt = kzalloc(sizeof(*opt), GFP_KERNEL);
  if (!opt)
  return ERR_PTR(-ENOMEM);
@@ -608,6 +611,7 @@ struct ceph_client *ceph_create_client(struct
ceph_options *opt, void *private,
 fail_monc:
  ceph_monc_stop(&client->monc);
 fail:
+ ceph_messenger_fini(&client->msgr);
  kfree(client);
  return ERR_PTR(err);
 }
@@ -621,8 +625,8 @@ void ceph_destroy_client(struct ceph_client *client)

  /* unmount */
  ceph_osdc_stop(&client->osdc);
-
  ceph_monc_stop(&client->monc);
+ ceph_messenger_fini(&client->msgr);

  ceph_debugfs_client_cleanup(client);

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1441aef..bb40d36 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -479,8 +479,8 @@ static int ceph_tcp_connect(struct ceph_connection *con)
  int ret;

  BUG_ON(con->sock);
- ret = sock_create_kern(con->peer_addr.in_addr.ss_family, SOCK_STREAM,
-       IPPROTO_TCP, &sock);
+ ret = __sock_create(read_pnet(&con->msgr->net), paddr->ss_family,
+    SOCK_STREAM, IPPROTO_TCP, &sock, 1);
  if (ret)
  return ret;
  sock->sk->sk_allocation = GFP_NOFS;
@@ -2944,11 +2944,18 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
  msgr->tcp_nodelay = tcp_nodelay;

  atomic_set(&msgr->stopping, 0);
+ write_pnet(&msgr->net, get_net(current->nsproxy->net_ns));

  dout("%s %p\n", __func__, msgr);
 }
 EXPORT_SYMBOL(ceph_messenger_init);

+void ceph_messenger_fini(struct ceph_messenger *msgr)
+{
+ put_net(read_pnet(&msgr->net));
+}
+EXPORT_SYMBOL(ceph_messenger_fini);
+
 static void clear_standby(struct ceph_connection *con)
 {
  /* come back from STANDBY? */

It's a bit smaller, less invasive and behaves properly in
!CONFIG_NET_NS case.  I'm storing net pointer in ceph_messenger -
having it in each ceph_connection is useless because all connections
will necessarily share the same namespace, and ceph_options is for
command-line options.  Also fixed the last argument of __sock_create(),
which is kern, so it should be 1.

I've only tested this in ip netns playground, so I'd appreciate if you
test it in your docker setup.

https://github.com/ceph/ceph-client/commit/2d72fbdf9908d101942bf2b4090cef0f044c292d.patch

Thanks,

                Ilya
