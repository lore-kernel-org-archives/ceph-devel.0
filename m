Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953778;
	b=xc/GXF2OukH4IUA9jBLrQE9jlwjDd1fqPJAr3KcrUpcCC89pL0n37Vo0qvcAJS4C8h2f
	 tsLDnDgjjQRp7GOO291XArHRZxS22fB+nLLPAgdv2fd/40jo7KcEWBmSDF03HPYD/QSww
	 XpCyD9twZBiLkyW5PAjetzxmXhpY/NWgjhuW3w0DVRz+yGmD9BrAW+WddkRQ8vslqq6sF
	 kSoTDGAF9oQ0aJpu8tQHOBmomvxkfCLUlSMcM/CbkXsg6FeA7TI6mvmLnkiplaxYehvES
	 awC9vNStjoMcNxAu5F312ILLg2VBSI1uFgAgLE3PFVc5g5Cyjfbj/xbjvAmyex9/esA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953778;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N1DCLvfOjDC42wmhEz6PCJeC1Bo8We6n6LwkJZv/JOA=;
	b=dPf6br1D4Tr642HUQP/7U/HguTP859ZopXpxoJCraOpBv5y04bF9AOzZ7fZ9iu90PVYp
	 AzvJFeFbtqwRiGQMf9OKoEv0WvEFJtNUQTFiiAKtyJlqQh7+IeaMq9x8heHBVfNCxJXH4
	 Dp7i5m04fFQgubznRQTT7uavx81/NvcOuYtqbEdFy34ZnppNvyukzKkrbZVWxfTwBlq6p
	 uoGxQZTIKHa8vnjhxlg3RDwIcTA7IxO7eXU07aqHpk3n5gS98S0cbZQzbD4F/OblsTSvT
	 +PNMjfJXT3IjK7dJp1kRhccOjkp0I2TLDzbs8q42dDsTmptZu0JCGd09Z7r6BXPA9BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="L3tO/Tvi";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VZw9ic3X;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52417606A31D
	for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 18:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52417606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L3tO/Tvi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VZw9ic3X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792953777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N1DCLvfOjDC42wmhEz6PCJeC1Bo8We6n6LwkJZv/JOA=;
	b=L3tO/Tvi3elnH0bIsl6H4MFRWARDy0vb3mRhx3xWXmJXRDF8h2ZnDpXbnpxG+3dkVD94yX
	DV62huQfuZ3IFrydBjWHfDJ2v+T9ZgNcRPwCC072thDv/Mgbf2/X/TTjr1vhQM3f/g3K9Q
	ymnncRwx4CiI4qKFT1pR6CM99Pw30PY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-COwfy6DyPRSGcqVwtWEABA-1; Sun, 25 Oct 2026 14:42:50 -0400
X-MC-Unique: COwfy6DyPRSGcqVwtWEABA-1
X-Mimecast-MFC-AGG-ID: COwfy6DyPRSGcqVwtWEABA_1792953769
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c3613c35145so256372866b.3
        for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792953769; x=1793558569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N1DCLvfOjDC42wmhEz6PCJeC1Bo8We6n6LwkJZv/JOA=;
        b=VZw9ic3X3a7UhX7gS/PKYUJhJw/npTrWYwFh4PSVJR7FzwU17ojJ06OL19l6qe8gFO
         nnctHZTJEEcbPzvqTqhj42B8XmW4WCW8zbrZApyczMa1W6EWM8V9LqRai/luJEY4hh6c
         ecEMM6sSkwz7qIJ2c+ndDO1NIIWxo6Mii0YReNz0cU6RqG/HiMO7Fe+cv0ulcAaLGljy
         0KJwKOgRliIoyk6pfaponjJKgsoWxd0jaBByiGrqbKKqViFuuHXCygjTGYGcKakzYn0Q
         Wcoj8GtVkT9VQD8xdcQCkfxFWRZTANEPmTYnRorN3g1INy8GyKOmLQZtT7EaZyxLxlL9
         vCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792953769; x=1793558569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1DCLvfOjDC42wmhEz6PCJeC1Bo8We6n6LwkJZv/JOA=;
        b=SccRr6LVn3jV+l5O4zAK7yKgpPjZw8XTn2EYmtTtRnGgjKbTXnQXQI6mNvOssbXeuT
         LiRMSwVKJeAKQ1FORCStkckWWP2ncxe9lhiNT9wkIrHm+1EQru0pys2MvK1VipBxoTV9
         dF6cwgz7i3iEOMV9mVjgx1fJ9vn40o8F7vLd95QlYQDW4te/+AVhJpS07MOgbo3uQDc1
         JqT7sTGAu2IyBMtV7PEySBA70elCl8xt16fFjdL0vKn7a697xaqL/XWYkTUy8TT/Eo33
         ii6q2pEQSATGPs5a2jWt6wCPw7wlG+U+q8lphNnfixtWxec/JADB8VY+MoP+tLIrMr2y
         1oRA==
X-Gm-Message-State: AFq9FYLEz4o/m04X2qj6yu1/Qg/QXcW2qxzwdB5g8pYfHxIMIR9l4A8H
	S0ja/c8Mc29KlsEW76T7utgIy4L2xO+9YxREHDEPz6sIepEKVoTVn/MM57FjaRlQoqkNhx8ugBs
	oycMZIELs4n//GGslfjRkbyfN+1tnPKWQWyNJNKcspSik0759fXaOPPg3J4pAlnMxGiYm5+Uer+
	nOcYDYAhNQMtiqSsvwtSmwd/TIyYN61fxAbUQeoaD9+xDaloBhcA==
X-Gm-Gg: AYBFou3LoflJx7fKuDM+3B4sJdYmFBjC1AOWu5SgybKp9px8nmYZl8+nJPvn/5YnbC0
	21XX3Luk0bOcDUwEngMZtOTFO54ep4tkE0Zwt0D+j/lIU+fsp9L3Di4+yXKvO0HNLAShrhI4zk4
	3sR5aiCjSR0q3BesuZtBwvvixQMkdTrwFaH6Lw3v2Qxzfdj+Q9v9SHIct1bEjYtT7eZ4Ncq3JMs
	74oiBtilbOAE4Xk0oY2TB5WyIAHI8AKA+1YSLa1j0g2NqL/WkX/P2YkLYH9MgFRcfOpebWuwQOD
	H3/IIkWvqu289u1u9WsadD6ycUrGuA+rRLYhqMuidI9AuQ3kgCVaNsM4fzhDMqA0KFoZyWiFWKB
	mh6IyPttJtWJAUOhI5MyZ+xRJYYBhGSOlVMUbsV8wYJdeeDcUf0vXudlnXcu0Ptkap6so5E0+IU
	20Xuy1qQZueG4CH9iNccrm/1+FrIc1IDWlvMNBxleBd900ivQba7XocFjqTBmPGAfuVDh/jGCDC
	qI=
X-Received: by 2002:a17:907:2d92:b0:c40:f9ea:7375 with SMTP id a640c23a62f3a-c46bddaed7cmr640681466b.15.1792953768818;
        Sun, 25 Oct 2026 11:42:48 -0700 (PDT)
X-Received: by 2002:a17:907:2d92:b0:c40:f9ea:7375 with SMTP id a640c23a62f3a-c46bddaed7cmr640678766b.15.1792953768403;
        Sun, 25 Oct 2026 11:42:48 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm230750866b.64.2026.10.25.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:42:47 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] ceph: support subvolume quarantine
Date: Sun, 25 Oct 2026 18:42:40 +0000
Message-Id: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS subvolume quarantine restricts ordinary access while allowing
recovery clients with q/Q MDS auth caps to operate. Add client support
for quarantine notifications and enforce them on cached access paths.

Based on the testing branch of https://github.com/ceph/ceph-client.git,
commit ed0502cb11f8 ("ceph: validate encoded xattr name lengths").
The full base is recorded below. The dcache and fscrypt prerequisites
are included in this five-patch series.

Changes since v5:
- Describe the dcache export as a prerequisite and remove Reported-by
  and Closes tags for it.
- Reject foreign, disconnected and unhashed non-root aliases in ancestry
  walks while accepting the live, unhashed superblock root.
- Reset quarantine state only when the lost or reconnecting session is
  the reporting MDS rank, including when its cap is already absent.
- Check saved authorization's generation even when no inode is marked.
- Check snapshot path access and acquire normal wanted caps after
  quarantine authorization.
- Clear detached xattr-buffer ownership after releasing its reference.
- Use synchronous CREATE for new inodes with an LSM security blob,
  before async preparation, including before feature negotiation.
- Keep an existing quarantine mark across a zero-error IMPORT while
  processing imported caps and negative quarantine errors normally.
- Use the incoming wire cap mask for clear decisions, so PIN-only updates
  cannot acquire clear authority from capability bits retained in a merge.
- Update encrypted-symlink and capability comments to match their
  interfaces.

Validation: GCC x86_64 builds with fscrypt, ACLs and security enabled
passed W=1 vmlinux/modules for the final tree and the recording patch.
Twenty-six extracted-code quarantine state tests passed, using mocked
kernel context. Live cluster, boot, KASAN/lockdep, LSM policy,
failover, performance and LKMM validation have not been run.

Previous submission:
https://lore.kernel.org/r/cover.1792527529.git.amarkuze@redhat.com/

Alex Markuze (5):
  dcache: export d_find_alias_rcu() for modular filesystems
  fscrypt: allow filesystems to disable symlink target caching
  ceph: add subvolume quarantine wire definitions
  ceph: record subvolume quarantine from MDS cap updates
  ceph: fail quarantined subvolume access with EACCES

 fs/ceph/acl.c                |  33 +-
 fs/ceph/addr.c               |  72 ++-
 fs/ceph/caps.c               | 323 +++++++++++-
 fs/ceph/crypto.c             |   1 +
 fs/ceph/debugfs.c            |   1 +
 fs/ceph/dir.c                |  54 +-
 fs/ceph/file.c               |  82 ++-
 fs/ceph/inode.c              | 956 ++++++++++++++++++++++++++++++++++-
 fs/ceph/ioctl.c              |  13 +
 fs/ceph/mds_client.c         |  26 +-
 fs/ceph/mds_client.h         |  30 +-
 fs/ceph/super.c              |   4 +
 fs/ceph/super.h              | 101 +++-
 fs/ceph/xattr.c              |  60 ++-
 fs/crypto/hooks.c            |  28 +-
 fs/dcache.c                  |   1 +
 include/linux/ceph/ceph_fs.h |  13 +
 include/linux/fscrypt.h      |   7 +
 net/ceph/ceph_common.c       |   2 +
 19 files changed, 1706 insertions(+), 101 deletions(-)


base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde

