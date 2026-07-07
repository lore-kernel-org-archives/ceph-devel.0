Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BA228CB8
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417770; cv=none; b=AvCD/n2FxAJNqvgfTp5EeKyTRpr1NferiJosiS261Un+qOldsM62cPq5LYv9BBnJzB42vSg3oLNVcSimcBgMlv1S1lRnf4/mBl9iXWA4qEEO8wPVI9JBgOh65jejUI1qLlRPDBWdvyVDflNcRGLpE/B67CmamkORKbQLh/ZHS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417770; c=relaxed/simple;
	bh=kBl/kKP90ZF/u8E5sZHqafpdbePGQrirOvgWy6DEWlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOhC70BuQV7sEFx4H2AH1/PTEDk2n4FjAEzm/bW19zHzu1Kirfobof48exHHbNQ/9SwK9pUf0a3dzgRk3Pfr2Nim9VI+bW3t1cCxZy94YM9ywqUdgh/ZcTBTC8GazYMxDkI3oQGwWVlsm7yVEnKczK4J7Ak6quO0Iy8/FYUXrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLw2LY58; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oF5w8qZS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLw2LY58";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oF5w8qZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783417767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBl/kKP90ZF/u8E5sZHqafpdbePGQrirOvgWy6DEWlE=;
	b=TLw2LY58xJEPkTRrZwbm2ZJN13qcwBk86lLmUCsDpRUl28yhH6DfvzNWaRyguODagx2sPS
	mZ1O018deU27hT/ewp0kkCegs3yjzdVpV8J9hqwKa2SOKE9vH/aprx7OZ2XDOjfW2suEzL
	t9tHPcMB+YlmN7ES/csOZla2LpAHuq8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-3wmic029ML2Ha3HVV_BlsA-1; Tue, 07 Jul 2026 05:49:26 -0400
X-MC-Unique: 3wmic029ML2Ha3HVV_BlsA-1
X-Mimecast-MFC-AGG-ID: 3wmic029ML2Ha3HVV_BlsA_1783417766
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f08560ea44so46517826d6.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783417766; x=1784022566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBl/kKP90ZF/u8E5sZHqafpdbePGQrirOvgWy6DEWlE=;
        b=oF5w8qZSBY9FMn6xbi6nOX4ImoJWF7tqOFsk5jBm/bl9VG32ntghpvPy5IDTYOy4Ui
         nRQSz6IC/BEtIqn17qTJxFZLnunNV3Rn1s/NBevrUgnOaQzsJeiqM3jXv79DZOafh2l7
         NG8IDZuOPDbjGGPFMTSHDf4ISoK44libojtNpEo2sgE1GooaiGgf3lh0I/abjn2QADWC
         Ank4HrqrsaiKmzoN3Og2Zau4t1O9rvcg/g++/D3bFCgWlBaRTin3+bSr2KPt4P5Uyvr/
         6v7Q2F//GaL9n/4/ii0ptmGuqSlw49FZlqW09lHicRllr9zhLKaYdIpA4GTWuy5msiyZ
         bYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417766; x=1784022566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kBl/kKP90ZF/u8E5sZHqafpdbePGQrirOvgWy6DEWlE=;
        b=SwfY8r5ekBpskPkyEzPvyb3wCX26KaEZ3Spt/z0OeF8t8fbhb9UyINOcC59HYQo+M8
         X/yaBIKlHLOLL6qXJ4pzNizsyBdADDhBdjKelfJfTS0XtHuMVCVH9pDE6FMHHDzELDFV
         CBY+/XPrP6tZ3ClRjphz1U/lEyarP1NSjhQ6nWkSApaN8+8fA3mMpWhfzxjCevrlworx
         piXFO+Be95pBT51UOFt/iLZUpksAMgk+G8+ivCCpveL5Q6FxHKXorZt8QYjM6uWtStsv
         gCQY9HQSXaT1H6tiQv7pj6SmgGAI9FduQv9gr9VtOXsK02ZqIc9bjV2glRj83pi0fi2Y
         +0Uw==
X-Gm-Message-State: AOJu0YzY+K3zc/BXbJwUP0t2KC937snfmPu2x3BEupeig7GJ5nOPPrxU
	+THzBdVFQuCEyrLDkradVmT0RySi7Fv9w6I797o1dO6ygiKZb0Po6q8nRkUYKQGjmV/5Tk1KD9F
	xwVyMGQrW9rjxMhRG4OBLTvyFgdUJhFm+eCIveFLtP4ZqHpG7lE3quz4FLVjr9UuR1YqjvYBvmA
	==
X-Gm-Gg: AfdE7cksdpOFgpe0+/zVoSOAkS7yBchGRI9hZXh3Ryi0VCyxXSSpymxmPhfRSNqqSiC
	JjoT3+fT6X1ANIF9bG6FMZrhqj7mOxt0ZuyQ3zS5CkrBBF0M3LNxjFDN8T4BCorgr2XT8jMr5kO
	kupyqrAKE6XmJ1ktYZXGEVapWMiz0Y5gvPU0mEqMBw8ZFgwJqRK2qIxH69VzzduWfCtc82rdCBp
	8XcY+XPhR238lXbX95VZPpT7jBjEVb6EbrmpcqvqUT5ZGPWhzsS66XcHZZsXJ2PXwqXtfWSB47a
	PqfCDa3NQgZ+AdveOlhH/zgjMNelT9tKViFnP4bYwY4fMKq2zsnCSQhv4tlPlHZu4d5N6/It1ad
	ZwtZ6KNo9OduL9OLL95BHj3AdRccRPVZjkC9ysPLsXhRH
X-Received: by 2002:a0c:f114:0:b0:8fd:6df3:b378 with SMTP id 6a1803df08f44-8fd6df3b76bmr10522396d6.60.1783417766096;
        Tue, 07 Jul 2026 02:49:26 -0700 (PDT)
X-Received: by 2002:a0c:f114:0:b0:8fd:6df3:b378 with SMTP id 6a1803df08f44-8fd6df3b76bmr10522326d6.60.1783417765715;
        Tue, 07 Jul 2026 02:49:25 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471813d25sm156795556d6.26.2026.07.07.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:49:25 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: fix denial of service issue in ceph_update_snap_trace()
Date: Tue,  7 Jul 2026 09:49:23 +0000
Message-Id: <20260707094923.2193042-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706213240.139919-2-slava@dubeyko.com>
References: <20260706213240.139919-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

