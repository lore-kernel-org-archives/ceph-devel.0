Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64EC3D890F
	for <ceph-devel@vger.kernel.org>; Fri, 13 Mar 2026 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429255; cv=none; b=Y6UERLjUqzRpCMkeiDzkN29OsT7vEYHvo6bwl/RQriNQs6llNex+WB3mQDdaeFoPsaYsGlttENPm/qfqurmlr3lX8FrA0iNq8kvfdobByAUQH0vVo0Gbb6xrYVz+NCDBbXxBFfVpwrsWRUEG+o/1KbAx5Ise2C9KhXfR6e2RHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429255; c=relaxed/simple;
	bh=VakASgl+mB49M341LGWqYlUfkHxkOVcfatBjS8LGfMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZ3U7fFseuB+Sc1tCCG0PhtLnAXnHnuQDtiPu4COIiiGxCNakwD5of6SqtJkAsZMEyTFGKNMKZymWRingolWqNboES5im77++TwMXtJKwIVG+dTOFHPEyr9v5fgGT8k5HZM10LY/yHgVfIUyF2TNd/xAyj6tpmuQzuiMz5++IWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQAFVRaA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQAFVRaA"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509006c070eso21794661cf.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 Mar 2026 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773429253; x=1774034053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MX4QERGgoB1NrRAVfwy3eLosUvE7wFcbpEOMGtvBeZk=;
        b=cQAFVRaASph5Sf9pzYn+Cz/V/mSlXzDW/rdjyNbVzjqL303p26o24hwKt61eHHLSc6
         H95S1/UydguCSyvi0Xe8X2Pz6VtmgluZPwxMdKQCp8qEGKYJFovNyU6GRhl1eTzkM+c5
         HxngOrWBgZfk1yXHDk9Iifsu8fORcrX2W1Z20PcGR1krVC/4LOO3QmuUnfx+2LqLi5L8
         z7E64xreKC62A1t7IEFPXzHOpvLNiXqqPA1Ckck6eWZfZyl508S/YckwYQA6IJ3RGs5d
         y/8i0Kf74iDPwx5OdLqqMyV/GbVHygm8XC/G+q8amhpNdpuu1L4Nz56q4ZBThqK5629c
         cgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773429253; x=1774034053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX4QERGgoB1NrRAVfwy3eLosUvE7wFcbpEOMGtvBeZk=;
        b=bZR19oHCnXeHcR07r0eD551dcYqUc+Bs9pa6iMjZVgaNYiEClsa+ySaxM8y7i0jJoL
         sJYrksnqpqDXnHZ9VcPM+GN5rq57nzfSSBI4v3MXf+cdxbftmUrV+Jj1wDGpKZlItQyH
         xsXU5ahVSw9MVJz8HB0FR+2lQbG/xRlzR2Pk8aLSnpdc61FWN9pI4YPJ2DXW9FJ+/uxN
         sf7TRT4JqmfgnTp9RQGqn1jrYiR+B5cmtPd3HQ0us3pV0O0y34MYgsqt6bUjV30WmeXW
         JOXpMRtTsowH/TLZAqtMAAJ/Cbp/7YYMx2SimQANyzz+YaVsNOq7iQOejc+2JYzrOD0K
         PjFg==
X-Gm-Message-State: AOJu0YzrLiX8BRUOwPDbAVYKvzv/ufBknjzMyt9Qty8SbP2KXtwOIopJ
	ZAhEKdhmVoQoEGGRVAWI+zzbfdDPUaaawe/x9xEqRVgTTdYhIlO9bRsNbmFp4g==
X-Gm-Gg: ATEYQzw+HQxLBn2hwW74A+IocpJd7aCRuBG1zxI2hN/Yec8Gv5O6+hN3QQL+j3RK7Uf
	yy/lSitNMoZwXtSSWhawiOCXrQHjQc/qNct+xvcfhQ2ivE5f6Xe8vWN9f/Pt8eLnFfr/W1gbNt5
	A/fNMOo572ngzktm6eZ9ZUWrfESzLywX7Lce5hVXFeQXzbFJ68QSHPKer7M+GKpXSY77TSt1rc+
	8m8ZA8fGwoctnU9BBr7FK+ZiKtRzXogKYQxBXVMNQj9k6iZnZ23EEUAcczgpyG3Cr7B/vMyvriV
	GorCzBci0MGw/foKk3cKD8vz7pxO0c2haiz1T+YIfGyW2YIDxGamDHINgDZtts44Y+bOifsKcuZ
	+RqUbIjy70bYd7zox/Zg8TQsJGchmmfyZ+ePTEglmTy+uoXLe6oj2u2n7vAEeOsVENoQFNXd6dA
	1XFOwmi0kOLUSR2VAkNIjVsh2CiyiMrGf7e91VbpCOY1QjbTAuXVWfTqVKL5M=
X-Received: by 2002:ac8:5cd2:0:b0:509:216d:5e46 with SMTP id d75a77b69052e-50957d6395amr57269071cf.34.1773429252634;
        Fri, 13 Mar 2026 12:14:12 -0700 (PDT)
Received: from zambezi (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a14791dsm61634651cf.31.2026.03.13.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:14:11 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 7.0-rc4
Date: Fri, 13 Mar 2026 20:14:02 +0100
Message-ID: <20260313191403.1075765-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.0-rc4

for you to fetch changes up to b282c43ed156ae15ea76748fc15cd5c39dc9ab72:

  libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply() (2026-03-11 10:18:56 +0100)

----------------------------------------------------------------
A small pile of CephFS and messenger bug fixes, all marked for stable.

----------------------------------------------------------------
Dongsheng Yang (1):
      MAINTAINERS: update email address of Dongsheng Yang

Hristo Venev (1):
      ceph: do not skip the first folio of the next object in writeback

Ilya Dryomov (3):
      libceph: prevent potential out-of-bounds reads in process_message_header()
      libceph: admit message frames only in CEPH_CON_S_OPEN state
      libceph: reject preamble if control segment is empty

Max Kellermann (3):
      ceph: fix i_nlink underrun during async unlink
      ceph: add a bunch of missing ceph_path_info initializers
      ceph: fix memory leaks in ceph_mdsc_build_path()

Raphael Zimmer (2):
      libceph: Use u32 for non-negative values in ceph_monmap_decode()
      libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()

 MAINTAINERS             |  2 +-
 fs/ceph/addr.c          |  1 -
 fs/ceph/debugfs.c       |  4 ++--
 fs/ceph/dir.c           | 17 +++++++++++++++--
 fs/ceph/file.c          |  4 ++--
 fs/ceph/inode.c         |  2 +-
 fs/ceph/mds_client.c    |  3 +++
 net/ceph/auth.c         |  6 ++++--
 net/ceph/messenger_v2.c | 31 +++++++++++++++++++++----------
 net/ceph/mon_client.c   |  6 +++---
 10 files changed, 52 insertions(+), 24 deletions(-)
