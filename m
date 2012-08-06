From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] rbd: make snap_names_len a u64
Date: Mon, 06 Aug 2012 11:03:31 -0700
Message-ID: <502006F3.5030609@inktank.com>
References: <50200691.3040006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39424 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2HFSDf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 14:03:35 -0400
Received: by pbbrr13 with SMTP id rr13so2904653pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 11:03:34 -0700 (PDT)
In-Reply-To: <50200691.3040006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The snap_names_len field of an rbd_image_header structure is defined
with type size_t.  That field is used as both the source and target
of 64-bit byte-order swapping operations though, so it's best to
define it with type u64 instead.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |    3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -81,7 +81,7 @@ struct rbd_image_header {
  	__u8 crypt_type;
  	__u8 comp_type;
  	struct ceph_snap_context *snapc;
-	size_t snap_names_len;
+	u64 snap_names_len;
  	u32 total_snaps;

  	char *snap_names;
@@ -511,6 +511,7 @@ static int rbd_header_from_disk(struct r

  	if (snap_count) {
  		header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
+		BUG_ON(header->snap_names_len > (u64) SIZE_MAX);
  		header->snap_names = kmalloc(header->snap_names_len,
  					     GFP_KERNEL);
  		if (!header->snap_names)
