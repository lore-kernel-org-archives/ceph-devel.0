Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246533DEF7
	for <ceph-devel@vger.kernel.org>; Sat, 28 Mar 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718623; cv=none; b=jwyS+/ZHokmP8rVgtpN4MEL5iWXnP2dV9smfnKLEUaGY/hu32edHTITCm0nru5Rf0E2gQ9iy/QV096ubLCEZcF61WDhAVXyBhCZx4ndVWkkCOVksAatxSYaVmXQPLO3WYrbWiX4H33cKr5PORieqIUCK/lVTWe5ICszWJOrZZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718623; c=relaxed/simple;
	bh=WbXqvQhn4qwD4XjOM1f/RolmfvXydvP/QpIVZ5/s984=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNqpo+M4q/edPKAKXgljF9v3ue2H1D81DRhBhj/GnDC8zT/d+oZbMVLCPpbuj5utoY8IvkzVD8zloGgyyxhjuHG4IMPvJMBdck/zmmsYV1De/YUcUlVsQWvMjnThyaxkxPharzUqmahjtI0g9p+zsPv8+MqS0AhcvdQB+lmzybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he2Tc3id; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he2Tc3id"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35c238f1063so1520066a91.1
        for <ceph-devel@vger.kernel.org>; Sat, 28 Mar 2026 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718621; x=1775323421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=he2Tc3id36N/dNrImAB0FtQFWApWtJHTjZ72YR26i8lE+n/7H96TCzG9qYvHmqk+2e
         uhIK/YFXplWVcKkPvGinoa+vojsICJPfJOCo90pDQcWKUw0bcf9YMhWHaGc6t3aDXzaz
         J0ZN74GIXjZxZ1cHytdCxoivIZe9H2+5LHik+R0ySUgsb7V81/k2KYAcaoJxglkogLHt
         itgBsuq/w5xhyhloX2BJw9loZpXt2izQxnRHpMpCU28qK6a3lsRUy1qiplwSVk2WBqXf
         i+gHVslEVJre6VrlGsJP/g1RxCmDbsoFkhecX6fevPzYq0iINcrs9faBGCP9baFUrKFp
         WCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718621; x=1775323421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=HXAgLw7HhkoX1Aqw8uT0reqQFQFOvuM1gKUmTKZigZf9Zz5II43HWjEjjyxxBmnWa9
         PaAuadKQCrFtwtxQHP4STHsNxkGueW78u1HUAy/satd92nlw3j0a1PO50tB9IYRsmuTY
         iJ0bQc/9yIeOgGIYIfcHvv6V8imu7EGOe6bqWEEF2jSkB9Mdhc0ZlahoAYO5WpVM3/SB
         D09x6C140X0LheY1tsAndl4khg7DjnXlFQYCP6/oBaOk5gwH1LUvIUFYD3swLDPk1FI4
         3xuOczSzwjak/tF+9JlESUiQJgrSLkUdZABr4+12j7BnB2+rNQQRyA2Q7gLFoVXTAMkO
         BfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6QmIea7nK5FENrn7WM2hUz5GnLna2BRdA46eY5wLb80zGOqnIchndnunhr1otYV3XHsLy9ZoUMlTw@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9Omcs9P0G1kPMmJz1f4MT+Ch/uouowwLWqGNuRuRDBGplvJl
	BDkIfty4lom88A92s0pBeXSkcz5mqYTjExEacnPeid1H2kFq0jB0e7P3
X-Gm-Gg: ATEYQzzKGSQCgbCoPMeIPrq9qb5EaOdMXKVNJKkc6vJFfA8uCvon0/0hQEpOg8L/NsE
	bK2fnswcG0raE+A+QCfuf2D2EP2Q78gmdOZMpaJGxZNuwGKbsGE0oM4RGEv2JGPoeNSZE8xLduG
	UtR5kSQ6XjZjPChbW8jRy6un6IdxmlJ0E0HgWCuCIub+HUEYaVu7vkjq046Kcje1BLFgKakl3Ll
	lApQlApF5tifd6XjDpL+/21kyKJ/04O+iThoTF1q0gJPdKKDTnwRh4p8oOVIt/ZEW89ix/LL7SJ
	ZYsDIBpzJXs7MsJpm9EDxdRRlghpqHc9A2c0rA87eNAFZkI+MI5zstYpFU4SN/Eu9dWctPL3rbc
	ljSp4kvnqn8vhuLI9WZT/JTwtXcKrSIPPjewwVUNHGR9F02OWYe08PSh7t+gG+RbMAnFWma6T2F
	RR6SvGWqUS6xt1m3PPktMYeKWUMXnB6Fq0G6LF+a2Kk7Cw4IZdJZrzPMw=
X-Received: by 2002:a17:90b:2744:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-35c30094a5amr6635171a91.25.1774718620730;
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
Date: Sat, 28 Mar 2026 23:22:21 +0600
Message-ID: <20260328172314.45807-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

The following filesystems have been tested by building and booting the kernel
x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
regular files can be successfully opened and non-regular files (directory, fifo etc)
return -EFTYPE.
- btrfs
- NFS (loopback)
- SMB (loopback)

Changes in v6:
- OPENAT2_REGULAR stripped from file->f_flags in do_dentry_open so that it doesn't leak in fcntl(fd, F_GETFL)
- BUILD_BUG_ON updated to use VALID_OPENAT2_FLAGS instead of VALID_OPEN_FLAGS in build_open_flags and in fcntl_init
- v5 is at: https://lore.kernel.org/linux-fsdevel/20260307140726.70219-1-dorjoychy111@gmail.com/T/

Changes in v5:
- EFTYPE is already used in BSDs mentioned in commit message
- consistently return -EFTYPE in all filesystems
- v4 is at: https://lore.kernel.org/linux-fsdevel/20260221145915.81749-1-dorjoychy111@gmail.com/T/

Changes in v4:
- changed O_REGULAR to OPENAT2_REGULAR
- OPENAT2_REGULAR does not affect O_PATH
- atomic_open codepaths updated to work properly for OPENAT2_REGULAR
- commit message includes the uapi-group URL
- v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-dorjoychy111@gmail.com/T/

Changes in v3:
- included motivation about O_REGULAR flag in commit message e.g., programs not wanting to be tricked into opening device nodes
- fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
- fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 060000000 to 0100000000
- added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O_* macros from hex to octal
- v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-dorjoychy111@gmail.com/T/

Changes in v2:
- rename ENOTREGULAR to ENOTREG
- define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) and in arch/*/include/uapi/asm/errno.h files
- override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.h due to clash with include/uapi/asm-generic/fcntl.h
- I have kept the kselftest but now that O_REGULAR and ENOTREG can have different value on different architectures I am not sure if it's right
- v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-dorjoychy111@gmail.com/T/

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (4):
  openat2: new OPENAT2_REGULAR flag support
  kselftest/openat2: test for OPENAT2_REGULAR flag
  sparc/fcntl.h: convert O_* flag macros from hex to octal
  mips/fcntl.h: convert O_* flag macros from hex to octal

 arch/alpha/include/uapi/asm/errno.h           |  2 +
 arch/alpha/include/uapi/asm/fcntl.h           |  1 +
 arch/mips/include/uapi/asm/errno.h            |  2 +
 arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
 fs/ceph/file.c                                |  4 ++
 fs/fcntl.c                                    |  4 +-
 fs/gfs2/inode.c                               |  6 +++
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 ++
 fs/open.c                                     |  8 ++--
 fs/smb/client/dir.c                           | 14 ++++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 24 files changed, 131 insertions(+), 35 deletions(-)

-- 
2.53.0

