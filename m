Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.24.179.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540052;
	b=BhMc62pBs6dwEKJ+bsbDzmPE6YRFTKvL4Osf9Fax+GsMg/25X6OBsqZeticbGAg8+PWH
	 k1Vno9hJxDAEui6V6Mf1tLOooG7yBojcV1AQcQ8F8OIY3llP9cZ6noOJ+0cWrFOG4cPw3
	 Dxchx74mTmFUst3r4T2QT6mPj/Wr6kEK/XFKRxcIBPRyhF4qsADSw3m5AAVGFz6y1yZ3m
	 3wc/IaKYtzi+uE0SnB0RfRm3v9a0yHUXQRUAx+QJ5WD+AIZ6vNiFvd0+va44t+l9n82s0
	 az5pfayJLQo9hRg8ffQkHtd7B3KtWnrj4pbhdQGCejN+Z9bDGDg162yg6mKiz1s6Ttg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540052;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qNn3EBZr46ixSossDKaqrEOYNVYQzSEwDDLx6QPyeek=;
	b=qw/Fdpmq1irrhtS+4dqDKmoFcUmXuDQi5aeD9rJJuMe35o31c8QjDVRSEt2XFohJri0d
	 BVBuybBDam5u5m/4LQGvLfoSMmHBwW1Hc6NsWHuhq9zhKJI3f/t8Ll9T97u2WhIFO7bhN
	 qKSZ4ZVL7TbDCFV0nEJ0rx0A48vIT707BBjZWuiMRVXdteyJinOmXeLu89WtoACe4LpZV
	 8r0/VgxgdsvhSsP/jLQad/Tpd+InHxi4cSBFOqYw44V001UgYNBmEdoENEuWuOU7TdsnP
	 ISWWlNe/ljwaTxPOpM4PsPgcQq61ef5EdHP8IYb5kUN8tQh1ptG3it1I+fr/ESeipMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-ilmenau.de;
	spf=pass smtp.mailfrom=tu-ilmenau.de;
	dkim=pass header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=iNQI4kHQ;
	arc=none smtp.remote-ip=141.24.179.34
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0522606A326
	for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 17:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0522606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=iNQI4kHQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1795540043; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=UMXIL1ku6YfE5CL/1zCHxhhGWRk2DGjhQOCbNj/2sc0=;
 b=iNQI4kHQgxudtxaGU2+TFN4MpJzQ7JUCgJE02U+g4NQyeXwiHRKPQki6jxbUwnAMZisc5
 ZvXaBZypg2Q3/mqEtY7f8L1OBnqOY0Le7eaJ9ZxYJEfAKQlsesDSyXlFz76XqFGTJyEOBVn
 UEIEbGFJs6uLXMMEyNhrL+wN0s4Ucl7Sdxz/g15LP2Sr7W40cspBZx28YGZ0tGocSBZ1r7R
 dxKftf5thSMCrnK3zNKOvcB88fjycJfvEcXqGM4VDOXZfS5rwKA625gubTgPay5HUNQU964
 pqnpgFW9UAWcf6Jz+bPN2vESFgH0bddXxYa9RKTkbZrXvNG5X2fkH9pWmqog==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 5976B5FD95;
	Tue, 24 Nov 2026 18:07:23 +0100 (CET)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 56E1B5FB63;
	Tue, 24 Nov 2026 18:07:22 +0100 (CET)
Message-ID: <9f77a274-3b40-4e0c-ac86-54d22cb94e9d@tu-ilmenau.de>
Date: Tue, 24 Nov 2026 18:07:22 +0100
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rbd: Handle overlarge result codes in rbd read replies more
 gracefully
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
References: <20261104153659.1117700-1-raphael.zimmer@tu-ilmenau.de>
 <20261110115013.3268036-1-amarkuze@redhat.com>
 <5a84c2e1-da59-461e-b1ed-f2ea3962f283@tu-ilmenau.de>
 <20261122204550.1346981-1-amarkuze@redhat.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <20261122204550.1346981-1-amarkuze@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.11.26 9:45 PM, Alex Markuze wrote:
> Hi Raphael,
> 
> You're right that get_reply() rejects an oversized data payload for these
> reads. The case I was concerned about is a malformed reply whose result is
> larger than the requested extent while its data payload is short or empty.
> Those are checked separately: handle_reply() uses a nonzero reply result as
> r_result, so the payload can fit the receive buffer while r_result still
> exceeds the requested length.
> 
> In rbd_obj_advance_read(), that result skips the short-read zero-fill and
> is then changed to zero. The request can therefore complete successfully
> with part of the read buffer unfilled. A write does not return data to
> fill a block read buffer, so normalizing a positive write result does not
> have the same consequence.
> 
> That's why I suggested returning -EIO for the overlarge read result.
> 
> Thanks,
> Alex
> 


Hi Alex,

I haven't really considered this problem because it doesn't require the
result to be greater than the requested length. The same would also
happen if the result were some non-negative value less than or equal to
the requested length, but the data payload still smaller than this
value. Therefore, I viewed it as an independent issue. However, I
understand your reason for distinguishing between read and write
handling, and I will send a new version of the patch returning -EIO.

Best regards,
Raphael

