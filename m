From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Share]Performance tunning on Ceph FileStore with SSD backend
Date: Tue, 27 May 2014 12:46:23 +0800
Message-ID: <CACJqLybjJ5c2aWf3_5Wt6AhS-jrcbDDWBCDDBCrDK=GL_oEg-w@mail.gmail.com>
References: <CACJqLyb+D5n74OyjP4sRG2=G083GQ3BzEUt4i8iAdw6nEBfRJg@mail.gmail.com>
	<5383A410.6010002@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43325 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbaE0EqZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 May 2014 00:46:25 -0400
Received: by mail-wg0-f49.google.com with SMTP id m15so8696093wgh.8
        for <ceph-devel@vger.kernel.org>; Mon, 26 May 2014 21:46:23 -0700 (PDT)
In-Reply-To: <5383A410.6010002@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 27, 2014 at 4:29 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi Haomai,
>
> regarding the FDCache problems you're seeing. Isn't this branch interesting
> for you? Have you ever tested it?
>
> http://lists.ceph.com/pipermail/ceph-commit-ceph.com/2014-January/007399.html
>

I don't test performance improvements with this branch.

> Greets,
> Stefan
>
> Am 09.04.2014 12:05, schrieb Haomai Wang:
>
>> Hi all,
>>
>> I would like to share some ideas about how to improve performance on
>> ceph with SSD. Not much preciseness.
>>
>> Our ssd is 500GB and each OSD own a SSD(journal is on the same SSD).
>> ceph version is 0.67.5(Dumping)
>>
>> At first, we find three bottleneck on filestore:
>> 1. fdcache_lock(changed in Firely release)
>> 2. lfn_find in omap_* methods
>> 3. DBObjectMap header
>>
>> According to my understanding and the docs in
>>
>> ObjectStore.h(https://github.com/ceph/ceph/blob/master/src/os/ObjectStore.h),
>> I simply remove lfn_find in omap_* and fdcache_lock. I'm not fully
>> sure the correctness of this change, but it works well still now.
>>
>> DBObjectMap header patch is on the pull request queue and may be
>> merged in the next feature merge window.
>>
>> With things above done, we get much performance improvement in disk
>> util and benchmark results(3x-4x).
>>
>> Next, we find fdcache size become the main bottleneck. For example, if
>> hot data range is 100GB, we need 25000(100GB/4MB) fd to cache. If hot
>> data range is 1TB, we need 250000(1000GB/4MB) fd to cache. With
>> increase "filestore_fd_cache_size", the cost of lookup(FDCache) and
>> cache miss is expensive and can't be afford. The implementation of
>> FDCache isn't O(1). So we only can get high performance on fdcache hit
>> range(maybe 100GB with 10240 fdcache size) and more data exceed the
>> size of fdcaceh will be disaster. If you want to cache more fd(102400
>> fdcache size), the implementation of FDCache will bring on extra CPU
>> cost(can't be ignore) for each op.
>>
>> Because of the capacity of SSD(several hundreds GB), we try to
>> increase the size of rbd object(16MB) so less fd cache is needed. As
>> for FDCache implementation, we simply discard SimpleLRU but introduce
>> RandomCache. Now we can set much larger fdcache size(near cache all
>> fd) with little overload.
>>
>> With these, we achieve 3x-4x performance improvements on filestore with
>> SSD.
>>
>> Maybe it exists something I missed or something wrong, hope can
>> correct me. I hope it can help to improve FileStore on SSD and push
>> into master branch.
>>
>



-- 
Best Regards,

Wheat
