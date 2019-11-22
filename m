From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 140/219] libceph: drop last_piece logic from write_partial_message_data()
Date: Fri, 22 Nov 2019 00:47:52 -0500
Message-ID: <20191122054911.1750-133-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 1f6b821aef78e3d79e8d598ae59fc7e23fb6c563 ]

last_piece is for the last piece in the current data item, not in the
entire data payload of the message.  This is harmful for messages with
multiple data items.  On top of that, we don't need to signal the end
of a data payload either because it is always followed by a footer.

We used to signal "more" unconditionally, until commit fe38a2b67bc6
("libceph: start defining message data cursor").  Part of a large
series, it introduced cursor->last_piece and also mistakenly inverted
the hint by passing last_piece for "more".  This was corrected with
commit c2cfa1940097 ("libceph: Fix ceph_tcp_sendpage()'s more boolean
usage").

As it is, last_piece is not helping at all: because Nagle algorithm is
disabled, for a simple message with two 512-byte data items we end up
emitting three packets: front + first data item, second data item and
footer.  Go back to the original pre-fe38a2b67bc6 behavior -- a single
packet in most cases.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/messenger.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f7d7f32ac673c..6514816947fbe 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1612,7 +1612,6 @@ static int write_partial_message_data(struct ceph_connection *con)
 		struct page *page;
 		size_t page_offset;
 		size_t length;
-		bool last_piece;
 		int ret;
 
 		if (!cursor->resid) {
@@ -1620,10 +1619,9 @@ static int write_partial_message_data(struct ceph_connection *con)
 			continue;
 		}
 
-		page = ceph_msg_data_next(cursor, &page_offset, &length,
-					  &last_piece);
-		ret = ceph_tcp_sendpage(con->sock, page, page_offset,
-					length, !last_piece);
+		page = ceph_msg_data_next(cursor, &page_offset, &length, NULL);
+		ret = ceph_tcp_sendpage(con->sock, page, page_offset, length,
+					true);
 		if (ret <= 0) {
 			if (do_datacrc)
 				msg->footer.data_crc = cpu_to_le32(crc);
-- 
2.20.1
