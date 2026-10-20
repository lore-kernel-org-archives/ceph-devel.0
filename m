Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528028;
	b=M3MqZpGsBeMO3AtGxioIkYAz2ETBQIRQYoYftc5gTD0cropiDqEA7x0htqqupEECeBoR
	 NnGKP5e+kHwOnLZ6DZuIcz6aU7mWupwOqcuw+ImM2YT0L+xxZU+SPqqEInDaefRxMTHb4
	 XWq6QXox11dndVkWlWa10g5T/WKURAgJB4Xf5I+kdAF02eJvGB+SJ3e25WSqvhxWlqJNS
	 uxZRIlyJynYv4VHY0iNlKRZBbD4fDv/gGLz9+yKeU7fU18I6wUyomTVlGWA9UuSuzMlcH
	 LRG9yL1V74V5jbxDEvyEY8AOg0L80ZNWdZXzXwSx8x0RgsMyLfB8bU9o8iZl3xz2TpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528028;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=U+8O06S9Eh2hIugHm1/ozCUCaut0H4CQS1V6HfCIeStofEn936oFzf4XyfjeCkriFbFw
	 FvNgQ0W7uSRSZWpeO0gXOUGVZ4YaJ+OtwQX3zJ8t5HzIGpF0F9bmtmcdp8Xc+76abmmcS
	 OQXwzufFCSPC+Y0ZvmLdzo+wzdCvNprHCRRWwKCPEbCHuAxSri2FNvI6+iEXgA4qCDxFL
	 kEmfgN9YHXeEm+gcZyfr7oZFjCuHn1B+et0StuscnZxx6SiM1eyRQREg8//o11sbh5g/p
	 GCnIIQUbsDG6hJUvtfDmwBE5mIoCW7nT3iXLc0SiiZQ/k82tDpN1E5gfR8jUGBOHAiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KrWjGgfM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qD38TerE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F41606A31C
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 20:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F41606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KrWjGgfM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qD38TerE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792528027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=KrWjGgfMQuF3fOqNYPCHHJPTU8MavV+0wGAxlICcdURHcw6RfixsZIHBH4tT+xaIweD2+o
	zLnM0MBMnZEmG+SYKkrhkpiOH2+cVhI2q/vFwVSntpqLlHXIVwKU/stG/B44L04RrLnDQ7
	cE0D6SxnwAdjGkyqo0u3nVPDQIIjGIA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-7LzPls1uPWy2D9ocxAfX4g-1; Tue, 20 Oct 2026 20:27:00 +0000
X-MC-Unique: 7LzPls1uPWy2D9ocxAfX4g-1
X-Mimecast-MFC-AGG-ID: 7LzPls1uPWy2D9ocxAfX4g_1792528019
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9195c59ac8cso2821316d6.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792528019; x=1793132819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
        b=qD38TerEvM/xhI2qcwInD8LEBlNiS/MBERmWwGQC5j/F3NqlwIYxOxFx+IhZPtkzkN
         ENXcCbTXRt3YC1+TsNbtx8fk1Wa/YWXLzTMop0W/2wJp9WXUFWddex/QXJTAsa+5Qw9H
         wOuqxeg5sOeXSxlF/KGmhV5KeTmXP4BTJ1Jb8/F/WP9JIqLYi37WziXseeVZrgNx1H0g
         PUME3/C8kIsuYH3WTKEHidYhfPHMGK9/dymDN3G6qlRaAG3PUPlxfXVijFuf0oNiPsXJ
         BCHRJ9iMD1Q1YRPqw306mNMcy0AgwRjMaLtlodFe8ueKeSqNptMuj2UClBSMSVMSutHG
         4JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528019; x=1793132819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
        b=O7PkoBIDd4m+gcdGGSRWq0qzPIkKhsP9yBWWI+l3AnrUzOJAJl52fPvKXtgKyJdKQh
         NzK9smIqAaLawTa38L6JjEiIkCy5MY+gPb+gevKj5/FCGm6fgZS7g0H2eAShecIRAvgf
         EZpagkw4wtWAUZ+aABHliu+AcnkwQIoxWEwres8LaEZraIy/hRZTPcux0F/rCzqgYQmO
         dHwx9IjY+1ik0tFg5+oA5KWmjl1KYqj/u3l+xAgk2CFdE7JM9pgE9A9m72j01kNWL1Rv
         wquMwg68sFq9DhCMwuAXTHYWeq42ed6wmoI/dtrcEMnVucKfqaOyqt5v6FYVL02xd2x0
         WhEQ==
X-Gm-Message-State: AFq9FYJRXEuH0YLa8ZgPoIWEWGcymLZ2VYqxJLNGRjC50FjQva9H30t2
	f/QrCi5KJTSoe3WZs0dQiIOAcLbEW/GKT57ENb+Q2cda+CrNWhGogwsAoGaL15G3p8spdJlxlRG
	RCAo3Akcbb9u/dgecw9ox5Z0hWQn2pW60JJYRWPk4nSTz7KAgBhQn10ajAj3q1nC//rk49SIzZ2
	xf/grdux2KOnt+ZwfpD5rYFG5f7CbReg8aKb+aYLLftkuiiN7ZHw==
X-Gm-Gg: AYBFou144jQgsnC84QlKdPV7wyroW3OtR2NT9W0El1b3ToLuEdZJwzmlb6paMcaNfVW
	wGVqU1iojPS04slOKEdnQTDXRyPKh9ijyVlcvJENUNstVvfgUAJ2kDEDD2LFdGqQH53WKswByFi
	pqGipdVxd36K43PDfJQHvnX30kwtiff97lgekmjsiLGMWHYc5b+1oR4DDkqt0i0abqKX4eMpgGW
	hZCItUi8Dtkag6A+EFCeWC0rjQ2evxaHO60mFdDkTQIMq+UHPmfiRCz7pQkK2pNNMSP/jmqOhRf
	vhYdMKhdjp5YCF825RCGlmP6U9uB0OL7RNZTRJQrES/2nSpKnUNrpBh3Vu480ymXmSwitS1xDBR
	D5/fVD0Ww1F5FxEteeSfDgJS6Dnknr4Jie4PajCqJG14tD4q2+TO6GBAZIZr1LbSNo+ffXau+2B
	pmDeO2N5J3sCdckCa1avi2GO/npKWfIShnf3b+P0/Ya38dUk0b/rDjn1mkLLWmTYpPf6jaLONW1
	0Q=
X-Received: by 2002:a05:6214:6107:b0:91b:f9ab:3944 with SMTP id 6a1803df08f44-91c01f39390mr65133296d6.7.1792528019352;
        Tue, 20 Oct 2026 13:26:59 -0700 (PDT)
X-Received: by 2002:a05:6214:6107:b0:91b:f9ab:3944 with SMTP id 6a1803df08f44-91c01f39390mr65132696d6.7.1792528018761;
        Tue, 20 Oct 2026 13:26:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm7461436d6.3.2026.10.20.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:26:58 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
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
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v5 1/5] dcache: export d_find_alias_rcu() for modular filesystems
Date: Tue, 20 Oct 2026 20:26:46 +0000
Message-Id: <ad1e9d2c5ba4803f1c7dafc6687638b0489a7265.1792527529.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792527529.git.amarkuze@redhat.com>
References: <cover.1792527529.git.amarkuze@redhat.com>
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

The Ceph subvolume quarantine ancestry walk needs to find a dentry
alias under RCU without taking a reference. d_find_alias_rcu() provides
these semantics, but it is not exported, so a modular Ceph client fails
at modpost with an undefined reference to the helper.

Export d_find_alias_rcu() to GPL modules so filesystem modules can use
the existing RCU lookup without changing its lifetime rules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..13ba553081b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.

