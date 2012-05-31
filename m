From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 05/13] libceph: rename kvec_reset and kvec_add functions
Date: Thu, 31 May 2012 09:34:29 -0700
Message-ID: <CAC-hyiH3if2h55LOVSBwNyX0eWe9fO55Bh51UzVu8Rd3NPe03Q@mail.gmail.com>
References: <4FC673FC.3060004@inktank.com>
	<4FC67655.7030206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56675 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab2EaQeb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:34:31 -0400
Received: by bkcji2 with SMTP id ji2so1034278bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:34:30 -0700 (PDT)
In-Reply-To: <4FC67655.7030206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, May 30, 2012 at 12:34 PM, Alex Elder <elder@inktank.com> wrote:
> The functions ceph_con_out_kvec_reset() and ceph_con_out_kvec_add()
> are entirely private functions, so drop the "ceph_" prefix in their
> name to make them slightly more wieldy.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> =A0net/ceph/messenger.c | =A0 48
> ++++++++++++++++++++++++------------------------
> =A01 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 5ad1f0a..2e9054f 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -484,14 +484,14 @@ static u32 get_global_seq(struct ceph_messenger=
 *msgr,
> u32 gt)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static void ceph_con_out_kvec_reset(struct ceph_connection *con)
> +static void con_out_kvec_reset(struct ceph_connection *con)
> =A0{
> =A0 =A0 =A0 =A0con->out_kvec_left =3D 0;
> =A0 =A0 =A0 =A0con->out_kvec_bytes =3D 0;
> =A0 =A0 =A0 =A0con->out_kvec_cur =3D &con->out_kvec[0];
> =A0}
>
> -static void ceph_con_out_kvec_add(struct ceph_connection *con,
> +static void con_out_kvec_add(struct ceph_connection *con,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t=
 size, void *data)
> =A0{
> =A0 =A0 =A0 =A0int index;
> @@ -532,7 +532,7 @@ static void prepare_write_message(struct ceph_con=
nection
> *con)
> =A0 =A0 =A0 =A0struct ceph_msg *m;
> =A0 =A0 =A0 =A0u32 crc;
>
> - =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 con_out_kvec_reset(con);
> =A0 =A0 =A0 =A0con->out_kvec_is_msg =3D true;
> =A0 =A0 =A0 =A0con->out_msg_done =3D false;
>
> @@ -540,9 +540,9 @@ static void prepare_write_message(struct ceph_con=
nection
> *con)
> =A0 =A0 =A0 =A0 * TCP packet that's a good thing. */
> =A0 =A0 =A0 =A0if (con->in_seq > con->in_seq_acked) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con->in_seq_acked =3D con->in_seq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (tag_=
ack), &tag_ack);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_add(con, sizeof (tag_ack),=
 &tag_ack);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con->out_temp_ack =3D cpu_to_le64(con-=
>in_seq_acked);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (con-=
>out_temp_ack),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_add(con, sizeof (con->out_=
temp_ack),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&con->out_temp_ack);
> =A0 =A0 =A0 =A0}
>
> @@ -570,12 +570,12 @@ static void prepare_write_message(struct
> ceph_connection *con)
> =A0 =A0 =A0 =A0BUG_ON(le32_to_cpu(m->hdr.front_len) !=3D m->front.iov=
_len);
>
> =A0 =A0 =A0 =A0/* tag + hdr + front + middle */
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (tag_msg), &tag_msg);
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (m->hdr), &m->hdr);
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, m->front.iov_len, m->front.i=
ov_base);
> + =A0 =A0 =A0 con_out_kvec_add(con, sizeof (tag_msg), &tag_msg);
> + =A0 =A0 =A0 con_out_kvec_add(con, sizeof (m->hdr), &m->hdr);
> + =A0 =A0 =A0 con_out_kvec_add(con, m->front.iov_len, m->front.iov_ba=
se);
>
> =A0 =A0 =A0 =A0if (m->middle)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_add(con, m->middle->v=
ec.iov_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_add(con, m->middle->vec.io=
v_len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->middle->vec.iov_bas=
e);
>
> =A0 =A0 =A0 =A0/* fill in crc (except data pages), footer */
> @@ -624,12 +624,12 @@ static void prepare_write_ack(struct ceph_conne=
ction
> *con)
> =A0 =A0 =A0 =A0 =A0 =A0 con->in_seq_acked, con->in_seq);
> =A0 =A0 =A0 =A0con->in_seq_acked =3D con->in_seq;
>
> - =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 con_out_kvec_reset(con);
>
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);
> + =A0 =A0 =A0 con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);
>
> =A0 =A0 =A0 =A0con->out_temp_ack =3D cpu_to_le64(con->in_seq_acked);
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (con->out_temp_ack),
> + =A0 =A0 =A0 con_out_kvec_add(con, sizeof (con->out_temp_ack),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&con->=
out_temp_ack);
>
> =A0 =A0 =A0 =A0con->out_more =3D 1; =A0/* more will follow.. eventual=
ly.. */
> @@ -642,8 +642,8 @@ static void prepare_write_ack(struct ceph_connect=
ion
> *con)
> =A0static void prepare_write_keepalive(struct ceph_connection *con)
> =A0{
> =A0 =A0 =A0 =A0dout("prepare_write_keepalive %p\n", con);
> - =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (tag_keepalive), &tag=
_keepalive);
> + =A0 =A0 =A0 con_out_kvec_reset(con);
> + =A0 =A0 =A0 con_out_kvec_add(con, sizeof (tag_keepalive), &tag_keep=
alive);
> =A0 =A0 =A0 =A0set_bit(WRITE_PENDING, &con->state);
> =A0}
>
> @@ -688,8 +688,8 @@ static struct ceph_auth_handshake
> *get_connect_authorizer(struct ceph_connection
> =A0*/
> =A0static void prepare_write_banner(struct ceph_connection *con)
> =A0{
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BA=
NNER);
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (con->msgr->my_enc_ad=
dr),
> + =A0 =A0 =A0 con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER)=
;
> + =A0 =A0 =A0 con_out_kvec_add(con, sizeof (con->msgr->my_enc_addr),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&con->msgr->my_enc_addr);
>
> =A0 =A0 =A0 =A0con->out_more =3D 0;
> @@ -736,10 +736,10 @@ static int prepare_write_connect(struct
> ceph_connection *con)
> =A0 =A0 =A0 =A0con->out_connect.authorizer_len =3D auth ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_to_le32(auth->authorizer_buf_len) =
: 0;
>
> - =A0 =A0 =A0 ceph_con_out_kvec_add(con, sizeof (con->out_connect),
> + =A0 =A0 =A0 con_out_kvec_add(con, sizeof (con->out_connect),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&con->out_connect);
> =A0 =A0 =A0 =A0if (auth && auth->authorizer_buf_len)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_add(con, auth->author=
izer_buf_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_add(con, auth->authorizer_=
buf_len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0auth->authorizer_buf);
>
> =A0 =A0 =A0 =A0con->out_more =3D 0;
> @@ -933,7 +933,7 @@ static int write_partial_msg_pages(struct
> ceph_connection *con)
> =A0 =A0 =A0 =A0/* prepare and queue up footer, too */
> =A0 =A0 =A0 =A0if (!do_datacrc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con->out_msg->footer.flags |=3D CEPH_M=
SG_FOOTER_NOCRC;
> - =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 con_out_kvec_reset(con);
> =A0 =A0 =A0 =A0prepare_write_message_footer(con);
> =A0 =A0 =A0 =A0ret =3D 1;
> =A0out:
> @@ -1396,7 +1396,7 @@ static int process_connect(struct ceph_connecti=
on
> *con)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con->auth_retry =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_reset(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D prepare_write_connect(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -1417,7 +1417,7 @@ static int process_connect(struct ceph_connecti=
on
> *con)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ENTITY_NAME(con->peer_nam=
e),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_pr_addr(&con->peer_a=
ddr.in_addr));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reset_connection(con);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_reset(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D prepare_write_connect(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -1443,7 +1443,7 @@ static int process_connect(struct ceph_connecti=
on
> *con)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 le32_to_cpu(con->out_connect.=
connect_seq),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 le32_to_cpu(con->in_connect.c=
onnect_seq));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con->connect_seq =3D le32_to_cpu(con->=
in_connect.connect_seq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_reset(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D prepare_write_connect(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -1460,7 +1460,7 @@ static int process_connect(struct ceph_connecti=
on
> *con)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 le32_to_cpu(con->in_connect.g=
lobal_seq));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_global_seq(con->msgr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 le32_to_c=
pu(con->in_connect.global_seq));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_reset(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D prepare_write_connect(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -1867,7 +1867,7 @@ more:
>
> =A0 =A0 =A0 =A0/* open the socket first? */
> =A0 =A0 =A0 =A0if (con->sock =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ceph_con_out_kvec_reset(con);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_out_kvec_reset(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prepare_write_banner(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D prepare_write_connect(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
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
