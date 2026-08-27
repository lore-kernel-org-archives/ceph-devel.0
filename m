Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4B40F734
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822545; cv=none; b=DRBf/usGbO57d9qc23juB9SHk3GuEgzwrcEtRC4Nr5eSI6b1doAk/vXUiCjuXZV8RwZmS/FNMQesxJRksxnV/oALEZAE+3lLzpuy01Ls8zDmqxMAIy2FcNhim5LxEK4e0vAPXmTH3KvqJbr8LLx4C5KhI3KB4gCD+OQld0v08Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822545; c=relaxed/simple;
	bh=4KGEmFqBo7s/stuNHhNG0lVjPiFj5YqDpG9ICHflxlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXZPzdE1BgS5N4lg1v3e4KeOtmoyYv7n2jg7swNx2xMN919Py0uSB9jgt2eYv1tSqeXj7DJjZUA94Z4waROT/3bNPMmlr5ZJPANeRGFTWhUWEkhXqQcV3byMGuRsBdSe+/clVzrACLvOXG6XgSv6Dxp/BV+iLgo29CGSGAbZCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhzjJiAZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rNjdjQ3x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhzjJiAZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rNjdjQ3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787822542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hw7/UxinWaOYi4nmIK8Q/euZYbsafd6DDjJpBXmtBy0=;
	b=bhzjJiAZcOTHpc/vwZvP4WKpEwIxesk2wASk03WkGecqTfdcqmhZkpH1iyXPQBanR3z1YP
	R7Y4WmuHq1cdNfG/Ru0+e4ySgbJHS4JYmiHg2Zv8m9kYSOQUG1uk/zgexc7QhGQzMkBrs3
	ASYlQFh+3Z7xcGgjF53XoYD2RqzFA0o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-oJatM9b7MLeIwKEAk8Skrg-1; Thu, 27 Aug 2026 05:22:21 -0400
X-MC-Unique: oJatM9b7MLeIwKEAk8Skrg-1
X-Mimecast-MFC-AGG-ID: oJatM9b7MLeIwKEAk8Skrg_1787822540
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfe48ca1efso30689095ad.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787822540; x=1788427340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hw7/UxinWaOYi4nmIK8Q/euZYbsafd6DDjJpBXmtBy0=;
        b=rNjdjQ3xTNh4Eby0ZCgWsvIIpkDWL9O+gZ8gfXg0vz5bXdYvB2F+3BxbXLNGbGiMZt
         +c9b9CHLrckEDW638Ein4e4ey7lD6+bfAnl2qai72RTL1IMbMm9y1SeXWA5ihcM81GE3
         /Ie2BAl2BtwCVIclxeZM/ELZoJBaHVLW4ErMMPldHhuxenxSG8g6JJBUj9PdhV+PTtyh
         hb1IVre4m0EAndU8aXJtSIfHYQoh98pU808nRhdVA1VMojmWVTBhfegTXsvbA71polXq
         QUFNYCIzukjnofxL/KdfBMrNhsTvM9Zc2uyGUvn26jicguWBIfPQD7/DBJNdeSDHi+SM
         JiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822540; x=1788427340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hw7/UxinWaOYi4nmIK8Q/euZYbsafd6DDjJpBXmtBy0=;
        b=eJpAYO8rJwbSOT5yfNRMblMUTKwo6H7jI+hL3gRwl4YUKucjA0TFo8UUKPx4U/RhtW
         FfOZbSi0zf5CitJg4kth0mwGhLk85n6p/fKggyTRZbpbIKUvDru6SLJ7DE2U1BKcEHp5
         a5Y2QFaeoVJUPyMkviOtpD6NduOzn1Wlyamn7pwBYWZM7UzHwImZif0khRiTRb4bjkhp
         Fkv8+EU7FDcQ/xv1ltqApRRydTyJyb9sZKf/gpMK0O0NCkWqjysRo8YZVydX6jE1Hp2L
         Wb+0JK5GWlYSH1uBQDw9SyzUGM2UtmflOeCuF+yGmBEVTFRBjsNToO4l7szMXyP1JFvG
         Zd3A==
X-Gm-Message-State: AFuF++nGE4NNIYjYOzuQHQcDYK/Q6xyLlye6pBmL2uZdlS0a0GlRnJNc
	uH5Qd6txN+EERJSWjsXQXwHhu9zNp7e6HnpHGb5A76nOvBN+1++6qug7VNCifLXPSh7IU8b/v9N
	BZDMyTgwJRTCgGosTdnwulFYDmlYtfrxJIrI++R8we7pUDniJIIrdAYshTbyl0nX4IXxI2HNjzg
	==
X-Gm-Gg: AR+sD12X8XnYtnfn33eZAMwJBRU16s0iySmS7K6PfRkEvg5a9E8svtJ+Tje6FMynkit
	Ruzf0W01WghLGjFSxJqlWLCAy/otUfOT3BQML7SzeQ3Qchoq9pkyikSa3m10nYK990RGAQem9mN
	n0CsCeSBd5bknSWRF/8ni3cNXRsvc+matc8kPS2jr2Md21J3f2sjktvOgAhSB/bgbpXZ7UGbCo3
	Vyq8l+aowxKiut9yqF3mm9yVeNBQahRT0cmYWUfUJZl3tQbxWgAfylgnsuyBCMHhC6xO1MiucGf
	GzI50w4kwU+NzNirL+kOnnbU5uDUnSk66ctmw7OP7u6U3GPr8yh65F3pKat1fbo+uTIjhw==
X-Received: by 2002:a17:902:f542:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d707a01932mr254855005ad.1.1787822539905;
        Thu, 27 Aug 2026 02:22:19 -0700 (PDT)
X-Received: by 2002:a17:902:f542:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d707a01932mr254854015ad.1.1787822539387;
        Thu, 27 Aug 2026 02:22:19 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm27728862eec.6.2026.08.27.02.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:22:15 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] ceph: add 'lazyio' mount option to kclient
Date: Thu, 27 Aug 2026 09:22:08 +0000
Message-Id: <20260827092208.2741445-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825-lazyio-v5-0-65118679d6fa@clyso.com>
References: <20260825-lazyio-v5-0-65118679d6fa@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please send a v6 rebased on current testing. Patch 1 looks
fine; the series still cannot go in as-is.

  1. fs/ceph/super.h: CEPH_MOUNT_OPT_LAZYIO (1<<18) collides with NEARFULL_SYNC
     nearfull_sync is in testing now, using bit 18.
     v5 still defines CEPH_MOUNT_OPT_LAZYIO as (1<<18), so 2/2 does not
     apply (conflicts in super.h and super.c). Use (1<<19).
  2. fs/ceph/addr.c: ceph_filemap_fault() ignores -EBUSY from invalidate
     The new non-lazy fault path calls invalidate_inode_pages2_range()
     and ignores the return. That helper returns -EBUSY for a dirty
     folio (ceph has no launder_folio). After CACHE is revoked the
     page cache is only kept for LAZYIO, which is the state this check
     is meant to catch, and filemap_fault() still maps it into a
     non-lazy VMA.
     If invalidate returns -EBUSY, do not call filemap_fault(). Flush
     the range, retry the invalidate, and only then re-read.

-- 
Alex Markuze

