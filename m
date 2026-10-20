Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489921;
	b=S6tqDqIqeFpDVakbDx4P22b6K9w6eWvYLbctDvfDq+mv9LSdL4u0FYH+lyQailDpSY6J
	 9wgre9uvY9m4UE5ZKT0xfRykR3Zbt4fzvTCkqX2l+heD4yNZ0BCs8HN5sjBadyZ9vVC/A
	 RN0G6AFFY/nX68o/Yfr3ItusXY8xyYCnfUlmsO7V4KlrBSGJD92fiDVK2NLIQbcP3L7FL
	 Ugsp8tWzwvzySG8PMdeCLiCo2lRnUgdakH8JUJas41Dgq7Z4duNE+s2RUFoaRoAF4VQo2
	 0bfVM1GRvajvC6gnKzdTSGxgLsjfD3Nk4cOZWkNRGYm/6hIGUeWwVCidlMYTxUIvsCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489921;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cRylA35RBRWTIIYqjmlrtrqTvwS8SCTsW6a89L946vo=;
	b=1VcQIXcBNs43hN+WbqkW55aZqqrGlBAbixjtxKiF5V1nNwrRZRmgUIxYZleFdDXH9nAo
	 KtbJG1J4KqwfQ3if+qpgaVB3ctVXFV7KpCpHw3lmQJsvauyrj+lNMLhAFtexlPpJzfItS
	 vy7nd1rTJ7OmvPfsPmSFd414D7WHJKkXLP/7TuWghLEogHi7goz0OFPv2SzJ5NVqfX9PI
	 iSf/PLchFF/1avassUrCjN6gyZrapvdblfEy1T+ec9+wvMjoY2seKxKcKZRT9/2gNIFbJ
	 yJbb4aLEIxsHLf3SPDBM/pVuHFBZ9lbBv5BjjbaJdI/8jHwJbDVcVAwPkc6FOGsEV6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iRSSKwJg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tsIn+3KW;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D1606A319
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 09:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 990D1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iRSSKwJg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tsIn+3KW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792489919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRylA35RBRWTIIYqjmlrtrqTvwS8SCTsW6a89L946vo=;
	b=iRSSKwJgvG+jYJ/eHKU6DMdt8N7dGqrLd0qG/ZR8okuR9wGYDETPPVYfVPrFbBs8QZyFo3
	MfT9ZwHT7dyzjF4RxLJ8StAJYDX/jhkQfS800pLRBTnuzujWzUPjdh2hL4k9zwBXTSG6X6
	YwBtf9xfp6uo8Ej4oySPkZGoQB0lvaQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-JmIYM5DLMRSueAA7LhHdnA-1; Tue, 20 Oct 2026 05:51:58 -0400
X-MC-Unique: JmIYM5DLMRSueAA7LhHdnA-1
X-Mimecast-MFC-AGG-ID: JmIYM5DLMRSueAA7LhHdnA_1792489918
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5338c59f90dso9023611cf.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792489918; x=1793094718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRylA35RBRWTIIYqjmlrtrqTvwS8SCTsW6a89L946vo=;
        b=tsIn+3KWHhB38SJMhJC+vS0yXSYMgp2CC36W+CouKdciVuGkd3SDyrKhRCo+/vrPbg
         Tzr5ih8mMY8Hcu6iaWq2k9YHpzTNfEbUViSAA1ou+JpgX9wLB2r4aTouZKAkPXNegpjX
         Mxvw/+WyhipZAvTiN01h6324v6pZjqLqM4XhW2xYU2yObidBJgKgTLQQvX++4hqMm1qh
         qfW4kdpVmsGRo8y5/gsnmKbxmzUhleecT8inltwvN9B6UDmLlANOfNLxwqJFi/OqOR69
         5w8vvU7E+Gzn7lvQzkqKo9z0TX92ZU+C9s2n1bcTJxVKFDd68Q9c8t2vMBQV65iqczW4
         bjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489918; x=1793094718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRylA35RBRWTIIYqjmlrtrqTvwS8SCTsW6a89L946vo=;
        b=JS6WeXUk/cdF/aJ6jovPfLmq0XLuG13Te9r5BJD5hnTrsDoypx/4c9KTzMf7AK+9+I
         zKO/P17DEmJmv1qEVwr2DYlufVoDiYpi1Fmi8PZZ/fC+edl+K+aKuT+JRUv9NR28ZSGO
         ja8chkTmoXJjNTEnIWCu1WJehRW2svUpiulyGLptDcf9zX1Sjwz/l9bRsf8VEdHLSfit
         Zz/Iy7nv4iSKP7qXeycIfs7JczZO1fF32lIN2QWsJ2YNsCThF+96ZPv4Szb/L7tIQvgM
         COp7y5AfFfdzMZzPgO4zvUrUMatS0Dag97vQH3p+r4Urf4QUEmV684Vxx7rCvpN2gQX9
         X6hw==
X-Gm-Message-State: AFq9FYLSvRpFpBQgCvkT9FiFdmJInFXZJe0RAWCzz3Oy5FzoXlS8V8dp
	NSLvSLRFex5BU36MAPRtEk9t+1hnz31UPvJTvBdlWR8Wqjngav06j95gTxivEekqiil1VDlBIRv
	STuk7GF0xcYFGqobrNOVPkN+qwXWFRbU+PrlEC6/U2BoCmAPDxzKJMAItd4yVe9s=
X-Gm-Gg: AYBFou3zNFNx2UEwH0cHa9Ml1j3tvDe5HFQzaRBPakb5RqmuUg9CYO9iYIglYF3bfRp
	MuG9xAtvQa2nRgfD/oNgpFgsjjawja3oRuaQr4Gv/XflEuZhx2s1auK3YAtbCwS0KemxPCx+ebY
	0anBOC3F9BNrgbD2xipfxZKpZp+8Qcbp+af2elAKS/dymfQzkMd5/MmxPhF2bymTk9tfgn4/WCT
	tBsswxqiHn5h0g/lXQOIVQkuuSouAv8dh60oKMaREOuRn/FWuAvUQnfK/IGFnXJ/ZLZYCI+tqQk
	41Qh47vAveHTP7f0lT2aeIYm20XvkBUbzLSt3DnEygoYmpwWr1zr5HyDyE7O8SbOvfS2zCcMGuj
	NkLNYZLf7DdTIjDklW9SQnuc2leARuMZFt9TFF1Ej4CL+VUtosmVHXi44UeTHUGoVyIyTDnOjrz
	lOesg4wUeQ01gtuy3zQtf7HZu95865iz+auXEvuZNDHIF3RXXl/ZjKvuBaoghfClchYQcbXalkV
	vc=
X-Received: by 2002:a05:622a:e159:20b0:535:f9dd:a3de with SMTP id d75a77b69052e-53686a4f96cmr14819211cf.23.1792489917850;
        Tue, 20 Oct 2026 02:51:57 -0700 (PDT)
X-Received: by 2002:a05:622a:e159:20b0:535:f9dd:a3de with SMTP id d75a77b69052e-53686a4f96cmr14819111cf.23.1792489917404;
        Tue, 20 Oct 2026 02:51:57 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8e43cfsm119708731cf.5.2026.10.20.02.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:51:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: read ahead along the stride of strided record reads
Date: Tue, 20 Oct 2026 09:51:54 +0000
Message-Id: <20261020095154.1312847-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020-b4-wip-ceph-ra-stride-v1-1-6314b013d3b8@clyso.com>
References: <20261020-b4-wip-ceph-ra-stride-v1-1-6314b013d3b8@clyso.com>
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

NACK. Please respin.

  1. fs/ceph/addr.c:257: pos+stride wrap makes next < isize true for a negative offset
     `ceph_stride_readahead()` does `end = pos + stride * nr` and `next
     = pos + stride` with no overflow check, then loops while `next <=
     end && next < isize`.
     Bail if `check_add_overflow(pos, stride, &next)` or
     `check_mul_overflow`/`check_add_overflow` for `end` fails, and keep
     `next >= 0` in the loop.
  2. fs/ceph/addr.c:256: stride 0 never leaves the readahead loop
     `window / len` and `next += stride` assume `len > 0` and `stride >
     0`.
     Return immediately on `!len || stride <= 0` before the divide and
     the loop.

-- 
Alex Markuze

