Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785BF55D882
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079919; cv=none; b=MJvikBgTAP2RkXHcPufTDnuJ4nWzsePJsdCEq5+KoL2uNKjIXVdR65teDTv2f3M3oetYm2kjWJs1jMDaBuvFIjXsHCtxMGvPA1xEqAUl8T9rhYuJxGaMetJ/WQRzh133U8An+5BJF+SZWe49BEJuFrayS/DAAD3BXseJEHZW5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079919; c=relaxed/simple;
	bh=PDkX3qXS+PW7zt08QUXkxcYG8+pS1pW4EI5n09BIMaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6XB7FNrboYcaYCL6uHfFDKbDr4bFhM6x2j6NTznlgel6el+AHH1Ai2KBuNYbDfKnvCHoMKG/BP+Mt+d5ge2MbNFMH86284BFyscbRtWvNxyLRu+wHGBIluTrWesxJQCcb8vRMzGsc/0bx1B8NDPHkGsmjQCDE/5WUzMSMKBlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BP90Fsxc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXG/LsoW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BP90Fsxc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXG/LsoW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792079898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0QHkMk8teOzUo7SSUdHtXWqTy5BQSYPRe5TzvGyz5c=;
	b=BP90Fsxc2oYLQCmra7xA3bcnmOsXcWx5Ztx6z+ebKBSU2VpowgmYKY2j15P9aI4xii2t1Y
	WE/e3GpGy/1VXNyFrWzk3+1iOW5JFabPOS1Qprobxq06EECb8qCuW75NV14Japn/gaDfwg
	pVZzVrj76MDa47okYrRbEQvngeWtmow=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-E2gy_WUtOcis_hFWBfasgw-1; Thu, 15 Oct 2026 15:58:15 +0000
X-MC-Unique: E2gy_WUtOcis_hFWBfasgw-1
X-Mimecast-MFC-AGG-ID: E2gy_WUtOcis_hFWBfasgw_1792079895
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14fed306427so2798819c88.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792079894; x=1792684694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0QHkMk8teOzUo7SSUdHtXWqTy5BQSYPRe5TzvGyz5c=;
        b=RXG/LsoWbdQhSH6qYU2uKfQYXEd9zWimipbxBTYQuLGMlfjTczPtQCA8vbpiPxPYQA
         3t51fHy+zwbhnIuPe+j44PaviEmDAw+9yxoll6enzCrTRfvRsASojsCqog4GjohxgncK
         0bkTAn4fWEgIbPo5mDKJZpRprOWZ+FFXqZJA/WxxFai2mYz0neqs97yakz45twif0Zgg
         XD4PnbMdA0nVMiFvTchhNQhIy62U8B80P/09TswCjb9p0q8XSiyR1wG5I4lJ+84iA8GR
         gVPUt/5+vK905+hAMnVOyS6N0/MT9IBgR6sbRlcE0UmTUTNiiA8BnH79uxlMnUqU3CX1
         nGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079894; x=1792684694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0QHkMk8teOzUo7SSUdHtXWqTy5BQSYPRe5TzvGyz5c=;
        b=iap5Lrc6HKLQutwUVNOWWB7i4kaZZi+V6nSOlIJy23DC1NzvTGWO4DnocpPRrccbGl
         zfelHE7USc6qvsfg6BdUdP2LWDBMPshI/JrTN5SycnM3A7y87jwINSpbVaHcprScqQha
         OkVMqIPd7O854o5Uw0ZgUkYvX4lleCSqqIw5QSTGbA2dgmqYXIoSMUzwXusQQwZiBbq6
         QZIrzsCkMUnds3aUjVJ9c0PERxN4MYop5Tx1IR5rZd+H1D6Av9SYxttGyXnq7ASeuceY
         2YHZ0VAsWcIRx+yoEyccGvhnFED2+zr6uyKVIIzZj7FeewFGxwFR72/L+ZiY/C1TfXuC
         v9Kw==
X-Gm-Message-State: AFq9FYJdthqKRSUUuzmpASvPoMN62Qq0xb2lOXDI7AIUxBwQ+65bU/Vt
	P8HfYs/7q5bHGttJEaDr0ZMPso9DR+jhybg9ceCr97AoDAbCXYzm0azTWRqb73txwKmpRiJeBPI
	TSOOGp4A4jPJZyhxSy5Ld/ZU9teA+KK75VCSRkvf4xyAMOLHEmirOXoyrs+VsjUA+FWzzEJJC8A
	==
X-Gm-Gg: AYBFou3asfTgNgkVZ75ctS8vLH3pQz4XBongyZmGHDMGlujleuNe85hryaS9/HC02ra
	Yn9l9a1NZ7IUv8UrbhGtQr8MSOz2gGo23AC3zbOUDuXcYaWhsbU/koVsAdCot2pOOzDF8RnwgcB
	ljAcGOBg5RCL1n4hKXT0EKJDgWCBsB3/mKJjfjwLO1NG2nIWJPh8a8+7bolR508RZtoKEPgoxnh
	ayseStl5wAlqXAReKQhAGFw2m7WO8O6eg5CoQKpnO5E13bJUgMgG4MgRv1Ckq1sjFrUaSZIXMLZ
	9izsC22a0O8wAOgShc3wIK5EaphqBQlh7EpoXhTmvE5l9iYbul+PdNfDK1Zl/Zn+K/t19hfpVNZ
	7p1daXfubnVQrJ17zprQXMUiYArrbI9PouWpYdGKj9g4c+GhtridS0XGLyWldCNwJpXFl+lp6lB
	ApdrpPnyp7OOqyoQ==
X-Received: by 2002:a05:701b:4211:10b0:14d:baf5:c40f with SMTP id a92af1059eb24-16a5dee142dmr27811742c88.14.1792079894506;
        Thu, 15 Oct 2026 08:58:14 -0700 (PDT)
X-Received: by 2002:a05:701b:4211:10b0:14d:baf5:c40f with SMTP id a92af1059eb24-16a5dee142dmr27811707c88.14.1792079893820;
        Thu, 15 Oct 2026 08:58:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm36205839c88.13.2026.10.15.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:58:13 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Venky Shankar <vshankar@redhat.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ceph: don't drop a lock grant that races with an interrupt
Date: Thu, 15 Oct 2026 15:58:08 +0000
Message-Id: <20261015155808.140236-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015064202.62886-2-vshankar@redhat.com>
References: <20261015064202.62886-2-vshankar@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Venky,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

