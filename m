Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243433263A
	for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190254; cv=none; b=R+h4D1rTCfFvFStz5EGYBb38WetK5qnis4d3lVM0jcW3ECumCB5rYgukQf1gKreHJRW+Aj3vkO0P6LA2EdHQCIUiZNw23+4TDKzpvX2so/vJ2qxJiL79tJEK3gK9i816onuQfHaPtPMYs8FxB9J+gkjP8XwR9Ag/7UUtubj2H6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190254; c=relaxed/simple;
	bh=2zdbSDYo2a4iqVuU9shfVMNQnc3dcNJq5nqcEPmoTd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKyJlkb/xPuEa9IoXVUxxH6cNlwOE5tNRlTx9WK36/LI4pEeeIAgfa9me5eAsBrCrAXEz5lIH95NkYZlzxRYUl4n7cxhWYa5W7k1mvzwotpT/N4Doeh6zdxEGkRAYTthUStgA/YTlUyE80HrmyfxtbvxhKtkHPonzE16l5vt4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6aZw9Ch; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6aZw9Ch"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91066394ef8so279330785a.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779190250; x=1779795050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdnoiIWTikhhiv4xZc+nEe/cpMOrkcgd3lQkjWYtbHs=;
        b=g6aZw9Ch4UtPKi/LjUypQDlcdjIICFxfAqt097JPkHwgKCXWPdXcxnN0avWS9KaTrd
         6YsvdHohDfWHegvxnhSwgPPKSENz0EZyWeWDgB7WoB5XpQ80lyi4yj5c6lYw2ecNba2c
         nZUcfjQmsNNWZkPAc8sHk/OEyo9ELKCYJ/n9SO7B0d+6gtdwyshm9RtgQ2dXsP8rqbiL
         qJaZN1GdXR30aK3aJ1eAWpOsXgzC5WlNXrq1IkuKM28yTowBl2q5JnNh+hFrHF2X2PWw
         NFY6MRjifIbqA51nFbyTNy7JOjA6jC3uH972SuYYy8Rijjizrg2+9Gj7gQYJy2vx3p8r
         vrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779190250; x=1779795050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdnoiIWTikhhiv4xZc+nEe/cpMOrkcgd3lQkjWYtbHs=;
        b=SupEcZOnLtalJTF17sRMvkJqtrXXozfkXF1JsBF6AZRDzTCltQBbyAFrWWzzu/A7xw
         kFZN/I8yikD+OsL6f/lpX5tHjKsxWsOJMeIFZ4FeMNN0U1LFaQzIfeE9tZnSWiBO76+2
         wJEENnQnR8XI4ml1zLBo3cIwfZai47rSfBTEFNxOVBXb4m+i+GoxvV+bB0F/S2yqZJrV
         UYMy9ZaK2QbY4q0PUo2CxvzzqXfmLJRefRZ3yFXBDdluU8fV9bZGYfyO3+DxtdqSQ0WQ
         SBDL/jiGeQHT+szzljwnR0pDLsWH+rQhjR6LZFJGX2uIMlirnb+SYSv2q3hGFRSoQSwE
         ljSg==
X-Gm-Message-State: AOJu0YwRh92TDnSAZaxMwFm4Fzr76/ywjzdb5q6IXXdZ5+L9NGP3td8e
	abmP17DqDckVfmbPbfGrxj3hzrArof1kZqJTQxdasiYHj/MV6bwqY0yA
X-Gm-Gg: Acq92OHfyf1VRrceYr8JZEyxEzXqnDBq6Dwy86PSaEVrKFzHiCKBAaL4gCeIvxgmZ09
	/A3HCPQrzU75JelcdoqgeKloXyvbq4omENiRo7BBdIEDYZvwbgKvQEsPMRKWIhxG4OEVFCRbqwK
	dTxxSSheKR0GJ6Vwj/NgzbBLEBNP0HmNO1o92pyOrP6dPn/sP2F73s+lLXPwFcTSPMYMiswBYqN
	TxMITRsZFOBzD6bpLCJ7Qp8zPaJ5CuJ/hxYMPKpJxPKvYdxCmEL0+bXKOC0Ijh2OY1JIqxhnYX8
	0krRbeTkXjEvxQJx2cIt5qGXOamQlJP2GipL2r07zq8o9LCbjp58qdGUYqc6EZJxNThWIPDMadw
	xt677iHgA1JBju/WmQQvqygaIDN/PzSv49F8gidvLjepbxzjHmlW2HHWnXdiT+Qhrw1NUqkkMfW
	Sx3avU1scRvQW8HSPwVdmhq+hlHb/dr3mALb77GhylK6wWloxdAdSSsDf3AfW9Ay3K/gZWp1nI1
	PURnrFZEKXAwc08yLaT
X-Received: by 2002:a05:620a:4406:b0:8ef:ed0b:c235 with SMTP id af79cd13be357-911d087dccamr2744259685a.56.1779190236546;
        Tue, 19 May 2026 04:30:36 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37762sm1880795585a.36.2026.05.19.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:30:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ceph: bound num_split_inos and num_split_realms in ceph_handle_snap()
Date: Tue, 19 May 2026 07:30:17 -0400
Message-ID: <20260519113017.1851462-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A peer that can deliver a CEPH_MSG_CLIENT_SNAP to the kernel CephFS
client (a compromised or malicious MDS, or an attacker who has
forged/replayed a cephx session on the cluster network) can cause an
out-of-bounds slab read in ceph_update_snap_trace() by sending
num_split_inos or num_split_realms as a small negative __le32.
ceph_handle_snap() parses both counts into signed int and then
advances the decode pointer with `p += sizeof(u64) * num_split_inos`;
the multiplication is in size_t, so the signed operand is widened
modulo 2**64 and a wire value like -32 produces an attacker-chosen
byte offset that walks p backwards into the slab. The subsequent
ceph_decode_need(&p, e, sizeof(*ri), bad) passes (end - p is huge),
ri = p, and the next 4-byte read inside ceph_update_snap_trace() is
performed from attacker-positioned memory. The same arithmetic and
the same pointer hand-off exist in the non-split branch.

Promote num_split_inos and num_split_realms to u32 to match the
on-wire __le32 fields, compute each array's byte length with
array_size() so a size_t overflow saturates to SIZE_MAX instead of
wrapping, sum the two lengths with check_add_overflow(), and verify
the total against the remaining front-buffer length before any
pointer bump. Re-use the validated byte counts for the bumps in both
the split and non-split branches.

The MDS is an authenticated peer under cephx, but the kernel client
is still expected to validate metadata it accepts over the wire;
this hardens the input-validation boundary that snap-message decode
crosses.

Fixes: 963b61eb041e8 ("ceph: snapshot management")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduced on x86_64 QEMU/KVM, KASAN_INLINE generic, two ways:

  - In-tree harness that allocates an upstream struct ceph_msg via
    ceph_msg_new(), writes num_split_inos = (u32)-32,
    num_split_realms = 0, op = CEPH_SNAP_OP_UPDATE into the front
    buffer, and calls ceph_handle_snap(&mdsc, &session, msg)
    directly.

  - End-to-end over a real TCP connection from a real ceph-mds
    daemon to the kernel CephFS client, with num_split_inos
    rewritten to (u32)-32 in the front buffer and the messenger
    v1 footer.front_crc recomputed so the kernel libceph receive
    path accepts the message. The KASAN report fires from the
    tcp_recvmsg softirq path through ceph_handle_snap+0x345 into
    ceph_update_snap_trace+0x23bf, confirming the bug is reached
    via the normal MDS->client receive path and not only by
    direct harness invocation.

A stock v7.1-rc3 kernel produces:

  BUG: KASAN: slab-out-of-bounds in ceph_update_snap_trace+0x23bf/0x31a0
  Read of size 4 at addr ffff8880012be1f8 by task init/1
    ceph_update_snap_trace+0x23bf/0x31a0
    ? ceph_handle_snap+0x312/0x900
    ceph_handle_snap+0x345/0x900
  The buggy address is located 248 bytes to the right of
   allocated 256-byte region [ffff8880012be000, ffff8880012be100)

With this patch applied, the same trigger (both via the harness
and via the wire path) hits the new validator's goto bad path,
logs "corrupt snap message from mds0", calls ceph_msg_dump(), and
returns cleanly with no KASAN report. Harness and wire-injection
scripts available on request.

The kernel ships no fs/ceph selftests and no ceph KUnit module that
exercises ceph_handle_snap, so no in-tree selftest delta to report.

fs/ceph/snap.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 52b4c2684f922..7c4487eb2708a 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1027,9 +1027,10 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *e = p + msg->front.iov_len;
 	struct ceph_mds_snap_head *h;
-	int num_split_inos, num_split_realms;
+	u32 num_split_inos, num_split_realms;
 	__le64 *split_inos = NULL, *split_realms = NULL;
-	int i;
+	size_t split_inos_bytes, split_realms_bytes, split_bytes;
+	u32 i;
 	int locked_rwsem = 0;
 	bool close_sessions = false;

@@ -1048,6 +1049,24 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	trace_len = le32_to_cpu(h->trace_len);
 	p += sizeof(*h);

+	/*
+	 * Validate that the two MDS-supplied counts cannot wrap when
+	 * multiplied by sizeof(u64), and that the two arrays together
+	 * fit in the remaining front buffer before any of the pointer
+	 * bumps below.  Without this, a malformed (or malicious) snap
+	 * message can cause 'p += sizeof(u64) * num_split_inos' to land
+	 * at an attacker-chosen offset via the size_t * int widening,
+	 * bypassing ceph_decode_need() and making the subsequent
+	 * 'ri = p; ri->created' read out of bounds.
+	 */
+	split_inos_bytes   = array_size(num_split_inos,   sizeof(u64));
+	split_realms_bytes = array_size(num_split_realms, sizeof(u64));
+	if (split_inos_bytes == SIZE_MAX || split_realms_bytes == SIZE_MAX ||
+	    check_add_overflow(split_inos_bytes, split_realms_bytes,
+			       &split_bytes) ||
+	    (size_t)(e - p) < split_bytes)
+		goto bad;
+
 	doutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
 	      ceph_snap_op_name(op), split, trace_len);

@@ -1064,9 +1083,9 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * child.
 		 */
 		split_inos = p;
-		p += sizeof(u64) * num_split_inos;
+		p += split_inos_bytes;
 		split_realms = p;
-		p += sizeof(u64) * num_split_realms;
+		p += split_realms_bytes;
 		ceph_decode_need(&p, e, sizeof(*ri), bad);
 		/* we will peek at realm info here, but will _not_
 		 * advance p, as the realm update will occur below in
@@ -1144,8 +1163,8 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * positioned at the start of realm info, as expected by
 		 * ceph_update_snap_trace().
 		 */
-		p += sizeof(u64) * num_split_inos;
-		p += sizeof(u64) * num_split_realms;
+		p += split_inos_bytes;
+		p += split_realms_bytes;
 	}

 	/*
--
2.53.0

