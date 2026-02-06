Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85EA30C36C
	for <ceph-devel@vger.kernel.org>; Fri,  6 Feb 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409693; cv=none; b=tTMfdNzB1igodKjfxMq73n3zdJAjKm+WDC+2Bcdhqj4YsbY5Xx1TabqssvCzHnlUquma+8vmCekRJEWEGyMekI/o2JeLusfX/kW+kiq8ihJ2JcYNxPQeyJoHG5tyhQqUnv/cievsw2Es5V7SoqT2oMxkHAOb91/pkvleUYlzk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409693; c=relaxed/simple;
	bh=Z5aaRmSOHMFDbg6CPFROQyFYr03jewWVqkDMdJPuzkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUCFAl2JwxCH/CUv3LvJgX1C0R+32aYSxineyDWZnDWp9NMCEoqVC3W/T51mpJjGW+D61yg6bzR3vNoY3uC5XuhwAySZDziBw8vAz7Y1LvtOmX5xuyzLspu4TbOqpDI3mLIHGtmYJVbj/9kpCGciR1qTSBQC85n6ia/sDglQFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=PBvyIfw2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="PBvyIfw2"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79430ef54c3so11301497b3.2
        for <ceph-devel@vger.kernel.org>; Fri, 06 Feb 2026 12:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770409691; x=1771014491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qkRyjYepm1vL8YsOB5hZZCuF7RL4gTgPwCwUHAKKtc=;
        b=PBvyIfw2kN1mJt1xHQCqZY3uauH58zenIDVzpd6QT274FAcRRyX6HYzvxYfXEvSqUZ
         OZ+WLYr6a0npnw5YDoKZ7oQhqUQG40I9FqhxfbR+fG4IPyV+wnUgeV97pFmawfBWCvPB
         SLEr7LvKhhav3s0zZ0wReXaOYTqTGBJsXxNWTX187L/mtYpgSS+hpe4dG9mcZMOWlr7I
         Ef2D7vHnZ+JyZu/TKMYGN0XhfYKRuzAIePDDtEzb04AIb75Y5jHC189V0FxPzcztUj90
         XKJjt5IKamj4KA/LPMhYyLC0lpYOLXtgGaAPl2abtQrrPLIOdEBAXUOijfWgNdgtiBPf
         MGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770409691; x=1771014491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qkRyjYepm1vL8YsOB5hZZCuF7RL4gTgPwCwUHAKKtc=;
        b=WagSgj/bqDUetKdECR/wppRuyv0KSHOpoHnvsaOP/cYTISXebe5u6Xahf966gf06w3
         KfLVuUhEiXCduOQkHQOtNR88j41k4Y2NiF2+iLshF2gzKkrMt7HcDAoz6QqytyuVsudb
         8Iz4lLEteS2YKxPqpyJAjCYqA/oFf96E7aGKJWaIkEHgYVfgIMQAXCEJ+ZMB2jMJDSPF
         CgZR3w9gcC5w/0SVQWxjfEFzfVLAGZ0XloY5XF9fhc1PGZEaeQa3UiJgquA9Fupwxni0
         FqWZ/xjTm/WRYxMCppRayCqywxVMSVUL1b32u1ry3G5ueL9klTF5JYa/u5L3CIGPDqlj
         qJ6A==
X-Gm-Message-State: AOJu0Yy8+THc6VoeEeaK00NU/iktdYMZuVIKXdKeO1HwOD5xdXVb62KK
	+0Uz2S9z7xM4xVRJ3bwV3Tn2OI8OIGShia7XDtOBxFEiN4DuylaMgPqAtRFlfuywPvvVps5nwW0
	PyFqgGvM=
X-Gm-Gg: AZuq6aLnpAr3BKNbVpWenGwxQB0VEMXmZ9D+r9+njHP4/QmRKdG0jaImzTJlx5+6fcx
	pWx4tzmr5vWI5w7HzKyx4IbCQUH8SvNNfFXSTv1OnDjzJybUkYIey3uQLiPun5l3L0lRd3IXf2l
	W2OEVOlK6B9iJNVrqdj57C1tuklXbGuR22EWfjIiy+9RsnFUQcnQnlITyVY3D2xcbD5fmFVkrfG
	6wTneANT/BD1uPS5Mb+sWf/lkiQ9yp6EmkSZGX34XFwTZpYQVEQmC9QVFwu3t3t7JLPdpf28Kwa
	uWGJQS1eELpGxOr8lCgIoinxBNHgNCxAKFokOsIpar3u49HsGHB7MR2UlBJJ4oFwTj8Q7Y3TT1s
	WM6MlDQneof9RrmZ1XXy4Tv8jOq5sXovjOri0Kq6CXoTUjENVeSND+b0fuSPxl7G1flhFSs3DAJ
	r8owYEZhsT4L0aqnFPMAZ3oqG/0zDCsaDudT4DPpYrgEAO37q2KkN8L43OWXoPUPHMbc6IOvNG2
	kDM0NMQl5yN65mt4u0=
X-Received: by 2002:a05:690c:91:b0:795:795:d8e3 with SMTP id 00721157ae682-7952ababb6cmr40484477b3.70.1770409691543;
        Fri, 06 Feb 2026 12:28:11 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:a0a1:736b:295e:2ad8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a2348c1sm31069507b3.38.2026.02.06.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 12:28:10 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix generic/639 xfstests failure
Date: Fri,  6 Feb 2026 12:27:58 -0800
Message-ID: <20260206202757.1535351-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The generic/639 xfstest fails for Ceph msgr2 protocol:

Ubuntu 22.04.5 LTS (GNU/Linux 6.17.0-rc7+ x86_64)

sudo mount -t ceph :/ /mnt/cephfs/ -o name=admin,fs=cephfs,ms_mode=secure

sudo ./check generic/639
FSTYP -- ceph
PLATFORM -- Linux/x86_64 ceph-0005 6.17.0-rc7+ #16 SMP PREEMPT_DYNAMIC Wed Nov 12 11:01:48 PST 2025
MKFS_OPTIONS -- 192.168.1.213:3300:/scratch
MOUNT_OPTIONS -- -o name=admin,ms_mode=secure 192.168.1.213:3300:/scratch /mnt/cephfs/scratch

generic/639 - output mismatch (see /home/slavad/XFSTESTS-2/xfstests-dev/results//generic/639.out.bad)

The simple way to reproduce the issue simply running these steps:

mount -t ceph :/ /mnt/cephfs/ -o name=admin,fs=cephfs,ms_mode=secure
xfs_io -f -c "pwrite -q 0 32" ./testfile251125-0004
umount /mnt/cephfs/
mount -t ceph :/ /mnt/cephfs/ -o name=admin,fs=cephfs,ms_mode=secure
xfs_io -c "pwrite -q 32 32" ./testfile251125-0004

Finally, we have the unexpected content of the file:

hexdump ./testfile251125-0004
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0000020 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
*
0000040

Initial analysis has shown that if we try to write out of
end of file, then ceph_write_begin() is responsible for
the issue because it calls netfs_write_begin() and we have
such logic:

int netfs_write_begin(struct netfs_inode *ctx,
              struct file *file, struct address_space *mapping,
              loff_t pos, unsigned int len, struct folio **_folio,
              void **_fsdata)
{
<skipped>

    folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
                    mapping_gfp_mask(mapping));

<skipped>

    if (folio_test_uptodate(folio))
        goto have_folio;

<skipped>
}

The reason of the issue that somehow we have folio in uptodate
state and netfs_write_begin() simply skips the logic of
reading existing file's content.

Futher analysis revealed that we call ceph_fill_inode() and
ceph_fill_inline_data() before ceph_write_begin().

void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
               char    *data, size_t len)
{
<skipped>

    if (page != locked_page) {
        if (len < PAGE_SIZE)
            zero_user_segment(page, len, PAGE_SIZE);
        else
            flush_dcache_page(page);

        SetPageUptodate(page); <--- We set page uptodate if len == 0!!!!
        unlock_page(page);
        put_page(page);
    }
}

This patch fixes the issue by checking the len argument and
setting memory page uptodate only if len > 0.

sudo ./check generic/639
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-0005 6.19.0-rc5+ #2 SMP PREEMPT_DYNAMIC Thu Feb  5 15:43:51 PST 2026
MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
MOUNT_OPTIONS -- -o name=admin,ms_mode=secure 192.168.1.213:3300:/scratch /mnt/cephfs/scratch

generic/639 6s ...  6s
Ran: generic/639
Passed all 1 tests

[1] https://tracker.ceph.com/issues/73829

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/addr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d214210..436a287fd311 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2184,7 +2184,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 		else
 			flush_dcache_page(page);
 
-		SetPageUptodate(page);
+		if (len > 0)
+			SetPageUptodate(page);
+
 		unlock_page(page);
 		put_page(page);
 	}
-- 
2.53.0

