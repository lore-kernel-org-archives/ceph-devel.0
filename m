Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794184212;
	b=smgY0V3DhEoULXq8DwiNwWDXdONd+Xy8Ncahbh9MLh42dE34ytwNVqEEgSb8P/1DPj3w
	 ejzvEmnYOcjufzooFVvAd6rQaZ34/7O8GTr5lIaoTfLQ4Ls+20VcjA6Xv+AGRpENkTvJz
	 1Vd3rkbWKJBMZC5Heh+6VMzebA+gsAxQn7yZVqana5bYusIktB8L16388q+R/ZaO1dc43
	 yzG4irH0CghD+RLNcP4lBdnG2UtGqqd497JNxGA3fyZs/5tCTOcsLJp7otKaWGzLRhMJp
	 iQDM7mB5pDHRfLURa9Te3wlKySzVdOu05Qj5zerw5PwMNkZ/d7D6M0RQK3AMfydvyjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184212;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LKyISZsU8OqUQ6rBGfsWetUZIzQ/NjY9vPkHt5QTooA=;
	b=ub9IiOhyGVVEm1QQSepE4TBbO7yJy4DlCHAex54TcyFGVFM1rA6AVTBOVI2eH9/L4Gf8
	 OqLisUCMFfSAamE1D5jwf9JIb8htP3knSSCVjL8HWiVcyzKxt/BZJPXuAX4xDCo5lpR4U
	 A2SmMeFbbWR9AHo5y2mC1Y5ByU7ce/YfrLjLwCkldnwmipONUN1yRN1PAxAHXtRG+mtZR
	 iRCe51n3W18NcDSMtogApP+d96TaqjEEL4StTGl00CObrTgLnNxC2cw1SjMQuU6GUFPKK
	 4I04rFd6KZhHuZnHQSYtwOODCkKsWnw4kScYvePV3DbyPd8YvzjhqR64UB9EAE6EEuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvrcnNKs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F8606D804;
	Mon,  9 Nov 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvrcnNKs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794184211;
	b=ev/u0/IBM9q+M6KaOgY8TTCdGA1Y1AeqMyZHK9GkQMm14zr8Z0gP9rLl7hNGn2cz04Te
	 op7OoV0FRuTW2OAHwwGlSRwzHF1D+quhZqWzN0cdan1f6hawmrkpeCUibZESzGQbC5m6N
	 u9InGYme2OIj42Rbl65Qt6iATRPb0s8zOVY0jLOAQlOfDL/Ee21U0eoyh7fDs+5CXV4QH
	 B4h2siXYHJgdjgV7m4ctGU5l4c5u50Nj2ZbCbMhMVkPFHoTNjMrhCkG/DW8D0/k2S/JXu
	 cpHqLqlB39s78i5giCKu5yP5N6deF+ot7zE6EeMzRqN20f1v8p4YkdRDF/w5vfGhKYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794184211;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LKyISZsU8OqUQ6rBGfsWetUZIzQ/NjY9vPkHt5QTooA=;
	b=GmZgplOHS13UpsMsy7iXvPzM1xNeX+mBT3x53T8H0vIePkbsPtyGhxsFheRCmltAln9y
	 KHfZ2RXCCb42Cj+vtkCATfhfhu1UiV+KxLun3eYXNoY2zhuP50AJFH1lIaS7P2GBVDJE2
	 4gwODZV8b+VM7wx9uXKUc1AuLOWx6hGLdn7mKW9pdrRn0if+PLLL8viRJL8r3A8VpTsVQ
	 SIBAVCpEke7JbqyI+ErP2u+2IM9SnNI7NPHZRlJ3D+SUMXDRhdU4RpUMsmi/00N8cY4K+
	 ijsyxZiM2lkKtTC5osUFwqaYjxaZjznkeftsXzqnLOkHlttXhIk8q21hEeqMquRYA0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F34D1F0092F;
	Mon,  9 Nov 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184211;
	bh=LKyISZsU8OqUQ6rBGfsWetUZIzQ/NjY9vPkHt5QTooA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=hvrcnNKsVAj/t5162EeqdvOHXjMX6kkiLXIZ7j5I7qSP7j/jt7JFV40+nxnnBo/3d
	 nrkN6o5M7XQkpYprEq8tTNkw7SOa5etl2neMxKnCStMDyADpuBxeegfidXT6oUqHT3
	 hrWYSCJo4A+TW46BvIM6CkBSrZgOVQMPll2pio23vY8m1tlIQxkBMpR8fBgsyqWNiL
	 J56OtNRcWG7LAIa+GDPp9lmzwAdSB9cY1cD8g2KIBEQydEVyH8N1kRJsU8wx6YpmA6
	 J39x6dd0LQ7bRGb9yFYF4pLbDvEvwKNbxobeiNU5/IVGUE13gaFPQI0tnGy4CbUQHZ
	 NIGnCjX+MzZ+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1926D4818E;
	Mon,  9 Nov 2026 00:30:10 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Mon, 09 Nov 2026 01:30:09 +0100
Subject: [PATCH] ceph: hand the lookup lock of an in-lookup dentry over to
 the reply
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
Message-Id: <20261109-ceph-lookup-lockdep-v1-1-54f9cbf9e147@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrA0kg5bUqxQXOk6bqWJCoiKId
 ze2q8e3eP8BiaNwgqY4IPImSfycYcoCyHXzh5UM2YAaH8Zoq4iDU5P34xry0DhwUPWzM1qjRaw
 I8jNEfsv+q77av9Paf5mWOwXneQEAlGOOdwAAAA==
X-Change-ID: 20261108-ceph-lookup-lockdep-59a10028224c
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, NeilBrown <neil@brown.name>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184208; l=5611;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=uc7SSQdBXs9iK/Wx2A/lVvyGm3o8mWlNwqwwtVdLWZw=;
 b=qGIO4+hKS5hb9H+Ny1IF6XbOizl6oW+zw1aUvubXFs5msYEaQAPsqakqEqtma4oik34TFeqFF
 7THQ1caSgG6DyPS+TV6dtyPg8xgX61NF8iVJn8lR9/LRTQ+y17MgeLx
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

Since lockdep tracks DCACHE_PAR_LOOKUP as a lock held by the task that
started the lookup, ceph trips it on every lookup or open whose reply
ends the lookup: ceph_fill_trace() runs in the messenger worker, and
the d_splice_alias() there releases a lock that the worker never took:

  WARNING: bad unlock balance detected!
  kworker/0:0/9 is trying to release lock (DCACHE_PAR_LOOKUP) at:
  __d_lookup_unhash+0x112/0x380
  but there are no more locks to release!
  ...
   d_splice_alias_ops+0x3e7/0x14e0
   splice_dentry+0x140/0x1110 [ceph]
   ceph_fill_trace+0x29c0/0x6fc0 [ceph]
   handle_reply+0xe4b/0x2d60 [ceph]

and the task that waits for the reply returns to user space still
holding it as far as lockdep knows.  The first report turns lockdep
off, so it hides any real lock problem found after it.

Hand the lock over as NFS does for its async unlink: when
ceph_mdsc_do_request() sends a request for an in-lookup r_dentry, it
releases it with d_lookup_release() and marks the request; handle_reply()
owns it with d_lookup_acquire() for as long as ceph_fill_trace() runs,
and releases it again if the lookup did not end there; once the wait
is over the requester takes it back, if the lookup has not ended,
under r_fill_mutex so that it does not race with ceph_fill_trace().

Requests sent with ceph_mdsc_submit_request() alone (async create and
unlink) do not hand it over: the lookup ends in the task that started
it.

Fixes: 59492f9991dc ("VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.")
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
lockdep now tracks DCACHE_PAR_LOOKUP as a lock owned by the task that
started the lookup, and ceph trips it on the first lookup whose reply
ends the lookup in the messenger worker (bad unlock balance), which
turns lockdep off for the rest of the boot.  Hand the lock over to the
reply handler, as NFS does for its async unlink.
---
 fs/ceph/mds_client.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f178efc8f7ad..01091dbb37a2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4130,14 +4130,38 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 			 struct ceph_mds_request *req)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct dentry *lookup_dn = req->r_dentry;
 	int err;
 
 	boutc(cl, "do_request on %p\n", req);
 
+	/*
+	 * lockdep sees the DCACHE_PAR_LOOKUP state of an in-lookup dentry as
+	 * a lock held by the task that started the lookup.  The reply to a
+	 * request for it (a lookup or an open) is handled by the messenger,
+	 * whose ceph_fill_trace() may end the lookup: hand the lock over to
+	 * it for as long as we wait, and take it back after, if the lookup
+	 * has not ended.  r_fill_mutex keeps that away from a running
+	 * ceph_fill_trace().
+	 */
+	if (lookup_dn && d_in_lookup(lookup_dn)) {
+		d_lookup_release(lookup_dn);
+		set_bit(CEPH_MDS_R_LOOKUP_HANDOFF, &req->r_req_flags);
+	} else {
+		lookup_dn = NULL;
+	}
+
 	/* issue */
 	err = ceph_mdsc_submit_request(mdsc, dir, req);
 	if (!err)
 		err = ceph_mdsc_wait_request(mdsc, req, NULL);
+
+	if (lookup_dn) {
+		mutex_lock(&req->r_fill_mutex);
+		clear_bit(CEPH_MDS_R_LOOKUP_HANDOFF, &req->r_req_flags);
+		d_lookup_acquire(lookup_dn);
+		mutex_unlock(&req->r_fill_mutex);
+	}
 	boutc(cl, "do_request %p done, result %d\n", req, err);
 	return err;
 }
@@ -4180,6 +4204,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply info */
 	struct ceph_snap_realm *realm;
 	unsigned int nofs_flags;
+	struct dentry *lookup_dn;
 	u64 tid;
 	int err, result;
 	int mds = session->s_mds;
@@ -4335,6 +4360,18 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	/* insert trace into our cache */
 	mutex_lock(&req->r_fill_mutex);
 
+	/*
+	 * ceph_fill_trace() may end the lookup of an in-lookup r_dentry
+	 * (d_splice_alias()), which lockdep sees as releasing its
+	 * DCACHE_PAR_LOOKUP lock: own it here meanwhile, see
+	 * ceph_mdsc_do_request().  splice_dentry() may replace r_dentry.
+	 */
+	lookup_dn = NULL;
+	if (test_bit(CEPH_MDS_R_LOOKUP_HANDOFF, &req->r_req_flags)) {
+		lookup_dn = req->r_dentry;
+		d_lookup_acquire(lookup_dn);
+	}
+
 	/* Disable filesystem reclaim while journal_info carries Ceph state. */
 	nofs_flags = memalloc_nofs_save();
 	{
@@ -4350,6 +4387,9 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		ceph_blog_exit(&ji);
 	}
 	memalloc_nofs_restore(nofs_flags);
+
+	if (lookup_dn)
+		d_lookup_release(lookup_dn);
 	mutex_unlock(&req->r_fill_mutex);
 
 	up_read(&mdsc->snap_rwsem);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4749438d94e1..ff9ba09f3b59 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -360,6 +360,7 @@ struct ceph_mds_request {
 #define CEPH_MDS_R_PARENT_LOCKED	(7) /* is r_parent->i_rwsem wlocked? */
 #define CEPH_MDS_R_ASYNC		(8) /* async request */
 #define CEPH_MDS_R_FSCRYPT_FILE		(9) /* must marshal fscrypt_file field */
+#define CEPH_MDS_R_LOOKUP_HANDOFF	(10) /* r_dentry in-lookup, owned by the reply */
 	unsigned long	r_req_flags;
 
 	struct mutex r_fill_mutex;

---
base-commit: 5dcec86cc31f8144857c0d9bf2a7fa13b6e6f531
change-id: 20261108-ceph-lookup-lockdep-59a10028224c

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


