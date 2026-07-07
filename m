Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F39227EA4
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417584; cv=none; b=Yx0AFUnkNgRJSy29kSrPO0B7Q+dqZQ1peb8vhOBVvdVjv/JYuLrIxv0Gl/GuqDhj4esWyamdpUKvWIY9Q7pKv/++8RsROK2uWjfBTXsfCE7cMgGlQOqR2lff+d48vEBx6MXPZzkv2PB5GeD8Hwwceyikrkrp3ukfy3KAbdcH/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417584; c=relaxed/simple;
	bh=QFQBg6fwRYYNCZCVpIJaMHpyTAui7VcFuoieD9GwKpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgLVD44MyiMoyuHaAoxwIEB0SwoDB0dScDNgipFqMDhek3IsWLlr/YQ74MSjKpdsF2KEHwn+eN29jP1OBZnk+HGSvRQDCt04wiF8J6sgNSPasavBKWoIhdY6AXPbeRWtWCK472cw3bEFquJPB7n09EnaZ8bLEE5zjLizZvLk7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuRQCU4w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eafpkSCO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuRQCU4w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eafpkSCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783417582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eT31lruQ/HEnvolh8F2cuF1g7luumSQDj0lKFbFSyQk=;
	b=UuRQCU4w2BxPM161hSe/M65mAJKk6hZlHEz3TTbgVk8XcqcyOzmT1KF8ir3u3ZGxzpm/3P
	gVbhBowCGSItrXgjqRqBgwGEu5QljBeAJ87wSzx51FCTcfGi0FYxoAs8CRQ7Ac/7JGvk3f
	kDiWfdHDO9VExJZFyThAdrjaFpWjKl0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Rk1YW7ioOc2LS90TjjZz0A-1; Tue, 07 Jul 2026 05:46:21 -0400
X-MC-Unique: Rk1YW7ioOc2LS90TjjZz0A-1
X-Mimecast-MFC-AGG-ID: Rk1YW7ioOc2LS90TjjZz0A_1783417581
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ee40bceb55so54893916d6.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783417581; x=1784022381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT31lruQ/HEnvolh8F2cuF1g7luumSQDj0lKFbFSyQk=;
        b=eafpkSCOzKDwgnovLgsT/KmRyomZ2JvSAF35whW+6qxRNbuiQ6hLGnd3coaJX194il
         fDrfWvczSS+u84ytpQxpymcuxcqEJNCgnyudsZo6YQCb1JlAmJeWA9KPztXYYVvTB1bm
         KtBNgEfo0trz2qSLO9rrL6ymU4/1eG9f8wINb0NuFtuOrWZBt69g4FzGBXub0nOTccso
         ibZneJQ/RCBmGy1dNk9TwcmSSWXJPmz45YSfES0wWeN8lnmzbvqOr9V7T2d5evb7JSRp
         gi4owz5k9kNVgXkXQBVuPN5ddQDPeI279Q8Y18czmoxJVuPrHVcUWg79Fa2duqgzxTt9
         MzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417581; x=1784022381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eT31lruQ/HEnvolh8F2cuF1g7luumSQDj0lKFbFSyQk=;
        b=qXIiWAh46Qd7KQ+ES0kcWoE+U1F9X80IUgtJ8HVX8vw7DieuCylU0WjwmSDjq6reMf
         HibdGOcaKK8G26TQbdhatLZ1mZlyuyH0WaJsrSi8d7Nzb0PO2fJ1M79gOLfzpuZtxPi0
         9GVl8BnCs+clFAQKR2QqpDnKbfD4iK4XYWJ1TA9eLvbSnqtr9hJo6FhEMdoQo4b9JSto
         d03+ezDNYLxixuHprau4CXkjDfwnN3t+MLK9D7gpFCmfWowWqOC1T7yLAGpI4C/VNBTU
         bq7I8i6A9qnKkgY33JZvlhgT9nrukeg8+d3MDYciSMb87dQSiCjS9wjBRsSiiuOTotD5
         gWxw==
X-Gm-Message-State: AOJu0YwiEW9pWwJMi7SuAFfEODeHGt2up67UY4zAEbmxFyaIPSEszHGa
	oeojOAPs1pwAEXm+cucEI4NBzSxPGzp9fZZEs12L82+5xorLCnA1vCjnjAKROFedGj9BsGe56EA
	urGVVfCphA82yzaAGFy9qo5IU+drXlWGtXmwSPeLYEyZMI2WHnRGvYeINl9NfXQw=
X-Gm-Gg: AfdE7cmuhexwT8QL1dlLJ1Sj08nMewtLEpIYsXjQf35AeKrqGTqv2WHsHo7PY3UQ39t
	VCO82fkX/7H0EvMcrGIAjQWdHQ+wqyG65+0bN01jet2D8mnSv8L4Q5iFal6MSWzUMFSssjDbvZJ
	I852p/45jIIb8gGVeU/xx8JMOPYv1BxdilI6IrYc2ryhp1rATsvjLtqxaEGv7u+ZLh+IRehUgbC
	CpShrpDCxTYS0PyObFJbeUV9kSu3e0huoH7EkadKtGAq3DFfdnHP89GOYVFoM3AYRycg7lH22LG
	T+acbWSJFgc94ZxknVuGTmUIMA3OHDoVyps3QSBHvZpXc0a7Gu4wfcn2yv40kEjbagZU3yhahA4
	g0i+tiMrGTTsiAGRNSA2FEzdfEdr5KcyflyqKWDGjua5F
X-Received: by 2002:a05:6214:5b07:b0:8f3:b922:b54f with SMTP id 6a1803df08f44-8fcb5ea6bb3mr48771196d6.51.1783417580627;
        Tue, 07 Jul 2026 02:46:20 -0700 (PDT)
X-Received: by 2002:a05:6214:5b07:b0:8f3:b922:b54f with SMTP id 6a1803df08f44-8fcb5ea6bb3mr48770986d6.51.1783417580128;
        Tue, 07 Jul 2026 02:46:20 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f304533sm155594616d6.18.2026.07.07.02.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:46:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: enjou1224z@gmail.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [1/1] libceph: use RCU to protect monmap in ceph_compare_options()
Date: Tue,  7 Jul 2026 09:46:17 +0000
Message-Id: <20260707094617.2192571-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8f8d2b03575328c52405f3d660b5d31e0c741ae9.1783342642.git.edragain@163.com>
References: <8f8d2b03575328c52405f3d660b5d31e0c741ae9.1783342642.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ren,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [major] net/ceph/mon_client.c:1032: Raw __rcu dereference in do_mon_command()
     `h->fsid = monc->monmap->fsid;` is a raw dereference of the
     now-`__rcu` pointer. The identical pattern in `ceph_monc_do_statfs`
     was converted but this one was missed. Safe (under `monc->mutex`),
     but sparse will warn and the conversion is inconsistent.
     Suggested fix: Use `rcu_dereference_protected(monc->monmap,
     lockdep_is_held(&monc->mutex))`, same as the other mutex-protected
     sites.
  2. [major] net/ceph/ceph_common.c:806: Raw __rcu dereference in wait_for_setup path
     `have_monmap = client->monc.monmap && client->monc.monmap->epoch;`
     — two raw accesses to the `__rcu` pointer. Under `monc->mutex`, so
     safe, but sparse will flag it.
     Suggested fix: Same `rcu_dereference_protected()` pattern.
  3. [minor] net/ceph/mon_client.c:1175: Init-path assignment to __rcu pointer without RCU_INIT_POINTER
  4. [nit] commit message: Non-standard Assisted-by trailer tag

RCU approach is correct but __rcu annotation conversion is incomplete — at least two mutex-protected sites still dereference raw, which will produce sparse warnings.


-- 
Alex Markuze

