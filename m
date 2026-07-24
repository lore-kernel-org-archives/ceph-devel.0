Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BE38E11A
	for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2026 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924426; cv=none; b=uj2+zWDzR4s77qsiK8AOHwWSZXaxOW7GcBtypAiCm01SqErXP/+BsbIM1GIX99A5bJBwOT9CicOFXonxKtcPUgr3AC6oDLMrhhovyh992jKchvhnnUfpQ49WHCr1+IPTX7iQGQFBeTH94sdCV05ymnYGq8tabm92FgB1Jbeny7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924426; c=relaxed/simple;
	bh=CLtBecbcEVgPyaUW1dYWgqXSxuOo3paJli9iVfJKoNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VK+EJxpSf0JG6n3rPlsuD5an8/Uy1MIIYWNdH++ti7Rc9u5aetyRfI3p+EDyPVl80ryt5asIoYUC/lyb2WgRhMcUX33wb4LHZVZ8puCVX7jyPd9ldjD/f0I4w14W4Cpq06m2Ovb4LA5KeUn/cUJfYtGk19E8ik6gPKqfMUErk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNqYSsSc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNqYSsSc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f72317a6so73133985a.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2026 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784924424; x=1785529224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/tD0oS5FfCf/W2RSYyxG7jBt51/W3i6j453047sHmM=;
        b=nNqYSsScLHGQKGlEpKAw/rsjCV32UKnZPS/itm7OBZsO4ZLspROl88SqJjn5ygCBrX
         z+hKIYYQdB6FvE/0v0y0puNCLrGW/9PxR2jUUdjDVfqU5tKiGYPzJYsNqy9m4jZFou7t
         Ly/oZZkHd9rNqg1+DwNzEnPYdm43C2c5hTUErJ49LKWVKL4CWUb2nU3jCSO+yA70PyH7
         aZBePiM6bAY6sdZzz8ofQCoERu/vZs5qZRXg60eF05Tn57WhNuKlfzfhTMwFxXSnWzck
         iGzohxZvfRqoTJu5/v6KeTatDRwE5hdZ6bsXehBR2+uNNTbbSa6m22yRfsot9+nhioyj
         XV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924424; x=1785529224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/tD0oS5FfCf/W2RSYyxG7jBt51/W3i6j453047sHmM=;
        b=m3YA63E7mATjwJuEHMnY3+8drD2wYKXOyyLKO2Tvn+1RgI41bBidpAowwxn9CJwZ5t
         mHX7cUUDqyrwkCUcVW3OXMtoQvWy9e9Np+XtyQUgudlsxkXwok9MmwunVCUQ6Qg8ENxj
         6eJHQMaVGeoB4togHpkDdHfgD66q00bdPELf1qCyDuJsmpr2TD7t8yaH9ge9ZdZXGBZR
         BDHxnnHYJDtHjr7KJcpg2ekdQfLCSYmVPjlfa69fnndk/89xdifPjbZ2zXhIc4wL6kRZ
         9JuMO0kWhHQBwdKowTU4oJ/e2NRnX+IFOG0PgexEG5yp7YuFGgH6ycZwp490G0px0K20
         GsFA==
X-Gm-Message-State: AOJu0YxXrW5bQiPRu7ULrfd1OBvu3bXnUdAg1tSSv+ZMrgH00IboeomI
	Nq2JcnH2GWarG7nIA2iylZbbWoWoiL4dFj+3pwd2RTaQoSbqD6t2Amol
X-Gm-Gg: AR+sD13e9tszqBEWqxXY4OZFU6AzTJRIqWIjAokc1zOTzxfeMvwu82w9oGYipP1kyi9
	jh/1m/OY7wyvrPGT1xn6K5Z7D8/9a+oz1IVxkbg+KqkLxenk07ocCAQmQkpjcyC29ZvoC8yZOwA
	G3RtwUyDQ7o9MYt3mqMPOy/yxNm7CeqsdDGPE/NNdjSv5JO9jNXQ+QMw5wSnQ8uckzLCyC+bHtT
	2qaT33ef9f+IcUP2PUF564Qo/Yt6lFRLpFZhk9rZCwl6CvzS90Qlm7xbV4j02Ug2rzqb44p7QNC
	HNPgpUi1EmY2y8lkW6KIjj1JtELvwY99HOT12g0feAKR3d7WoZC9MQhYsZ7WW4ZAzpXL0fl4D7a
	HEVBoNSE84IL9eT9M/QzZcd8afVQFLIei5agw79jmEPZK3HQ8g8sHv25HDMzL0BlualsazdTax2
	ibqBElosRai/MAOU7MC8dO0dTDPw==
X-Received: by 2002:a05:620a:a401:20b0:92e:fd2a:102f with SMTP id af79cd13be357-93103746127mr740387185a.72.1784924423835;
        Fri, 24 Jul 2026 13:20:23 -0700 (PDT)
Received: from zambezi.front.sepia.ceph.com ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86d7207sm5839716d6.34.2026.07.24.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:20:23 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 7.2-rc5
Date: Fri, 24 Jul 2026 22:20:13 +0200
Message-ID: <20260724202014.1168527-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc5

for you to fetch changes up to 5b602344a49e039e792ce5a8923bcc61412ee134:

  ceph: avoid fs reclaim while using current->journal_info (2026-07-23 20:29:42 +0200)

----------------------------------------------------------------
A bunch of assorted fixes with the majority being hardening against
malformed input and invalid data scenarios that don't happen in real
deployments but can be utilized to trigger use-after-free and similar
issues, some error path leak fixups and two patches from Max to avoid
a potential hang in __ceph_get_caps() and unintended nesting of
current->journal_info while handling replies from the MDS.  All marked
for stable.

----------------------------------------------------------------
Bryam Vargas (1):
      ceph: fix pre-auth out-of-bounds read on snaptrace in ceph_handle_caps()

Douya Le (3):
      libceph: reject zero bucket types in crush_decode
      libceph: bound get_version reply decode to front len
      libceph: remove debugfs files before client teardown

Max Kellermann (3):
      ceph: fix hanging __ceph_get_caps() with stale mds_wanted
      ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*
      ceph: avoid fs reclaim while using current->journal_info

Pavitra Jha (1):
      libceph: fix two unsafe bare decodes in decode_lockers()

Raphael Zimmer (3):
      libceph: Fix multiplication overflow in decode_new_up_state_weight()
      libceph: Reject monmaps advertising zero monitors
      rbd: Reset positive result codes to zero in object map update path

Shuangpeng Bai (1):
      libceph: refresh auth->authorizer_buf{,_len} after authorizer update

WenTao Liang (1):
      ceph: fix refcount leak in ceph_readdir()

Wentao Liang (1):
      ceph: fix writeback_count leak in write_folio_nounlock()

Xiang Mei (1):
      libceph: bound pg_{temp,upmap,upmap_items} length to CEPH_PG_MAX_SIZE

Zhao Zhang (1):
      libceph: guard missing CRUSH type name lookup

 drivers/block/rbd.c        |  7 ++++++-
 fs/ceph/addr.c             |  9 +++++++++
 fs/ceph/caps.c             | 18 ++++++++++++++++--
 fs/ceph/dir.c              |  7 ++++++-
 fs/ceph/file.c             |  9 +++++----
 fs/ceph/ioctl.c            |  6 ++++++
 fs/ceph/mds_client.c       | 11 +++++++++++
 fs/ceph/mds_client.h       |  1 +
 net/ceph/auth_x.c          |  9 ++++++++-
 net/ceph/ceph_common.c     |  4 ++--
 net/ceph/cls_lock_client.c |  8 ++++++--
 net/ceph/mon_client.c      |  4 ++--
 net/ceph/osdmap.c          | 16 ++++++++++++----
 13 files changed, 90 insertions(+), 19 deletions(-)
