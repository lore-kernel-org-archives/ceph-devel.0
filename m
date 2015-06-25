From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: Fix ceph_tcp_sendpage()'s more boolean usage
Date: Thu, 25 Jun 2015 20:30:10 +0300
Message-ID: <CAOi1vP_Jd6SH+ZPLV0euqcDPKOwHN5v2uGtu4q09cgghfnOWnQ@mail.gmail.com>
References: <1435251386-25108-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36178 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbFYRaM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 13:30:12 -0400
Received: by wguu7 with SMTP id u7so68474311wgu.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 10:30:10 -0700 (PDT)
In-Reply-To: <1435251386-25108-1-git-send-email-benoit.canet@nodalink.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Beno=C3=AEt_Canet?= <benoit.canet@nodalink.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@ieee.org>

On Thu, Jun 25, 2015 at 7:56 PM, Beno=C3=AEt Canet <benoit.canet@nodali=
nk.com> wrote:
> Spotted while hunting http://tracker.ceph.com/issues/10905.
>
> From struct ceph_msg_data_cursor in include/linux/ceph/messenger.h:
>
> bool    last_piece;     /* current is last piece */
>
> In ceph_msg_data_next():
>
> *last_piece =3D cursor->last_piece;
>
> A call to ceph_msg_data_next() is followed by:
>
> ret =3D ceph_tcp_sendpage(con->sock, page, page_offset,
>                         length, last_piece);
>
> while ceph_tcp_sendpage() is:
>
> static int ceph_tcp_sendpage(struct socket *sock, struct page *page,i
>                              int offset, size_t size, bool more)
>
> The logic is inverted: correct it.
>
> Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
> ---
>  net/ceph/messenger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index ec68cd3..eda06fd 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1544,7 +1544,7 @@ static int write_partial_message_data(struct ce=
ph_connection *con)
>                 page =3D ceph_msg_data_next(&msg->cursor, &page_offse=
t, &length,
>                                                         &last_piece);
>                 ret =3D ceph_tcp_sendpage(con->sock, page, page_offse=
t,
> -                                     length, last_piece);
> +                                     length, !last_piece);
>                 if (ret <=3D 0) {
>                         if (do_datacrc)
>                                 msg->footer.data_crc =3D cpu_to_le32(=
crc);

Good catch.  Applied.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
