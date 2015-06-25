From: =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>
Subject: [PATCH] libceph: Fix ceph_tcp_sendpage()'s more boolean usage
Date: Thu, 25 Jun 2015 18:56:26 +0200
Message-ID: <1435251386-25108-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 28-113-190-109.dsl.ovh.fr ([109.190.113.28]:33453 "EHLO ariel"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752076AbbFYQ41 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Jun 2015 12:56:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, elder@ieee.org, =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>

Spotted while hunting http://tracker.ceph.com/issues/10905.

=46rom struct ceph_msg_data_cursor in include/linux/ceph/messenger.h:

bool	last_piece;	/* current is last piece */

In ceph_msg_data_next():

*last_piece =3D cursor->last_piece;

A call to ceph_msg_data_next() is followed by:

ret =3D ceph_tcp_sendpage(con->sock, page, page_offset,
			length, last_piece);

while ceph_tcp_sendpage() is:

static int ceph_tcp_sendpage(struct socket *sock, struct page *page,i
			     int offset, size_t size, bool more)

The logic is inverted: correct it.

Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ec68cd3..eda06fd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1544,7 +1544,7 @@ static int write_partial_message_data(struct ceph=
_connection *con)
 		page =3D ceph_msg_data_next(&msg->cursor, &page_offset, &length,
 							&last_piece);
 		ret =3D ceph_tcp_sendpage(con->sock, page, page_offset,
-				      length, last_piece);
+				      length, !last_piece);
 		if (ret <=3D 0) {
 			if (do_datacrc)
 				msg->footer.data_crc =3D cpu_to_le32(crc);
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
