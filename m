Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEF2417D1
	for <ceph-devel@vger.kernel.org>; Fri,  6 Feb 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392780; cv=none; b=dTI2fwST0uu1RfbAlMasPPX9t7EMzOcmoyyhMhQ0hIxSHPt0ADutgIPT2nRn5d0yP7VKmtuiIgSJA3CqAYIOyNfOIkT4W4oHrcAl/YdAFbg7PMtmzQ8GiAR9CyaYx+9MMJ+lXLDtCETebWYW+N9yh1ovA8dyOZntSM36iWI9D+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392780; c=relaxed/simple;
	bh=b0+Bte4dgAh7ipXKn2qxNAR4SPWavmbHCLyixVr33Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kslpShnJpmy1KQwzD4QiMGcSBwMNGve2ZJ/Aj5x5O3dut9Qd+2shao0z9w8Y0Z+v7169EaXO5WSJgMoj6UyvPbwFkPK+YlMwAnCQ9r4+uvlSGgKVw7yvrIxYo57kKkNTMJXUGOWolf00FYv5Cp5IbcP/Vh+i6q24VJDOI1cCZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNEnEdQU; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNEnEdQU"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-895071c5527so10740436d6.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 Feb 2026 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392779; x=1770997579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZSSxMdqjzfXmMX6nrA4gIO4ApZ7Z16X71f8CeQJJaE=;
        b=RNEnEdQUFeHxhkiiOs56L4B7Lt7t1ummlNu0TELVk3agfGZT/vnZQqkiquMNsSnCmJ
         q2nkSzHXtKjg7pmOCcPZiKYi93IjW1W/2h0gFHgs8GOrkDBfBrJqEx68orPX75VeYfej
         G2wSbplcV56/4HxF0p2rgYZFj9+2x2YsszDFbtku9SJFii1Ip7/oAr5oF7DboDv7fcBz
         dPCwHRX2UbMk/fgbG3aDgFY83R09C90E2X2/1YLt1roLrLRYsJtnrd6Ct9qht98uoJ5j
         Jqjt+yXg2wl9tB+hKBDXjhxJZl4Eml2ErOHdJGC3WYZeFtYW2OumpLs03n4eNNOYCJda
         lHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392779; x=1770997579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZSSxMdqjzfXmMX6nrA4gIO4ApZ7Z16X71f8CeQJJaE=;
        b=ipdsk1sJetZi7EDoqikLxKhollUIKE9+faatC2ADfCulLQFQ4ijkUtd8icW1YthTP9
         PfKmcTSZK29L8gTzV4S0Sq9dTDoirsH6m2+PyzghQsfJXUzA0kb+lqf/pLqUyom8jFYB
         wS8Ysou+HhXzJcE39x/+4TMmxaZf8qPEtl5t7FmUgmyPHS3oZwEPrPFXxhutKRmtlx4I
         gSxHruDt0B1+vw5vxeHW26My1tF5io777Tk1UXBLwaatsAJo/U4aK9tXKMBxLuPDP9HD
         bhKIwG/sOTlmU1n+FrRXMlJvxNNujkWbaTHMkGePUlG/uaUKqttwkootlF0l8zL4a0cT
         OMog==
X-Gm-Message-State: AOJu0YxgwRyAWZPwni0wJlgdl8rMMvNe5GYZi7TwYVAqLVTYRv5WBrbo
	S9mH9Lu5Twuf7fFkyzVWBWl5Sm66gbQ1o2upy7ncT8ZlY7tXJ7HJ/gEd
X-Gm-Gg: AZuq6aLW/3G696LTlhbXoO+XX6G3c9EyEeWatU7ANxRotunfA+bkOrMQLw/ej63FZQN
	554IjKuAzBZQ6s6UVfxGLxsGJKwrHWL2tKnIYKql0qY7kqg4f+k3XiO9ZriS+vPRduJDhbICoFe
	o1FwXnWN+3nJF0/wOyWuKeaqhQBe4WpeyHZGI47xtg1gY3DvPcFGsXEyOzbcO/M7xIixduHXI4g
	iMwRu5aiJPB8fXsxfUyAXaJ2o+sllADFBL8NZMdaC2DNw6h+LV8sPCcnEBD54aZrmTPFSkreusR
	RqF2gcmiw0aVCJnNDIwvdoum+5UBbpRLbKlCuFMQa2wA7uy6vkAeVupSnGIDOViM9JBP7L9yHDb
	ygaHY2FFa1hR3u+X+ooSrbmrMomqF4Gq86+byz2oEyy1iAMvutbkmkV1ggqB18o2UyGgF/cT2z7
	ChSbZcMG33wYu4a5o0bsF+8dCK/Yqn9BMbBkc9vNTtRvqjzdKsk00NWLgdgJtvbek=
X-Received: by 2002:a05:6214:21cc:b0:890:6331:7e7e with SMTP id 6a1803df08f44-8953cd97fbfmr43164176d6.60.1770392779066;
        Fri, 06 Feb 2026 07:46:19 -0800 (PST)
Received: from zambezi.front.sepia.ceph.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf5b2ddsm19206376d6.18.2026.02.06.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:46:18 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.19-rc9
Date: Fri,  6 Feb 2026 16:45:32 +0100
Message-ID: <20260206154605.1369203-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:

  Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.19-rc9

for you to fetch changes up to 7987cce375ac8ce98e170a77aa2399f2cf6eb99f:

  ceph: fix NULL pointer dereference in ceph_mds_auth_match() (2026-02-04 22:00:42 +0100)

----------------------------------------------------------------
One RBD and two CephFS fixes which address potential oopses.  The RBD
thing is more of a rare edge case that pops up in our CI, while the two
CephFS scenarios are regressions that were reported by users and can be
triggered trivially in normal operation.  All marked for stable.

----------------------------------------------------------------
Daniel Vogelbacher (1):
      ceph: fix oops due to invalid pointer for kfree() in parse_longname()

Ilya Dryomov (1):
      rbd: check for EOD after exclusive lock is ensured to be held

Viacheslav Dubeyko (1):
      ceph: fix NULL pointer dereference in ceph_mds_auth_match()

 drivers/block/rbd.c          | 33 +++++++++++++++++++++------------
 fs/ceph/crypto.c             |  9 +++++----
 fs/ceph/mds_client.c         |  5 +++--
 fs/ceph/mdsmap.c             | 26 +++++++++++++++++++-------
 fs/ceph/mdsmap.h             |  1 +
 fs/ceph/super.h              | 16 ++++++++++++++--
 include/linux/ceph/ceph_fs.h |  6 ++++++
 7 files changed, 69 insertions(+), 27 deletions(-)
