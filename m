Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371957;
	b=CjtB63becRoU8JmTki5rUaOfPCCQlWTaJOdavLs2uoFH+bXQLOkYUK9XVHytcaP0dFVO
	 Y5N2+9N9N/LXCRtVQK/7yyYNx3pWYqJynYzO3QB1EiGELILYpSHcpDDemSJ+no5SyaRjr
	 PL3mGoS7EDmP8BSw79s4lmTrnGnEvS7pZCiOZGiylvVoQCqr81AJASfs+mwjrwgayZJID
	 m5MeejN+bIQtomsI7p3ItD34YUE+eFvviblhV6sDknc6F9QxsqBGAWhvEhBaoMsfSZidk
	 4qdAF2OsqrxCHM5KvMKA2xhfX8rH8kvbkvjO9/ZswEyjVsmasqTpR2FH1Ty1ooi2d0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371957;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p22DdnkyUJb36XAEAwjYj2yZLJPtAGtNNL8IeEy3sN4=;
	b=pgEZTZG+yC2RDZzpSJ7jOCOk01RTNMFyPeHznPaMmZalUcetIa9yVfzYKL9HSxU0XLXw
	 OX6MRO7vPr0BuwtdPj0H0gCH8k/PfiPT8qaXrOtPIssUPBpmO/w4AfY0HEs4d/hEhoqo0
	 X0ve9U8GwyLUlLqRuugI3QDDqru9SjhZvc6+1wEHwC8X2XS080BiG8WW6gqTPnzeEZk0a
	 J0kY5rzTQRDPh7NEVAt1XihcD+CJ5QBLmdqFH40FUP1UNq+WKX3tqZ97Wtxyc6Xw/VUx/
	 WEOlywrjVVVEDpdNCiPfGjfRXH0uZFi0HkkTe8FUB+PP7IjZFBjK2FjqoQz2WYvl+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I0nNlk4r;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="QSLBQIO/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE4606A32A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 18:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFCE4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I0nNlk4r;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QSLBQIO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795371955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p22DdnkyUJb36XAEAwjYj2yZLJPtAGtNNL8IeEy3sN4=;
	b=I0nNlk4r2UFuefZP5/FOAuRjd52WHakcIFQw/Y43IcvNHKTwaQramjAfKtVrdX5oLo2XUt
	aiKJ7D8Ug3BVAf/Om0o86GvCwGobruMvUfMf1IjA1nUqiVODRkVPEaSjpXelnci1EHaUWF
	h1NysMVY68arzBcVXcTkD3rhGkUBFGY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-K68vxWc_PyyIvOQlqdrWGQ-1; Sun, 22 Nov 2026 18:25:53 +0000
X-MC-Unique: K68vxWc_PyyIvOQlqdrWGQ-1
X-Mimecast-MFC-AGG-ID: K68vxWc_PyyIvOQlqdrWGQ_1795371952
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c5095dd1514so210752566b.0
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795371952; x=1795976752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p22DdnkyUJb36XAEAwjYj2yZLJPtAGtNNL8IeEy3sN4=;
        b=QSLBQIO/ryxfybK+VRqGG+ZJkVFsYUaSvEg5k/9O79MmuPzGMENwQpQtuJsl00AgZS
         7q1Cd195aEg9R8XIIJjfNEpGEh3FskvVzmT8Ob5YoMakJnsk0w0asTFU9i24Ukl5wv6h
         MZYPXpnpy5n9ZxNzHVf+VRcTOTCnwzAJty3Zz/QKrUxb6FQVreJ8ARwquLipvmrsE2er
         dVH85pEENd3SoPaPD41qTPOCiVDfUPsYUBaIMs6nAcClqFEcHZrAp+4gZQbO8twMHxEA
         rCY8CbPwUk2AXuLPom0qR2k8KYRsGRZOcT+zSgnowsuB5TQ5kZfR/i4/Xf9NNnh8Iv5/
         Bp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795371952; x=1795976752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p22DdnkyUJb36XAEAwjYj2yZLJPtAGtNNL8IeEy3sN4=;
        b=tOYLSOW6Dm3XrFy+JlNq1uettXH5GGoLDBGQvVCWYCnIBQcycK3xcmxoMfaSDP5Wy6
         odeL7Sg+HXTWE+2n/G14jUyVx/FKwyFV/LZUEw4GVM0aPNxAd+HDnpZTqEeOPQZuMf1w
         Smj+r1gYvy0/nkN52Vned7Y7ltj+AVhjgiGavbQHtJRNS4zsMc8LdVwRXI/szfXjgpyd
         4rtWayqa8GFSz3jXmHxkfYU6Y2s2olkiuh5wm1SnVQ+QK+n78EW+SAJ3dgTrYdilg8w8
         +NayWHLltHQBbwhbpoINmGl/krJIP72WtC2ARHJ70+NDdN7ZU/cO/VcFy5k2vjYBoLZg
         19jA==
X-Forwarded-Encrypted: i=1; AL+hErGzSpppmSnIYKLIErjqghRpVf11+mojqUEFDe63lgyxscmTgHPa+JdC2gAgdBsc/j7xbIRuL37Gh7t6@vger.kernel.org
X-Gm-Message-State: APuU4Z/p/D9uUVX6YasfMM2PHKrH5deuOgFoe7lsdUk5rY1G0RboeZrS
	7DvebkTyk2q8aZ0/4l0HyqlvPvr+8QbmQVlyqe1TaeI78iMIcCg1eI46U1GFSIrJqGdtmO2JZ6G
	Ke0Z1JaOl0BhQdq1MeHNXcEsG+6wkjNJLIYdOJTVRNzfEa2fMIHO5ZRC+e2eDZ2I=
X-Gm-Gg: AZFdTZejsEN6wXjbh31eIHld1OrGwUix6BUIGtyDPErzT8L/XzIv2CBmTvPsYLDLVQT
	3MdtPD53cNR/BfXpm97DajHjkoIg7ylvi3znq7s2JwBrBLUFP81KaapqdThI1T4jUc98OYdzQKU
	mq9otpmkxiWZCUu9naF+g/cYDZP02vPoZgXHEeMuSSKeKd9xXmZKTeVJcmoNqMb/RIDkU3af0KS
	lKOx6hFYxxVOu77QiA6e2GxiMnoGbLSXD1BTrJUdJcLBfmo2tX02UyjVbu9VWZ+PUBhAaLBqCOq
	wYHoK5Itqg3MFKHOFGWzGq4F08O76F8EM4w+pEsY906gi4h2ZkfwREpcZ7X4XagejC6SHPdh4gn
	xIlrTX2xVk77UO/mx2/fKjlI9azJIyvSHrpl6chNZ2YVN9938ij2tnoy6yUXGj+T6tkk14VhI5k
	C9gov4zOYmfshCIaoO77LGeyY1g3F+J7t4xZA3ygA7JUKylkOxyVNtT2+gGw8eFnAsBMPNEvDal
	HqQM7Ztu+d1zFaRbdxFBJU+prdjE1EQSQ4eOpUExYNx76XzMObr
X-Received: by 2002:a17:907:da0c:b0:c50:5545:b66f with SMTP id a640c23a62f3a-c513a803353mr696213266b.23.1795371952527;
        Sun, 22 Nov 2026 10:25:52 -0800 (PST)
X-Received: by 2002:a17:907:da0c:b0:c50:5545:b66f with SMTP id a640c23a62f3a-c513a803353mr696212666b.23.1795371952240;
        Sun, 22 Nov 2026 10:25:52 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae68887sm339380966b.20.2026.11.22.10.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:25:51 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anthony D'Atri <anthony.datri@gmail.com>
Subject: Re: [PATCH 0/2] ceph: serialize O_APPEND writes across clients
Date: Sun, 22 Nov 2026 18:25:49 +0000
Message-Id: <20261122182549.1297448-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121-ceph-append-excl-v1-0-5870375edeb8@clyso.com>
References: <20261121-ceph-append-excl-v1-0-5870375edeb8@clyso.com>
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

The feature check happens once before ceph_get_append_caps(). If an
append starts waiting on an MDS that supports APPEND_EXCL and the auth
cap migrates to an MDS without that feature, ceph_append_kick() keeps
asking for Fx. With another writer active, the older MDS can stay in MIX
and grant Fw without Fx, so the append keeps waiting while holding
i_rwsem.

Could the waiter recheck the current auth session's features and fall
back to the existing Fw-only path once an open session is known not to
support APPEND_EXCL? That would preserve the existing older-MDS behavior
instead of leaving the write waiting after migration.

Thanks,
Alex

