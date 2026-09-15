Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03970485CE2
	for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470818; cv=none; b=jYB9xE2wrXqODYR88ocrYxTSY1wI3g26CQIHg/zLufkGQwWd+95vXWY4rsttsk36R9kPgc9YlH5Q45jvn+3FJYv3Qw0QZiRacPr054wJhSaUQ5kJBeKhKkM5AOdcH6xW0+Ef1UVggrVtd7LhzdLtThcFo2h2XrRVrX/jQxL8NlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470818; c=relaxed/simple;
	bh=pDG+LUYfWE/lg9GV3EwC7bNAC2luO8YmosElSYurcVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSqFsWLoloX7aY7FbCDTm1gwwXwc7pByZ2DBbBDI0O+Q9GTH7AG48aIJ4cfiJoBezpb3cxUrq1dI3yaexbw3h0We/umyRZpDLJQYP/aXCrj4K4l0pXLOFK/YOBi+2VY0Zs1DjbzH4W5QJkSbkPlGZzCpgbmUroS+qPDgSrl4b3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV9l1Up7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPHTE+Vy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV9l1Up7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPHTE+Vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789470811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
	b=bV9l1Up7iZfNRbBS6PYPqJivsjKVx/ePypflGKMI5bBAcnjXxJbZzmqyxoXBrZxyynIHoh
	I8PGHAed2WUKY98oodEd1JbfBfqalf1ncL+eRkB5EcM4LZJazEFsannDvIKY1kO6f49uUR
	L3Od8UTHz/ty+i2h0H1SfANCfQs8Vbg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212--_X91oaVNAqCgzhHCmDvGw-1; Tue, 15 Sep 2026 07:13:30 -0400
X-MC-Unique: -_X91oaVNAqCgzhHCmDvGw-1
X-Mimecast-MFC-AGG-ID: -_X91oaVNAqCgzhHCmDvGw_1789470809
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c252b87e9a2so393819466b.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789470809; x=1790075609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=DPHTE+VyqGBisQaWzooEaOWWX6U5OAK8gljqsp0XsfaD00lGrrwurLFtujqF/s2/w3
         NHXTNJB3/gXRGwFdN3VOBkX3dnrwQQL0coRFluu2YnCyCxEOt+X4twm9JPNlWerNsSqJ
         up/mIcIHhmMafT91fQF/zFuotL3pX0Rhdx+3v6Ah197YJGdFpkH9MbLVEAAIjbnGxHxB
         i7iphUXQ0xGbJuQrEdfj3aa0g3GMUGYsF7qiLxL8j1Aalm5b+X2GfvqhcxClOE5a9Ylm
         dZUvpp+0CoFuMIfz3r0tLM2KgQcwZHdYn7/yzx+Ef/RlI5VFPgxEaTfHCWqd7+r/xN88
         U6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470809; x=1790075609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=tuAavSUmRVEOWaVmsmLlTUQFB/bgsw3GEzGNJFR3QdGRFSVLVT0WWRe/MJYA+QGO+/
         6PIX85rxOuLU+3Y3abfmwopBhbdb3DnFaghvhxSMCcb3Ozqo66e6Wo8/s54f19hswsY5
         QC50fO5a12wvFR2i89LNQSxlqVHkWlCigYeIH1UuhZa+I/D8ljiT2oGszB5zua2WNjBZ
         CnNjfb3+lCwOjyM62oPORT4j1vUat1XYN358AayBHZLVvyVdm+20MlnjsMoiSx/IxRG+
         vlWWwgmPgNcE2d8ui5Fxq78UfehyvQ/jV9d20gl9crNyx/eBZLUp6yQZMd6kNeCsJP9N
         0wmA==
X-Gm-Message-State: AFuF++novtizlWoa0xvTxHS/xSLyPwAvUX/KjKWfWZ9bdJpatIWF59Z4
	7VRcXZpEFTVVectsNnf8iiflzMAQeApykZhm1hhmXf86RsUkzjIDTUGsAfKJJHJ7OvP1n9iWViw
	Ppo8tOlqXJx7z5kzWeCIVqOdpvFXVbrClE6ZR8xX2z9oWzuSUpehEV4R9a6Y+T4w=
X-Gm-Gg: AYBFou0jlkqRLKlu7LnQ3q34NFooKWoUhF5tpxyoMk27r4jOW7sKTaVwN8pKiL2Rh8h
	ZUUZtSy+F6iKFWeZO1NdjMXIWq+eF07g/zZtlckOlVI6PvUsUN2ISTsn8wNjcQe62lDJMasnZ5n
	0LE6fEF1n3SwmMvM+Bu7yIeLz5VumEh5TCkSdjDlMM4rFxyihRtx3IRvioH9MEncSWF0XhhU1CM
	qmSlbFkB0L2xGud34X8qlVBybe74O0Riw6sjcmZjgxPposLPXy54kXxQQynTi0GbAoWNcnuBhK3
	kM7GTwhQjZMUODWhYxOtvH1YVhlPVggPmjposj2O86lDyHay9b1cDjggrYc/9pYSg4epp0ac2an
	jvbKgFbUbINnmxSsW6Oem/F/nQYLEeo89wa5XWBbyqSqLCWVfzvCpDltzhwV1Atwye7NtqNKoMA
	cv13hxM17GNRszJQ==
X-Received: by 2002:a17:907:c491:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c29d78100bamr47698566b.21.1789470808908;
        Tue, 15 Sep 2026 04:13:28 -0700 (PDT)
X-Received: by 2002:a17:907:c491:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c29d78100bamr47696466b.21.1789470808515;
        Tue, 15 Sep 2026 04:13:28 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e8a1sm573304566b.6.2026.09.15.04.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:13:27 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: require the dentry lease record to cover struct ceph_mds_reply_lease
Date: Tue, 15 Sep 2026 11:13:26 +0000
Message-Id: <20260915111326.232783-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915021710.386847-1-xmei5@asu.edu>
References: <20260915021710.386847-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiang,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

