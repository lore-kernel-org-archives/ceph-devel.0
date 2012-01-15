From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH RESEND] ceph: fix length validation in parse_reply_info()
Date: Sat, 14 Jan 2012 22:20:59 -0500
Message-ID: <1326597659-3892-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51207 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab2AODZy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2012 22:25:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

"len" is read from network and thus needs validation.  Otherwise, given
a bogus "len" value, p+len could be an out-of-bounds pointer, which is
used in further parsing.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 fs/ceph/mds_client.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 23ab6a3..3cc9b0b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -262,6 +262,7 @@ static int parse_reply_info(struct ceph_msg *msg,
 	/* trace */
 	ceph_decode_32_safe(&p, end, len, bad);
 	if (len > 0) {
+		ceph_decode_need(&p, end, len, bad);
 		err = parse_reply_info_trace(&p, p+len, info, features);
 		if (err < 0)
 			goto out_bad;
@@ -270,6 +271,7 @@ static int parse_reply_info(struct ceph_msg *msg,
 	/* extra */
 	ceph_decode_32_safe(&p, end, len, bad);
 	if (len > 0) {
+		ceph_decode_need(&p, end, len, bad);
 		err = parse_reply_info_extra(&p, p+len, info, features);
 		if (err < 0)
 			goto out_bad;
-- 
1.7.5.4

