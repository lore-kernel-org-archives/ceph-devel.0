Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8D36EAA6
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jul 2026 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078383; cv=none; b=TlC/6up2wdBIqudzja11Zs/GBxhuwAWktAP2RFRL7EbvfNLo3Hxq4wpVvYcUBt+r5qJM2bVB8NbmwS2eG7GtnkFPSMCyNMO7YSWiz8PFjgJMHtS8ttk6GDSWJ1ZJICF3lAiyTS1OqjvcOtby3ArrZ/axryQevcvV88Aw/wbgNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078383; c=relaxed/simple;
	bh=UH7BuFXY0mTyNLMmwQGy+2I4KaMbYJ2QrOGX9DLbpiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XS82JG0VWFEMvWCu3hDeVi9E7XGnyJdY/mUFmpgFGspF3UV5NN5IiokSp2eZxD9dfdVZ3sdpfj42WVzf+QCR9R8GYSExopoj7sHcsis1jDc1zCOY5VE3f/a5QDnuEmEtKBka5isCKUny8N9ovN0yJtDK9T760VKOfCr4Z0MtmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e/AViQ0G; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e/AViQ0G"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4758bd3731bso359453f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jul 2026 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783078379; x=1783683179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXlhWG1WKeTg4AmWopqf59lXRVTRhCfpPcccqRSqFt0=;
        b=e/AViQ0GYKMpYq8H52yDkg3o+tkcr7qkNQXjuGGdqz2EC5cM/ypMDIXHbVnfBMlQWm
         Y+mk1gAfo4eV1tWZMybLPYdZ30XfjCuJavFxAcqcJgi57T+xEmFZyyRyg9s3odBvFi89
         7xJfCkI7/wDiCJAKfxNsdQ4lNa3x+Ryu+WmhadWRoFyn/BD2/i0HjGqpUEPAiXQSVE2n
         uECGQS2H13weiPY/kTI6THiGm74fkFqGHvbQrWGpCf8jdjfcPjIkwwBEq2G+eNGWvrj2
         5c4rvscUvAwxgRmyxObAqKNVOTTWcUtUfC/3emdkhh9KRMDjLpSEwQy9k8qIK3Ra69c3
         RU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783078379; x=1783683179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXlhWG1WKeTg4AmWopqf59lXRVTRhCfpPcccqRSqFt0=;
        b=Xa7OIE7X1MgUIopzU59J8EEcBlxDVw4574RZ3/gIFD3HGM+xx59kUsSLlPRy5JCxIB
         3O9+4H0NEB0l2a0S85FcqkN/H9nxp13IehypOg10E+HJ8FJ/FpfweY/hmRRWtdv8puOc
         gPSpacuwCYYllUH7RjtkP7JDGrLrbgwanu/f8aIpwkn++2qwrV2U723jx/NgaOONd1Bc
         cf+ffz/iA4Tdr2krLVwPqnAtOkVYpazVN5nmBk/Nk69bk8txvQuCpqRDT90M1NZ550Zr
         EBB3UipmVs5Su6auMJQgMUrky7qJXkILyIhcQ/wHBnYf4VEvebkANThYTjV/na8u4V14
         4Gig==
X-Forwarded-Encrypted: i=1; AHgh+Rrgjyiv3+3E9WMihrDIpF9LbY9MqD2iTeqcEAGUjbxEoeuAHdo5PgHuoxbgxavpdsm10/qf6bDRMGvF@vger.kernel.org
X-Gm-Message-State: AOJu0YxtedRaHDxym7QXWVBEloISJYkL6EbwMcJFR71L4vEXmTTiT+5H
	ap8BbOgFGbqEsrwmGGtEUcXlMJc6H4aGeYYxkXlIOXYqutWewF/K7EHuyD7AC3dVr1g=
X-Gm-Gg: AfdE7cmdk4QcpRo5mRvHbiv1BrKGKmLPm8iitEO1GR1RYnN++1gyRjxmZ5j3cdDzku0
	PSYtF/VV9K/FPWVmlyAu1DXV3v/TYPp6K5ty5Q91A+9K788fzIeZoNiw9TSZc5+t3XrQamK0l/8
	7VCwSlSyZWEhhViaDXAaAHPgy8UX2Oid6X1B4huBQRiBPNrsyesqPMyfmu6EdS5cFIf751JgHAE
	tFcSWC0/WAJInlwECJKxb2FIrrfNXrX2kvcDRrsXX3rFY4zVMNng4uyeZsz++UALJteadu3KHFO
	xZCVR+4r+ZPn4zIiX8xU44fqfTxtcHq8KtmB0iOkM3/lZCGxvQbLJxfugO64WLlCkSuUZ02+TA3
	nkx7ZunG1SagMNr9QtUOknPYG/i2g3QTd9VcHHK3ZhOf7GEyx8Cxdk8opqZoKftmdVBGGD2Ik5v
	xz/10614yUewbXloybULBP6vOLjg+WbHhtT8GTtZ442fMncRaK2ElseYpidzyPGiDA5jWA2gAAo
	0Wp1gJ5JNu8DgYU
X-Received: by 2002:adf:f708:0:b0:475:b34a:dc1b with SMTP id ffacd0b85a97d-47936391546mr3807567f8f.21.1783078378602;
        Fri, 03 Jul 2026 04:32:58 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4a09sm17566060f8f.13.2026.07.03.04.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:32:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/caps: skip __touch_cap() most of the time
Date: Fri,  3 Jul 2026 13:32:52 +0200
Message-ID: <20260703113253.3635335-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__touch_cap() moves one capability to the end of the LRU list; this
list is sorted by access time for just one thing: ceph_trim_caps().
That function is supposed to discard the least-recently used
capabilities.

__touch_cap() is called extremely often - several times for every
system call, but ceph_trim_caps() is only called rarely.

__touch_cap() causes considerable lock contention on
`ceph_mds_session.s_cap_lock`; this is a /proc/lock_stat I captured on
one of our web servers for 5 minutes:

      class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

  &s->s_cap_lock:     336304046      341686597           0.04        4905.76   418498578.76           1.22      892783632     1957814739           0.04         959.40   355752146.24           0.18
  --------------
  &s->s_cap_lock      339379730          [<00000000a2197200>] __ceph_caps_issued_mask+0x1bc/0x240
  &s->s_cap_lock        1268054          [<00000000c96a24b7>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock        1021360          [<00000000aa76f996>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock          16042          [<0000000099463548>] __ceph_remove_cap+0x1f4/0x270
  --------------
  &s->s_cap_lock      338509619          [<00000000a2197200>] __ceph_caps_issued_mask+0x1bc/0x240
  &s->s_cap_lock        1937864          [<00000000c96a24b7>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock        1203451          [<00000000aa76f996>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock            202          [<00000000888f212a>] __ceph_remove_cap+0x7c/0x270

In this /proc/lock_stat output, __touch_cap() is inlined in
__ceph_caps_issued_mask().  It is responsible for 99% of all
contentions.

Since __touch_cap() is called so often, it is acceptable to just skip
most calls.  The most busy capabilities will still gravitate towards
the end of the linked list, and if not, it doesn't hurt as much as the
lock contention.  This is still good enough for ceph_trim_caps().

This patch adds a static variable that gets incremented with each
call, and 255 out of 256 calls will just be skipped.  I didn't bother
to make the increment atomic or use READ_ONCE because I don't think
that makes a practical difference for this use case.

Another /proc/lock_stat for 5 minutes with this patch (__touch_cap()
is no longer inlined probably because it contains a static variable):

      class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

  &s->s_cap_lock:       1043711        1065182           0.04         502.72      737472.88           0.69       10522578       25069948           0.04         796.44    11053669.64           0.44
  --------------
  &s->s_cap_lock        1043074          [<00000000f4367d73>] __touch_cap.isra.0+0x50/0xa8
  &s->s_cap_lock          12147          [<0000000096f45706>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock           9472          [<0000000038a23e0f>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock            471          [<00000000e2eba934>] __ceph_remove_cap+0x1f4/0x270
  --------------
  &s->s_cap_lock         978499          [<00000000f4367d73>] __touch_cap.isra.0+0x50/0xa8
  &s->s_cap_lock          57794          [<0000000038a23e0f>] ceph_add_cap+0x108/0x3e0
  &s->s_cap_lock          27226          [<0000000096f45706>] ceph_add_cap+0x234/0x3e0
  &s->s_cap_lock           1581          [<00000000e2eba934>] __ceph_remove_cap+0x1f4/0x270

__touch_cap() is still responsible for 91% of all contentions, but the
number of contentions has been reduced by a factor of 320 and the
total wait time by a factor of 567.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..a5e2b00d91a0 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -871,6 +871,14 @@ static void __touch_cap(struct ceph_cap *cap)
 	struct inode *inode = &cap->ci->netfs.inode;
 	struct ceph_mds_session *s = cap->session;
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
+	static uint8_t skip_counter;
+
+	if (++skip_counter)
+		/* skip this call most of the time to reduce lock
+		 * contention; the LRU list is still accurate enough
+		 * for ceph_trim_caps()
+		 */
+		return;
 
 	spin_lock(&s->s_cap_lock);
 	if (!s->s_cap_iterator) {
-- 
2.47.3

