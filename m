Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9CF4F1
	for <ceph-devel@vger.kernel.org>; Sat, 10 Oct 2026 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591395; cv=none; b=L+ZNYlChUQWKChrCGSu35FhF21rGhG6H5CkLjsntc6f2lYWQJ7rxwcOAq1Eo7lGYOMJiEztaTe1NS4YisPCyTjOZsjharYq6+qKnm+ld1V56upsKQ3P75O+yi20xW0UOsYiXYXxfo5Ew6Gebb7fSPEYDHkewArkEZNQxj8Gr73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591395; c=relaxed/simple;
	bh=5kCbcaTTTqgxxt8BaTH10ihf7QJwDiWdRV2+3PkCxNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1aCwv/rjsksDAnQbmJ1AusMhgard5w/DvjI2wLTefkNMk3xv0peGZhDFZ9YnCPPemikw4DS5fk1oBFJj2dmikJ7ioDZA4kujld127RDPrIwnNzk10ZsrJrH3vIfFo/j3oQT0p7AFZ6QKuRJYlBw23BjKlNOlnxwovI8ZN4Oy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Kq0GhzJn; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=39QUCxuh; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Kq0GhzJn";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="39QUCxuh"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699MZqMb801645
	for <ceph-devel@vger.kernel.org>; Fri, 9 Oct 2026 20:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Oxe4
	FgcIrqZbXu5c8U3MHYqvLVmmx/Gg1O74bCce4C0=; b=Kq0GhzJnrSWzFX7TC8T+
	aas1DtcC24NtpQYuLxHodd81bapodk5H+a6MJKlNc0gNZmnPIJM5Pdc3nBQdgjk9
	lFZ2xidWLCgENj3xA8Zq7WzJK1pscsQorYQ8yILuqAcr9QeL7nJV1TiuHo4jR+P+
	yQOpXghlCRiDphIHjuY8D1j6TmwjlNuktZxHNAg5CjxzmcO6p+0SHJDAZvlt727d
	NBeRFE9+kHE0ocdJuybfSdv4BAJiw6QkZsvkhK0GTDQLGuZBiojKAbeNPgK1DIlt
	VG6VFiLD0ZniGFcK5Tm9ak9dV5F3vETBs/XiPu1JnpmfzdME0F9cryHhx8F459pp
	ng==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h74tdaks6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 20:16:32 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9179d9cde17so4357346d6.0
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791591392; x=1792196192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oxe4FgcIrqZbXu5c8U3MHYqvLVmmx/Gg1O74bCce4C0=;
        b=39QUCxuhUWqJOfh/Z4HVohNwufbFEjwOPHoRRbvTk6qrXpdAnDJPu0mkGQ7W8Mv38D
         AEJTS39kW8l+kjkV1TUFYUxfctau63uAX4AkAUSW/aZQV6+XD2IBmemQaO1pOjGLCAlb
         LCH61+6ANRMoBoLsBvxy50NM6dRai5k+FVU0wwE76K+jjk+1902ylIFBMEpzO+34YhZc
         Kf/7z6tHimzKULzbCA3Qg/sq7m7fPy5obR35ZKZdMg3usePgkKvmdqqpbd0H4nLkItJR
         JxRAyWaBTfXbPSWVmvG5glknMnX8kvBJu6TT/8C4F3unu4b/V5Hn95uMmka0lO4VElx8
         YawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591392; x=1792196192;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oxe4FgcIrqZbXu5c8U3MHYqvLVmmx/Gg1O74bCce4C0=;
        b=H8nY4yQRgmcu2piZhBdhTsHPGu0aqerks8VK+pGtHD58JJLxK3F3Syjy1I/yjjBEwn
         C+EdCpYJAWwiro4+ixskGV7mZ5jNcHFm5xHPEtoQD8DMd2r3DvC5EcT63SyQbTydg+pe
         B/yzzij9x7xmtdqehZvVlDKrt71rALLTDcvhxrmS8JEtRAqOK3u05JO0oX70hYas0TEJ
         x1ZZnU8FY3rF5ogD7LabZU10HhyIb1NgJPG65AQO0g6TzbOXofs89LSGaMN+3xYTDgsL
         4l/a6Cg9WEDnhL6FiXCkYOyXFuDWcekufgu2hH+it2Bg03XdAlqtOgxg3jqQ++ZyLQNO
         nf0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8gLLS6M2hBZIYU5J/FliHsi4t8il9GKvM9jfZQdB/Vwe5tGuCqWuqKG05iR1XT+NgDgHLKnkFTUe1@vger.kernel.org
X-Gm-Message-State: AFq9FYLKyM3aUxH4ppd9PUAYUtYzExIz0mYDEVzddzHQ0aCFTAoNrWNc
	fkgxQ5tI+g1Uq2IyG9Tdmbupo62VTGmFC1bselfOylu4kmo9OhKC7W3hsa31rkDxxOYVD1mVn1/
	cXlHPwjVT+tErk0fy6jjn2z4Mx193UlbBHSpf3rckdd6aRYm98un+97eDx6M=
X-Gm-Gg: AYBFou1MZ0iH5Uc+C6dWtckARmTFtPgNMQXKYTE4iEfLjUztxasAmz49+hXIlVBLPPh
	bI7XEFUr5bSpPpLo5b3i4esSVIXEgxEMzq9rzMvI2nZMw6gttB2WDDnCIplhgtWRHxIfDEaJv2l
	C934EUwjltKftQEXqGUO7N02iUMBydUG8yL75m0YR09CZVGYjQWUp0HGt47CqzGkCvxCGnhMoXw
	dAiknbEuMJTtf9zBWUlOZjo9Qr33/slc+djJ8V20ROHQoBIjUMOINWQD35EwsKe1iJi7LjdNktJ
	LnfonXcTYVTOoG0qPDmNmObHuStuTgXhr4r/oYv2RGH+J40fLgJBAmNECrJrYu6yZIoruSKGdnq
	Zny57ruu+zmVI7NRwOWOKCeeULUznf6srfe+wTo9RDujq3wTS
X-Received: by 2002:a05:620a:1a0e:b0:93a:2611:270f with SMTP id af79cd13be357-93ebd20ecaemr593316285a.13.1791591391933;
        Fri, 09 Oct 2026 17:16:31 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0e:b0:93a:2611:270f with SMTP id af79cd13be357-93ebd20ecaemr593311785a.13.1791591391404;
        Fri, 09 Oct 2026 17:16:31 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c350sm305668885a.22.2026.10.09.17.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 17:16:30 -0700 (PDT)
Message-ID: <35f4d048-c858-471f-bf9f-24a976094f73@columbia.edu>
Date: Fri, 9 Oct 2026 20:16:30 -0400
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] ceph: convert writeback path to folios
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
 <1043695.1791475206@warthog.procyon.org.uk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <1043695.1791475206@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fr9jEhAxJ6djeQFHuZjfJXtAHM920dka
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDAwMCBTYWx0ZWRfX+PQ8C7Udz79w
 eRGqVQXhb8aN6Hu4dxnVIEWCpZX/stuNN9yyCuzLM2StgEdpgMDzptOaSGolgc/SYUgdjYr4O2n
 rm1R30/Pl8KELPepdGISD93yfZaOom2J9PeQAnrQYXyXwudHbfC/
X-Authority-Analysis: v=2.4 cv=GrPXaU1C c=1 sm=1 tr=0 ts=6ac983e1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=D3aJNg95PxMWSXTfbh8A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: fr9jEhAxJ6djeQFHuZjfJXtAHM920dka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDAwMCBTYWx0ZWRfXx9UxcVaOuFHY
 3THlKbxc0IhbMu0p7CTv6ahPOCjktxzzxVJ+HqdEJaz2J6dAQi3EA376mlOSGA+bqEGYisTZmOy
 pxmGp93d2kpMC8SbXOEkHZXGLe5IXGD/Jk/6e15RECGs2bWU5sZrBgoLeRVN4xBG9wzNn5C0FBY
 Xk8L1j77+fS30zUjY2fPMJ+cDPbdKpzcJpHWfzuS+9ANBShuXnWw/bVs0itd2c6R7BkDCvbIgPv
 8exSanczi7nkp5x1kJiYH52LuKokHs0+mBEUhwmNqNZ8HYnPFShbIK9q42jiHt4RipGOG7Ntusc
 j63Nsa9gU2AUvl5UY0b3t836FNfeddYjtnZBnyJY1774AVJk/I74OQbhAmL2vel8+f4bVgp4dN6
 0hfF5N4ttwY8DY460m69esfstvMyOFXeDRuN8buCwUVTJqpjwATZw09aLYX65M3Wp1GFlMAgHtb
 ODRWlm8OMq1K/ntJKQA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 spamscore=0 lowpriorityscore=10
 clxscore=1015 bulkscore=10 malwarescore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100000

H

On 10/8/26 12:00 PM, David Howells wrote:
> Hi Tal,
> 
> Apologies for not reaching out to you before, but I keep getting diverted on
> to other thing - usually by AI patch reviews.
> 
> Just to note that I have patches in the works to convert ceph to use netfslib
> and thus strip out all the dealing with pages/folios as much as possible -
> even getting down into the protocol and replacing the five different page
> carrying types with the same structure as is at the core of netfslib (bvecq
> chains) and pass the bvecq chains all the way into sendmsg() for transmission.
> 
> This also lets me remove ceph's use of the PG_private_2 flag which the MM
> people would really like back.  That's then replaced - transparently inside of
> netfslib - by setting a special ->private value on folios read from the
> server, marking them dirty and then having writeback write them to the cache.
> 
> It's unfortunately stalled on getting some netfslib changes in, though there
> may be hope for making some progress in this merge window.
> 
> If you go to my tree here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/
> 
> The netfs-next[12345] branches are the prerequisite patches I'm trying to get
> in at the moment, divided into five batches.
> 
> On top of that is my netfs-crypt branch that has content crypto support
> 
> And then on top of that is my ceph-iter branch.  Note that it's not fully
> working as yet and I'm still testing and fixing bits of it.
> 

That's great, I see it removes the ceph pagelist and with it the last couple
callers of __page_cache_alloc(). I wasn't planning on sending additional ceph
patches in the near future, as they would all require getting into the
protocol, so it's great to hear you're working on this!

> If you want to push these patches first, I can always adapt my patches to take
> account of them.
> 

It'd be great to get this series in sooner rather than later. I think it's
ready to be merged and it would let us remove five page wrappers of folio
functions immediately. Hopefully since it's fairly small it won't cause you
too much trouble.

Thanks,
Tal
