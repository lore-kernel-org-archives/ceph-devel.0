Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6602417BD2
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621886; cv=none; b=GO+Mxk0smKTBVun3pPVGy1RtYUmFvVsWK8QEiiBlUPY3m7jZ5pI/dOeKiHkEG7xFVlefmzE9e9swsWCtDqab3XuQpQEutQ1SKrG+jWoNJWcOpmdsT2xWHvl81PLaSjthbBaX7W8cm4HSku5/NI/T+15yAeOMtrWbNECfni9INbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621886; c=relaxed/simple;
	bh=2h1NDyJBJcqPT+2AjyMFKZWAC1UnoyaHoEIEokT2fa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gf0f6g7Hn/Rl2gmaitNO5bheutkgPqq4hwD49t4KcgrdHsSSo7QtgRN5/x/vrVp0REHqllP88nWT1xeTCyPwC8SI/oaEKjHyaixyb8gWFXqewjbJZeXT3vmSIHMbEtxGQHiBe9vADSvT76MUZTJ+2umb3nYXgqcm+Fq+N1xtgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fQp2HEHo; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=pW3iTGo7; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fQp2HEHo";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="pW3iTGo7"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D96AKP480702
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 07:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1cbE
	bpn5Hw7xsVAZB92jcWtVfy6QlgvAYpkTwn5oETE=; b=fQp2HEHoj+JYXCXLaZGr
	ldQMakSg40j4Abbi6x9/UB/C9DzuNT4s8XhYAzjbTDgmi+AReBDeg3fF4w4nWOjC
	e2r3xlUQcXZuOakjDvc5syP2LOebQ/7umwzl+LlGoNDqMqH50fyhM0sUq3CsAdOj
	z3fNHd3NQmXiYG1oFFV5o5AjpVx5bzlnxxHuqoyxwp9H1icuQgWTwIAxE7LWAzjW
	sECTj1JsFD75sjextmKJeH+KdK00vL8ZR+o7XBHN1XOd98wutmWH2oEAV5ozUktf
	P1TkIBYISO6QosVwaIJ39r3AJ4oc/Q4TE806ly9sceZBxgjbhj2OizfeWSqDrg8F
	Kw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4g1ayu8m7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 07:51:18 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d7b3b6aa2so3326781cf.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786621877; x=1787226677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cbEbpn5Hw7xsVAZB92jcWtVfy6QlgvAYpkTwn5oETE=;
        b=pW3iTGo7TBMA1c3ED7O96pnKD+OVVxTHq/uvjZRLM8FoU+HLwv/RAmL4TYosWP1zno
         Ly9gDEYzvDURFE1rXLQ77+VDTNAsUHkrhMW2yaobnjHzEJS0FWP/R+sRNGjJ2TzBgbLg
         fExTAtWR1eN4hGjJIGDy6u5S4VNC/tqmRhUesuY7Zhmqpo5O34JWrN8kJOGxUTKaIfb8
         oL/kOqNYHURprvp6/5IDrdwpV3+Y2PuvKYIrcTYNBg+s3gr0SmXfeW3L2Ps6nVaqttFU
         wsB74drrX6EBURG5jWiRUTTjBoh/mlglMc70eEnKSxae/Yq4ZpxM+GVpGckZijvj5RsW
         AAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786621877; x=1787226677;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cbEbpn5Hw7xsVAZB92jcWtVfy6QlgvAYpkTwn5oETE=;
        b=gKZvxAayvasvzpM5/YzXMdw6W7JRhheoSZ2utYKM0oWbc/m6ZyvD2dDVcM+89TYe0A
         lBqIWjFUL0kVZdZednkF3n5RtGhiqZsvYVbdnJUnTv9KyTKSs+7RMQfBgMZ2+uQrcPuu
         h1UvJtWKxKZIFs0iwmFJxaWlNRes9RR6BtsKXVsmUgck6yPZK2kXaEjZfSDoJ4RUN1/o
         CJgYfboB7QDlwhXRW75Nv+1uwQMJZP8dKKkVWH6PAMbKQlxmqmAJLpao+aRpkXyFLQyN
         +xWdvdRiUx7+Uufu8bKsBm3uX+CazHATR69pFhUZBx9dJXMPKKgFKPA3xGl8GFQbs4xm
         Sewg==
X-Forwarded-Encrypted: i=1; AHgh+RqqTS2ZZyZyFPu5+Vlfk4bU0DkWGxoQMDRMDS2sn2HDNVNC80/GB/ZsFnLx/jBxaEs/iRAIhkHMBwYa@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+CZeYh02rw6DYJ7h2s4TP5DUq2yGTqJCGEJ0Q52X2MgJp/qw
	HqNc3fFbe5ZYeMzAkO6Hs35toVDgsabJVVQlPJnUGRgOHH7Ky60eeQYkZ+qm21+KbZUbX59XgvU
	BfI2GF19BVnxh5FbkOWxcNz8Fu3sNFeWB23np03ioLNbWqvrT6PbReEZK9sQ=
X-Gm-Gg: AR+sD12NJwq+eWYBPqOHgpUKxib/wL1iWICPgKtXwIjsvmWBPfDt7dE7hRsxSRYlCq8
	oU4V7BGz6kitishe2wSrEoUPkxLyKk9vTKUt41Mb+IQV6h/L2vOD9laqwTaQnYH2bQi5KGE+m+6
	bQjnYGkKdYaOvLdYqbFs+gE7hRVyz/MPlJ8cSROXyPkX45b9WAf9RIwhIYf/UmXO27NEatoQlpA
	DAdFJUWl3JjadQX+IOYzQF5NpwrYuYm+4xinYvuWjwDrJmmFsnAdAsl1FeRR9AWGsCChTxfM5OI
	jVTcKOGu92/doPGeyIMrO18r/2f15oxyLFgLcfpzNQK/twf5SHZVjd7Y7C9y8lvp7wecnGuYPCQ
	qbswdKxFHudkwWVmVsjBEzY6XTQOH8FDmfupunC4MGrhpdELo
X-Received: by 2002:ac8:5805:0:b0:517:6d6c:187f with SMTP id d75a77b69052e-52d73c7b09cmr47608931cf.14.1786621877324;
        Thu, 13 Aug 2026 04:51:17 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:517:6d6c:187f with SMTP id d75a77b69052e-52d73c7b09cmr47608411cf.14.1786621876825;
        Thu, 13 Aug 2026 04:51:16 -0700 (PDT)
Received: from [192.168.0.165] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569314sm6335812f8f.16.2026.08.13.04.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 04:51:15 -0700 (PDT)
Message-ID: <709df647-3af1-4d9d-a99b-c36c9ee69ac0@columbia.edu>
Date: Thu, 13 Aug 2026 14:51:14 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] ceph: convert writeback path to folios
To: Alex Markuze <amarkuze@redhat.com>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>
References: <20260810-remove-wait-on-page-writeback-v3-1-dd7531704f26@columbia.edu>
 <20260813112028.3989422-1-amarkuze@redhat.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260813112028.3989422-1-amarkuze@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CLcamxrD c=1 sm=1 tr=0 ts=6a7dafb6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=mxPCofyttrhx9O2bwGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MyBTYWx0ZWRfXyuSHwjk6CEts
 fXohpe6jQ5XAtE+JIZqe2jWf4GxtavpZP4crOp6c+xF+G9ESXvtBZ1ey1cTeOu+ZUrOV9ACJfBS
 442jsMU5vxufUG/LS41bEUswOvKb94+zxeymige6e0cnYjV+dxtG4YushbRmJcRyGgKJrv5fb4t
 nOslHjVZWWm6HbljZh+q5QH1LuhrjmRm981GHpFoiT/TPR9cTtfbtL2PBLVvDOVdU7jH21cjDkZ
 31Gp9ryzcArQ/f0lVj5X8wJMVtx2Z7TntYAzApv+72W57nKMv2xd8eso/H8cZYUbVwTNzimwa3S
 R3vEU0aG6zCBfYLkyXe3F1a6iyKhJEuDSh1YXvhTXPenSCp901xnNcoCnpkuGC/+ldETTtfHn/H
 +rYR5VBGzvq6zVJlCwKSZKkTqHUQQ6T/HMMbXXAT6yoOWGdCk3bowRz6BZP68rVrP9Bg9EmPHlI
 D60JOkO/+xMbz0UxYrQ==
X-Proofpoint-GUID: NzGl3p6qyWZAQGWU4KV5q7YV_81yWQNr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MyBTYWx0ZWRfX0Hog/ZysFdsz
 Cnz7Am/a/NDM268t9oWqmwj7O02apnsdWhS8VjI8lKFP/5mZ8jKRlAfLWoGt2x+W074j18ieHF1
 g3gO6SY2ym8Eo+HXbmy7wLOCrgY8AYvAQbDi7xMPIB03NmkCuSF7
X-Proofpoint-ORIG-GUID: NzGl3p6qyWZAQGWU4KV5q7YV_81yWQNr
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11873
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=10 phishscore=0 adultscore=0
 bulkscore=10 malwarescore=0 lowpriorityscore=10 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130083

[adding the mm maintainers back to CC]

On 8/13/26 7:20 AM, Alex Markuze wrote:
> Hi Tal,
> 
> Patches 5 and 8 remove wait_on_page_writeback(), thp_size() and
> thp_order() from mm/, but those helpers are still used by f2fs,
> mm/filemap.c, and mm/folio-compat.c — removing them would break those
> users.
> 
> Could you split this into two series? The ceph-only conversion (patches
> 1-4, 6-7, 9-12) can go through the ceph tree once we drop those two
> patches. The mm/ helper removal is a separate effort that needs to
> coordinate with f2fs and the mm maintainers after all other users are
> converted.
> 

If this is the preferred approach, I'm happy to split it up this way, but
to clarify:

 - This series removes the definitions and exports in mm/folio-compat.c
 - The mm/filemap.c use of thp_order is a local variable, not a call to the
   function
 - And I don't see any f2fs users of any of these... it looks like f2fs
   defines a folio-based wrapper with a similar name to
   wait_on_page_writeback(), but doesn't actually use it directly.

Given that all users should be removed and the relevant mm maintainers have
provided Acks for the two mm patches, I think this could all go in together
safely and avoid delaying this an extra cycle.

Let me know what you prefer.

Thanks!

Tal
