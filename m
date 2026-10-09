Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D74EDCCA
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564178; cv=none; b=jrnYUb/BL0k8Nir994Rr3Gb8Oj57R1YYIZUTg25eTrXeMAPa4uH/QgIHXXTGH80swL742jonyu7FYbdYLf4elw9HmuxSMIP8xeTvWPzFEtnURaVVqXx0E28pnxCNzaZnTpFKQVoPY5lyDCO8U9ReeHnDh/x2g9R4klX/R+4lSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564178; c=relaxed/simple;
	bh=4RolatjJYKhW4BkRVxNZi68eViD/glA0DjLIfDtVdL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bJ+wxq2bR1fkdxmN4LUeBcyemZ47NJBtGcUF4nCN/Weybk3viyPWnlHjkSOcoSNWbEeVygPqgBPiPaiEVvaV5tOjLWK3N0xMx8X013XZFojpCTI3YnxrECYN1iolQREL++J/5/9Q9hrZliwL9VzZ4h1OMRlbD8aGs9jlI5RED6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtEXp4kB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcE072Ue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtEXp4kB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcE072Ue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791564176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nLGnaa45AucYTG/YmDTM9KpL4DL+ShCLMZeRFvMFPe4=;
	b=HtEXp4kB+tBCs2rbAigz3Zhm8qEC4qX73R/D0uRVW5oXgHp8VNaa1jj+MaCrMe3Nr4cHGi
	nO3OJT4G4+9Z/BIeZPvDoWWip8dNWVarguMztv6rJ3dhnM+Gh/WZyNM+Jrll5KUb2z1M2Y
	hUSI9/l63fF8v1nh13y70IwvDeRjhh4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-TB1uD3A9N3iqiTlSFHOFPA-1; Fri, 9 Oct 2026 16:42:48 +0000
X-MC-Unique: TB1uD3A9N3iqiTlSFHOFPA-1
X-Mimecast-MFC-AGG-ID: TB1uD3A9N3iqiTlSFHOFPA_1791564168
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2939083cefso5041166b.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791564167; x=1792168967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLGnaa45AucYTG/YmDTM9KpL4DL+ShCLMZeRFvMFPe4=;
        b=GcE072Ue7WTvwCeBBHNXBl2SqKmWv4SPALFd3wVNWGAFjJYJYH3ZwMyrAbLxdCYy52
         ccmWeXNbeIIgtU22OqlfeVzrBGR8wXx0+qfHTVfWFubqBrly0Ri6l3eS/GeVbAuLElZR
         BcHQQIT9imh4mOq/E2YuI7p+yP1HMm23Ng2zOaod4tk+2pnmwKkb7x/HN0ggz/T/SDdr
         Ou+TIUtqTG1ZB93Tghc573VP8OvTY7szoea+sRSAFJdA2JEplKmd40bDpo9SwEp/h6LO
         R+q8OxXXXuS6cnxwUGJ34AmO6aeXmv8OnC5mHs3cx/0PdSlrRJYjLb+S/8raIOs7JRZz
         /DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564167; x=1792168967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLGnaa45AucYTG/YmDTM9KpL4DL+ShCLMZeRFvMFPe4=;
        b=xtuYcKIbMdjE4g4CPaH7N/QGPGVZk9WUy13H4pj67JOUyNvqn/of7B+ay8lCVsBKQH
         TJk+WNtSaF47v3ux/gaRvKJ4PtSlqSeBk/OOQsJNSMUK4jDKeuOlyqD543xaxJ1d5irl
         QPa6P3m/WygllDV1/AmGrrcb1qg1sMnlXse1wqCA9JvAAoiKMRAIc+OEun3Ve9R1ZCJG
         RWbSPXXZBfiUDZoaRYxk4CbyMk+BCxSKY5EBlmFntHjgKXnc47eVfBuX+vRfFiJfK4v3
         p9FCx3WqJJkWbiUkkc35cmAljhTKey22yIFuZPBUv31r/e5LeCede7uxBc9ejAxXDlnv
         p6Tw==
X-Gm-Message-State: AFq9FYIB+Bk/hdYI4rpRlBGAj7hHKWvADGgduJ0BJQ/iyT7XjYoQ1gDT
	eB0FakPX7RNZnm0+jhsRiFToKt+uPWHWLSs5Nk2Z/xJKAM//TN5UYeKsNkw6zng9POGt213t38y
	lb6tC5AydwWOl7VeWcrp4yv6d/4ydNipPjMKENN6g0FR5ncCpMuJD+aYdR+iFVjzTYlqyGO5Gq4
	EZf5np2GOPurio0bF3F1G22NCRAUIFeAiIkfHEBqQWTP7eGNtuzg==
X-Gm-Gg: AYBFou0BlxwGNmjl1mM780kE+MSTpX3Glk9RMo+v0pphoF5afUeyKJqO2s1V6SZO8nI
	SMikC2UX/twdownsREFYfj04GTJwqiaoqKFZIJWSQYAUrmTVDJOqkhpqRBC+IhctOqrSz16wJqK
	vJbRL5pwTMG2e0EBBW9LTIAlIzEounL2D2oyOrStwz1Ez4g/6BoRmhfi6vic54g2cFQCcEWfa/m
	fh6KHS3pL39PUYf4QZjesXQqqx1JXXHa3/LTlb8Am8exjX6cdAxyzrLpSGMVXPc29hL6xVjKW8A
	WkLRA3E4YVK2Wh1q0YZKbt2fMUSie3FcNgyxPOoioXU+yshRmqyK1OcAk0fTjtCv4siIcI5tIxq
	TCIqCZQMsHYUNtsrDPmFWSZxRhk3r8ocyUdQeNJNsPYnHjyTCZnu3ovVgvu7bGp/6y9JOxj1QoW
	8yRF21OxqK9p/9Gw==
X-Received: by 2002:a17:907:9720:b0:c2e:378c:8cec with SMTP id a640c23a62f3a-c31a9a29c8cmr291371566b.5.1791564167598;
        Fri, 09 Oct 2026 09:42:47 -0700 (PDT)
X-Received: by 2002:a17:907:9720:b0:c2e:378c:8cec with SMTP id a640c23a62f3a-c31a9a29c8cmr291368566b.5.1791564167161;
        Fri, 09 Oct 2026 09:42:47 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa8511sm120683666b.59.2026.10.09.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:42:46 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/3] ceph: support subvolume quarantine
Date: Fri,  9 Oct 2026 16:42:42 +0000
Message-Id: <20261009164245.2483933-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the kernel client to handle CephFS subvolume quarantine.

The MDS revokes caps to PIN and, for a client that advertises
CEPHFS_FEATURE_QUARANTINE (bit 24), rejects new metadata with EACCES
instead of parking the request until quarantine is lifted. Recovery
clients with q/Q caps are not marked: the MDS sends errno 0 and full
caps, so those mounts keep working.

Patch 1 adds the wire definitions: CEPH_EQUARANTINED (1000, not a
VFS errno), CEPH_MSG_CLIENT_QUARANTINE_DISABLE (0x315), and the
disable payload.

Patch 2 parses the MClientCaps v14 oserrno, records quarantine on
the inode (and, by walking parents, on children that have not seen
their own cap update), and clears it on MQuarantineDisable.

Patch 3 advertises the feature and returns EACCES from getattr, open,
lookup, readdir, ceph_get_caps(), and ceph_mdsc_submit_request().
The request check also covers async create and unlink, so those
cannot complete in the cache.

Alex Markuze (3):
  ceph: add subvolume quarantine wire definitions
  ceph: record subvolume quarantine from MDS cap updates
  ceph: fail quarantined subvolume access with EACCES

 fs/ceph/caps.c               | 108 +++++++++++++++++++++++++++++++++++
 fs/ceph/debugfs.c            |   1 +
 fs/ceph/dir.c                |  10 ++++
 fs/ceph/file.c               |  11 ++++
 fs/ceph/inode.c              |  57 ++++++++++++++++++
 fs/ceph/mds_client.c         |  44 ++++++++++++++
 fs/ceph/mds_client.h         |  10 +++-
 fs/ceph/super.h              |  14 +++++
 include/linux/ceph/ceph_fs.h |  13 +++++
 net/ceph/ceph_common.c       |   2 +
 10 files changed, 269 insertions(+), 1 deletion(-)

-- 
2.34.1

