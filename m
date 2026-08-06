Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8F2FD696
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984153; cv=none; b=rzKp3786hDb+9Dy0fyC2XsT1atwwa/3WUQoBaVwfoXHQMGa7NUzVrYHpcR5fotJTyt8aPOPkH85vhJL5PDb6JygXJP3Wg0FW8HK8J9Syfn7sqi1G7DOdDhzJ/6q7OzG69OVsWnpWXJm8vHfJs+IUUu97jAzFqlJU3CV6Vygo8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984153; c=relaxed/simple;
	bh=/UVh9sFE/S6fCVgt9MCg3dl6oNHtaahZLZ+WBAfjE+8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L5jIveBPMDBg5V0ML/QjjOVifdILRaNV+/TGyV7utd6ZTWa3f20sQMyu1vIr0e4+Lst/9tfnM5Id48JGeoVcbRq7TqbCTP2oLjCLw5M6y3psYMNl2rbV2MO97FwpUvsQCFuCjE8vuYKKLvWUNH8BCbAOZEyk9uz3EjucdlRa7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i6/SgbBk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i6/SgbBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:To:
	Content-Type; bh=tLoMQ2P1WaLySjdK/rYV/Kj4ho34ugamoDcoWKKqqcM=;
	b=i6/SgbBkrWRMnrk+IfdGpyHa0ydpc56VmnyFoDP26B8uDrLHnrff9ESuZRMTZ9
	GXKfdD5q2y+DlmEAFvgJsdpwyci8L1Ap8cCDv0BBstmtIYerF60e4nlEDowLee4m
	dJ5z2UGdU6bx+8lNZ4gAW687ct6FrNFNZe3zIahKCQdfg=
Received: from [IPV6:2409:8a34:e20:2071:dcaa:d871:30d0:1ac5] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3j8579HNqIvSuOA--.52274S2;
	Thu, 06 Aug 2026 10:42:03 +0800 (CST)
Message-ID: <fa91fe35-5bf1-4dc0-aaf4-90cc84154460@163.com>
Date: Thu, 6 Aug 2026 10:42:01 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yong Wang <edragain@163.com>
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
In-Reply-To: <56b420789e339d168e825cc162ddaf6a66daeec2.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3j8579HNqIvSuOA--.52274S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF47uryrAryfuFykWrWDtwb_yoW3WFX_ur
	Z2krWUAws7Z39rtFsxGF15X39FgFWkuryktr48Ga40g3sxZ3WDZay09rZ3ArWfJrsYkrna
	vr1DW3y5Ar1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUy8BUUUUUU==
X-CM-SenderInfo: 5hgutwxdlqqiywtou0bp/xtbC9RzT8mpz9HwvNQAA3D



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

