Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85B3403FF
	for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895895; cv=pass; b=Iuxuv0Eq1Q6ZqwuktINM5IqITOy8un+xThbrRCmmpu/ysvAA+2fTFRu9zcCG2zhnL5jjwSiKBxql3Xr8BN7GGUWHcBwmToHJc6R+SL//7yGtnr/HinhfpxXrdzgorVnapA+7CyHu3s4IS/46rKrf4UHql3yzPnKtlt790mckRiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895895; c=relaxed/simple;
	bh=TyNvMMqIrDrrdQrNSTAkjwcw9uAfd2HiNJdpFGlLXMw=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=DMy1NUgSbo8L+C3GOEfaeFJ3HvdlvbZeqlPslo2YMl06UtT/YMtXIBGVecEqc/bHaM2bJb0aTk3jl7SsHltK8wCBJRnaS6/HUnKL1vQSh1OqgU3iFCxSb4FbKwRF+oX/ItNDsA991mfP89qUzGK9m1lUV1w69q/kvcKG56Sri9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=nZewbbOn; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="nZewbbOn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d049069377so7446615ad.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 22:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895894; cv=none;
        d=google.com; s=arc-20260327;
        b=p5iLwylBs3Iq7o1JN8CX9Xqtxa+1iY5Q9KMiKzCq1uqNVyX7wm4ne1MzyeaNUk+8z1
         /HcZrqzD1l72Tq8Q+7Yqr0NdDwmci0rKd4u3pnUzriYBJ8QJFcAgUaQgHitoxhYNxp0A
         mfRHI0iedsD+HryvcuLCQv/XCnmvISl9CMqEtEDCb5pnb2C1WeT6ZGdJhpRg4kLELagr
         HvI/MMQKqSux3TkPYBwanVgJhGFIYU9XSNYtt1GSyIM2gC+nNSCodZhEY28bod68E9fO
         SPpxYF9lLgFNpWFBr94JazHfPlO1NgwncFF8KA6DqynzvuubTBeAax2X0o7NY5DhGJzK
         0bQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=GlVbWj9nJs4r3HvjeZeXaQSMdk8WIjeCxs6FsayvhQ8=;
        fh=CtAGUr4AfHPdhlN2+ULigVih8qaq0J7jdGjlmjHB5l4=;
        b=mGY15/o08mTI58xgnlKRs8jJUX0TMAnklSOI9dPaoa7XLXtPpOqp4PEG3NBqxYkOgJ
         g1PeZ9Gta9c0lZBG/wIfMV0QZtE7mRoPcdiLxPxfveqBvT2COH/ddBE6rmBUkM/1V6xd
         ZpYep1udDbRVfAy29JuvGB6heXUEIY2rb211CLK3km7Q75cWuiAmayPguYOQqkImEmCm
         MYuqdQkUqYgIQxVYf6PYt6lLliWenU57p7WddfoaZxM5Es8f8Sm++GHMlnSJ6kGUU3P9
         EGeVS9Q8NZXg5JaBykL6GDEFCzomfra03TqZcTVePvaaZ7knZrnQrc8e+Uk6ghF2DE3f
         JfpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895894; x=1788500694; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GlVbWj9nJs4r3HvjeZeXaQSMdk8WIjeCxs6FsayvhQ8=;
        b=nZewbbOn14tQBRrQuiwSJTZ08OlAxVu/MDYknSVUwuOVFpZwJR/OyArHF0NZfnskn2
         OFVwxnxrWUjsqgDy8WVX1YGuYb54IcYDpQksoyJSLX14QiIHYmgplQiS0ub7k0z4Xh8f
         xAHFG4J4pcee3+sFqNMgTaIMtVMkN8HQ5UMxA3ohjLxAIR+ZIIIOdWvi8sAGjtUZKAT7
         4zUk1MfgW3/ADkp4iiuAatVsk19EhqxT6i7G+lu2hd7NsGApUsWQFGDJ6GDZD5ivwXvQ
         7MkH28H/prhSeuTrCPlNBumEgF5HC40HacH7iC7Z/PAJG4lrRm5YylBbzpm5prmyVhXl
         RsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895894; x=1788500694;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GlVbWj9nJs4r3HvjeZeXaQSMdk8WIjeCxs6FsayvhQ8=;
        b=bz9g0X1VpPMxy4DRPH+A3naVT8FcOW5+f9JwQtEjuNVFfNfByDtYxoD2fHetl+/psU
         ciK8jDuuopIIUvKUUFsB5sfqhihlbzST7leRf976SoOayE3nu0XijOwGoi+anZvVSsSD
         1uNNNlpnUop+yEGVDSUx1WS+c4YtcfqcBMTkC2xNh135phI9uknS90w4j4xL/heBiy/0
         LBss6o5qDwiSSL8hTwePAsdPntYIPvdYNdZUvFqYHIuk2wd8JTUoCblGJerEc34z1gOp
         JlKAUoHjDh2feH124pvb7lBTPttmxWRJRq3SALkdqpPlzPT2D/YCdJvl/mL4pGdZo2lz
         wH0g==
X-Forwarded-Encrypted: i=1; AHgh+RqfHM7DzAUZxCUmNioFgvjvBsjRM2VRyCxvLP1uHyrumoArzO5F4EVzRSCKnTrKcaLPitLowVvhSP7H@vger.kernel.org
X-Gm-Message-State: AFuF++m81p0LhIM6jXXbhBvfVGtKIi7xwARJ+NUZatRnuARuTxJCkV0i
	ePDKhVV627f51tMEIKkiA0Xrdinf9txvjOQEf1TAi21s1MwEadtBd28taIhu7sU6yhSoccvRg01
	9bCAz92GZETrwfzeJ2+YFlmLRkbijAvs4gnUhg16z
X-Gm-Gg: AR+sD12VC6PKNMc6Ib2QMg48AXEVAvzOkftYBuhOtGOPYmAwYgLr4X2Hp8Ng3oIh1IL
	+0pahoFlyi57K2V1UwJyDJZ0j4YkVpUPBKK0pZakMaUJw0x8SvuLyjwoklg/V2QXNdfB7pmEax8
	8irzUckUpHAbDbbQLkwASPrz3qbG90lOeKwnn5gE0ToojPrYHeLP9iovlLj9UM3CrKTQEIZ0hqg
	rnDhVXNNTFvtLJ70bcDOWgbkba2cpB1uJaAufrMtkIOqKAG57usOgo532c8I268kFehnzhUET7G
	HtBn9C1gDqrpMGUOUdiMCh/h+gMc30o+M11NfpqoH+lbZQsiNCFARYBwY0sbhXu2LVE/dGt5mXl
	YXoSe6gWQ3n9sqZisa10709E+U9VSYnHw
X-Received: by 2002:a17:902:e74f:b0:2d7:5ebe:a588 with SMTP id
 d9443c01a7336-2d75ebeabbbmr24264815ad.13.1787895892791; Thu, 27 Aug 2026
 22:44:52 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:44:52 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:44:52 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:44:52 -0700
X-Gm-Features: AcwNN1X8SEHOkHuj9cQDgmFe2kkXov2vM2emNM_BCi0ltZI-VSEqYIh1j3pwqxU
Message-ID: <CA+0ovCjLWPoUdo=W93DQ4vKj-A+Xo0AQkjzcM+SQ35ph0VzukA@mail.gmail.com>
Subject: [BUG] WARNING in ceph_fill_trace
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/171-warning-in-ceph-fill-trace/

  WARNING: fs/ceph/inode.c:1632 at ceph_fill_trace+0x493/0x3a80
fs/ceph/inode.c:1632, CPU#1: kworker/1:5/11236
  Workqueue: ceph-msgr ceph_con_workfn
  RIP: 0010:ceph_fill_trace+0x493/0x3a80 fs/ceph/inode.c:1632
  Call Trace:
   ceph_fill_trace+0x493/0x3a80 fs/ceph/inode.c:1632
   handle_reply fs/ceph/mds_client.c:4050 [inline]
   mds_dispatch+0x4753/0x77d0 fs/ceph/mds_client.c:6384
   ceph_con_process_message+0x14f/0x530 net/ceph/messenger.c:1425
   ceph_con_v1_try_read+0x2f40/0x6f20 net/ceph/messenger_v1.c:1430
   ceph_con_workfn+0x1f5/0x1440 net/ceph/messenger.c:1577
   process_scheduled_works+0x881/0x1170 kernel/workqueue.c:3397
   worker_thread+0x988/0xde0 kernel/workqueue.c:3478

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
