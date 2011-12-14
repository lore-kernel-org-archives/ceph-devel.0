From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 1/3] ceph: fix out-of-bounds pointers in parse_reply_info()
Date: Wed, 14 Dec 2011 15:24:31 -0500
Message-ID: <1323894273-13904-2-git-send-email-xi.wang@gmail.com>
References: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53937 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab1LNU0I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 15:26:08 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so763871qcq.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 12:26:07 -0800 (PST)
In-Reply-To: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

Given a large len, the pointer p+len used in further parsing could be
out of bounds.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 fs/ceph/mds_client.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 6203d80..be1415f 100644
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

