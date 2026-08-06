Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92053175A83
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983452; cv=none; b=nR5NCU+LZPMlf+mD1jEKAd4O4ZWQ3tj2DE9SKM9zyaIIS1u0tpd/TPGvSHVynSm5i+AV+OVUFcJ15kw+lN30gtC/N0pFZTG/nHERAnU5vTDeeNS9WeEVTazVOhgyYNifLHQUF8SWI/SxlBXq55IqP48dU8QIsmEgo1Rjh3V5SOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983452; c=relaxed/simple;
	bh=/UVh9sFE/S6fCVgt9MCg3dl6oNHtaahZLZ+WBAfjE+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dvz9rayKRUO1v5MEjvTinTo8xpKTmdj4LzKT5JtprD2bbf+IJpBof2BubAGpUSsyDfGHn7EnRArePwduK3NwMG6IY86M/ya0iU7HqJoFbYxXrXW9Pw7EchKcUIk6XyuPmf+Ciowm23X92cLSEfLPV1+F1r1ewtV+GKEuG/Bb3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L5AKqjuY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L5AKqjuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=tLoMQ2P1WaLySjdK/rYV/Kj4ho34ugamoDcoWKKqqcM=;
	b=L5AKqjuYtd0NPxBHKxhqcUnXMNkYwG2MXQczoKfZ1cGZhOeoLiXJDYsG9sWAvw
	KAps4iDdDTikHscE5iIJ0Xu/386v2fJJxyydJk5ic3urS/uBbDpKYk6vOVUdJvTU
	xDCRZWI0FOqVx7NgnbwM4kZxBEI3GPs4dRYwImmj66iyw=
Received: from [IPV6:2409:8a34:e20:2071:dcaa:d871:30d0:1ac5] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHFYau8XNqyiK_MA--.66S2;
	Thu, 06 Aug 2026 10:30:12 +0800 (CST)
Message-ID: <c101f653-b220-47be-99b5-892e50dbbc0a@163.com>
Date: Thu, 6 Aug 2026 10:30:03 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "sage@newdream.net" <sage@newdream.net>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "dstsmallbird@foxmail.com" <dstsmallbird@foxmail.com>,
 Alex Markuze <amarkuze@redhat.com>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "enjou1224z@gmail.com" <enjou1224z@gmail.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <cover.1783423648.git.edragain@163.com>
 <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
 <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
 <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com>
 <7a71431b-4c39-47cb-baac-0cbad03e13c9@163.com>
 <ee478394c5d2ec19dd0b5ce39adb9476c826cf39.camel@dubeyko.com>
 <c7648fd0-d311-4757-aeeb-f66d261e3fbf@163.com>
 <56b420789e339d168e825cc162ddaf6a66daeec2.camel@dubeyko.com>
From: Yong Wang <edragain@163.com>
In-Reply-To: <56b420789e339d168e825cc162ddaf6a66daeec2.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHFYau8XNqyiK_MA--.66S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF47uryrAryfuFykWrWDtwb_yoW3WFX_ur
	Z2krWUAws7Z39rtFsxGF15X39FgFWkuryktr48Ga40g3sxZ3WDZay09rZ3ArWfJrsYkrna
	vr1DW3y5Ar1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUBMNUUUUUU==
X-CM-SenderInfo: 5hgutwxdlqqiywtou0bp/xtbC9hQhQGpz8bT5lgAA3w



在 2026/7/29 7:15, Viacheslav Dubeyko 写道:
> Hi Yong,
> 
> On Mon, 2026-07-27 at 11:35 +0800, Yong Wang wrote:
>>
>>
> 
> <skipped>
> 
>> Hi Slava,
>>
>> Thank you for your review.
>>
>> This patch has been sitting for quite a while, so I wanted to
>> politely
>> check whether there has been any progress on it, or if there is
>> anything
>> more I should do on my side to help move it forward.
>>
> 
> Ilya sends patches upstream. So, please, ping the Ilya.
> 
> Thanks,
> Slava.
Hi Ilya,

Following Slava's suggestion, I'm pinging you about this patch:

  [PATCH 1/1] libceph: use RCU to protect monmap in ceph_compare_options()

I just wanted to ask about the current status of this
patch. Please let me know if there is anything more I should do on my
side to help move it forward.

Thanks,
Yong

