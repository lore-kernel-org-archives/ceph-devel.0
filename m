Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307470;
	b=a7bT5COazhj/nFvNB7sChpAwa8+H/dIwseXvHYcFgcTEa7OquyphVg/Hv5Vzj9iZTMm4
	 KCymJmyKkq3Rt/1wvVEj8ZwWLr9cGmNkVCHPgALBoDz/IHJG88lC36jP8E365+VxfPacA
	 NfsOW/cgd2DHaulFyzt87uawmk4g0GDIe6323ec7j1voCHJWK+8rr7VH7CHQoTOuxcsmy
	 n3VMhecmxU/JRmf4Nm8oInjJ/6F4cdmaH02BNCOnmdOo+e1JcmXPLdXnATnEXHoFULJ46
	 1hsOxJrhUaCVm+itTJKnzd0IkOBk7LKJPhWRRcwMsH9jrXRiIu6WFg4NVNLc+ntRmrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307470;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U1cUXgJtJfTpClQXFEjz/6+TpXUx0lJ43LunFephVXQ=;
	b=VrPRroBabP9b7cekUJSuSGlMGMMFC+0qqif53Fj5670JV/82Op1gIKdr/5S9tik08iGv
	 4HxG6PZtTg4Bj9bz8w6s3x00h6XnnZOtKWHjkfQzEOVjq90+kZzpQUhf4JwLFDAFFF4ZK
	 WFyXWEcwaNIth/OpF12ulFkicjpgYC+lVr47FrKgvkP672NiwoLn2A/8zGqWlEVvbNrmv
	 Qb794TrcP6rsXqgyrFpTbaMls22lnaTaPNPJwiBPjzsIgxM+o8NJVnwgvBW6wXTRGLmbS
	 Yk5mXRdvd04+QEwrp2FTVx0iH6VSiX3uCdHIzLbyOzvPITzPWJNADyn/Vx3IiG8ayDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="bQH/VEso";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NBkZSJtO;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E19606A325
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 10:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E19606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bQH/VEso;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NBkZSJtO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794307468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1cUXgJtJfTpClQXFEjz/6+TpXUx0lJ43LunFephVXQ=;
	b=bQH/VEsoswM4zNiOnMXRMixLVbguOB5ScnFQ252DsTURlCQHvAM3aQl4d3LpNfPRfjdHik
	32qozFcrlYmhAb1TJENrhe3CsYQjO5kbhiELvD3zk+jgw7eikrFzCXElGXoraYDZlejgsT
	sQk3jzXp4seNxCKPuYJkjYdcCxcKcgs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-YKPzSq8yPTWY49F-AHRDWg-1; Tue, 10 Nov 2026 05:44:26 -0500
X-MC-Unique: YKPzSq8yPTWY49F-AHRDWg-1
X-Mimecast-MFC-AGG-ID: YKPzSq8yPTWY49F-AHRDWg_1794307466
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40aa03ded8so217022166b.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794307466; x=1794912266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1cUXgJtJfTpClQXFEjz/6+TpXUx0lJ43LunFephVXQ=;
        b=NBkZSJtOXNGIluO7ptrSONAKDDA5GCyWauAMR3ZumdDpJ5r2dF6cH8/Mbqkp+gd8VU
         kHsZ6aXcZF5K/BM0k5WkkEv/DXlwT5nl8XKH3+6lY47gt+6tdlNLzigUhvIs6o+e+TPU
         iZufPMIIEZF/e5nkTVJgc6MUhQf7gMp0k0wBaX5acrIpn6MM2UfsHyEKnDhzXI4/pVAn
         QbspjqOxq2rJdo5X0IPUXBfEyGEaRG/xC4T7rBWApW2xLJAgFAo739VypfvEYq1C1tQo
         eKR9mY+DUvEdbaRP8kwhuPXAdUr7o4bkjCSQyntQIXFzThyMlztj7Tvp+t+80IvjjPQR
         KgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307466; x=1794912266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1cUXgJtJfTpClQXFEjz/6+TpXUx0lJ43LunFephVXQ=;
        b=Sk1zx50MuSE42sEAq+5Yty2el+cxjgK9CV3cim0WSOeOuXxUFVDsDAtvuhLRuLagQv
         pVTAqa9IiUywo5VbBOXk/G3b5Em8zSjk0g+i7qgVlag6lzy2WjGxnNebzgYPaBIWwjf4
         6mTkUm0VcpAwqkNwiaW7Sy2RZzkffY+S593deAbk9TXocM7OAgBt/dKOPntKEkwRtIhY
         2BQGeMsTLhUZpptNqYikbWIhibM2s20k34sUI81kJXw2Dt1/KLEjwcIJp1uyOEi96ahX
         zg3/Rw7joXvfUM1jYpcANH0qyVGkRx8GZZznQ+5SX/BVzGqrSwjSLebTjRBv+fQzZa15
         +xAQ==
X-Gm-Message-State: APuU4Z8WkaEq0GSw0xx6tQAL87yPV2zt6QrUrQG92WvU3rVPa6eFwkLD
	tbacO6BudCrqxPoCLswiX6PVnciUX9msZJV4pA1JqzUc0lev254ijksxXz0XxDiUBnu6LSQGLWc
	25LkMNcBQ9Di/jEOwdgi0v9yIPB0ZYOsxnQJT2JpkQfxf6x9uThXAngVFCUbgPt1aNnWBBz0=
X-Gm-Gg: AYBFou2mWHyXTr5bBQfxq4slkJ0WCLIRzn8TaY/GZRFmTqyzIDosKzRg51fNuslPnWR
	SvHsce/7Gd3tmGN201GBlnkQ6buXngGOxEubsd4jgbmRT7euxiBzGR7VPz2ICZjAaMVJGa806CI
	4GZU3cYAuIyatUOlKzbGlsSfmBVSkjdMpdBpRopbevwO1b6hdsVhMjHEvH2VHsYL91RhtAOh0ZS
	Yy/XIt1wbt+VEtV2Xc748xY7OzpioWN1ghpx1ReajURJhK3XSkMrV+6G+PCcNKvlxq9Fw3j9+IK
	oJPflHwD6IeGqnFv5e0aj8VGWm8b+loItBH+ZZ7pmoAbTVjVv3qgJdzdDj8OOBANz8Dej2pbPm1
	dEqj2sAisxu+GmAxy2ulOfcfGmkt4mkI25dayK0UxCTrhnBYhai2ZRENGBEYUJpgZlOusZZ8vg8
	OlRllGr+nwzauiwFV0Xd5an6+TkOAzeirdSH42rKzQ27BDHUuPih6xCmEB5mfrdVmTG4sQx7J9F
	O3vFPtOrjUo9OgoG4lVjBO6yOu8mIk6mr7rHE29CJSEVCwPyJG/
X-Received: by 2002:a17:906:c112:b0:c41:8e21:4d5a with SMTP id a640c23a62f3a-c5048f7b648mr179711266b.5.1794307465759;
        Tue, 10 Nov 2026 02:44:25 -0800 (PST)
X-Received: by 2002:a17:906:c112:b0:c41:8e21:4d5a with SMTP id a640c23a62f3a-c5048f7b648mr179709466b.5.1794307465339;
        Tue, 10 Nov 2026 02:44:25 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a59436esm94251266b.40.2026.11.10.02.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:44:24 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] ceph: dirty folios left at umount
Date: Tue, 10 Nov 2026 10:44:23 +0000
Message-Id: <20261110104423.3253503-1-amarkuze@redhat.com>
In-Reply-To: <20261109-ceph-shutdown-dirty-folios-v1-0-34600e8dab20@clyso.com>
References: <20261109-ceph-shutdown-dirty-folios-v1-0-34600e8dab20@clyso.com>
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

Hi Xiubo,

Thanks for the series.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

