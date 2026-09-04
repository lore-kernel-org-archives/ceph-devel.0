Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313A4F4723
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542996; cv=none; b=t36Dl9gZZ2pEmCUkNDQkI4EefjywfoPaObZQaeZQ0c6jr/Y4HXBVrjAOR1JVPRD8T1R0YnmYvJLw3wHvGKIm8Oy9ny1FLOOUCgecr2jrzrgvfpT1y3ChppP2qL9KfMhdL85nK75ePojiJ7RLa6HndOEhFp9y+9Pgy+p7y1Fm9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542996; c=relaxed/simple;
	bh=y/U7lI8WnnU1KnwvHBw077ZL1vJVeKUb+XM4rIteV8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZVkuJPqZrIRlGnpWffBSXLbVDIfacA1+wlxWU9o27igvrm3yrXL3kYoZC7yCnuN9gOXY2Ccwd75iIy8Su/YdZPDUiTLro/cqRIpNgxVJqnscyuUpNmzmhOn/BLYkv9IiCHUsSU8CaqPt9tial8vTrfAB7dQ52ZR/QKK+J0HAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3GVoOIz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3GVoOIz"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so9628181cf.0
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542990; x=1789147790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E6jALHeVsBRq8RHBq3ibhbiHxBjg74BRHeDZvOic9v4=;
        b=o3GVoOIzRKBeQfeetK0yrUXvj8lwAJ40b8jK3SUogyZblLzD6kyA/AdUT21NDMCw3z
         jtWT7bzWWaFBb4mDR4mXDobBHRoGXOA93Xz/SHDHWv+qF00QTPeaWekr8QDa2Sm77esM
         dDmr887Clz/om+0YtEZlac5TIPANpL7NEHnuZLgAvWYyxUzciBz4BY81WLQHXqRDxLBx
         n4WV0vWNptGer9FyQ678mh8EXIgBJo6ZcWT/HxYSgE9gv2T3dZ6fpzADvMGjXjLIJUfF
         wrYzxDXdPOmnOW7XIFSr96jWmkORlccTt7Syw/e2R7+cQR6h9VsnYuJM4AN5d/VFum0n
         ihtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542990; x=1789147790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6jALHeVsBRq8RHBq3ibhbiHxBjg74BRHeDZvOic9v4=;
        b=YAb8q2WWeFzWtUgaW7cW90I2iZzwog5J7I8n+MGwXYjtV7xZgs5WnDyyu+wtjK2Zee
         9p2GxyspE3cDx12iVzQs87Ma3E/EGivVqhfYUeWu8dxrJemlwBkmEPW7X5E20asvJyQj
         bMUE01Zt9e6kbzSG0Eb1ELJakrH2yeS/qAytrWPiQqJN0YJoK+JR5guxx6hQcAlcT1xr
         04tgh/i5/Sb5DzW66vPA3dfI+9e3oMoyeNjNtWHAKtk7ARjluTx/bepEOhB/mtWOphqN
         nUAzJbQx/I9yyDYwbL7nYRomflOr5TisY+XQqQSwZcFDTGbYBy+LYFsqHT2yb67vw8hY
         Li1Q==
X-Gm-Message-State: AFuF++ksYnNX0v9F4pyPFg2PxrTOYeYESSRSHU8wrf0s4QK069KjYTYd
	hgNwC7ttUkAJ+VAdOx1g/tbQ/9htIHJXsQlpxXk4KPeS9E7gVR8QjxnpHk8DEA==
X-Gm-Gg: AYBFou2KDtt0S1HAYMzIWmPFQi6tAbJz4BIyuCKVm1hYjH2Adzn+fHg+cvss1b3enOa
	+61Yad0RLs/TM+h/NQbjrb7+6cfV5hQgG5Ij1a6k2bAcsMC3grAtAq3GONnCSDhIf6vLzatYyA+
	XPrEnQoFr84YO5hHhRKd3b4+Lo7yErLhEzlEmT1CZ6/+uhtSS46nWyHfJlbS63Qot+qce8Th6FK
	hRg8ODtJhneB9KWzBvsS3wv/qoK6yRgIlU6cCv8qiITT4aCork+X0xy/bJKQB2oFK/XDgcCN+Q8
	v30mhOZIErRAaBX6Dbru4g3jwtPcIBSvMNYCP9xVacl18xjbF/ZEQ/hnc1gbosyar35GhrRoj58
	3zqC1vCYffKHkGUdYBUARVb89jDtLNCezK+HA+LlvrNOCy+M4u/262yArFT04Qyarv09OJNS4Kx
	UslutRaqxUEjdwhyc4ffIdZxjqdDeq0BKQZH95H05ohJ5cOslWMF0Kfi0=
X-Received: by 2002:a05:622a:14c:b0:52d:ea18:a9c with SMTP id d75a77b69052e-5305499a4a5mr72353451cf.34.1788542989154;
        Fri, 04 Sep 2026 10:29:49 -0700 (PDT)
Received: from zambezi ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305418950fsm25000631cf.20.2026.09.04.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:29:48 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 7.3-rc2
Date: Fri,  4 Sep 2026 19:29:38 +0200
Message-ID: <20260904172941.1970111-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.3-rc2

for you to fetch changes up to dc173b37415e8f738fc4de477490056b479ddc9f:

  ceph: apply nearfull_sync option on remount (2026-09-02 12:23:05 +0200)

----------------------------------------------------------------
A small fixup for the new nearfull_sync mount option, a potential
use-after-free fix (marked for stable) and a patch that eliminates
the last use of PageWriteback macro in the tree.

----------------------------------------------------------------
Alex Markuze (1):
      ceph: apply nearfull_sync option on remount

Max Kellermann (1):
      ceph: lock mutex in ceph_mds_check_access()

Tal Zussman (1):
      libceph: remove pinning assertion in ceph_msg_data_iter_next()

 fs/ceph/mds_client.c | 4 ++++
 fs/ceph/mds_client.h | 1 +
 fs/ceph/super.c      | 5 +++++
 net/ceph/messenger.c | 1 -
 4 files changed, 10 insertions(+), 1 deletion(-)
