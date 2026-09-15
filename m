Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A636A36C
	for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449574; cv=none; b=cljRBWw73zdbHw2+ck//vdyEBkPD8eK0B99gI4zULhfBNLjQbTenPaSquuc82rLJGORKWlsQ2qZO0dj8wNMAQx/RG/qr4UUs6QNjYX1qsldhjSB7RAyIBcFhhbjXrgkUNKh4XHkLxUu1dqZbkDsNV8ZZfe0V8mURK9N8L87DwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449574; c=relaxed/simple;
	bh=tRK/WLCmOL9yWhdP5u7X+a8hOKx87CLe/k7xw0s+QCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4/rBFusgpYo56vnGRSZfM0wl4QDVK+V3N30/KFJgQOaGwC3+3qUTNeE9wequRlL8jJIa+agugNJAWFJiIk1fcTL/jsVFJx2JL6bYOhDLCfuku1pitfEY7hoyWXA51HZoQ0RjFPKuzwoyXNpJUdUdzYGc6vvkbzIMgRNIkFittw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=q7rAe4ly; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="q7rAe4ly"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso731843a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789449567; x=1790054367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OOwy7c+zcjkAyM/C1EYhF9ectrxzXXceO/PRGImhvE=;
        b=q7rAe4lyJRGIY1qra+QwabZXXcVkexZdsB7FW/7cl1ndR7E0EisBYCtvRJG49n6oaV
         cPRTRyvN9KdMjleC7i0MgCg3eeN6Qv2s7WoZ60GmHMVoRAwKqU4SFMyQFNobznZciBy7
         qDbGzs+W987wXO1BvnTvqmBQl5S5Z5i4NF7K5LmaQwuvxCywg7B3jsQS9KUvj7rpCqdj
         FUQzAWbsFDlXCchxBNQUH7suXnHSsZOmxZ2FkH0jfogHQMsiMlAOEDW6MM++NoYrd4GU
         tWGRc06SO5ZPNsmYzhtS1SFoo7DYzirfo6DCgpsRJMINIaFs7+3t5/UOz6ba03YLjpCe
         eMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789449567; x=1790054367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OOwy7c+zcjkAyM/C1EYhF9ectrxzXXceO/PRGImhvE=;
        b=cxIrvJK+FpgPU2vzvLrXND3Tk4IFzAH8wgI8A229ADOFt4uJzziAkVpLdjJERyq3N2
         tXP+oq+YID+m/ndRrMWh4TaTlK9MKTA1TW2ektdIaMZUFg0XYnTv3l1sKnjCd4lEh1Q4
         soWsLhmkOtVUvGri5T7jpOl3I1gQrFHhWGoTpu0WFzpVnHFieAy/6J034orWfUwQ0TbE
         BBJimCQlGAG0ItI93pcpYW3nBbKciT1wJu/1j10gq12UadQaMPLtcoNIGIhohj5bdn3V
         oNAAL1sn0GLptBggQcragsqqjonEsvzHk2Y9vAg+OIybR28CEw0tbXB+wuoO+oNop33U
         NVQg==
X-Gm-Message-State: AFuF++k/1Daz81RlLYaddmC/suEkku4wgzPVwdRAJ7C3VO/s1r2vSpIf
	iwCQqoPcbZ7Xe6eYso15kBXawNaC6J1XHnIqws2EZElybC95Eah4P8pV+2ygMreLWg==
X-Gm-Gg: AYBFou0Qafgz/IroD/mNpKAL7R/kIsgPGVM+WyZWBGj/0KbJ9NLKk5pnDUMfWL0tUzp
	+l3di5wRB4cc4UxMiWKc1CtrS3dZEnYuM4X8G5bmXQLzUFNIsq8Cni8lGMUodtBlrAjg8V3tIIT
	CDZpTB+kKsmCjJrSMPJidZD+Yjwr2ESRAI+9SSP3DbN2SRQ0YyBPEt7BjoVK3vGhiFUavLEW5eO
	7ATJgo2UZQeH0HFNNJaJk9MdJj7PnWfNLbWlQhgclFa6wv8ft20sbcS0p2O85QOKY8BQ+EtYnGQ
	L8kycrWAuERtfUdZ2l3gJi4udw3oYIAuceUukhbRdlNrmbgCbpjH18p5Crlpc9mKdISIgOJH1+Z
	oKE58dOuE3DE/4GTkIQVZTG3D/5irvLTmowuhdtOoOxYXHoOWyqbVaaDONP/Omx3sl8TmtANI78
	DOzllKDEp5KrwChoiGkKaM+QiizC5grSZqtBxx+reb0sGFPTJEUBM8EvlWr3SV5Yw7iw481ROLG
	TjA/9gu//QdRFjxLcUaSq43w6DuUsD+EMRm1A==
X-Received: by 2002:a05:6a20:7493:b0:3d3:aed2:6f28 with SMTP id adf61e73a8af0-3db501db9afmr3325689637.28.1789449567479;
        Mon, 14 Sep 2026 22:19:27 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e4fb3esm30593846eec.7.2026.09.14.22.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:19:26 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+f8e3e01d8dda8689@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
Date: Mon, 14 Sep 2026 22:19:24 -0700
Message-ID: <20260915051924.737109-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_new_map() sizes its export-target bitmap from CEPH_MAX_MDS but walks
it with newmap->possible_max_rank, which comes straight off the wire:
ceph_mdsmap_decode() sets it to max(m_num_active_mds, m_max_mds), then
overwrites it with the size of the "in" set.  Neither is bounded by
CEPH_MAX_MDS, only by m_info allocating, so a monitor announcing more ranks
than the bitmap holds makes test_bit() read past the end of targets[].  The
clear_bit() loop above indexes the same bitmap, though it is additionally
bounded by mdsc->max_sessions.  The map arrives on the monitor connection,
which is unauthenticated in legacy msgr mode.

CEPH_MAX_MDS is a protocol constant from src/mds/mdstypes.h, and the
reserved inode ranges in super.h are laid out one rank apart over that
span, so a map claiming more ranks is corrupt.  Reject it where the rank
space is established rather than letting the count reach check_new_map().

  BUG: KASAN: stack-out-of-bounds in check_new_map (fs/ceph/mds_client.c:5968)
  Read of size 8 at addr ffffc90000ac7798 by task kworker/1:2/127
  Workqueue: ceph-msgr ceph_con_workfn
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
   check_new_map (fs/ceph/mds_client.c:5968)
   ceph_mdsc_handle_mdsmap (fs/ceph/mds_client.c:7060)
   extra_mon_dispatch (fs/ceph/super.c:802)
   mon_dispatch (net/ceph/mon_client.c:1483)
   ceph_con_process_message (net/ceph/messenger.c:1424)
   ceph_con_v1_try_read (net/ceph/messenger_v1.c:1430)
   ceph_con_workfn (net/ceph/messenger.c:1576)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
   </TASK>
  The buggy address belongs to stack of task kworker/1:2/127
   and is located at offset 288 in frame:
   check_new_map (fs/ceph/mds_client.c:5846)
  This frame has 1 object:
   [32, 288) 'targets'

Cc: stable@vger.kernel.org
Fixes: d517b3983dd3 ("ceph: reconnect to the export targets on new mdsmaps")
Reported-by: <co+f8e3e01d8dda8689@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/ceph/mdsmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 53079ef34c3a..5e3b8c3ca502 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -170,6 +170,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	 * and the mds rank >= m_num_active_mds.
 	 */
 	m->possible_max_rank = max(m->m_num_active_mds, m->m_max_mds);
+	if (m->possible_max_rank > CEPH_MAX_MDS) {
+		err = -EIO;
+		goto corrupt;
+	}
 
 	m->m_info = kzalloc_objs(*m->m_info, m->possible_max_rank, GFP_NOFS);
 	if (!m->m_info)
@@ -316,6 +320,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	{
 		int num_laggy = 0;
 		ceph_decode_32_safe(p, end, n, bad_ext);
+		if (n > CEPH_MAX_MDS) {
+			err = -EIO;
+			goto corrupt;
+		}
 		ceph_decode_need(p, end, sizeof(u32) * n, bad_ext);
 
 		for (i = 0; i < n; i++) {
-- 
2.43.0

