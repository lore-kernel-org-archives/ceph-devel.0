Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311E3B28D
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148440; cv=none; b=uReE5PrDG+ZJP8P4zzT94WIUrEqfEZ/k1kAfJYaWiMWqKt1XG1UMBSaBBn7id9zz2UaHn2KpUfsXM8eC9/m3D4yx368Na141c98Ggw1bU2QTNgZ+3HApR2/ZT2ua2FC3rTw4vBmU/Krw4Y3jd08BXUE/nIhvokNhvKSfld1z7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148440; c=relaxed/simple;
	bh=1vV93XBCwh7EHsjIMoMhqmyHffQl3GR+7jvlkX6x23M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7pNUVo+7vvJ5Gu74zEx07y0krqLO6lrTO3b/aLOqbKBJcJTRFQAThzYLC9UdS5SD1wZKX/U2jKLX0ge0qZ8wHvvVyu/qDkFs+soxo+orjojOCsEwv9uDI2I8PGkfipSGk72se9JpFvrC+kBqPNROFsm/9NPQlITHLlNcaVYCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QainxQob; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Q9KWIuJL; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QainxQob";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Q9KWIuJL"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JDKgkA517996
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 10:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=v+rW
	b2PI9H0trus3v50K4+LrW0ehZGd/jWBMgVbO+5A=; b=QainxQob9rJFuYU+UlAT
	dkqXJi7wNZDzfdxQwvYBkAVISduRhyB/nJcczHJkHBQ4ZPQsF+T4OMxaH1CO1hPJ
	oIi1Q5GyPnBJZwlwLAemBhaM7KebGjgUgSQ4pBXIb/0h6Tlj578az31+DRLe4rif
	ZVrZ/6e7r3DzaXHxvE9rTAZtG+ffJSx5FmmRY2IkqaatlWCBfq3Z+oRgycEkOCCP
	w+v2zzlmntP0dSsoLFi1TXrRxMV0aYoe3e8ptcgbQiJrYglz9jFogpdii8S1U2n5
	1xeCbN9TrQVhQDuCrkv7PTIr088mhFNqIe69BgHifQjjHt7/K8Q68q0mbqvCCUQV
	Ag==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g4yf3bnp9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 10:07:11 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930dda91cbdso206483885a.3
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787148431; x=1787753231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+rWb2PI9H0trus3v50K4+LrW0ehZGd/jWBMgVbO+5A=;
        b=Q9KWIuJLHoFpn5Ze2c07isxq8kSGzWSTjaO3tVGniVmi4HxMfTbIcyKg9ZF0scNjQ3
         DDPVmEuc81uhhfvLVkbAUqLBkAo608TRA0bbCypKkCtQFoa3LxGHXk3wvDfMsJ9XCYqw
         8C7GDTpgM8QejFg/F4lNenoVayeNalentFKUgtT3vu8K0FRsGAqPm0tzfPbYIzn3VbBx
         qcD8zYZd2XbX9jwvoS7BQSQBjxiHvqRyXJIJ3F5uHE8Leduf2GdnoAonPgsTsPtnRlEO
         hFCVLFwXTbyIxXpAIgzYd3+nuzQJZjA+IXhElGBmTZSam6N1Jh0LOwIGReO6vnwZVtKo
         V/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148431; x=1787753231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+rWb2PI9H0trus3v50K4+LrW0ehZGd/jWBMgVbO+5A=;
        b=RFASQ1VrGw3VXmdqO0TZ0ZnYvn/OroNvf5gz7gHrlVBYP6KqeJ0ybMYF+lyQlBQVru
         FP6ZaYkTwjrOqhFcnMnDycVgCPKtYZqg2yukVVeBLZ22qDYLcNSLKMBzLHV/t2SmwzVt
         6v0PuLakRw7JbjzaX6OTAuN1hJW1doViCkg9ZHVmWAUMja3FoKEuG3AMkiD+iz1fRjzI
         oHiiEU8Mqe0I/WP35SmrpO8ZNPqfb4xyrKeeWXcWgkuNHKq7uW8MxpbKcH4fggCujDC9
         xZuovxrT3UyD+TGG7EZpyB707MVl8ONhC/N745/NE2VxkWOQ3qTvQ6tPyxDAmcmOQSrm
         z00Q==
X-Forwarded-Encrypted: i=1; AHgh+RoTnrn0NsjTK8ggGqD9B3BkrZkjQ/T3lop+xR9PVJka/BPHTlfnavQQwqKslk07hecRasti0Ne+RJEK@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWQciikNeUx45ljXloNXuYciNJyKzyfwI0M9xL5ULRPLIK77e
	TQKD6gY4bYfIQ3AypmkvN7jGw6WE50u3YR0P6wm2WbDxwTLBrE4RWaRmD2LdRciGhtWWJlRmHe4
	rThbVV3LOqJ65edBoEuWgT8gaokTV+qLmNGVynUMK47IK9y33r6XANpHNd1U=
X-Gm-Gg: AR+sD10d/GF1rVemn8mFoDjJe2EGYYj8m59OSmqiTRouTWf6sdUebyExmjnolPZttu3
	VJ7rDPcK8VG3WcvtBX9+WVgkuWFMQb5hAKpM+DEtL3tsDfkfuZI4mGhTzr5K3GE4uFqlMNyV3VY
	GxjVaHTF0vOP4B9aBAhTUK2E/Vr+M0YaQPq71lp8QSdoYiNQJ8L+UlUUAL1/9TuSuW8yXps/PKQ
	YwO1cpl6VZQY6+FP8KXcNGJR8+RGG0iVddbsmlxjBVPCLsayk/Qq2X5DvVE/tD9P+/mUzvBS+5k
	+QSq62wtSBGcNeBUVUakVHeCk6SqMyJOBDwRTJUAdQSVTLFnkyuAD87aGPTTAcNocjadebV9xpP
	393jFHJh0Bqo31CtUCS/gFILkSht3Ifat/Wil5xIXmAJCKq5IsLe6lsE5jIT6Rcsw
X-Received: by 2002:a05:620a:458d:b0:92e:541e:632b with SMTP id af79cd13be357-9371e1f787fmr458360285a.2.1787148430890;
        Wed, 19 Aug 2026 07:07:10 -0700 (PDT)
X-Received: by 2002:a05:620a:458d:b0:92e:541e:632b with SMTP id af79cd13be357-9371e1f787fmr458338085a.2.1787148429725;
        Wed, 19 Aug 2026 07:07:09 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:9cd5:4094:6d4f:9d51? ([2a00:a040:199:782e:9cd5:4094:6d4f:9d51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c78a083sm80892066b.28.2026.08.19.07.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 07:07:07 -0700 (PDT)
Message-ID: <9d9bf5c2-008f-42ba-9c39-403ce224cc99@columbia.edu>
Date: Wed, 19 Aug 2026 17:07:05 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: use iov_iter_extract_pages() in
 ceph_msg_data_iter_next()
To: Christoph Hellwig <hch@lst.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu>
 <20260819054413.GA32590@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260819054413.GA32590@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a85b88f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=czLo_xrUl_3H_s0coRQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ogB_zyvbjTV6X_aevvnP2XBy4SIl2kFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExMCBTYWx0ZWRfX8R+W3De0GZOs
 BECG7o0da6/G8mDnwGGQ7FYoLB6HgbtUUrDqx7oB4/oGo2cNZR60DCsRlZkTlmXsoSPhHWNLy+t
 u9vnAa72MuJ+ef3zrqT7DxObdwCaGB1FBWI7RHATf0dW/F3IfutPCO3Oy7VlJ+RRWrAdnigS1Rz
 vGy1a1OPAn5H5PaJ40U2EumiKoT1RdkRhGuVOWtq2Nq/d73ZOa+WM8Fc5wPrPOAzAoMNZD2nw8x
 pFO+UHDBiNIC3l5yMmVfzi4JhUFZ4EKhmzpCdYDeu6xF7iJtIFMAoq822R2iDws59jcKf0sPHCH
 9YtwULTThQug8XPWQlf8yp5wVjI3+LGqUN2auC1n5EC9pbbH6DQYLctVgujywjJhqYClLoCdZp7
 HZY2EXAGFsU7ZX740gpJpo9+g9n87MyLErTTUTXc7D7A16+ayvnkv7XpbsiepLF9n2hCA+yHb3F
 Sj1QGRswqsZXaW3LH4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExMCBTYWx0ZWRfX7s8MEEWpE0UG
 WlE3FDMO96B5AQQ5iPeDuQJioW+S9C1Jb5AF4zakbHLCl+xXXOhzHUMpmPX5tfC5YDH1C7iYGzK
 f2rJEhABL2kOFVmk5AcElAmOP7ciCM1VGHJJoe/NUQjZwNf2rDI2
X-Proofpoint-ORIG-GUID: ogB_zyvbjTV6X_aevvnP2XBy4SIl2kFS
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11880
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=10 lowpriorityscore=10 impostorscore=10 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190110

On 8/19/26 1:44 AM, Christoph Hellwig wrote:
> On Mon, Aug 17, 2026 at 06:16:56PM -0400, Tal Zussman wrote:
>> ceph_msg_data_iter_next() gets a page reference from
>> iov_iter_get_pages2() only to immediately drop it, asserting that the
>> page is pinned some other way. The FIXME here predates
>> iov_iter_extract_pages(), which takes no reference for kernel-backed
>> iterators.
>> 
>> CEPH_MSG_DATA_ITER data only comes from osd_req_op_extent_osd_iter(),
>> whose only caller passes the netfs read iterator, which is always
>> kernel-backed. Use iov_iter_extract_pages() and remove the put and the
>> assertion. The messenger still relies on the upper layers to keep the
>> pages alive while it uses them, as it did before. Extracting from a
>> user-backed iterator would pin pages that nothing unpins, so add a
>> precautionary warn in ceph_msg_data_add_iter().
> 
> Yikes, this goes through like three layers of pointless abstraction
> for a single user :(
> 
> But trying to unwind those it comes from ceph_netfs_issue_read, which
> is the netfs issue_read method, which is used for all kinds of
> reads, but it does seem like for direct reads it uses the kinda
> interesting netfs_extract_user_iter helper to turn the user iov
> into a kernel one, which makes all of this such a freakin' mess.
> 
> So yeah, the analysis is right, at the same time using
> iov_iter_extract_pages is just as weird as the old version.  Someone
> really needs to clean up all the mess in both netfs and ceph :(
> 
>> This removes the last caller of PageWriteback(), allowing the page
>> flag accessors to be removed in a future patch.
>> 
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>> The assertion is the last caller of PageWriteback() in the tree. The
>> removal of the PG_writeback page flag accessors will be sent
>> separately.
> 
> What about just killing that assert and leaving the rest of this
> mess in place until it is sorted out properly?  iov_iter_get_pages2
> is a pretty good marker for that, and it would be sad to loose that.
> 

I'm perfectly happy to do that. I just want the PageWriteback() gone
and wanted to try to fix it properly rather than just delete the BUG()
or throw in a page_folio(). But seems like "properly" in this case may
be a deeper hole than I want to jump in to right now ;)

