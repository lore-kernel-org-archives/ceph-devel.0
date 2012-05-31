From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 06/13] libceph: embed ceph messenger structure in ceph_client
Date: Thu, 31 May 2012 09:44:52 -0700
Message-ID: <CAC-hyiGSUxsnj_LqdxNX=E2FCwCmEDKim7Bn5np96zcsLfasHQ@mail.gmail.com>
References: <4FC673FC.3060004@inktank.com>
	<4FC6765A.8080100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48654 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031Ab2EaQox convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:44:53 -0400
Received: by bkcji2 with SMTP id ji2so1043923bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:44:52 -0700 (PDT)
In-Reply-To: <4FC6765A.8080100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, May 30, 2012 at 12:34 PM, Alex Elder <elder@inktank.com> wrote:
> A ceph client has a pointer to a ceph messenger structure in it.
> There is always exactly one ceph messenger for a ceph client, so
> there is no need to allocate it separate from the ceph client
> structure.
>
> Switch the ceph_client structure to embed its ceph_messenger
> structure.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> =A0fs/ceph/mds_client.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0include/linux/ceph/libceph.h =A0 | =A0 =A02 +-
> =A0include/linux/ceph/messenger.h | =A0 =A09 +++++----
> =A0net/ceph/ceph_common.c =A0 =A0 =A0 =A0 | =A0 18 +++++-------------
> =A0net/ceph/messenger.c =A0 =A0 =A0 =A0 =A0 | =A0 30 +++++++++-------=
--------------
> =A0net/ceph/mon_client.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++---
> =A0net/ceph/osd_client.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
> =A07 files changed, 26 insertions(+), 45 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 200bc87..ad30261 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -394,7 +394,7 @@ static struct ceph_mds_session *register_session(=
struct
> ceph_mds_client *mdsc,
> =A0 =A0 =A0 =A0s->s_seq =3D 0;
> =A0 =A0 =A0 =A0mutex_init(&s->s_mutex);
>
> - =A0 =A0 =A0 ceph_con_init(mdsc->fsc->client->msgr, &s->s_con);
> + =A0 =A0 =A0 ceph_con_init(&mdsc->fsc->client->msgr, &s->s_con);
> =A0 =A0 =A0 =A0s->s_con.private =3D s;
> =A0 =A0 =A0 =A0s->s_con.ops =3D &mds_con_ops;
> =A0 =A0 =A0 =A0s->s_con.peer_name.type =3D CEPH_ENTITY_TYPE_MDS;
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libcep=
h.h
> index 92eef7c..927361c 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -131,7 +131,7 @@ struct ceph_client {
> =A0 =A0 =A0 =A0u32 supported_features;
> =A0 =A0 =A0 =A0u32 required_features;
>
> - =A0 =A0 =A0 struct ceph_messenger *msgr; =A0 /* messenger instance =
*/
> + =A0 =A0 =A0 struct ceph_messenger msgr; =A0 /* messenger instance *=
/
> =A0 =A0 =A0 =A0struct ceph_mon_client monc;
> =A0 =A0 =A0 =A0struct ceph_osd_client osdc;
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/mess=
enger.h
> index 74f6c9b..3fbd4be 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -211,10 +211,11 @@ extern int ceph_msgr_init(void);
> =A0extern void ceph_msgr_exit(void);
> =A0extern void ceph_msgr_flush(void);
>
> -extern struct ceph_messenger *ceph_messenger_create(
> - =A0 =A0 =A0 struct ceph_entity_addr *myaddr,
> - =A0 =A0 =A0 u32 features, u32 required);
> -extern void ceph_messenger_destroy(struct ceph_messenger *);
> +extern void ceph_messenger_init(struct ceph_messenger *msgr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ceph_entity_addr=
 *myaddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 supported_features,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 required_features,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool nocrc);
>
> =A0extern void ceph_con_init(struct ceph_messenger *msgr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ceph_connec=
tion *con);
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index cc91319..2de3ea1 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -468,19 +468,15 @@ struct ceph_client *ceph_create_client(struct
> ceph_options *opt, void *private,
> =A0 =A0 =A0 =A0/* msgr */
> =A0 =A0 =A0 =A0if (ceph_test_opt(client, MYIP))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0myaddr =3D &client->options->my_addr;
> - =A0 =A0 =A0 client->msgr =3D ceph_messenger_create(myaddr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0client->supported_features,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0client->required_features);
> - =A0 =A0 =A0 if (IS_ERR(client->msgr)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(client->msgr);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 client->msgr->nocrc =3D ceph_test_opt(client, NOCRC);
> + =A0 =A0 =A0 ceph_messenger_init(&client->msgr, myaddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->supported_features,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->required_features,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_test_opt(client, NOCRC));
>
> =A0 =A0 =A0 =A0/* subsystems */
> =A0 =A0 =A0 =A0err =3D ceph_monc_init(&client->monc, client);
> =A0 =A0 =A0 =A0if (err < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_msgr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> =A0 =A0 =A0 =A0err =3D ceph_osdc_init(&client->osdc, client);
> =A0 =A0 =A0 =A0if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_monc;
> @@ -489,8 +485,6 @@ struct ceph_client *ceph_create_client(struct
> ceph_options *opt, void *private,
>
> =A0fail_monc:
> =A0 =A0 =A0 =A0ceph_monc_stop(&client->monc);
> -fail_msgr:
> - =A0 =A0 =A0 ceph_messenger_destroy(client->msgr);
> =A0fail:
> =A0 =A0 =A0 =A0kfree(client);
> =A0 =A0 =A0 =A0return ERR_PTR(err);
> @@ -515,8 +509,6 @@ void ceph_destroy_client(struct ceph_client *clie=
nt)
>
> =A0 =A0 =A0 =A0ceph_debugfs_client_cleanup(client);
>
> - =A0 =A0 =A0 ceph_messenger_destroy(client->msgr);
> -
> =A0 =A0 =A0 =A0ceph_destroy_options(client->options);
>
> =A0 =A0 =A0 =A0kfree(client);
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 2e9054f..19f1948 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2243,18 +2243,14 @@ out:
>
>
> =A0/*
> - * create a new messenger instance
> + * initialize a new messenger instance
> =A0*/
> -struct ceph_messenger *ceph_messenger_create(struct ceph_entity_addr
> *myaddr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0u32 supported_features,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0u32 required_features)
> +void ceph_messenger_init(struct ceph_messenger *msgr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ceph_entity_addr=
 *myaddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 supported_features,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 required_features,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool nocrc)
> =A0{
> - =A0 =A0 =A0 struct ceph_messenger *msgr;
> -
> - =A0 =A0 =A0 msgr =3D kzalloc(sizeof(*msgr), GFP_KERNEL);
> - =A0 =A0 =A0 if (msgr =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
> -
> =A0 =A0 =A0 =A0msgr->supported_features =3D supported_features;
> =A0 =A0 =A0 =A0msgr->required_features =3D required_features;
>
> @@ -2267,19 +2263,11 @@ struct ceph_messenger *ceph_messenger_create(=
struct
> ceph_entity_addr *myaddr,
> =A0 =A0 =A0 =A0msgr->inst.addr.type =3D 0;
> =A0 =A0 =A0 =A0get_random_bytes(&msgr->inst.addr.nonce,
> sizeof(msgr->inst.addr.nonce));
> =A0 =A0 =A0 =A0encode_my_addr(msgr);
> + =A0 =A0 =A0 msgr->nocrc =3D nocrc;
>
> - =A0 =A0 =A0 dout("messenger_create %p\n", msgr);
> - =A0 =A0 =A0 return msgr;
> -}
> -EXPORT_SYMBOL(ceph_messenger_create);
> -
> -void ceph_messenger_destroy(struct ceph_messenger *msgr)
> -{
> - =A0 =A0 =A0 dout("destroy %p\n", msgr);
> - =A0 =A0 =A0 kfree(msgr);
> - =A0 =A0 =A0 dout("destroyed messenger %p\n", msgr);
> + =A0 =A0 =A0 dout("%s %p\n", __func__, msgr);
> =A0}
> -EXPORT_SYMBOL(ceph_messenger_destroy);
> +EXPORT_SYMBOL(ceph_messenger_init);
>
> =A0static void clear_standby(struct ceph_connection *con)
> =A0{
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 1845cde..704dc95 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -763,7 +763,7 @@ int ceph_monc_init(struct ceph_mon_client *monc, =
struct
> ceph_client *cl)
> =A0 =A0 =A0 =A0monc->con =3D kmalloc(sizeof(*monc->con), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!monc->con)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_monmap;
> - =A0 =A0 =A0 ceph_con_init(monc->client->msgr, monc->con);
> + =A0 =A0 =A0 ceph_con_init(&monc->client->msgr, monc->con);
> =A0 =A0 =A0 =A0monc->con->private =3D monc;
> =A0 =A0 =A0 =A0monc->con->ops =3D &mon_con_ops;
>
> @@ -880,8 +880,8 @@ static void handle_auth_reply(struct ceph_mon_cli=
ent
> *monc,
> =A0 =A0 =A0 =A0} else if (!was_auth &&
> monc->auth->ops->is_authenticated(monc->auth)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout("authenticated, starting session\=
n");
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 monc->client->msgr->inst.name.type =3D
> CEPH_ENTITY_TYPE_CLIENT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 monc->client->msgr->inst.name.num =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 monc->client->msgr.inst.name.type =3D C=
EPH_ENTITY_TYPE_CLIENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 monc->client->msgr.inst.name.num =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0cpu_to_le64(monc->auth->global_id);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__send_subscribe(monc);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b098e7b..cca4c7f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -639,7 +639,7 @@ static struct ceph_osd *create_osd(struct
> ceph_osd_client *osdc)
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&osd->o_osd_lru);
> =A0 =A0 =A0 =A0osd->o_incarnation =3D 1;
>
> - =A0 =A0 =A0 ceph_con_init(osdc->client->msgr, &osd->o_con);
> + =A0 =A0 =A0 ceph_con_init(&osdc->client->msgr, &osd->o_con);
> =A0 =A0 =A0 =A0osd->o_con.private =3D osd;
> =A0 =A0 =A0 =A0osd->o_con.ops =3D &osd_con_ops;
> =A0 =A0 =A0 =A0osd->o_con.peer_name.type =3D CEPH_ENTITY_TYPE_OSD;
> @@ -1391,7 +1391,7 @@ void ceph_osdc_handle_map(struct ceph_osd_clien=
t
> *osdc, struct ceph_msg *msg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 epoch, maplen=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0newmap =3D osdmap_appl=
y_incremental(&p, next,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osdc->osdmap,
> -
> osdc->client->msgr);
> +
> &osdc->client->msgr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(newmap)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D=
 PTR_ERR(newmap);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto b=
ad;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
