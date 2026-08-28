Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86C396597
	for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939119; cv=none; b=U/4G5tUMWaq9ryIgVFRXC8pCP4IRwTI+B6NLaTwgapSsUthKm+1sz26aOmFZ/etcEvkr+qQxUJwo10EXAap8Q0VnJF14p/HnLARWkXfAai0KU7w84DJ2TmWdhUywt1+lyQFMWKXTTH7lPeyjLJE9C4U0gpO50W76ucc5XdjfwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939119; c=relaxed/simple;
	bh=gB5RTtAy5uyR3po6ncycfOXTkq1Gqhn9QMLyNLNNF1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGyZv70c2ajnarII7bQwGTW7HZ1+THYCcH6SgzPsyfFKgP0qInJR1usAKGAyICZ8bjJ09jvGV6UGJDFTLLFpraUtFbaxDqG6+CvASj9encXQ/QEyqjVojiTyXPP24FzvbMY8NWtDha2lHlyLr6WRUgfk5aazcI94aQiVlrduJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iMERkoKO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iMERkoKO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so8927945e9.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2026 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787939112; x=1788543912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LiTQ78YI5C0O3US8Qv7gUnvZwNb3AVrk0V6EDSLnVw0=;
        b=iMERkoKOvBmpyeG/hH4/xDJEibGcRZ5TADPpdSTn8Bdsis/K+1i/uqDPtVji3/Wzba
         kNxkqpM68n7fZnwtMUlDju/3L+UxplWL2m9XaZ8v4bH5zp57dsJw7pQqhzj3NUV/NtCx
         1MwjghA7rTxXXBYtypvrBTlPkrerXYdNLysC1meECfdsRRbho1tSJRcTYtk2lEk3RpFv
         zqsdQOhdEsjgweQzdvTtSKImKzGSwlq5GpUTKrqx3XuMQApvMg1N+/QSAibsE3hjs9QC
         HVCtW62fjr2F/GtAbKDHTjvhCXsNqsV7fIgtqKko0wRU2Zd5Imk++KvHxu1gMVBrhUsY
         Ue7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939112; x=1788543912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LiTQ78YI5C0O3US8Qv7gUnvZwNb3AVrk0V6EDSLnVw0=;
        b=hs8CNk43gPVbQf9SbP7Gnwm9YropQywQ+iDUEc8ANNlVkWPaeGeEZzuakcJ14/xukf
         7oNSUFXhUmgnTAnSc0ZA0RXPk2Pj4n7U2hrEdcof9VaPIAMAaLlcKfUVR7AS/bMuG9gC
         KNagjzlbqAU30CHrdddDlakkofs6/ntzPu3jc/4j5MmpjeEWBECb31QNJescgAt0w12n
         6w9u/TnAz0oD0KpNslQCtK4kMl4eSzYvzisUrK7GcmC9U9OPwNc+Vj6HgSz9IWBhb5Ru
         B67KtQU53/nRg8OlWlbmCNbuncS3JQyCGsscNCeKaGZBtUSbQ1wMgTdrjgObMohpIkjF
         L+zQ==
X-Forwarded-Encrypted: i=1; AHgh+Roef+WkAM8RXHayfJ5n9M2CuxXSSZShzGSyDTGtzq+Tzitno3EB3r1KpWPDMSE+R0h+nZirZ038CK2K@vger.kernel.org
X-Gm-Message-State: AFuF++kLs+Y3KldHKxT0iN4Ehcfj7Nm9xr+MtCTSme25BJYanGTxlu91
	Pw/3q2ir/wMM3qdTnuUs9XLIVqfZ6/oGG6TCODGeE7ovZugoY0aJ8aeyLgo8PRd8Si2UDHLweeJ
	R/+WECW0=
X-Gm-Gg: AR+sD13rUHbfNwktHeKe7SfqLHgBp7ViP8h0g4fax47YKFnD2B/ifSlhvfRr+JRWY77
	wz+MM3IN4T3OJqxJDCgRvBYnCsjgXtWSVdN656brdoSJxA/DggxWbnQgNqaf3wu6cFLbsyHWO1F
	gPMU7pQ6sWye/2jcU9/vHNS5iDnvp1U3vO1qswmGVMeBtxoCcmv09G8R9A3+aNJTDirdNdemP1W
	A9wNeG4lgMcwQK1aglth+eictj5kAllQi5BHd3m2Ul0DTppKn7dQ67F1Ef2EV9VchipShLjFu2r
	/ACaKtY7pSgsshAP3EWWBUgjXnfTr2GmdtAAK+iW/ViICVq/xW1/MzWkM/phV1WrUIXrLVEQ9JX
	ppaVCJlDrRb3KD11egl0INwmmVcGcBGrg0i5DUbHW7PKfUhUJAIMuRdkKDPwUCmVHdEogyz4ch6
	SMeXCj9qivLvf5f3fR/rx5anw/NJ5ZA9q7CB4lU0FT4ogk/b5OH1vprzOA7L84VLS8iJgR4kCNI
	P7cilEoBmPfmuUzSIeGa1bVUUoiuTaA+BA6UHOrZX2dM8uGRAC9KC7/BqUN27k5MH47anel8Q8=
X-Received: by 2002:a05:600c:314f:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49b91c38bcfmr120834755e9.6.1787939112420;
        Fri, 28 Aug 2026 10:45:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2794dsm5480678f8f.25.2026.08.28.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 10:45:12 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 0/3] ceph: don't unregister an MDS session before removing its caps
Date: Fri, 28 Aug 2026 19:45:01 +0200
Message-ID: <20260828174504.1247038-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_session() removed the session from mdsc->sessions[] at the very
top of `CEPH_SESSION_CLOSE` handling, before taking `s_mutex`.
Between session unregistration and remove_session_caps(), the MDS rank
has no registered session while the old session still owns all caps it
was granted.

Any concurrent filesystem operation may walk into that and the next
__do_request() call registers a new session for this rank.  Once it is
open and the MDS issues caps, ceph_fill_inode() calls
ceph_add_cap(), which looks caps up by rank, not
by session identity, finding old caps linked to the old session.

The list_move_tail() call then moves the cap object to the new
session, which is already a bad thing to do.  Since it doesn't
decrement `old_session->s_nr_caps`, this will quickly run into a BUG()
instead of crashing:

  kernel BUG at fs/ceph/mds_client.c:1959!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
  [...]
  Workqueue: ceph-msgr ceph_con_workfn
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : remove_session_caps+0x2bc/0x2d8
  lr : remove_session_caps+0x74/0x2d8
  [...]
  Call trace:
   remove_session_caps+0x2bc/0x2d8 (P)
   mds_dispatch+0xf48/0x1b60
   ceph_con_process_message+0x74/0xa0
   ceph_con_v1_try_read+0x3a0/0x1510
   ceph_con_workfn+0x260/0x460
   process_one_work+0x168/0x3b8
   worker_thread+0x1bc/0x3a0
   kthread+0x118/0x1e0
   ret_from_fork+0x10/0x20

That's BUG_ON(session->s_nr_caps > 0).

I was able to reproduce this reliably by delaying the close and
starting I/O during the delay.

This patch keeps the session registered with
`CEPH_MDS_SESSION_CLOSED`.  New requests will be put on the
`s_waiting` list where they will be resumed on the new session.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: skip CLOSED sessions in check_new_map()
v2->v3: split session pinning and stale-map guards into two preparatory
    patches; rework CLOSED-session and export-target teardown handling

Max Kellermann (3):
  ceph/mds_client: pin sessions while checking a new MDS map
  ceph/mds_client: stop checking a stale MDS map after dropping mutex
  ceph: don't unregister an MDS session before removing its caps

 fs/ceph/caps.c       |   3 +
 fs/ceph/mds_client.c | 164 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 150 insertions(+), 17 deletions(-)

-- 
2.47.3

