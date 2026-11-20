Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158679;
	b=ry0SKEYc8lBDHtYCJxOzAJtc3CnFDdyinzmAKrtXtBGod4iWp52zahsWaB67hoIZowQ4
	 5aqNbMQgf3Vchj/jM5nrkop6tugzoa7a1U2yWr0EZhGpcvzu+a5gfTj/DoVdqJUUGoveK
	 XA+w/M2yq5qx4zAjO5Dj4P+SeiBK7DDkEgmZOtcfidJwgNnq45O9TEtp7MG5qmY0GBm6/
	 AEgI/Z1LpjG8BfJi287MNUOtXllaJtpqQcjvQnQIVZA7uc0p2Mzvlr4fWz62ckBK40sIE
	 Ip0z48YGN2d4GVmhqxXSZyS7EThnl9uQwIVceFGph3nh0q2DtpA+GgThYYLZiAuF8Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158679;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ujQcAXwSQh01u/e/L7r1yLSAZzyU10lVOfUMXqAK1k=;
	b=olid8/7FKl4Yiq0YJfTA8zaWMNRpd0jorY2E3e9ViumZNFIm91NA3nE+/HVBsx9yvH/f
	 wP/PIKyiAYFk7HvvInVChZz4HztSYii3thKr6cnEGNQ87PXK7uLzRC5D0Insh0pETb9WR
	 i14RV2bMUIA+3pyuG8jpJnm6gTzx2kXY32+dUN8V/mwWjIBp1kJzIXn409451rARJSi7Q
	 hMUBKau/EeUyYM28bpwW7eZbSgXaxXW6+WdsJ6BC64BipQXPldgk+dFmqvwMhPjKh7oPj
	 VFHyuBk9vbmgn2r15avNf4R4Qx5PJrgIKXkfG4QTs74wSsiZ8ntXjCP4auCbrc6BuWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTCi1fyO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCA606A332;
	Fri, 20 Nov 2026 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTCi1fyO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795158678;
	b=FkPHsmIt4cpM0BMZCpCIRRAGDRAYnDNcEnKbaz0CgXFlB/yvmupzCkw0/a7t9O8eL/h1
	 g+kWghdwK0ZD/BG5c9cQ/+85dGU/TMo6d7msPgLNC+aER2WeAOtPOCZbapW0ncf9zK1OL
	 PH2lMgEyFQo9GLd9bPtyoiNuFAqleZfNJMNlOORGqgMCavDceSE1C3bCG2/2E92u698qh
	 d9WRo6bRiky7k7ijv+ypxGt1xYI1b1JoumhQICZYFMGFyxbJUZXPcRwd3ke1M/ZB31LOG
	 z2c2jjGOAOFPN+rVb8uV4/7w1Vt5jFghc3eEZvlbze5xHfvVVM0Gds24b7i6PYpYa6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795158678;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ujQcAXwSQh01u/e/L7r1yLSAZzyU10lVOfUMXqAK1k=;
	b=1p9UXtO6vxPlkDFUGCB4XK5EoFdLay+LDSp9wyenIL1Z4GwA/XnXSYMR5LqyXKVoA3+P
	 MNtZtepFklSh3L8SSTAr1QoVV4UHGWp4wq1Wg2OVysXIJaPXp10dvtUm8lLPHN8Sf20/O
	 1JmANeqcaVM+sz80RrB/N7R+Mzg+x12/MtNgZl4ZnEt/IkVIE7H3K9BqZrW/enQFayjS7
	 O7WNu7su9LqSZNW0m4UO+NJ+n7OT9UXnWkV+OE0pIWjY0EcQnTbSHLqjTA7NpwbdJCu3n
	 dQCmldyd2K/LXx0eW+2+Glv78G3PfpV19TFFTwFajvQHYLWKwbZNM4yczNB8VShyOKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C52AF1F000EB;
	Fri, 20 Nov 2026 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795158678;
	bh=3ujQcAXwSQh01u/e/L7r1yLSAZzyU10lVOfUMXqAK1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iTCi1fyOUa0s/oUqEwyn6iyuOda+HG5hpdqqNbOGjdNSis5rMaLaogsWo7BlzcnsV
	 sb1syXTBF2SYnJwGSBZuiBZi21ofhAIgCL9JJgMdxZJHaV0mDSXsnVJn1dKmQ6UF/4
	 NJAf/SSpT8AqmiiBaz4AgoZrXXytKe65rI5ov8wIi45UryJc9YjBFhswezPu4vegOf
	 svGPWnu4wzc7w8GD9+oo9CEF+8OAK5QVu2rRAel51xPstURESWlhWLw2yt1RzcZ2qF
	 /uaP0af6jUts8d+Mib898/p9SapElcCtqcROO8unqUNnC0dO+1+et+PG2nPIV5yfBQ
	 EMg0kawGudnaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 542EC4973B;
	Fri, 20 Nov 2026 07:11:17 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 20 Nov 2026 09:11:09 +0200
Subject: [PATCH v7 1/5] ceph: use READ_ONCE/WRITE_ONCE for oldest_tid
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-ceph-mdsc-mutex-optimization-v7-1-a4eee70e0038@clyso.com>
References: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
In-Reply-To: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795158674; l=3350;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=18WejL2UEV4doOiN98828eEMSZB+FE6A4iIzuLLp1Lw=;
 b=TPDUBs4MQy8SQ4zR7/1o72UrwhnvVnI4EzAWEbskI7i6MryYUM0S21llI4q1H2nw8zvolyr2+
 IvgFvGiHBmiCDbPG+V6PYgsJU/pm24v1N/a4Ljr+5GUj2Ic2pol1aKA
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

The oldest_client_tid sent in the MDS request header is advisory:
a stale value is harmless --- at worst the MDS may resend a reply
the client already has, or trim its completed-requests table
slightly earlier or later than optimal, both of which the protocol
handles correctly.  The field is monotonic and does not need lock
serialization to stay correct.

Switch all accesses to READ_ONCE() and WRITE_ONCE() to prevent
the compiler from tearing or inventing loads, documenting that
these lockless accesses are intentional.  This removes the last
reason the MDS request-send path had to be serialized under
mdsc->mutex.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 85f8ceb10377..b84d04835329 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1309,8 +1309,8 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	if (!req->r_mnt_idmap)
 		req->r_mnt_idmap = &nop_mnt_idmap;
 
-	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
-		mdsc->oldest_tid = req->r_tid;
+	if (READ_ONCE(mdsc->oldest_tid) == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
+		WRITE_ONCE(mdsc->oldest_tid, req->r_tid);
 
 	if (dir) {
 		struct ceph_inode_info *ci = ceph_inode(dir);
@@ -1331,14 +1331,14 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 	/* Never leave an unregistered request on an unsafe list! */
 	list_del_init(&req->r_unsafe_item);
 
-	if (req->r_tid == mdsc->oldest_tid) {
+	if (req->r_tid == READ_ONCE(mdsc->oldest_tid)) {
 		struct rb_node *p = rb_next(&req->r_node);
-		mdsc->oldest_tid = 0;
+		WRITE_ONCE(mdsc->oldest_tid, 0);
 		while (p) {
 			struct ceph_mds_request *next_req =
 				rb_entry(p, struct ceph_mds_request, r_node);
 			if (next_req->r_op != CEPH_MDS_OP_SETFILELOCK) {
-				mdsc->oldest_tid = next_req->r_tid;
+				WRITE_ONCE(mdsc->oldest_tid, next_req->r_tid);
 				break;
 			}
 			p = rb_next(p);
@@ -1767,7 +1767,7 @@ create_session_full_msg(struct ceph_mds_client *mdsc, int op, u64 seq)
 	ceph_encode_32(&p, 0);
 
 	/* version == 7, oldest_client_tid */
-	ceph_encode_64(&p, mdsc->oldest_tid);
+	ceph_encode_64(&p, READ_ONCE(mdsc->oldest_tid));
 
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
@@ -2834,7 +2834,7 @@ static struct ceph_mds_request *__get_oldest_req(struct ceph_mds_client *mdsc)
 
 static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 {
-	return mdsc->oldest_tid;
+	return READ_ONCE(mdsc->oldest_tid);
 }
 
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
@@ -3513,9 +3513,6 @@ static void complete_request(struct ceph_mds_client *mdsc,
 	complete_all(&req->r_completion);
 }
 
-/*
- * called under mdsc->mutex
- */
 static int __prepare_send_request(struct ceph_mds_session *session,
 				  struct ceph_mds_request *req,
 				  bool drop_cap_releases)
@@ -3630,9 +3627,6 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 	return 0;
 }
 
-/*
- * called under mdsc->mutex
- */
 static int __send_request(struct ceph_mds_session *session,
 			  struct ceph_mds_request *req,
 			  bool drop_cap_releases)

-- 
2.53.0


