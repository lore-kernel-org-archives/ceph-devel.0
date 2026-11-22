Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377157;
	b=MnhhDyUvT2N3kaP0eFj1v/pgkt+XmaEqrVKSR1CHFyPUg6b0l7OIcvYtjw89CPswE/X6
	 hiyLbDfhm4gqGIoPAgTbRkQmHnN1WMboEzVtB7Pc8NM1lOC8znzcotpAtK/8WnarGnx6Z
	 rlt/UlDR2m5KPTBR/0Xkn/prSIKcsi4bHUx/AsdbijTiOAVaV5Samrno+zgFA6yCGeqyA
	 9p4xYd7M0t1mrTp1hffnQFURmvSjpP48vLONiiwpBBKr9Q7I/0P/Maqqg4iXHzy/j4K1x
	 mUPaEX1LV79Xh7SQwJO16cKXQmVNS1LYNwfigYFQFoRnzCk5Zoy+YOlj78OywYguZZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377157;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7VGrb7WS71DyyI0fhI2DRFpkOSU2ZVGtaAzlEiilKBQ=;
	b=GFEMVTeSxl8LXQOwgBWrzlqeiQ/cjRoU68ktBDJecSSybCsPI2T4/+o1+mAKAww/foXf
	 3T4tt98bzBIS4CJTPTmpA6A4U6kkneyisNlSpVTgp7R/4Y3aXEFouhNoLj2gZgMAz8U+L
	 +6t/s2gz4ecNJejW6VlSOHmpt9ybrml0Tr2uxQc7zU1JWLP3rQ9MGSztNWNYbdFFPdapG
	 DdqukoXMBbNXTv866/DBKjSFb9aNi//iuGf52aAqHdZ8LG0byY6utaq03CloW6x0zBdOl
	 SeUbKiPo+wvIJvsB3hMl8kSJpUPM1CtgEK6mIxPgpVxyNyeE145vl+loY8DY89VG1KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E40nSBS+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jGQjXShH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786A606A31A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 19:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4786A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E40nSBS+;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jGQjXShH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795377155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VGrb7WS71DyyI0fhI2DRFpkOSU2ZVGtaAzlEiilKBQ=;
	b=E40nSBS+Jz9PMmr+jzFH7nEdOZE1NPKTHLZ/i747X8I7m771U0XbDQGcBDOEKw7U5kCx9V
	sO/wv8qB+btM5x0gp0vbzJ4i3kWPN++QE51Z81WeMLQUoUsETj1V8ZCz7Il1NX3QHTYReL
	w1rRsk+LI2AjNxymGF2CJtB22SXYjkk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-E_YndDwVPcmQDdUglV2HHQ-1; Sun, 22 Nov 2026 19:52:33 +0000
X-MC-Unique: E_YndDwVPcmQDdUglV2HHQ-1
X-Mimecast-MFC-AGG-ID: E_YndDwVPcmQDdUglV2HHQ_1795377153
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-92126ecb4b8so50636276d6.3
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795377153; x=1795981953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VGrb7WS71DyyI0fhI2DRFpkOSU2ZVGtaAzlEiilKBQ=;
        b=jGQjXShHiWJtUpcD7wnqoYgpsH8xKOLYuBIak8R17aYJQDJScaxzdAZR19LlLqg1NE
         1ONGnyccmRwoxVZ+SFpv66U+Fh63EmE6Cz4kkWFfk+w2I5yZB3tsU3erT9ry6fo1NX/w
         hHCvojRW+fVrWVH1p3q6kPhAh+OYlX1qClrqa8TyHOSYU3Ry4gwoN1iQLmr0XDGOibea
         R+ZzT1PCsKX8eGzhdvNbTBF0+XlF6N6qUGcQEdTiF+NkJxxZihp5BHq+E31nkDbzqEv0
         YX2O6XEIPTkG0w/h4MzgANeU3oz5P6azOvVhQFfqyzE6VNs0D5oFKKyQr5DUxGuppD0E
         13gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795377153; x=1795981953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VGrb7WS71DyyI0fhI2DRFpkOSU2ZVGtaAzlEiilKBQ=;
        b=0aB0H7EuT42pwqlEDKwqCTqS3lsQQf8xFX1Ty4QqN+pU7v6ParF1HayysLV8X4DVCb
         HDE14pT53OY8P5CufP8PY2DNPZl9tC7KC1XQXhuaIZ+eDXrB4p+IOAyteaLcWNz5y6jc
         AlhjRJqozZosQOQLpealbO0qe1teEmvJR/wq91n4DjjDwosH1PQlNWjFtwoClUWtIWlo
         lzJ0Wz7M5fThdKoEZL9/R8GiKM2sJyjAAnkCrbhsJF0mJj8Ko5XPmUUf0USFK8rdIFQm
         vCsO5cCwJncT9lRaoLRjuHr9cFKniEhtS5zrqp9Ng6xwWSooH7DAz4jnBS+mWp6xqhLA
         TsTw==
X-Forwarded-Encrypted: i=1; AL+hErFdiPjuZEiTJnGv8J0/7sPr9R7al5NIb4yE7vshAbX4O93gGM2EoVe1AvGmr5VhlHOqXow8ibbn78FS@vger.kernel.org
X-Gm-Message-State: APuU4Z9LVmpLADDrQyqjR8dZeo1mjd0xYy5A2JhQLrOvX9cYYNE3Hfx3
	kxXgKwU6jIV999BZQD//a8P38ODFcrY4FUqlA673EFlv8+9wcMsV8ZM9HtG+4Qmx7nHOgms60CT
	3sXd+PNPkesT2ujTG4jDwBVrzcqoTNdHyujCenIaGYt8hD9tndamCn4xygGAAWxE=
X-Gm-Gg: AZFdTZeqLOE+p+3XSvmW9CTRwzZB/rJQxTZZBw/6m6wezebDfbRbysl0Q+8yTg2bSCR
	fqpz/YJfBEgVHbgYtuV3OjtMzfcfAaISCfUJuYN8858dzPfLGoLCsg5gvHniPhJC32ABqb2OI1N
	P4eK9mI07ppl2Y1x5QRmZx7lj/Kbva8hP849LvkavP/eMN6KHFn67nvbwZt/manthZWYXVp895R
	z7unmSMbAHIixBmZaFYwOvfuTJQuARlw24AIPxpLDzLGdpS4Fs49W491LU8C36W+nBt7iqJjpms
	KrCmnrKeIbPLx0DmTT6XZIc9DPNc0RWhH2X3kIzFSUULtRig0yH76Hluu9u43WBOESFwizEgDOK
	X33cSqsyCn6nUVag5k2/OXqgYF2N472Tbqf1n316CJj+vmpVA9g5YsE0WwgNeA5z5Lt6QHnzRNr
	7YuE4Rf/2G8spxOwLcr30P+85xWnxBhEsxkBMtCUg3D0FldjxkK2l1JYKuT6/Zj+o6JApjr7pND
	9U3DQXiiWWrrLD6U/c5C7f5ahss3Xjely7OcJ7+qYG9qF4awuk5
X-Received: by 2002:a05:6214:4886:b0:91e:77e0:fc0e with SMTP id 6a1803df08f44-92134bbfcd6mr164732356d6.57.1795377153076;
        Sun, 22 Nov 2026 11:52:33 -0800 (PST)
X-Received: by 2002:a05:6214:4886:b0:91e:77e0:fc0e with SMTP id 6a1803df08f44-92134bbfcd6mr164732156d6.57.1795377152657;
        Sun, 22 Nov 2026 11:52:32 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b0827sm85693066d6.8.2026.11.22.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:52:32 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Xiubo Li <xiubli@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] ceph: fix mdsmap and osdmap use-after-free in unlocked readers
Date: Sun, 22 Nov 2026 19:52:25 +0000
Message-Id: <20261122195226.1328644-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

Hi Max,

There's a separate xattr-limit window in patch 3. The map handler installs
the new map but updates max_xattr_size only after check_new_map(), which
can drop mdsc->mutex and wait for a reconnect. During that interval,
__ceph_setxattr() still uses the previous limit.

For example, if the limit is lowered while another MDS is reconnecting,
a client with XATTR_EXCL on a file can accept a value that fits the old
limit but exceeds the new one. An MDS using the new limit can then discard
the oversized dirty xattr on cap flush, even though setxattr() returned
success.

Could the new limit be published before check_new_map() drops the mutex?
Also, __build_xattrs() can drop i_ceph_lock; could the second size check
reload the limit instead of reusing the value sampled before that call?

Thanks,
Alex

