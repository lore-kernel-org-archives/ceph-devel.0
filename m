From: Mark Nelson <mnelson@redhat.com>
Subject: Re: =?UTF-8?B?5Zue5aSNOiBSZTog5Zue5aSNOiBSZTog5Zue5aSNOiBSZTogTmU=?=
 =?UTF-8?B?d1N0b3JlIHBlcmZvcm1hbmNlIGFuYWx5c2lz?=
Date: Tue, 21 Apr 2015 18:59:08 -0500
Message-ID: <5536E44C.20302@redhat.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC021D081C@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504200826500.18547@cobra.newdream.net> <oqwenulom2umn8f37cg5gvgh.1429545030301@email.android.com> <alpine.DEB.2.00.1504200945000.18547@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC021D1018@shsmsx102.ccr.corp.intel.com> <CACJqLybRGUEXqoME_fQpNHtbYG73En2AnhgMsZ+WEN+EYP3xqw@mail.gmail.com>, <alpine.DEB.2.00.1504211246450.18547@cobra.ne <alpine.DEB.2.00.1504211627110.18547@cobra.newdream.net> <yg97r6x6t1ff48fm6yxbycg8.1429659769859@email.android.com> <alpine.DEB.2.00.1504211654560.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964865AbbDUX7Q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Apr 2015 19:59:16 -0400
In-Reply-To: <alpine.DEB.2.00.1504211654560.18547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "Duan, Jiangang" <jiangang.duan@intel.com>, "Zhang, Jian" <jian.zhang@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/21/2015 06:57 PM, Sage Weil wrote:
> On Tue, 21 Apr 2015, Chen, Xiaoxi wrote:
>> ---- Sage Weil?? ----
>>
>>> On Tue, 21 Apr 2015, Chen, Xiaoxi wrote:
>>>> Haomai is right in theory, but I am not sure whether all
>>>> user(mon,filestore,kvstore) of submit_transaction API clearly holding
>>>> the expectation that their data is not persistent and may lost in
>>>> failure.  So in rocksdb now the sync is default to true even in
>>>> submit_transaction(and this option make the two api exactly the same).
>>>> Maybe we need to rename the api to
>>>> submit_transaction_persistent/nonpersistent to better discribe the
>>>> behavior?
>>>
>>> Let's audit them, then.. I think they are right, but we may as well
>>> confirm!
>>>
>>> Again, FileStore is the odd one out here because it is relying on the
>>> syncfs(2) at commit time for everything.
>>>
>>
>> Yes, so maybe we dont need to expose the option to user, we can decide
>> whether to.sync in code logic.
>
> Yeah, I think it'll reduce confusion too.  I suggest we do a pull request
> against master that does this... let me know if you want to do it,
> otherwise I will!
>
>> I remember some folks in out team tried to move KVDB to a partition on
>> SSD while leave other filestore data on HDD, in my memory it benifit
>> performance.  This deployment is problematic with kv_sync=false.  gWill
>> check the data first and then we can evaluate whethe we want to support
>> this kind of deployment.
>
> We could detect this by doing a stat(2) on the current/omap/ vs current/
> dirs and checking if it's a different file system.  If so, we can do the
> syncfs(2) on both dirs.  The btrfs case would probably not be practical,
> but we can error out in that case.  But yeah not sure how important it
> would be to support this since filestore doesn't use leveldb that
> heavily... and I'd prefer to limit our investment of time there if we can
> instead make newstore (or something else) better.

FWIW, the last time I tried putting leveldb on SSD didn't really help at 
all.  It's been a while so maybe that's changed, but newstore definitely 
seems like the way forward to me.

Mark
