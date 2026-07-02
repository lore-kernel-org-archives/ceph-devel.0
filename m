Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332447DD46
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992460; cv=none; b=DHg9H+vodfRIdGJoIorpbpNQyX4TUY5CtNrKRSFQMrXjUCGaKRkoeI2kCKbsmxH0UP5w+eXyWuBR/y327OnoGw/eyCtY8qpSitW/N/HVBiT5I6UA0zqCkcpAwX9zbb1IqspyP9tnI4MXJ70gdj30sylSDYEMW1BG4Wt6No0Kbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992460; c=relaxed/simple;
	bh=oQKmzJWY9AQy/Az8YSsqJ2RqTH1oes3xIIpcsmNUiaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOFqicPDsGfWINjKsm59ksgSZt0cjfh6ZlRPo5IeTCXvucycSprgUCnlyW5Zn7m08F63ZST734XmAtHH3TowsLsYaKZPh0dB+uDDICx2Cd9oJ2LEZd5C8+6q88ZbMtXmYXTb5HQTsWuCq1M5PNm4/i32qfJ9i+Ht8JGugJr74Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9Jdgmzq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l2ZcWXsO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9Jdgmzq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l2ZcWXsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtddLFrX87QM21i2Z8OMh7w+SzYH/c7mWuZNEQNP4d4=;
	b=c9JdgmzqzwoU9A3NMjBlIj34f+KG0o1Ju9OnKySa1AGgvBXND+CjVwI8jG1GbftZV4VXao
	zvFiy+o3px9zoF/05h3Uob9ReTJ+W+MgJMkFXEfYfVAP4Jfi15S4zqCWk7eOWIULqzJb+9
	x8iaTQz4K7wr1PwuW1nnFsMaRNdi+E4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-w7yoCx6SMA23PhkC-gBXpA-1; Thu, 02 Jul 2026 07:40:57 -0400
X-MC-Unique: w7yoCx6SMA23PhkC-gBXpA-1
X-Mimecast-MFC-AGG-ID: w7yoCx6SMA23PhkC-gBXpA_1782992457
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7eae3ac0072so995440a34.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992457; x=1783597257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtddLFrX87QM21i2Z8OMh7w+SzYH/c7mWuZNEQNP4d4=;
        b=l2ZcWXsOLxQAkqRRudUcE6ZuWOHPOKHOuFLIfSTfSG5ZPsmp8mx+ZrFZYzF3KCbfML
         ODQF8ICvbY0rb5dRDxJmPeWDOfk0iGfNYV6+demHQm2XYNPzLlAp4hajFu59eisCHz29
         U5f/U4heZRqwkkrzVjd5WIvYpQ0Pmvzo8NbCzhkI2V3Ovx8VIxCsibmCUFi4RjmuWT7t
         IXm4Iu+mpS9UQjIsGP7lZMYM87OQ5VEK+05nmLq4dBaGKASIRVxLET4x0UHwukNrw4Mp
         YxXFmiBVfHk3W1rwqHOMPCWgIVT7fMLohNpdHEEwX8XHg7uWv/9Jq+usqITwvMcm5gT8
         Bjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992457; x=1783597257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtddLFrX87QM21i2Z8OMh7w+SzYH/c7mWuZNEQNP4d4=;
        b=sa/bzYangGxfKg1XCP5/z6ynhBQT4JDSMVzZ3zIx+c88DfuovMPyP3JXIeLGKYqAqB
         2Nf2wctbFRC8tl7QUFjkh6BYH1D0XK46P26nC5Ijq3Mcnl69foIN+XwvOt3zBKKdy0SN
         msRYFVS0WBf8e+ebxS+cbHG7JHUIDrF5RlBWsJiJFohtL6slBZ/WISehxyoNsktkHh2i
         PvmXao6KgSOUdcf2nXD8FQbaZAoJRJRr41cL7lkk/vK58nFS6Pql9uiD6RbVBLwNDyUN
         eFKyFbxG2EMySTmo8Pl75kv2rbosUOuP5rbpFu2gWwKjFDNu4Z3k80Agt+4rSLF8/a8z
         I52w==
X-Forwarded-Encrypted: i=1; AFNElJ/ISZVXh5QRT17AEChbwZsoA0JnYySo9iQB5vHdaxVrnTMvDdDEynstVdB9JnzJ0Tt4KNMYTLjzWM8A@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8D+sdvDSIx6PVMnzcdoX+YlaT6tpTzAubgyJtWE/mH77efgk
	TgygUT527aFSX+Eqc5uIEGPgFrnRl55pkQOQrKKgLykodJDvaq2amimg9TN/ECeNfIOSRaOocNE
	lUbOdKPFI7bnAMop5pyHH079TOJWGh91T46njblEjqJJtm8FHc9qT6hVKWBatiz8=
X-Gm-Gg: AfdE7cl5PQiehuesGAog40pbNrr8/8NTBDE9sYIvZeJnQ1jtZqEbF7M+W1YNhHVqIPp
	Gq0K3EIRmnRwdHxuKXnO/ZYNYVkWVxNh6D2PRbqmvWOqvBmLDGIxgz7/n9MIzi0HiuEfBDkvRSF
	HWo4rDjvFgacqgfATE82dSku3mnGrP5LEoncGcT7/DcYfDQ0PrPtjqoq0rCyX0XpPhMRXYm/1pF
	GW7IutH24vjmdPImerO3FSEl1KKzx48pEdekM7dZNLlFWcUyNdLYE265aXySzWK+IIOLjUsFa/W
	JR5RgErqewv4gTdmrcRK8RbhYRu5KBo74Lk+NXRa3fdtk3ziJWChoq8atpcW494zjSs9SeGsM8i
	JlmnT
X-Received: by 2002:a05:6830:dc3:b0:7e6:e349:538e with SMTP id 46e09a7af769-7eb4cc18722mr3286550a34.19.1782992457064;
        Thu, 02 Jul 2026 04:40:57 -0700 (PDT)
X-Received: by 2002:a05:6830:dc3:b0:7e6:e349:538e with SMTP id 46e09a7af769-7eb4cc18722mr3286543a34.19.1782992456509;
        Thu, 02 Jul 2026 04:40:56 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:56 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: lilei24@kuaishou.com
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: Revert "ceph: when filling trace, call ceph_get_inode outside of mutexes"
Date: Thu,  2 Jul 2026 11:40:31 +0000
Message-Id: <20260702114034.917507-10-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260418041241.17892-1-lilei24@kuaishou.com>
References: <20260418041241.17892-1-lilei24@kuaishou.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi 李磊,

NACK for now: this patch does not apply cleanly to the current
testing branch or linux/master. Please rebase and resend a new
version.

I tested it with `git am -3` against both trees, and both attempts
failed.

-- 
Alex Markuze

