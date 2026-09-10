Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF24746CA;
	Thu, 10 Sep 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040403; cv=none; b=HyIemNc8aKepvOWhbjR/efbnsj13ecQ4jcTlwnj7djNqgJb+ciFSxH5tOQYVmSPW+iADjBJOp5fBTVoeAABzwnlC3tSuU/UldyD/di0CN8xZ+U3Ye7vuRHt3CcFH7RQCQ5o6gzrwhzaA41QMFcW4izrBt7FFcuMyNy+OwLU961A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040403; c=relaxed/simple;
	bh=96lXYioszbpPR+oiWEwTgl6aBum+bP7Ktf3khXcXMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZGc12H939N7MOgSa9daJltxo7QfWcN8bTbkXHEqFoAucxUeI46Rp4hvsldm3aEIQcll3wTfRpFYUNdTWkiiyZ+bwDh53szFBcplH5hIXZ6tHG+ZN1w7E3RT1gYiEb6xdUgMI2GBiTdv9Q4URakz0+nmNlTgQu3XlTC3pWQ8D5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b=GIxh6xna; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b="GIxh6xna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789040385; x=1789645185; i=f3lix.dev@gmx.de;
	bh=sPzE0lwrFxb7DD5ec0EoanN+DCAxrdxKGSdLoReUtz4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GIxh6xnac5XWiC8v7ePQ5ttit+jmEDzKwFBt4wtUT3bIePrcutjdEeXVYlfnzcWV
	 6x14sH3zDEbiG9UP+DkNPQiIw2jWTBOnNXIAFyNCD8LPC4zc8MMRlKzV6uj+pRlEp
	 IQ4x1GgvyouCb18Z7c/fF78sADr94z0N2ShZitxn4UTMXz3d0hffFU9cqej04THjc
	 CvDDTsZh5RQl+YLjYZ5+a65zJJsEKtcoitnlj411F32Out/kB6UnoJekVfCsuskus
	 FaG4kcJx3yZosFHw9d+Ho0LeYracwe0zHoIrjEqGf/abNHh6eDYaFjemAR+nWRTsr
	 vDNC4tibkxJSCO1buQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1wRBei0S5B-00nhOO; Thu, 10
 Sep 2026 13:39:45 +0200
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libceph: reject mismatched CRUSH weight-set sizes
Date: Thu, 10 Sep 2026 13:39:36 +0200
Message-ID: <20260910113936.336895-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TpR38O3sWPJpOY0kYijRu9vMgwvvx9v3c+3KUQU9iQHQMV0gN3C
 tPCX3VFUourLW93MJdVtFgXZUFr/SY4alBhju6dPiHA8Je0dnN7fCDGnBkws7aC/Jtw8/iC
 zVcF2PmjpG/ztG7GypgrW4ojQW/vMBJTJILDMJ6lfmiwnqCneiK/1LKg3FZouikv0Ykl2An
 jO+Z2CDFK070VhFCXddDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DJp9VLofksI=;jOPUGdKx9qfrE3usmlC/hiBA+mW
 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
 kBs484VKmgn+Cqq18tRA8+rrU6IGFOrzn3Q==

A CEPH_MSG_OSD_MAP message can contain CRUSH choose args with replacement
weight vectors for straw2 buckets.  decode_choose_args() validates the
optional IDs vector against the referenced bucket, but does not validate
the size of any replacement-weight vector.

The CRUSH mapper assumes that each replacement vector has exactly as many
entries as the bucket.  A zero-length vector for a nonempty bucket makes
bucket_straw2_choose() dereference NULL, while a shorter nonzero vector
causes an out-of-bounds read.  An authenticated monitor or OSD can deliver
such a map and crash a kernel client when it performs placement for an
ordinary request.

Reject a nonempty collection of weight sets for an absent bucket and
require every replacement-weight vector to match its bucket size.

Fixes: 5cf9c4a9959b ("libceph, crush: per-pool crush_choose_arg_map for cr=
ush_do_rule()")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
=2D--
Tested on x86-64 with KASAN enabled:

  - a KUnit reproducer containing a complete serialized CRUSH map with a
    two-item straw2 bucket and a zero-length replacement-weight vector
    panicked in crush_bucket_choose() through crush_do_rule()
  - with this change, the same map is rejected with -EINVAL and the KUnit
    regression passes without a KASAN report
  - a valid replacement vector of the required size maps successfully
  - the KASAN-enabled x86-64 kernel builds successfully

The reproducer and complete console logs are available privately on
request.

 net/ceph/osdmap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 558c7c3a4a8..51833dba999 100644
=2D-- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -376,7 +376,9 @@ static int decode_choose_args(void **p, void *end, str=
uct crush_map *c)
 		ceph_decode_32_safe(p, end, num_buckets, e_inval);
 		while (num_buckets--) {
 			struct crush_choose_arg *arg;
+			struct crush_bucket *bucket;
 			u32 bucket_index;
+			u32 i;
=20
 			ceph_decode_32_safe(p, end, bucket_index, e_inval);
 			if (bucket_index >=3D arg_map->size)
@@ -387,10 +389,18 @@ static int decode_choose_args(void **p, void *end, s=
truct crush_map *c)
 			if (ret)
 				goto fail;
=20
+			bucket =3D c->buckets[bucket_index];
 			if (arg->ids_size &&
-			    (!c->buckets[bucket_index] ||
-			     arg->ids_size !=3D c->buckets[bucket_index]->size))
+			    (!bucket || arg->ids_size !=3D bucket->size))
 				goto e_inval;
+
+			if (arg->weight_set_size && !bucket)
+				goto e_inval;
+
+			for (i =3D 0; i < arg->weight_set_size; i++) {
+				if (arg->weight_set[i].size !=3D bucket->size)
+					goto e_inval;
+			}
 		}
=20
 		if (!__insert_choose_arg_map(&c->choose_args, arg_map)) {
=2D-=20
2.43.0
