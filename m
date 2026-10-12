Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DB443315
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788791; cv=none; b=jxkPTImGGIw2wain+15a9dRJTYRDAnQfO+vonHBqL0fZCmYpmBOQ5ybOqAaOshFHVfgpbBRaTXPRl7dfnLXd7KNoKdu96XOr5liXDhyM5vIArdRDVNZpE4ozzMQkWwNiakhP0gLIbVbDM/v6qo0904rNZFP/VWrJCIK4nHF9GWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788791; c=relaxed/simple;
	bh=+w152tQAMv+Vob14gBmEXJQwdQQXExw21f3DGOnV41M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8sLGCVTIJwaTspctlZ0ZHFCKPaZPRfnPaUIMFzEiJjFxza9XQdymk6YCvm2T4jSDWS/GuEM66BS3JdSJNncFR+AVXe0iQDCsB2JoMvraXr5ngu6EsxrSCGBfqwBZ5+bQ+RZrIQejImVQnt17t+xDwunqYvemkmNOq56WlfLHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAwkDxBG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+kvQFLx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAwkDxBG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+kvQFLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791788788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjJkyKNbD9Kc0888ZrKUGFstH6mIxy4JqPtIAG6dvaE=;
	b=MAwkDxBGiUL1PPghpr1TKMsyErs6KjWqmtITqjDnevE04pIj2Tl3v1fLpD9iMgI5ajUfBV
	5FWrTS74INuQwM5z17SEgfto9XZpp4B+7IYXnLxypk1x6bNIS17yPMEvY03BaIV9dvvOly
	hz8fOJqNfAh6zsob387NycM5+5ErNrg=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-YPKB4CQ3No2RPBAGtV7y1A-1; Mon, 12 Oct 2026 07:06:27 +0000
X-MC-Unique: YPKB4CQ3No2RPBAGtV7y1A-1
X-Mimecast-MFC-AGG-ID: YPKB4CQ3No2RPBAGtV7y1A_1791788786
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-152d1363a29so7347514c88.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 00:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791788786; x=1792393586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjJkyKNbD9Kc0888ZrKUGFstH6mIxy4JqPtIAG6dvaE=;
        b=Z+kvQFLxnfpVoRYkA/QsR/XnFgZztuJvQzOhiRUNR10c5uOjj5DE+DBnt1TKqvkYff
         uTv2a5bkYQQ8Vo70EmYgIXgLigD7QXSfdIziY//e/22pVGCOEkuUnmIVBk67Y+vvklEW
         AQ7ZGLLiKHMLgRScRs3qlskp3f4ENF7jKiaEnOSxi6hj2u7W4C9fAjcpne4LWgzn6+yl
         v6OXWymrnWhLB0Pbw2Y/DH9n1M20uOfj6rtNdSXLnYcrE7upSoR8x/z1Okm99yFmai2P
         /4UICm2pNfQXBQKJNmrXSshzo7D2su5ION1ykh3cL7tcK3Rj1ooXL19kT3o8NouXbsfk
         i/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791788786; x=1792393586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjJkyKNbD9Kc0888ZrKUGFstH6mIxy4JqPtIAG6dvaE=;
        b=PEpDOCx8HWgyjNtPecaRmM37P+9FpRpwR3VJ+2reNxM8gDqr4DeBhYSvnzzfLgwRrb
         Az+buc1EMZZ/ASG3u3gVeNikMyWVfjlShWmrzoC76SP4Ru9Jlfulb4jWDkzwk8+73KTc
         bJC1nWvjHBrftSRBUozs6skEhoPoLdxs2VzIgmE+0D47uNJMbsgTR9YkByjgJ2yX+pMj
         0f3uoa7qAFMZbcc5/d1c70nWoqiScwvhGqyXzTnPCsIndWbfymDHO2PzLC/qTS7kZ9xn
         dCYVdYZQH3PGEKHytFElPGrVnIgt0BmrrME+rj5duP4lsJIarc+n9g8nl0zBH/mpgmiE
         hq0A==
X-Gm-Message-State: AFq9FYIlklEkceLhQzem7GOy8nbOgXH1MT4WMGNdZMSBbMH6iYod0iaL
	t4VZ3dU6NXI5+B/RrDAum8ph8DU0Vqktx22Pek/Je98i2WLk2Mdutz38ln7rfVI/f0MoWWtsaUz
	z/jyQf8M+3cPXoTE2iupkvA2hiqGMtJRO/hmDd2gML3huZhWM5ItHauNFRblHBKE=
X-Gm-Gg: AYBFou1ixomiCjC/hxWkIM62QYAyij2gIGu5z9c+cXtqmCdi7AZL8oHSb3uyN4IJ/bX
	t55S/nvQG4Du7fPBloO/D1ZwwAa9gteZLty/+dsSBjHbLXbswixzklOTTWb3DI92A1JwdTf3yVT
	8knKt4H+k3FsEFwSDiiObxXhsNEGmLueoSZaF64zptm87l63rb1J5VqW02g9HIjrQJMBNxedeJU
	AtCn9rOLpDj1VsKQmMFpYuPd9UXdaudbLFDjF2mPwLLZmjXjOd8LD6/MvYvfI0KeOWgzevUvl58
	fqKZdqQ/B9YL0PXrgOXCzUBl9mmE2SklOqQmRBCacuA4f8/RruGyddaPez/t7k9tBg1m+bUgKcx
	vEQRuC8H9lMCmC7HGJWd9cBb5n72Tuh+F2cKJV3RiGO0Nc3zm+A==
X-Received: by 2002:a05:7022:b055:10b0:15d:63db:9426 with SMTP id a92af1059eb24-16a55673ae0mr13065321c88.5.1791788785742;
        Mon, 12 Oct 2026 00:06:25 -0700 (PDT)
X-Received: by 2002:a05:7022:b055:10b0:15d:63db:9426 with SMTP id a92af1059eb24-16a55673ae0mr13065291c88.5.1791788785200;
        Mon, 12 Oct 2026 00:06:25 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm27136706c88.20.2026.10.12.00.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:06:24 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph: prevent MDSMap in count overflow on 32-bit
Date: Mon, 12 Oct 2026 07:06:15 +0000
Message-Id: <20261012070615.3425125-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008060701.182128-1-tjdqudcks0424@naver.com>
References: <20261008060701.182128-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sung,

NACK. This is redundant.

ceph_mdsmap_decode() rejects an "in" count above CEPH_MAX_MDS (256)
before it multiplies that count by sizeof(u32). The largest product
is 4 * 256 bytes, so the multiply cannot wrap on 32-bit.

-- 
Alex Markuze

