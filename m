Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C42369D43
	for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133498; cv=none; b=u0jWauLptrEjFuRHrSEZIz5KZNWBqu/qmo4y0MkKMYW3U+YuXLyx+w17RfP9r6oqE34t7ckVVab6Xzy2QovNEing3u1sRerNjV1Rv1sec6oWIktyFG8jtMFHHAAYh4ceiDIqw9hLdvpBrRysJM7XZbKxrGMl1diRiWqIFyUDMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133498; c=relaxed/simple;
	bh=2X+A03Pv0LYSgb5yLMQ9XQBAPaOxElKWw3TJL0ADSzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRvIoOL9bt3jvhNisLxpAYrkz+t7sBg6j0spklbCKsKBSEkNql4MKFHFk6LMPdbrrT68C+cx09iZZHY4ttXNfVx53x8xpfPDgXS+Ds7rT9gQVru5ETD5yi1cGTENscFmTt0FJq0ivQt3aXHv1gD5mcnsjigZj/gXVlbfiNM4Os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4FsQxDH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4FsQxDH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d91ded8174so8110605ad.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789133497; x=1789738297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bs0qoIDTEbciN12ky9jw1GqCxhD7HHbqHEWQ/QwGLt8=;
        b=r4FsQxDHLQi0jG7HSfxpYpzR8+1JK/h6hS2h3SKxSCTdfkzY5h/aQmwTnMGmeCGBZl
         zJyK6hBSaQES+DSyhDx+1/TcQclsVW2LET0oVKuefsDGF3//aRqKadCxKC9B/Rgddn9x
         EQTpjBKi2G4NV3RZQO7JC4rWf58eTWjiGq8uWaeK+EH+r93yFm8lcuiAMaCMTSxZjnQR
         VQGUAQ0PfPHaDmsuDpqfm1iTSgcgU77YUsoe5VLPqTlb6MzXREhADsqBAeAW+zV+oIQJ
         v6IxQ7XBdMns9M3XIc5DwgTeOocLO4ahsVV9uAuyEx0GfPcmjwRWFH6EEdPjTiEJ2iu/
         KYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133497; x=1789738297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bs0qoIDTEbciN12ky9jw1GqCxhD7HHbqHEWQ/QwGLt8=;
        b=N1CZl+hYMQoGC8MW20BKlPA4Z3HIZFlU62/nYHozS54SV09vAOA+YwT4qPac8NacBk
         D8MH3wdPf+QjXBIQK3q07GC2c9oQjtlfmaKw62aq68NMr9scHUjZK5oViBZPSFfJHS4g
         gAPDr3bo37dginkSGx/D6G5BEwlzRnKZH1z9wdt9Xq7YHAd5cnP+A/iBvdodURtOIiFr
         kzho2pZzFldRPtMY7amM/7nmUx5Hunq15F6Yya0L3QYPa1SWUWI6RwWa/x75njCCcAy/
         deDOXqLbidNoWg9B5PLCr+W8pcOeT30bW6oKsCieOAG92onBlMFTe1vTh/s4sxnpAOrw
         a64w==
X-Forwarded-Encrypted: i=1; AKwUvByOb47j3ig39YsFXOys4IGVIxBt7sswVkgLr0mMI0XcH2ePNidRuPGrs0lgrVOkZIuWEm+qXeimTb8J@vger.kernel.org
X-Gm-Message-State: AFuF++lx51OJmWuVA3OBOqS9toAoDGbysB6guvzzWyegzQH8YUlmx2ml
	M7CB6Lf29gbDQNDv8GPCUyfHwdLjktSbJhfc4AwbX6F5KxLZxlLdePyP
X-Gm-Gg: AYBFou29rg8RWXmL/Al9Q9qOpE3y3H2S3ZeqgsRfm0/jAF2g3qUIAEyoFMDwDJGQvcF
	C8BzEPTPfJqDOjc1sFnYtwAnnY5aRxdPcXDgEQ+VLeAEDBYXjTKHPGoyrJI7ZP7e3DHQ3hSDn7t
	VtB+sDNrtmNrbEOHcl8Qz/Z0qtYXzHa91oT8GO/U6z8BflHSGY/+HYF+c7tABskIKNQZtcMPocE
	3HFyiB1uw7c/TUetyoyurDW32VsjRsO8A01kUsuuOoeykuuRKzF8LOye/zMgaiytaA0QNGRKBFn
	RnkJMhfA3PD8Wv3k7c3TAJI2UwWauUNHTiPlJoWBXgKR26b480QsFTTOpCy2cfrgNidpY2p1IlS
	OayX5Q/eNLhRizx/Hzd0/ZtKsuj4/xmg+MWBBAWWnSYRJN1yRMOnV/4cRop+itBwv72t2VKruoH
	OulDtHVSxwRf50egbJdImJxazFerkV7brd2RTos9CkdRbgv760ppvN/xbrjNV/oOO/9waExH6vY
	4Jh54TUKNQ5dwaJDyv/WG7AGy8hL9z3FCw=
X-Received: by 2002:a17:903:1ac6:b0:2db:331b:e187 with SMTP id d9443c01a7336-2dd2a1e0a15mr87471305ad.8.1789133496571;
        Fri, 11 Sep 2026 06:31:36 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc5c7bsm11349015ad.51.2026.09.11.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:31:36 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>
Subject: [PATCH 0/2] ceph: don't let a bad mon_addr= reach the empty-monmap BUG_ON()
Date: Fri, 11 Sep 2026 19:01:08 +0530
Message-ID: <20260911133110.2218-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot can panic the kernel from fsconfig(2) by mounting cephfs with a
mon_addr= that does not parse:

  kernel BUG at net/ceph/mon_client.c:211!
  RIP: 0010:pick_new_mon net/ceph/mon_client.c:211 [inline]
  RIP: 0010:__open_session+0x60f/0x740 net/ceph/mon_client.c:245
   ceph_monc_open_session+0x46/0x60 net/ceph/mon_client.c:534
   __ceph_open_session+0x135/0x590 net/ceph/ceph_common.c:798
   ceph_real_mount fs/ceph/super.c:1173 [inline]
   ceph_get_tree+0xd98/0x1fd0 fs/ceph/super.c:1362
   vfs_cmd_create+0xd7/0x2a0 fs/fsopen.c:231
   __do_sys_fsconfig+0x55a/0xcb0 fs/fsopen.c:463

  https://syzkaller.appspot.com/bug?extid=1dbed5969931c19d3eb5

The sequence is fsopen("ceph"), fsconfig(FSCONFIG_SET_STRING, "mon_addr",
<something that does not resolve>) - which returns an error that the
caller simply ignores - and then FSCONFIG_CMD_CREATE. Two things have to
be true for that to end in a BUG():

 1/ ceph_parse_mon_addr() commits the string to fsopt->mon_addr before
    validating it, so the rejected value survives the failed fsconfig()
    and satisfies ceph_get_tree()'s "No monitor address" check.

 2/ ceph_parse_ips() never got as far as writing *count, so num_mon stays
    0, and build_initial_monmap() happily builds a monmap with no
    monitors in it. pick_new_mon() then trips its own invariant.

Patch 1 closes 2/ in libceph, which is what actually stops the BUG().
It is the same rule commit 40480eee361e ("libceph: Reject monmaps
advertising zero monitors") applied to monmaps arriving from the wire,
now applied to the one built locally from mount options. Patch 2 closes
1/ so the bad string is not kept in the first place and the failure is
reported where it happens.

Either patch on its own stops the reported crash; I think both are worth
having, but say the word and I will send just the first.

Compile-tested only: x86_64 defconfig + CONFIG_CEPH_LIB=m +
CONFIG_CEPH_FS=m, net/ceph/mon_client.o and fs/ceph/super.o both W=1
clean, checkpatch --strict clean on both patches. I have no ceph cluster
here and did not run the syzbot reproducer, so this is reasoning from the
code and the report, not an observed fix - please treat it accordingly.

Yogesh Gaur (2):
  libceph: reject an initial monmap with no monitors
  ceph: don't keep a mon_addr= that failed to parse

 fs/ceph/super.c       | 9 +++++++--
 net/ceph/mon_client.c | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.55.0.windows.5

