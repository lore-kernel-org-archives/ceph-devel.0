From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 04/13] libceph: rename socket callbacks
Date: Thu, 31 May 2012 09:33:22 -0700
Message-ID: <CAC-hyiHb2pHhj=L9jcHeaYh9n=A-W=vc27r=Cofw6NPXnDX4pw@mail.gmail.com>
References: <4FC673FC.3060004@inktank.com>
	<4FC6764C.8030503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33331 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2EaQdY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:33:24 -0400
Received: by bkcji2 with SMTP id ji2so1032956bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:33:22 -0700 (PDT)
In-Reply-To: <4FC6764C.8030503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, May 30, 2012 at 12:34 PM, Alex Elder <elder@inktank.com> wrote:
> Change the names of the three socket callback functions to make it
> more obvious they're specifically associated with a connection's
> socket (not the ceph connection that uses it).
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> =A0net/ceph/messenger.c | =A0 28 ++++++++++++++--------------
> =A01 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index fe3c2a1..5ad1f0a 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -153,46 +153,46 @@ EXPORT_SYMBOL(ceph_msgr_flush);
> =A0*/
>
> =A0/* data available on socket, or listen socket received a connect *=
/
> -static void ceph_data_ready(struct sock *sk, int count_unused)
> +static void ceph_sock_data_ready(struct sock *sk, int count_unused)
> =A0{
> =A0 =A0 =A0 =A0struct ceph_connection *con =3D sk->sk_user_data;
>
> =A0 =A0 =A0 =A0if (sk->sk_state !=3D TCP_CLOSE_WAIT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("ceph_data_ready on %p state =3D %=
lu, queueing work\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("%s on %p state =3D %lu, queueing =
work\n", __func__,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con, con->state);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_con(con);
> =A0 =A0 =A0 =A0}
> =A0}
>
> =A0/* socket has buffer space for writing */
> -static void ceph_write_space(struct sock *sk)
> +static void ceph_sock_write_space(struct sock *sk)
> =A0{
> =A0 =A0 =A0 =A0struct ceph_connection *con =3D sk->sk_user_data;
>
> =A0 =A0 =A0 =A0/* only queue to workqueue if there is data we want to=
 write,
> =A0 =A0 =A0 =A0 * and there is sufficient space in the socket buffer =
to accept
> - =A0 =A0 =A0 =A0* more data. =A0clear SOCK_NOSPACE so that ceph_writ=
e_space()
> + =A0 =A0 =A0 =A0* more data. =A0clear SOCK_NOSPACE so that ceph_sock=
_write_space()
> =A0 =A0 =A0 =A0 * doesn't get called again until try_write() fills th=
e socket
> =A0 =A0 =A0 =A0 * buffer. See net/ipv4/tcp_input.c:tcp_check_space()
> =A0 =A0 =A0 =A0 * and net/core/stream.c:sk_stream_write_space().
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (test_bit(WRITE_PENDING, &con->state)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sk_stream_wspace(sk) >=3D sk_strea=
m_min_wspace(sk)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("ceph_write_space =
%p queueing write work\n",
> con);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("%s %p queueing wr=
ite work\n", __func__, con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clear_bit(SOCK_NOSPACE=
, &sk->sk_socket->flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_con(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("ceph_write_space %p nothing to wr=
ite\n", con);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("%s %p nothing to write\n", __func=
__, con);
> =A0 =A0 =A0 =A0}
> =A0}
>
> =A0/* socket's state has changed */
> -static void ceph_state_change(struct sock *sk)
> +static void ceph_sock_state_change(struct sock *sk)
> =A0{
> =A0 =A0 =A0 =A0struct ceph_connection *con =3D sk->sk_user_data;
>
> - =A0 =A0 =A0 dout("ceph_state_change %p state =3D %lu sk_state =3D %=
u\n",
> + =A0 =A0 =A0 dout("%s %p state =3D %lu sk_state =3D %u\n", __func__,
> =A0 =A0 =A0 =A0 =A0 =A0 con, con->state, sk->sk_state);
>
> =A0 =A0 =A0 =A0if (test_bit(CLOSED, &con->state))
> @@ -200,9 +200,9 @@ static void ceph_state_change(struct sock *sk)
>
> =A0 =A0 =A0 =A0switch (sk->sk_state) {
> =A0 =A0 =A0 =A0case TCP_CLOSE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("ceph_state_change TCP_CLOSE\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("%s TCP_CLOSE\n", __func__);
> =A0 =A0 =A0 =A0case TCP_CLOSE_WAIT:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("ceph_state_change TCP_CLOSE_WAIT\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("%s TCP_CLOSE_WAIT\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (test_and_set_bit(SOCK_CLOSED, &con=
->state) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (test_bit(CONNECTIN=
G, &con->state))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con->e=
rror_msg =3D "connection failed";
> @@ -212,7 +212,7 @@ static void ceph_state_change(struct sock *sk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case TCP_ESTABLISHED:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("ceph_state_change TCP_ESTABLISHED=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("%s TCP_ESTABLISHED\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_con(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default: =A0 =A0 =A0 =A0/* Everything else is unintere=
sting */
> @@ -228,9 +228,9 @@ static void set_sock_callbacks(struct socket *soc=
k,
> =A0{
> =A0 =A0 =A0 =A0struct sock *sk =3D sock->sk;
> =A0 =A0 =A0 =A0sk->sk_user_data =3D con;
> - =A0 =A0 =A0 sk->sk_data_ready =3D ceph_data_ready;
> - =A0 =A0 =A0 sk->sk_write_space =3D ceph_write_space;
> - =A0 =A0 =A0 sk->sk_state_change =3D ceph_state_change;
> + =A0 =A0 =A0 sk->sk_data_ready =3D ceph_sock_data_ready;
> + =A0 =A0 =A0 sk->sk_write_space =3D ceph_sock_write_space;
> + =A0 =A0 =A0 sk->sk_state_change =3D ceph_sock_state_change;
> =A0}
>
>
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
