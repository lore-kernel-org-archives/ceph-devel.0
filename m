Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF2263F44
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047024; cv=none; b=dAJP0ouNiVNMzegnqO5I8ZJgK7qxkxzj6twYa1tCqrmOqmEvwkim8gDvJrJnXRqutVMjDz+2ddpKXQXqsWxU/RZ0eVhS/sWM8GSx9pay7B6PPRXmfqxcrZO2ts5jw8RMp7FMkkumhZUnZMqpasNrQWxcVrstU7B655D6O/4W83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047024; c=relaxed/simple;
	bh=NosuJPy6HkCGTGNafwzPK1YiqxBKK/ZAWYxif8nIaGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S76+N9wOFrqqWiXAm4u77pPaNiWevnOcAG1rWKbbpgmz5uW38vS0MAAKJiX5c94dyhSwidFUnXg8BKdP8ZWmX7zJFZBG8pzIRUyrovZgBNebdSUWvRPP/NJwxqZH3WwvjBjUd3menZhQy6Rsd/hcIIyiMXonhETXpeiQPm8HOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3H+f+L5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNrJ/p0s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3H+f+L5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNrJ/p0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787047020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NosuJPy6HkCGTGNafwzPK1YiqxBKK/ZAWYxif8nIaGQ=;
	b=E3H+f+L5I1P/LE2k1JCgsfKKmeHSi3/iDWRLRCfOf2rdMTC72VI0p6ePsR5N3e9gNyfLJh
	5srre/LGzGBMJURt5hNECe9vUL8h5Qth8hR3YXtWHDJxzcrkrDCjBqKp7sMiv12+TE/1mQ
	HPTo9k5Z2Fv8V3P50Q//TusHsaa6NPA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-p94bIJNfPfarRaSUwGT8bQ-1; Tue, 18 Aug 2026 05:56:57 -0400
X-MC-Unique: p94bIJNfPfarRaSUwGT8bQ-1
X-Mimecast-MFC-AGG-ID: p94bIJNfPfarRaSUwGT8bQ_1787047016
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a3ef31687dso320315a12.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787047016; x=1787651816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NosuJPy6HkCGTGNafwzPK1YiqxBKK/ZAWYxif8nIaGQ=;
        b=NNrJ/p0sju4cdmVszZ9ErFu0Yumlfrx1/dn98KV7ftwp722eiXvnYpN2JAyneKQhF9
         eCyWX8trpJ0h4JwB1GNemKj1en83ovaK74DIxLrdhfokqJPS3VId8Vg2N1wFsvv5sgrk
         BQTwIMV4530xSHmVudJyTbMt3Ol5xlvrIgcJNyvJAMqpMZpyQ+P5lAJMvjSrTSG6BxrM
         0W0hSLueInVzPXgodaM81Mv1XhZfQ5nVYHSWv72zD4K+toO25tqKJ0Aye0D8stwNZDfn
         hrSN+T64L3Z2QEShewLMj6CSfxd5Gry31o6zC1F0CeK/vfMnP6hqsePam1SS6WWhzRhS
         h/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047016; x=1787651816;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NosuJPy6HkCGTGNafwzPK1YiqxBKK/ZAWYxif8nIaGQ=;
        b=KKTzAtl7yhvIFulqNMLNXI7gHY7V2NqY/dkPih4Opc6lCcTNOCCbr3da98PQL1ehXB
         lxuPi7S5hGXPO9bjd2SDB/9XVQDw1pfWE1FsuiXX+xmL5+CVujRP01GBDGSk8DRlrbvO
         c7ACibg3vQvqG/UohJQe9YIUzw2hom/KCVfd0Zl03oreazkRu4Z0nPgClQpapsXChA3p
         4HW9w2eMhuO09lVwXPNnCZhDSXDfleCEbLPNFZDz8i2e7hMW4dtIjEQNdhK6JxePXNBA
         oKpbfNWYYss4FRrO13ksRa6qu0VQcQvh8E+jyQEZM/G8yQN1UKTafbkQIRcaloBUkAKh
         4N8g==
X-Gm-Message-State: AOJu0Yx3pI0zzNcydsVcggbGDpzvzZgWKGrVnqJLcW4Hl3g5FXAx+GFz
	zAHs/RtyM5I17rGlryzhSDuaW39fsMg9hzUM8zBZ9lqvXgk9rlxqbX3SL7j92pyBwsISya2f2mb
	YxJo5HXL4cbnJHZTyPeb4CQxTKfm/ULyoaL55Jj0Cmb6De7cK1SExC+hzEFrhFQ0=
X-Gm-Gg: AR+sD13w5qzMw4gBMToIysE5HBZJEV9hO7wa7uSNFRRZrYKBF2B8YHt3qDTNdixUXZU
	SgJGgTc4qWO3A8++Smi8ghkOEvE2KJ3O/ywi2iO79x8+OXGgkxgiJ9KAupqq2IT+lEOd+kO/LkH
	kptV1332UpUn8Kn46FkWZ0Ut1o38xaycbkON6CQ0ka3S5TzwqCyb+qUY6Vgd3HK3VXkLwhAyVYi
	eik3i8WuWXPLvv/tde0xXI/+E6M9niNBXD/eJSkPRZawkT3psgjIRmlTrAE/tb0bmi0htyrKXc5
	JZ9PoXZ0KbtludwiY6p28mWW5BYa9FX0WY1YZAr/VBQ7CO/+WCYkX/0k+j8ZSR7khUkTDjLIrqm
	UIQ2kw11vjDwkO3PPqu4Wu7BVhfAD17xcrA==
X-Received: by 2002:a05:6402:3789:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a38a9801a1mr15235096a12.15.1787047016292;
        Tue, 18 Aug 2026 02:56:56 -0700 (PDT)
X-Received: by 2002:a05:6402:3789:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a38a9801a1mr15235065a12.15.1787047015894;
        Tue, 18 Aug 2026 02:56:55 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d85173dcsm1808003a12.3.2026.08.18.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:56:55 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: carges@cloudflare.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3] libceph: reset OSD session when keepalive2 acks stop arriving
Date: Tue, 18 Aug 2026 09:56:54 +0000
Message-Id: <20260818095654.955417-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720-fix-rbd-keepalives-v3-1-c344fbad63a4@cloudflare.com>
References: <20260720-fix-rbd-keepalives-v3-1-c344fbad63a4@cloudflare.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chris,

Your patch is already in ceph-client/testing as 4a74ac97c553 with Slava's
Reviewed-by included. You don't need to worry about chasing tags — once a
patch is picked up it goes through as-is. We'll take care of the rest from
here.

Thanks for the fix, it addresses a real problem.

--
Alex Markuze

