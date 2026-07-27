Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0821175A94
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785123386; cv=none; b=khRe1IgomopVaxSDDgY17Koe13/2k0W9z9BMGdBxO4mDv7WjKYaxewcWlwH0ZXr12b3dYfENdIBcp5+yRopI/4KYqSpngKzE+/hMBdJL9EgE8GQmZqs2lwG1Stk+Kf8NBwMY2WtiNphu8nRj0ehhyGB/J0a6TZnExb6iPCoEqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785123386; c=relaxed/simple;
	bh=4hyF+2zW9VvNa5+QQQG8G+WtQWlQ0QXMPthMirJmET0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tl7p3O/wv6krdt6MLRPoGg9SSQTbDkgytQnkoSc0C6Vv5CYNIBpChYaTGnPrg6K5+kFD2GHAQWy9xW6+lqWHMeLPsKYZAYDJ/DOb8fg7ZdQE6NVrTA2txXhRfLXCx/DA1c735J9SPiiw2J3B6YAm+SAhkvyyJrYt339XB8pbq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gkchLH9f; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gkchLH9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=IpT3dv7/IdIBjrJ+pEOB1V2tZPlfrPM0SeGo7uYP9dk=;
	b=gkchLH9fz4KwGKEjQmtYHE2FcnJ83KOkY1OrWrp7I0RYCsOWb2Np58EmGDX8Sr
	2uJ2+/2Z7Z9avV5K049asi40IJYSZHUNEwmlmbBn4W5ggVeilBZDrdxzqikk9Pia
	g32EWAP2ia2GJyML6rfFvTLuKqiZjLe7Gaf/6vJ9DCOXQ=
Received: from [IPV6:2409:8a34:e20:bb31:d3f:de17:11f0:efbb] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3P6cT0mZqo8eyLQ--.59076S2;
	Mon, 27 Jul 2026 11:35:49 +0800 (CST)
Message-ID: <c7648fd0-d311-4757-aeeb-f66d261e3fbf@163.com>
Date: Mon, 27 Jul 2026 11:35:44 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "enjou1224z@gmail.com" <enjou1224z@gmail.com>
Cc: "sage@newdream.net" <sage@newdream.net>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "dstsmallbird@foxmail.com" <dstsmallbird@foxmail.com>,
 Alex Markuze <amarkuze@redhat.com>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>
References: <cover.1783423648.git.edragain@163.com>
 <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
 <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
 <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com>
 <7a71431b-4c39-47cb-baac-0cbad03e13c9@163.com>
 <ee478394c5d2ec19dd0b5ce39adb9476c826cf39.camel@dubeyko.com>
From: Yong Wang <edragain@163.com>
In-Reply-To: <ee478394c5d2ec19dd0b5ce39adb9476c826cf39.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P6cT0mZqo8eyLQ--.59076S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1UZF4DtFW8uFyrtFWDArb_yoW8Kr15pa
	95K3WY9F4kGr9Fk3s7tw1kXa4qvws3GFyUZrn5WwnFy34DZrykGrW29rWruFy5Gr1rWw4j
	qa1kAryfWr4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFzuZUUUUU=
X-CM-SenderInfo: 5hgutwxdlqqiywtou0bp/xtbC0xXtDWpm0hXg4gAA3v



在 2026/7/14 6:22, Viacheslav Dubeyko 写道:
>>>> So it is safe to use.
>>>>
>>>>> Have you tried to run xfstests for the patch?
>>>> I ran the ceph xfstests in QEMU on the patched kernel, and all
>>>> ceph-
>>>> specific tests in the current tree passed: ceph/001-006.
>>>>
>>>>
>>> The running only Ceph specific test-cases is not enough. The patch
>>> should
>>> survive the auto group of xfstests.
>>>
>> I reran the tests on a baseline kernel before the RCU patch.
>>
>> Excluding the notrun cases, the following tests failed both before
>> and after the patch:
>>
>> - generic/363: fsx reported READ BAD DATA
>> - generic/429: encrypted dentry/key revalidation behavior did not
>> match expectations
>> - generic/440: encrypted name/key cache consistency behavior did not
>> match expectations
>> - generic/580: encrypted files became inaccessible after key
>> removal/re-addition
>> - generic/593: filesystem-level/provisioning-key encryption flow
>> failed
>> - generic/595: encrypted file remained inaccessible after key
>> eviction/re-addition
>> - generic/631: overlayfs-on-Ceph scratch mount path failed
>>
>> generic/650 and generic/777 could not be completed reliably in my
>> local environment because 
>> they caused the terminal to become unresponsive, so I do not have a
>> meaningful 
>> before/after comparison for them.
>>
>> So from this comparison, I do not have evidence that the above
>> failures were introduced 
>> by the RCU patch.
>>
>> Kernel(net) commit tested before the patch:
>>   6d27e29a90bc6a717b97c6ddcd866db7bd8e4adc
>>
>> xfstests commit:
>>   ffc8bad17e5b2f56e48dbac43f7c5ae8ac368fe5
>>
>>
> It's interesting that you can reproduce more failures that I can
> reproduce in my environment. 🙂 Usually, I can see around 3 failed
> xfstests. I've already shared fixes for several ones. But my fixes
> haven't been accepted. We still need to fix some xfstests failures. 🙂
> 
> The patch makes sense to me and it looks good.
> 
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> Thanks,
> Slava.
Hi Slava,

Thank you for your review.

This patch has been sitting for quite a while, so I wanted to politely
check whether there has been any progress on it, or if there is anything
more I should do on my side to help move it forward.

Best regards,
Yong

