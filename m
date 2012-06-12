From: "Yan, Zheng" <zheng.z.yan@linux.intel.com>
Subject: Re: [PATCH 09/13] libceph: start tracking connection socket state
Date: Tue, 12 Jun 2012 12:52:39 +0800
Message-ID: <CAAM7YA=4M_NQq03UCiEO=RQ=D3d3LHq1T9fbCkiqBxvv-AQyLA@mail.gmail.com>
References: <4FC673FC.3060004@inktank.com>
	<4FC6766B.1090307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35801 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab2FLEwk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 00:52:40 -0400
Received: by obbtb18 with SMTP id tb18so7767279obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 21:52:39 -0700 (PDT)
In-Reply-To: <4FC6766B.1090307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, May 31, 2012 at 3:35 AM, Alex Elder <elder@inktank.com> wrote:
> Start explicitly keeping track of the state of a ceph connection's
> socket, separate from the state of the connection itself. =A0Create
> placeholder functions to encapsulate the state transitions.
>
> =A0 =A0--------
> =A0 =A0| NEW* | =A0transient initial state
> =A0 =A0--------
> =A0 =A0 =A0 =A0| con_sock_state_init()
> =A0 =A0 =A0 =A0v
> =A0 =A0----------
> =A0 =A0| CLOSED | =A0initialized, but no socket (and no
> =A0 =A0---------- =A0TCP connection)
> =A0 =A0 ^ =A0 =A0 =A0\
> =A0 =A0 | =A0 =A0 =A0 \ con_sock_state_connecting()
> =A0 =A0 | =A0 =A0 =A0 =A0----------------------
> =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> =A0 =A0 + con_sock_state_closed() =A0 =A0 =A0 \
> =A0 =A0 |\ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> =A0 =A0 | \ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> =A0 =A0 | =A0----------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 | =A0| CLOSING | =A0socket event; =A0 =A0 =A0 \
> =A0 =A0 | =A0----------- =A0await close =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 | =A0 =A0 =A0 ^ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0|
> =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0|
> =A0 =A0 | =A0 =A0 =A0 + con_sock_state_closing() =A0 |
> =A0 =A0 | =A0 =A0 =A0/ \ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 |
> =A0 =A0 | =A0 =A0 / =A0 --------------- =A0 =A0 =A0 =A0 =A0 =A0|
> =A0 =A0 | =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \ =A0 =A0 =A0 =
=A0 =A0 v
> =A0 =A0 | =A0 / =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--------------
> =A0 =A0 | =A0/ =A0 =A0-----------------| CONNECTING | =A0socket creat=
ed, TCP
> =A0 =A0 | =A0| =A0 / =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -------------- =A0=
connect initiated
> =A0 =A0 | =A0| =A0 | con_sock_state_connected()
> =A0 =A0 | =A0| =A0 v
> =A0 =A0-------------
> =A0 =A0| CONNECTED | =A0TCP connection established
> =A0 =A0-------------
>
> Make the socket state an atomic variable, reinforcing that it's a
> distinct transtion with no possible "intermediate/both" states.
> This is almost certainly overkill at this point, though the
> transitions into CONNECTED and CLOSING state do get called via
> socket callback (the rest of the transitions occur with the
> connection mutex held). =A0We can back out the atomicity later.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> =A0include/linux/ceph/messenger.h | =A0 =A08 ++++-
> =A0net/ceph/messenger.c =A0 =A0 =A0 =A0 =A0 | =A0 63
> ++++++++++++++++++++++++++++++++++++++++
> =A02 files changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/mess=
enger.h
> index 920235e..5e852f4 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -137,14 +137,18 @@ struct ceph_connection {
> =A0 =A0 =A0 =A0const struct ceph_connection_operations *ops;
>
> =A0 =A0 =A0 =A0struct ceph_messenger *msgr;
> +
> + =A0 =A0 =A0 atomic_t sock_state;
> =A0 =A0 =A0 =A0struct socket *sock;
> + =A0 =A0 =A0 struct ceph_entity_addr peer_addr; /* peer address */
> + =A0 =A0 =A0 struct ceph_entity_addr peer_addr_for_me;
> +
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0unsigned long state;
> =A0 =A0 =A0 =A0const char *error_msg; =A0/* error message, if any */
>
> - =A0 =A0 =A0 struct ceph_entity_addr peer_addr; /* peer address */
> =A0 =A0 =A0 =A0struct ceph_entity_name peer_name; /* peer name */
> - =A0 =A0 =A0 struct ceph_entity_addr peer_addr_for_me;
> +
> =A0 =A0 =A0 =A0unsigned peer_features;
> =A0 =A0 =A0 =A0u32 connect_seq; =A0 =A0 =A0/* identify the most recen=
t connection
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attem=
pt for this connection, client */
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 29055df..7e11b07 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -29,6 +29,14 @@
> =A0* the sender.
> =A0*/
>
> +/* State values for ceph_connection->sock_state; NEW is assumed to b=
e 0 */
> +
> +#define CON_SOCK_STATE_NEW =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 /* =
-> CLOSED */
> +#define CON_SOCK_STATE_CLOSED =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 /* ->=
 CONNECTING */
> +#define CON_SOCK_STATE_CONNECTING =A0 =A0 =A02 =A0 =A0 =A0 /* -> CON=
NECTED or ->
> CLOSING */
> +#define CON_SOCK_STATE_CONNECTED =A0 =A0 =A0 3 =A0 =A0 =A0 /* -> CLO=
SING or -> CLOSED
> */
> +#define CON_SOCK_STATE_CLOSING =A0 =A0 =A0 =A0 4 =A0 =A0 =A0 /* -> C=
LOSED */
> +
> =A0/* static tag bytes (protocol control messages) */
> =A0static char tag_msg =3D CEPH_MSGR_TAG_MSG;
> =A0static char tag_ack =3D CEPH_MSGR_TAG_ACK;
> @@ -147,6 +155,54 @@ void ceph_msgr_flush(void)
> =A0}
> =A0EXPORT_SYMBOL(ceph_msgr_flush);
>
> +/* Connection socket state transition functions */
> +
> +static void con_sock_state_init(struct ceph_connection *con)
> +{
> + =A0 =A0 =A0 int old_state;
> +
> + =A0 =A0 =A0 old_state =3D atomic_xchg(&con->sock_state, CON_SOCK_ST=
ATE_CLOSED);
> + =A0 =A0 =A0 if (WARN_ON(old_state !=3D CON_SOCK_STATE_NEW))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: unexpected old state %d\n",=
 __func__,
> old_state);
> +}
> +
> +static void con_sock_state_connecting(struct ceph_connection *con)
> +{
> + =A0 =A0 =A0 int old_state;
> +
> + =A0 =A0 =A0 old_state =3D atomic_xchg(&con->sock_state,
> CON_SOCK_STATE_CONNECTING);
> + =A0 =A0 =A0 if (WARN_ON(old_state !=3D CON_SOCK_STATE_CLOSED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: unexpected old state %d\n",=
 __func__,
> old_state);
> +}
> +
> +static void con_sock_state_connected(struct ceph_connection *con)
> +{
> + =A0 =A0 =A0 int old_state;
> +
> + =A0 =A0 =A0 old_state =3D atomic_xchg(&con->sock_state, CON_SOCK_ST=
ATE_CONNECTED);
> + =A0 =A0 =A0 if (WARN_ON(old_state !=3D CON_SOCK_STATE_CONNECTING))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: unexpected old state %d\n",=
 __func__,
> old_state);
> +}
> +
> +static void con_sock_state_closing(struct ceph_connection *con)
> +{
> + =A0 =A0 =A0 int old_state;
> +
> + =A0 =A0 =A0 old_state =3D atomic_xchg(&con->sock_state, CON_SOCK_ST=
ATE_CLOSING);
> + =A0 =A0 =A0 if (WARN_ON(old_state !=3D CON_SOCK_STATE_CONNECTING &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_state !=3D CON_SOCK=
_STATE_CONNECTED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: unexpected old state %d\n",=
 __func__,
> old_state);
> +}
> +
> +static void con_sock_state_closed(struct ceph_connection *con)
> +{
> + =A0 =A0 =A0 int old_state;
> +
> + =A0 =A0 =A0 old_state =3D atomic_xchg(&con->sock_state, CON_SOCK_ST=
ATE_CLOSED);
> + =A0 =A0 =A0 if (WARN_ON(old_state !=3D CON_SOCK_STATE_CONNECTED &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_state !=3D CON_SOCK=
_STATE_CLOSING))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: unexpected old state %d\n",=
 __func__,
> old_state);
> +}
>
Hi Alex,

Single node setup can easily trigger above WARN_ON.  I think this is be=
cause
local TCP connection setup and shutdown is very fast, they finish immed=
iately
after sock->connect and sock->shutdown return.

Yan, Zheng

> =A0/*
> =A0* socket callback functions
> @@ -203,6 +259,7 @@ static void ceph_sock_state_change(struct sock *s=
k)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout("%s TCP_CLOSE\n", __func__);
> =A0 =A0 =A0 =A0case TCP_CLOSE_WAIT:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout("%s TCP_CLOSE_WAIT\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_sock_state_closing(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (test_and_set_bit(SOCK_CLOSED, &con=
->flags) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (test_bit(CONNECTIN=
G, &con->state))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con->e=
rror_msg =3D "connection failed";
> @@ -213,6 +270,7 @@ static void ceph_sock_state_change(struct sock *s=
k)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case TCP_ESTABLISHED:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout("%s TCP_ESTABLISHED\n", __func__)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_sock_state_connected(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_con(con);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default: =A0 =A0 =A0 =A0/* Everything else is unintere=
sting */
> @@ -277,6 +335,7 @@ static int ceph_tcp_connect(struct ceph_connectio=
n *con)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0con->sock =3D sock;
> + =A0 =A0 =A0 con_sock_state_connecting(con);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -341,6 +400,7 @@ static int con_close_socket(struct ceph_connectio=
n *con)
> =A0 =A0 =A0 =A0rc =3D con->sock->ops->shutdown(con->sock, SHUT_RDWR);
> =A0 =A0 =A0 =A0sock_release(con->sock);
> =A0 =A0 =A0 =A0con->sock =3D NULL;
> + =A0 =A0 =A0 con_sock_state_closed(con);
> =A0 =A0 =A0 =A0return rc;
> =A0}
>
> @@ -460,6 +520,9 @@ void ceph_con_init(struct ceph_messenger *msgr, s=
truct
> ceph_connection *con)
> =A0 =A0 =A0 =A0memset(con, 0, sizeof(*con));
> =A0 =A0 =A0 =A0atomic_set(&con->nref, 1);
> =A0 =A0 =A0 =A0con->msgr =3D msgr;
> +
> + =A0 =A0 =A0 con_sock_state_init(con);
> +
> =A0 =A0 =A0 =A0mutex_init(&con->mutex);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&con->out_queue);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&con->out_sent);
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
