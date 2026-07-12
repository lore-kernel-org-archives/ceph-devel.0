Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF41B4F1F
	for <ceph-devel@vger.kernel.org>; Sun, 12 Jul 2026 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783837739; cv=none; b=XjzRGHRBB2PvpnrUy3XNPeq79/+HqUp4yoxTgZ1y1SFqtDwdO5HvgUmr9ZdcS0hqEkJfmJ4GKuiT6LzUCt6ypRlqa1gtFhRa+p9envaQuQQNH+hvBZiotbY3BrIx+pL5MS1tex4HGo42IoiLbRAVHHR9jp+lHiOrD64uSw8lxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783837739; c=relaxed/simple;
	bh=fT5bIMf0WKucA28sBpL7/GAImb4WLpViSx76pNl6iH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goL/PhtG+BOu1xPxfzJdsCcg5UzIOpNM8U6kDB5ajNFUzgZWp7DCG0+ue3O8WprEGg1IOml1p7U3St9KKPFrf6XiJNN4fPkyJphxdq6eUYDMYq4At94aWFUHaPMxMmnCZbA0WZ0VE9R3tQ35GD+NAP7QeZV+rgmzsoPTQ5bxyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DzyBuCZa; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DzyBuCZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=qmIDAadDd7eZFx/DgKasy3AmDpAFPNo83josGsvjNro=;
	b=DzyBuCZaxW+J7bCZAfE6egRQcOdFm2S+Vj8sJlzi0YmEg4ZjjEdLIKT9Dd3i9z
	GsC8d3hn3IDqR60z3ky2DBzJ/t8oMbVfQhAdpllIrk5wykdn17JjKwSWHTOIZB43
	V5CGhN4G8irid0Nx8FU+/yZ3gDAX2BJg38G80cpwD+hBw=
Received: from [192.168.31.228] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCndmgKNFNq5X2VIg--.38486S2;
	Sun, 12 Jul 2026 14:28:28 +0800 (CST)
Message-ID: <7a71431b-4c39-47cb-baac-0cbad03e13c9@163.com>
Date: Sun, 12 Jul 2026 14:28:21 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "enjou1224z@gmail.com" <enjou1224z@gmail.com>
Cc: "sage@newdream.net" <sage@newdream.net>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "dstsmallbird@foxmail.com" <dstsmallbird@foxmail.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>
References: <cover.1783423648.git.edragain@163.com>
 <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
 <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
 <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com>
From: Yong Wang <edragain@163.com>
In-Reply-To: <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCndmgKNFNq5X2VIg--.38486S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4Utr1UCr1xWryfKw17ZFb_yoW5tw1rpF
	WDKF1UKF4kJw17Aan2qrn7Xa40vrsakay5Xrn5W3W2vas8Xr1agrZIvFWruFy3CryrXa1Y
	yr48ta4fXr4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeKZAUUUUU=
X-CM-SenderInfo: 5hgutwxdlqqiywtou0bp/xtbC9gx-nmpTNAxpcAAA3D



在 2026/7/11 0:33, Viacheslav Dubeyko 写道:
> On Fri, 2026-07-10 at 10:16 +0800, Yong Wang wrote:
>>
>> 在 2026/7/9 6:43, Viacheslav Dubeyko 写道:
>>> On Wed, 2026-07-08 at 11:03 +0800, Ren Wei wrote:
>>>> From: Yong Wang <edragain@163.com>
>>>>
>>>> ceph_compare_options() checks whether a new mount shares any monitor
>>>> address with an existing client by walking client->monc.monmap via
>>>> ceph_monmap_contains().  That comparison can run under sb_lock or
>>>> rbd_client_list_lock, so it cannot take monc->mutex.
>>>>
>>>> Meanwhile, monmap update handling replaces monc->monmap under
>>>> monc->mutex and frees the old map immediately.  A concurrent shared-
>>>> mount comparison can therefore dereference a freed monmap and walk
>>>> stale mon_inst[] entries, triggering a use-after-free.
>>>>
>>>> Protect the compare path with RCU and publish/free monitor maps with
>>>> rcu_assign_pointer() and kfree_rcu().  Annotate monc->monmap as an
>>>> RCU pointer and use rcu_dereference_protected() in mutex-protected
>>>> paths to keep the accesses consistent with the new pointer contract.
>>>>
>>>> This keeps the existing non-blocking comparison semantics while
>>>> ensuring that replaced monmaps remain alive until readers are done.
>>>
>>> The approach makes sense to me. However, I have some concern. If the replaced
>>> monmap(s) could be in use with newly allocated one(s), then are we safe here?
>>
>> The new monmap is fully allocated and initialized before publication, then
>> installed with rcu_assign_pointer() under monc->mutex. Readers only dereference
>> an RCU snapshot and treat the monmap as immutable, while the replaced monmap is
>> freed with kfree_rcu(), which means the old map is not reclaimed immediately, 
>> but is delayed until all readers that are still accessing it have exited the 
>> read-side critical section.Readers only see either the old map or the new map.
>>
>> So it is safe to use.
>>
>>> Have you tried to run xfstests for the patch?
>>
>> I ran the ceph xfstests in QEMU on the patched kernel, and all ceph-
>> specific tests in the current tree passed: ceph/001-006.
>>
>>
> 
> The running only Ceph specific test-cases is not enough. The patch should
> survive the auto group of xfstests.
> 
I reran the tests on a baseline kernel before the RCU patch.

Excluding the notrun cases, the following tests failed both before and after the patch:

- generic/363: fsx reported READ BAD DATA
- generic/429: encrypted dentry/key revalidation behavior did not match expectations
- generic/440: encrypted name/key cache consistency behavior did not match expectations
- generic/580: encrypted files became inaccessible after key removal/re-addition
- generic/593: filesystem-level/provisioning-key encryption flow failed
- generic/595: encrypted file remained inaccessible after key eviction/re-addition
- generic/631: overlayfs-on-Ceph scratch mount path failed

generic/650 and generic/777 could not be completed reliably in my local environment because 
they caused the terminal to become unresponsive, so I do not have a meaningful 
before/after comparison for them.

So from this comparison, I do not have evidence that the above failures were introduced 
by the RCU patch.

Kernel(net) commit tested before the patch:
  6d27e29a90bc6a717b97c6ddcd866db7bd8e4adc

xfstests commit:
  ffc8bad17e5b2f56e48dbac43f7c5ae8ac368fe5

Best regards,
Yong
> Thanks,
> Slava.

