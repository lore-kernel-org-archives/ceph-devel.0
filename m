Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665130C16D
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793524; cv=none; b=Za2+qlzjbwbkNNiaKg/naL85mXFhEm73BHpX9rJ9dHOYuUUnC16bMJBRNgbYQvBtsIMed/jB//T64kSQsBEEgSqusSxuNS2lA5AXuSQSzuNVY/WpKT7Yt6fgCSgd5vQfjXR77j0MnnIuP22JXMOprLG7zn2a67SduVFTolPKARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793524; c=relaxed/simple;
	bh=UQ81wrYL0LmbSLcaS8DcEKRIBIP7QZUdg3+DosT6v9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/g0oyp6YASnTPasty2+63tWHTfPyxNEA8E0z2hYjFaVpR92rEIsYE4HnLjSP6LL0WmbYk+xd+x3A4NR9OjI6IGZ5jJo37pH7kr3BGDliW0ih9N3Knuc70/lnabUISsrSo1Te6+JTDxkhLA+1DOG07HX+zCpC3F4DkyjNk00WbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSwCuqjM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1URlEL6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSwCuqjM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1URlEL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788793521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSJnZ5MrZ9jKw++r52yJvhl/m83JYsFDu1H0GYM1f8Q=;
	b=DSwCuqjM+edqu8QKV1Ceb60/lH/W0oeTnMPM2twgDL23BfptCdDSlUuPY3rfLzRASJR7yK
	BTGeRKh/QUM9iv+QpigQKNyWU87CLKO63VHITCkIPrGzBuJfs2VLk7P6uG/ak7ghxVTpQc
	aefXWzifO0fK1zHWMY/n+9siajz/Sfs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-g5RXfbjCMHi9gfPKO639wA-1; Mon, 07 Sep 2026 11:05:20 -0400
X-MC-Unique: g5RXfbjCMHi9gfPKO639wA-1
X-Mimecast-MFC-AGG-ID: g5RXfbjCMHi9gfPKO639wA_1788793520
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93975d63ffcso408752185a.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Sep 2026 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788793520; x=1789398320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSJnZ5MrZ9jKw++r52yJvhl/m83JYsFDu1H0GYM1f8Q=;
        b=a1URlEL6+Q5JzEDC1ZyuCW9rNhTf8DWLUhUdlyz/qpv14vMpRSlq7AY0+zW+p6T9P5
         JntH/SjtQNNStzUp3eBsyUEXd7QShDR5tONJ9Gb8LIPfL6ebeCEFfRQJPnuWyjims3iS
         ++S1y1PVTXpE+gCz1d4a6JkAnBo4hm7Meii6o+svbyZV+Sg7DYjlxCw/bEzg9T9GAJx9
         +tLvJS3380bIdp5O8H4V4523NxNeOSJmqUpDI4oEFN//jPVyrGxCnbYfaRB8xr/8xroy
         dbxuxRjfrIWXUmu8OSZqlNXvycjy2Ej29tRrcTTOoBSzRJVgnkelJTkX/gBUZFucPzuM
         FO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793520; x=1789398320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSJnZ5MrZ9jKw++r52yJvhl/m83JYsFDu1H0GYM1f8Q=;
        b=rqLzg5+1LBEQVLlP3ITdCzwJMLuSKXtbybQGlE4E2vfCAbVR0uhjYsIlDMZjnukpxS
         u/aSls+AbScs+5kiQXIpwQ9k74/WCKK1wgOqg9Vs0fPVYKip9oWUpDWH/J+M6QvFw6iJ
         /Ex7Wr1Ppq4n0v079O5yO4zG2ECyCjRto1i2CegTEwW2uEw/8eBxWb1GIbWpBGaSKsmq
         1ijgwkdNjWQi4TEORaB1RhwK3QZ36MESaEMzo+ZvGVTbRg9lltl020ES8DiUl/2PkcF3
         45e5qWrxX3E92YTAh+ZGUK/wtE3XI4h66WVQVBJ3AKVuCFTzOtpyxmrL+bOfbBb582Ey
         9pig==
X-Gm-Message-State: AFuF++nbW8SGSqTpNRvN76iU0rUAlO19oOK/hcD9xZdvdMyuM+V8yhSr
	DhuGgunqwZeM3KIy7RthB+6U2m4+1mzfok8hnDRIv/F0qY4hxN8dzk7QsQeb0YAzg1g0vdVNkjE
	SMRfgtxuA4NuQKrFpLtpFgeRvd3TwQCr4iyyU/DZf6CfZwR0tStQnCzKbUi/CBhmbVF3ywpRZ/g
	==
X-Gm-Gg: AYBFou3syGc5xT7WZIwGkRXaJn6de91Fw067PZoXxbp0SzlmIPXKopLyisJC+hll2Qq
	4ITmoR0FcZmg+/bCJ9/9D/pHNGsjZUsQFcgydrN/dELqZT6qpIP4D05kPTWXQH1Q0IGHtQOqOoI
	Eca1WCKNk7PbBmK6vPIes3nozt8zh8jfJdaLrcxLpc7mr89zYr0uEIM6avFTIyRvXORQzSQtxNl
	o2b/UTbXBDtsmFxzDfemiPT2VtKVLGZEY+Omdp3PvhLvFbMPlaALgsS/Bl0W9MVR1FeBLWv7RfR
	rI9Cq7SZ/jL/sEUZEV3+qW0XAJ9SEVQ2w5CElflxcEryhC9qe5AHagczIQ7T9H6y3kK6rcy0qx9
	I5X8iKgr5+qEXxKF6fRu6NidWO5igtZQBSdzxxK0A/cpKlXNy5ABVyIfpjuZVujt4OSyvkodpmr
	4d1V2Bg7VkPHMB8A==
X-Received: by 2002:a05:620a:a358:b0:939:78dd:89e6 with SMTP id af79cd13be357-9398036d182mr1811621285a.15.1788793519739;
        Mon, 07 Sep 2026 08:05:19 -0700 (PDT)
X-Received: by 2002:a05:620a:a358:b0:939:78dd:89e6 with SMTP id af79cd13be357-9398036d182mr1811614485a.15.1788793519169;
        Mon, 07 Sep 2026 08:05:19 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm609081385a.29.2026.09.07.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:05:18 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Mon,  7 Sep 2026 15:05:16 +0000
Message-Id: <20260907150516.3696765-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903104742.729279-1-yijiangshan@kylinos.cn>
References: <20260903104742.729279-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiangshan,

NACK. Please respin.

  1. fs/ceph/crypto.c:433: NAME_MAX is the wrong bound for the readdir in-place dest
     Jiangshan, the new `name_len > NAME_MAX` check covers
     LOOKUPNAME/export, which allocate via
     `fscrypt_fname_alloc_buffer(NAME_MAX)`. Readdir does not.
     Save the dest size before decrypt (`dst_len = oname->len`) and
     fail, or copy into a buffer that is actually that large (e.g.
     `fname->name`), if `name_len > dst_len`. `NAME_MAX` alone does
     not protect the in-place altname dest.

-- 
Alex Markuze

