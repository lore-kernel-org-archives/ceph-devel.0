Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8B386429
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596551; cv=none; b=iw4yHlMJaiuPnvtXI1Xlm+RiI37NIqyxk+u/rtfJXmzvB8weS3eTt9zLy+C0WsWIOBaGwqKfrvjphp3rdwpivJtVwBOTh1AYLBducpAGcCnXYefd16XcigRDSj2ahesBU15QYfRHWMepuvpcMuqbHsL9OaXrMbVhiny1UbRNtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596551; c=relaxed/simple;
	bh=i0ujoMB3NYlsNFPdP9lq7RAdOjAOpDttICbVjZBocZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmyZeBzpWo4kpbXTQ4z2NxTth60bbQ0/kSkEjCSfua5R101ZKT1iR1zJDvAlieE6+GNpDpAl1/juAkXdEV8m2KG9omizsqHLJtErT9OVRAg7r72AVA9JznwodiQOJEorR1qgDJzvsl7AyRVRGgVeaTKCxY1h4so7+4mIv0PZ7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsYFv2Px; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsYFv2Px"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5175cb5946dso5998181cf.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596549; x=1781201349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYChz5dDOhgIdKBmtje4M1+cRrICz03eZkA2AVEvq/0=;
        b=NsYFv2Px1kAoV9ML90XZPwqfYwgiarGwouElc8OeyCjAjvkOdw6Tju0OqOfut74+RY
         FhOOz6wV31fH7sbaERdwcsNyLC89JX+oEOoXOPAZCXF4uiuMBQGAzgzV+G9MBRtBudUW
         HMG2jHnbCkaeZoqJXQP2VVnM/QEdhO3IQ8CKffHw3L8OeMtcMUyf4C5KN/6TInpdqQD5
         41O+EUoim1TtcRVWMZ/q+8yVBVw+/6MCKBX+SVTXAqIXT5lfg0HAslYdlsxNbJNPTpr0
         VjyFFg0y0SeAhzMWw4t5OJKAnVEMT0PQDKw+ASbxKrvUM5QuljSFHHLcmeGgS1JNg4x1
         vukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596549; x=1781201349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYChz5dDOhgIdKBmtje4M1+cRrICz03eZkA2AVEvq/0=;
        b=UKRS3oeNCcb5M4H8SmWnP//wYWifYxqSmaDU7Z5XmhOJQNM570Om58b4Xqps+YZbdR
         FxoD1Kqb7EopTWCHIJtjGkGHohk/CJON+Mt3R1x1tbyre6J/yUp24T2FNDDEIbxzG7P0
         4WHh0cgFl/m2FZIvem4iFPnDPHZyk9caoYueFTeulJxOUy4IQI6F3yFO4P29fLNdICS5
         If7INdNhc9ITOZPsSSeecCJBTbD5Adh/flAlxEckcGI1MVotFicJEFlfSI2IFDoeWgRb
         Y7Tec9w5MjCXDYt+FQvv4LdZ1Q26kc4qqeKdbpvcFt8gLMvqqam12Mc6gVldHARinG37
         lruA==
X-Gm-Message-State: AOJu0YxvyWnpoGUFDjE/jQgPnm2MAd0C8IU3cv46uwGtJ19ANoqtDP1e
	AaRCKy5sA0ft3fyfBaGmwf6LQpHrQAVpfszS/X9HiscxQ3vOJy9yuGAB
X-Gm-Gg: Acq92OFHK8Y21s4yeCUJL0iMJg8U+Cg9hU9JXq2yv3r/vhMictWiYE2xVUfJYoEKj1f
	Ot5tRgSIOCEEGN4W+05CDzfYK9i8T3kR8P0i54lmnHtpNdXOllp7iRgfy+Flb3NHNtwwmeI0aQT
	EUdcZ1eNgsjdLDxxr86aEeIBP3INTzJR7U76yVHAbKnKAszef2U5Oxm6odGhA0R2lF1jNatJ4c8
	1j5AcnulAwqBWE7sRaRZKiutZrhpby7KeVvbEn4k2jeDp7KTMoTsovtaXQhfY4X+zfVoeCxNbWG
	07rAluNNUas6Dst0pfIJKCBcjx1ElXHv3Tp+fkKlAWtUTGAr8cZM6RQm7m3ZNSzbDOdDP5ntisW
	dMoSVQ6zHigbQKPALQEU/dC7dSmZQXGRuzur1KB+4IEX0COAbMHS4oOMn9FLwBTJwbLiRvNX7CE
	tIFaCdblcGGj0lAQL1yAbUCaKL7dA1RhPvvNHEanscIzRCXhU//Sjpn2EF8tQX3TNEMaCgvITpl
	s4F4N9dFL99Y4jBZNxuncqvrxPC1/s=
X-Received: by 2002:a05:622a:4e89:b0:517:8bc0:9b5e with SMTP id d75a77b69052e-5178bc09ee5mr52725101cf.47.1780596548942;
        Thu, 04 Jun 2026 11:09:08 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dbd2c9sm59020961cf.23.2026.06.04.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:09:07 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ceph: bound untrusted MDS and monitor reply decoders
Date: Thu,  4 Jun 2026 14:08:56 -0400
Message-ID: <cover.1780596023.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The CephFS client decodes several variable-length fields from MDS and
monitor replies without checking the declared length against the bytes
actually present in the message. Each of the four sites below trusts a
32-bit or 64-bit length from the wire and then copies, advances over, or
loops on it. A malicious or compromised server (or, for the monitor map,
an on-path attacker on an unsigned messenger session) can drive an
out-of-bounds read or an unbounded loop in the client kernel. The fixes
add the missing ceph_decode_need()/ceph_decode_copy_safe() bound or an
explicit count cap, matching the idioms already used elsewhere in the
same decoders.

Patch 1 is the most serious: the over-read value is returned to user
space through getxattr(2), so it is a kernel-heap information leak
(AC:H, requires a user to read the attribute). Patches 2-4 are
out-of-bounds reads / an unbounded loop that crash or wedge the client
(denial of service, no information disclosure). For patch 3 the supplier
is the monitor, a more privileged cluster role than the MDS; it is
included as a hardening fix for the info_v 2/3 compatibility path.

All four were reproduced on x86_64 QEMU with CONFIG_KASAN=y by calling
the real decoder via an in-tree debugfs harness, and re-run with the
patch applied:

  patch 1: stock - __build_xattrs() stores val_len=304 from a 256-byte
           blob, then the getxattr memcpy is a slab-out-of-bounds read of
           304 bytes; patched - decode returns -EIO, no value stored.
  patch 2: stock - slab-out-of-bounds read of 512 bytes in
           handle_session(); patched - the bound rejects the record.
  patch 3: stock - slab-out-of-bounds read in ceph_mdsmap_decode();
           patched - decode returns -EINVAL.
  patch 4: stock - ceph_parse_deleg_inos() runs 1048640 iterations on a
           crafted len; patched - returns -EIO before the loop.

Well-formed replies still decode in every case (valid xattr value,
in-range delegation, in-bounds export-target array). These bugs were
found with AI assistance and are reported on the public list
accordingly, especially since they are mostly about a malicious
trusted server.

Michael Bommarito (4):
  ceph: bound xattr value length in __build_xattrs()
  ceph: bound MDSCapAuth path and fs_name decode in handle_session()
  ceph: bound num_export_targets array for mds info v2/v3
  ceph: cap delegated inode count in ceph_parse_deleg_inos()

 fs/ceph/mds_client.c | 22 ++++++++++++++++++++--
 fs/ceph/mdsmap.c     |  2 ++
 fs/ceph/super.h      |  9 +++++++++
 fs/ceph/xattr.c      |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)


base-commit: f72c95f3a516d87483e225ae081a402a09fd0127
-- 
2.53.0

