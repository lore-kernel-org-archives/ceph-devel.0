Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF353A3A5
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075727; cv=none; b=cCWKjKCcaiZiaylbI3SqnDmmERVHNK9Wglk+QtrOAhfelHWPSc4YVmnJdNh19hjKrxq0fuqR9t/M8GKhsw9wSYXYBV/dRmdL7bABGVG4+5LB7zVdueDVv+WFOLWhbxbY8haGl0uYzbTLWQ59X4iQ7L9q0qRaB8FX4rmjGVnpSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075727; c=relaxed/simple;
	bh=onU/5/kT1hiHwApG8rwpT3PI4XbL2fj4IPsBDnGXyqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buEua3ptYxXY1brOjtoDscOTL3d2uQ693DXs0j9T1bCDN2KW40TMabLtSZEpvDi4Zp9RvM8cmzZ+zWNO2Ws4dt1jY3DeRd8uUbSFfqYQ7bKf7mDoDapiMtM4G2mTO5AwNyzwZ6KEcEbYXDBaM14EvaO+TFpGRAWjpKuHE/7M8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IY5mQcRy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sfiU0DiE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IY5mQcRy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sfiU0DiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=IY5mQcRyPweUEoXQzyNLg+YW+Zpn95W7lSssCy1mflaNK569XlusE4a4oUTTg+I0/9UQYt
	A6YkdOXzj9sYxHA+OnHdxOFD3PtOHCwW+NfHpVGPikbiwN0ivwI/MYziIzIS7QW0eyi/C7
	zmATFfpQ/jxWyk8Rx9y7ss+mXw3lz9E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-xM3UDEZJPd6cg9h2oZouCw-1; Tue, 22 Sep 2026 07:15:24 -0400
X-MC-Unique: xM3UDEZJPd6cg9h2oZouCw-1
X-Mimecast-MFC-AGG-ID: xM3UDEZJPd6cg9h2oZouCw_1790075723
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so827644385a.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075723; x=1790680523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=sfiU0DiE6c7PfvqJUyjleXwZeT8Q+3W+Yx21a3WxXK/CgkHR2+mdCiAItV+Gjxhylh
         F3s41vu6wK19IEd2ivHiiHildwNFZT05j74FRfk7akZFbFqYyIqPVyZGK5NkUCT8kcTd
         uqso0+JW+tk+nFe6ChNoAkhDZHFh6xJ5xLxWgrikM/H5dNaDnw4gT4NQyGbuYVkyjbN8
         4lWJ1APg11423eb/BN9lMO+mC23aBZMF5JredgYh5LxYmENEJHgx0SkOE5vhbeT147Pz
         ESLg2NiOf33J734fBoAIi/DELg0Y5dOxmax2Nc9kKqJevLEmjD4UvtjI9twhD6I3156f
         p1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075723; x=1790680523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=sDIB44YS+9NgBBEguEstw3xjP053EGpuE8rDha8yty9MPwn1uXidwN4zRsmMTXBsEL
         cWmDD0x/TMQq7fy/bnzsQivfxVKp6lTnJRUh/MhLoXUcqjtO2QG9V9NRLkkEZidhe4en
         1idjcL1KwS5Q2V9XaIvLsm3bkh1UrXIHZ33HGkPVtkpsiwWuVdqCazBGCtu5g7SDa92h
         UM7NTNDDofHRQThGJzDqDtohIb3bRUYeAx5HQ/GCNjvJPT+yqLvjF6tP20M/h1QE0uSP
         If+15cx/HHTwPl0zk3d+asnHPl8A4rOC56OAXo7fGfiCqdBrKye4ZqiDLPNF0UmnoPPf
         Varw==
X-Forwarded-Encrypted: i=1; AKwUvBwiRgi4N/OM7dTLYXdtn/vXOmu7Om0DLcxsmFX1VQb5EG8MIo6GJsv/7/eUkz6eGeMz9au8iZ5uPKpv@vger.kernel.org
X-Gm-Message-State: AFuF++nTO2S7ZTFX/djFRgpVNt1L7L8mcPzRvR+aS+76tc6uVy+cQo+2
	gFAzA2gJzEsEjwcGDqKeR2FF8Uw6YiMiQkV7OFCtgA1Z45ReQqRAyk/oxQUW9BCJUD4pWydTjly
	O0XBJ9+42W/Tnb7ZPsN1YfOJpqBYUcWYvo9g877y1Kp2Z21iTeUbf+Uy12hGdNb2jST/gv/9kjQ
	==
X-Gm-Gg: AYBFou2j7//RxFvuGb2PFOP0+OrL9U9D5mfTnn5cptTbw9eJPJ5eCiBknaXNiJSql+I
	Dadtd3dFZsUXWrYBsZrwvcCINIBmibDoVXN1bEUbpyFs1Z67AxpOQg5cju0c5ORuz/RK9nCmnXc
	X21AAk8Mk0i/j9U6Q/FDjJrsSUWPM0Ln8XbZhNJFKaD5q0c+8g+V9XEkUvekP74tEgJRj5VolDi
	oPJVDSDEWQaVO4cum4FZdYMPak9aXk0AOXuBNhBUQL6zzwbeuWr3Oo8O0RN/cFR6z1BTsyguhFE
	4I8WdBeNs2MYCifRtRCGqj8DJh3bIzsnq/MVK3d3wE4Me8mEdVl3VZiTnbRLCaZJawQQOkrtqiK
	X+zgSnVqCrtW82sAVrFRqN+Xj+H7040+ZUGfIdt8zN6cxyDa5rePfv0I04d0NhyGs6Ga0B4GI6F
	z8zriAHz5EWut5DA==
X-Received: by 2002:a05:620a:468f:b0:939:993e:bffb with SMTP id af79cd13be357-93c15d9918cmr501925985a.22.1790075723451;
        Tue, 22 Sep 2026 04:15:23 -0700 (PDT)
X-Received: by 2002:a05:620a:468f:b0:939:993e:bffb with SMTP id af79cd13be357-93c15d9918cmr501920685a.22.1790075722951;
        Tue, 22 Sep 2026 04:15:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d251723sm116084185a.45.2026.09.22.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:22 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: Fix unsafe decode in ceph_redirect_decode()
Date: Tue, 22 Sep 2026 11:15:20 +0000
Message-Id: <20260922111520.767344-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909145913.1164255-1-raphael.zimmer@tu-ilmenau.de>
References: <20260909145913.1164255-1-raphael.zimmer@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Raphael,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

