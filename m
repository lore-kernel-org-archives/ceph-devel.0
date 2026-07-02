Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA247DD44
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992462; cv=none; b=TjyTfOzv0BOetmq9yR4SiBeTsTLGFlaaGW3xJecN4ayAyC8/utVdqOSU5DbiJ48Tij5SorfRzQzRHmauUN6vq8ZMdN6yPTW68wVZndku/4v2C69bn01ytEYph+Y+zo27LMkP1PnixBx+zzvI14aBl3JewVQup2u9Xn6OEDxMG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992462; c=relaxed/simple;
	bh=A0JsiacpYh6Tuo/TEfEkOkEcT9+ZnunN/YizoWbYZw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZkiWNz8drCTvKPxMArpGf+0rI47qTpOwkur6kKTGJsVEfVc5HzvQvk2sa08AEuV7pFLVPh/Epo97r3lbrP67R5hkndjrRda81ERcFmlmTsw6y23oz97y3D6GRNZoyxJVnb7ld1EPL2j3qNLKt0hJUEDhm9llEALQzk5KYC8aMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dsvdjust; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nFik6GJd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dsvdjust";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nFik6GJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl5ZNMU9dwrla/pIMHMbh8dg0IFka3DPnzzQGoWCMqQ=;
	b=DsvdjustdWA6lzMVM/y6z+Igu1qnGT5M/3SXmB0QSbDisvtVfluw3YvUFVD7xWjHTgNiYe
	vpV61BjK4RSvF6gezLj/B/VmXcn9SC1IK3VL0FCQxyC0BLJyw7nnHZ8ccKGZMfjUAsp0Tw
	Qf5AsuVDz7VfTCp4FcNVNxaop11Mzb8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-NkK3w7IoN0iQg7yfXca7pw-1; Thu, 02 Jul 2026 07:40:59 -0400
X-MC-Unique: NkK3w7IoN0iQg7yfXca7pw-1
X-Mimecast-MFC-AGG-ID: NkK3w7IoN0iQg7yfXca7pw_1782992458
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6a17dafd042so1868722eaf.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992458; x=1783597258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl5ZNMU9dwrla/pIMHMbh8dg0IFka3DPnzzQGoWCMqQ=;
        b=nFik6GJdHFMlEUdgbRseeyDnEFRutxlXWR7Kie0YBBK5j4nJ1sLrVGrQO72QzZCDGO
         yhQkNUEUInWgg6bM/DY+Km+HrdCGEnxUH6yRNuKZtU4QpKuBNMox9Wa9ny6HyA8WFFgE
         5aDVtQD8sic2geLelblkOWQHOJY85g5EEI9IfquNiD4/X2LFzJwsMqCCKlkDNMCquVbp
         Xyaqf/S3x14UMyqzidYiqgHZA/9v+0xI0iARvyVv8V3j43tT3KGsCN38pGbNobxDiCZw
         t69drOU0LLonMGqxcqzJ/Rw1tHOg5eZ9tdoTHC2/sv6D9nt0MGVMQEa2XvgpLvSqb3kU
         e6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992458; x=1783597258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kl5ZNMU9dwrla/pIMHMbh8dg0IFka3DPnzzQGoWCMqQ=;
        b=JDQzla3qqVwNwLhuaSBp34CB825CJykDg1tayXCoxvSAI1/kdWgHjCTpJex6tLDFa2
         1e8kJpkzTjsIOt9oMBiQuJ8UsoUXely0s5FWnYewtQMSMfEJEeHFNxF0JnLxprm5pWOF
         vgLPOHB0EKnuC0/383NOVPUTOAI6UmaF4sLMJz/EZvu7p7QGhbUHkWYIfht9vVJhKvq1
         VMVCYGj2X2q15IUE49HPyut6RdLzmNnhk3Tfgvzn2nLNQnKT6Ucpoze6+dAs2ms87tyD
         JSjc6UBSDAHnFjTvsQXq19rc3YAW6+klOd0aPdUN0K/8Hsh1vANLImD8Mc3lhYhE/VaN
         bQ0g==
X-Forwarded-Encrypted: i=1; AFNElJ99CrDQ0uWrU6hGkc9Y86qFhOH0IA/RPXyWWJvaxGjhgk5Xoqf3+eLDUt7RS5HRIqTy4TvIZuuq7eoB@vger.kernel.org
X-Gm-Message-State: AOJu0YzIy9ccDx3q4MLXrtwwnDLs/g6UVSCwTroZQeum44BrumjwggjW
	kknVokHCOBZg231UuJaMrHYMAarlQhYlhMi9dFnVXXVCetVBA8TGMJzKQIoNlmrsfE58mXEoZXr
	gqXSI/Jwk+nSYM4PgJGaiBVjK3db912YXAy9q1EBwkY1HYZ+UJkUejrmOMU9EJPUofydNfG86fQ
	==
X-Gm-Gg: AfdE7cmINtdO8j/35kjq/Y0w5VMSGxD46NAj4cjpoTZGjO94B+erhgolArnPSExJTLw
	hr15A10zXM0lOP6YBy6fQ965bHs3DYAYLGoX0sq7HSqeq1CQOIGGK3IYkJmXinN3Di5IXCjQAXa
	n80Siwa4ThmGESVYGSEhAVaxPLixXZpJN4Fzylk7WErnN9RQKgjSsvJ9d4WZz0B4w2lrQHv1f+J
	Hg5dBsfx5JhbS47oVSFrWhw5Y8U3t097Bpik/sJCXMCs2qVCO1kdQLit/Ef1Y2Pf5SYtrNcZw7i
	CGxXZZTtXLR+5RBeDjW4ROzJ8baH1tV/O0hnzqY+QSgNXRSRvLmTygspTA4yGtAQEu4iOoGQkxn
	/zRtl
X-Received: by 2002:a05:6820:1903:b0:6a1:50e9:d586 with SMTP id 006d021491bc7-6a309c2b004mr3316452eaf.67.1782992458396;
        Thu, 02 Jul 2026 04:40:58 -0700 (PDT)
X-Received: by 2002:a05:6820:1903:b0:6a1:50e9:d586 with SMTP id 006d021491bc7-6a309c2b004mr3316441eaf.67.1782992457990;
        Thu, 02 Jul 2026 04:40:57 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: michael.bommarito@gmail.com
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v2,1/4] ceph: bound xattr value length in __build_xattrs()
Date: Thu,  2 Jul 2026 11:40:32 +0000
Message-Id: <20260702114034.917507-11-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b95f479f4cc52c879ace02ee224894b8feae942e.1780766417.git.michael.bommarito@gmail.com>
References: <b95f479f4cc52c879ace02ee224894b8feae942e.1780766417.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael,

NACK for now: this patch does not apply cleanly to the current
testing branch or linux/master. Please rebase and resend a new
version.

I tested it with `git am -3` against both trees, and both attempts
failed.

-- 
Alex Markuze

