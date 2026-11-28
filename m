Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847133;
	b=brdOL8rrM0f/X7W0yA+JR9yMT0FGf+1a+9AThJlxXqhhZdK1TipRsVa5Rxi2DnGdU54L
	 LV1EpGkNBelUIVhenEmKlg86qV2UgXPCbU/2Dbs8ZuvLoAIbJ64q94qE97ktMRkHr7zWK
	 vgo07FxE/AEAeJb/Ue+4TXzuhs7fFhL/Lprolc85gSE7miHcucjv7qLUqjjoQ1e9vyDz0
	 6NnjD2Cp9CiOfpsODnlKnE2lBS/Eu/ApOPHqkOga3qCNiyTwhG4yt/Aj40yR9mNlk8D9Z
	 oXA3HuVmY1zDOrLpWsd4sUesLls87lAbwNtoB+RCebjCjbGyvZjYkvprEymlUu1+ClA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847133;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:Subject;
	bh=Vg77F5ocl8bfUJEusZ7umXrziR/EmjQNaD3WVEYV1OA=;
	b=LCl8uSooztCZDtpPnDoopH9BCydRyIF/iH4qZI56JNagvjtnudFgEJ2EuUtDj7z2vB3y
	 vWuSO18Sl4ToGdBI2b0ezDUghk/ISMwPGk2xXpM52rnYPGXmY3Nt3VICf0sJfTYDe38Ws
	 nTctiTuGLEC5aQOpbxUhlB9A1ZpXw3SwUfVCyYyKaHcSkld4AzinwG8vs1cuiyZ64SFCL
	 kAAWLtu4OInFdTeEHotD6QIrj73HCptEtmh4dhSe8KpRpvQvo1LWZGRXJ7DsmyAMkFGqT
	 Btkt5bOjrq/WjAqjRgjSljwX4F5ptGELqou+UBENpDPsGK4EAP2Fql0MaRgBi8dxqzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b="c/iPuPYE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C2A606A31C
	for <ceph-devel@vger.kernel.org>; Sat, 28 Nov 2026 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=c/iPuPYE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391D71F00893;
	Sat, 28 Nov 2026 06:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795847133;
	bh=Vg77F5ocl8bfUJEusZ7umXrziR/EmjQNaD3WVEYV1OA=;
	h=Date:To:Cc:From:Subject;
	b=c/iPuPYEW3Qfb4PeBYVtKXcG5TARdAQsmog5ILLG1r339kIysmgAJmaZV4vtlhxH7
	 HLMgV151GSHo3AiP2NRsNjTPC2CIzCMM2dgHF11pWjVRV0BsuZEVpP8M/hpvs6tfvf
	 TFfTHkwxC6eCQc/VqyUjGJv+Dmvh83K8XbgvK2H0=
Date: Fri, 27 Nov 2026 22:25:32 -0800
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <d56a5a0796c14ef68a178d7a010373c2.1@linux-foundation.org>
Subject: [PATCH] ceph: preserve data writeback errors in fsync()
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list

From: Andrew Morton <akpm@linux-foundation.org>
Subject: ceph: preserve data writeback errors in fsync()
Date: Mon, 23 Nov 2026 13:28:28 -0800

file_write_and_wait_range() can return -EIO for failed data writeback and
advances the file's writeback error cursor.  ceph_fsync() then overwrites
that return value with the result of ceph_wait_on_async_create(), which is
normally zero.  The later file_check_and_advance_wb_err() cannot recover
the error because the cursor has already advanced.  As a result, fsync()
can report success after an ordinary writeback I/O failure or after a
memory failure poisons a dirty page-cache page.

Keep the data writeback result when the async create wait succeeds, while
still returning an error from that wait if it fails.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>
Cc: Xiubo Li <xiubo.li@clyso.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>

 fs/ceph/caps.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ceph/caps.c~ceph-preserve-data-writeback-errors-in-fsync
+++ a/fs/ceph/caps.c
@@ -2651,9 +2651,11 @@ int ceph_fsync(struct file *file, loff_t
 	if (datasync)
 		goto out;
 
-	ret = ceph_wait_on_async_create(inode);
-	if (ret)
+	err = ceph_wait_on_async_create(inode);
+	if (err) {
+		ret = err;
 		goto out;
+	}
 
 	dirty = try_flush_caps(inode, &flush_tid);
 	doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
_
