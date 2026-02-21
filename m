Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDD32694A
	for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2026 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691805; cv=none; b=othBRmrfu/4mylKnLCi/V4V6aq2wAaIVhALs91ARZN1FsBD8vIToVCHI/bxtTNAgdkw1JDf3orf9oIHLjJI/s+z4uLswU+072VKKwMkJeYlRmWG4BxkMP2hI59nBgDOuaUGCC26RYrEB/pfcSIJ6DvsmM2GyRjKWRUms2wJeHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691805; c=relaxed/simple;
	bh=Q8LjG5w0LfBzA+qqIJUKX9oy/FN75Vn0W7VHoH69Qv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUE+4xhK/hwyg5CXLnAem9rlpK0+7uKe0aEZ9HJDKgNcL6qGAYF1xtB8pxjj2Z3NjOx6KgpzK7R9rlizwV1p6cnMTOrHjeezByBPJqxMSTDK6C9TmQrm2CYy0pECDWfxD17dvX/hCpL0NlR1nXtLOV4LuhQfCS9AzPUP1gOp9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+BuPlpd; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+BuPlpd"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9489d087bcfso1852661241.0
        for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2026 08:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771691802; x=1772296602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=j+BuPlpdPAxjRbrGvQRU013TZS3Bl6DpAXfOOkc9DLfteKR4ENobPdF4Qgh7PY99js
         2l0k8bRhdON4Lu73ZvTzhf38M5cLWwYWAl/5D0ZEIG0s4lEatV0Vfb7l6bjFeIb9UOA1
         oR4I9c3z+leynSVeOqoI4lhaq3BAn6qIEuYX3RKpWvm/+R+7c3j4BihvQvvqOFdjHGTr
         PFFuDTKXyGECfMjIUXOLyACHAKHHBemx4/IaJJpjkgDXS8kro3RQYCmX/4RxazvjVR8Z
         RqhVqdq0+T/N3/piIjFizcvepIMhpBxBvQIEkRx2BAd3ELGLdSNDAt+ccb/ESJ+802ec
         GETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771691802; x=1772296602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=t4WNiJOvSnW5x5YEQ0qnvewfaqvzKuAV7MoDasR0nvISrZRPXrdZwJr3ypcxGTMuu2
         AmlcdIW69NsVn1KlG3+gLzcnJ8oyQ8EEI7bZNKTffZBY+Xg0tZUwE6vNfEkgyCXEnc+4
         7N88x+v9/i5jIaWIQhOyhagOaTCjWNYABE5YIpz7dNQJK8idcl/fEDiun+xnJ+W0mgZ9
         2u7lZ0eaIxsz4bR9BsNKHmZAWkQWYRUnCemDISAF+Ajlue07W4lRlZ1Ba7aFqThdl2es
         xkV37fDNX75vFvL+7HgtgdxrAMf5g31gz08wSeKo2DIpmHyKfZpziIpLRpCkNoE2Osix
         k9bA==
X-Forwarded-Encrypted: i=1; AJvYcCWEHvkrw0VnKuwUi+ao1XpD96qXP1l/kYLtPQUDPdSWtLIt+Gjc8OzP+Wj7LyVCQyvqkRFQt14AuDTG@vger.kernel.org
X-Gm-Message-State: AOJu0YxOnzYvScqzOjGI1Om6VLUZPFGkROGuCB9MgzThXL04pYtF+CFH
	ywG0dSDmC/se3ec/2YnI90VXjQOUziLldPRYm96pDn2fwQYlTNiPIdryl+L3Ug==
X-Gm-Gg: AZuq6aI3Wt8fbcMCT8QRoLBIU8JC0AyGI6Qh2ueV7otnfHn/4hAlAJAkHlrWD1y7gg+
	AEy7YnpcdjjVRMWoxnii0PXY4tFUpCuX0IItyuoKdzqrXuW0Zsokj0VDz4IrlXqOniz8oGyQ7bG
	RiduWxtC6yDbmZqFGT7JV1+HOsHULn8v3MWzj7tR9ru8e5wSovGVXqVTfWZXqb0JbFbOV1xT+nd
	Yn+TvHYSzWRohiaWWFe+Efk8jj/pcj+hSKKgmucefqHY15nI8GO9UfAxNiKm3Qai4Z8yYlWgVIs
	HsKdoBPGC3gRsllHMNMAvE+0i5wJQvV8dmx7fwyfIoZe9HmU5uZuBPAYdSpui0fu6lN2VscLp86
	wcXcY0dFp3MugCS99P/VnhCUkNNACuRaFion1kpL2gN2A70yg6RaXwYQeDxhTt65rXaBAG/mVeg
	NNMinZ1LR6jVDTPpfegaFzpZPzBbCSDtIR+iB+mdpoLKB3xVLqaR7PjOk=
X-Received: by 2002:a17:903:1d2:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2ad74458fa3mr31285505ad.22.1771685983010;
        Sat, 21 Feb 2026 06:59:43 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:59:42 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sat, 21 Feb 2026 20:45:42 +0600
Message-ID: <20260221145915.81749-1-dorjoychy111@gmail.com>
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

I only tested this new flag on my local system (fedora btrfs).

Note that I had submitted a v4 previously (that had -EINVAL for the atomic_open
code paths) but did not do a get_maintainers.pl. It didn't get any review and
please ignore that one anyway. In this version, I have tried to properly update
the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs2,
fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
(fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, most of
the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |= FMODE_CREATED
for the O_CREAT code path which I assume means they always create new file which
is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead of working
if path is either a directory or regular file) as it was easier to reason about when
making changes in all the filesystems.

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
 fs/gfs2/inode.c                               |  2 +
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 +-
 fs/open.c                                     |  4 +-
 fs/smb/client/dir.c                           | 11 +++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 23 files changed, 119 insertions(+), 32 deletions(-)

-- 
2.53.0

