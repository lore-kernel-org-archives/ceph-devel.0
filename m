From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Question about writeback performance and content address obejct
 for deduplication
Date: Tue, 7 Feb 2017 20:03:37 +0900
Message-ID: <CAFNt83Z1+n+uEGo_58DmrXYxfNQe_GzG4iTYtBdDnt6PEYvdHQ@mail.gmail.com>
References: <CAFNt83bds6KzCnMvxyN=vPu7dg_NyX3cHdZwgmhiQqKt4B314A@mail.gmail.com>
 <alpine.DEB.2.11.1701311420210.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34501 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdBGLDi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 06:03:38 -0500
Received: by mail-ua0-f178.google.com with SMTP id 35so81761864uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2017 03:03:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1701311420210.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sweil@redhat.com, =?UTF-8?B?7Jik66qF7JuQ?= <omwmw@sk.com>

Hi sage.

I uploaded the document which describe my overall appoach.
please see it and give me feedback.
slide: https://www.slideshare.net/secret/JZcy3yYEDIHPyg

thanks


2017-01-31 23:24 GMT+09:00 Sage Weil <sage@newdream.net>:
> On Thu, 26 Jan 2017, myoungwon oh wrote:
>> I have two questions.
>>
>> 1. I would like to ask about CAS location. current our implementation store
>> content address object in storage tier.However, If we store the CAO in the
>> cache tier, we can get a performance advantage. Do you think we can create
>> CAO in cachetier? or create a separate storage pool for CAS?
>
> It depends on the design.  If the you are naming the objects at the
> librados client side, then you can use the rados cluster itself
> unmodified (with or without a cache tier).  This is roughly how I have
> anticipated implementing the CAS storage portion.  If you are doing the
> chunking hashing and within the OSD itself, then you can't do the CAS
> at the first tier because the requests won't be directed at the right OSD.
>
>> 2. The results below are performance result for our current implementation.
>> experiment setup:
>> PROXY (inline dedup), WRITEBACK (lazy dedup, target_max_bytes: 50MB),
>> ORIGINAL(without dedup feature and cache tier),
>> fio, 512K block, seq. I/O, single thread
>>
>> One thing to note is that the writeback case is slower than the proxy.
>> We think there are three problems as follows.
>>
>> A. The current implementation creates a fingerprint by reading the entire
>> object when flushing. Therefore, there is a problem that read and write are
>> mixed.
>
> I expect this is a small factor compared to the fact that in writeback
> mode you have to *write* to the cache tier, which is 3x replicated,
> whereas in proxy mode those writes don't happen at all.
>
>> B. When client request read, the promote_object function reads the object
>> and writes it back to the cache tier, which also causes a mix of read and
>> write.
>
> This can be mitigated by setting the min_read_recency_for_promote pool
> property to something >1.  Then reads will be proxied unless the object
> appears to be hot (because it has been touched over multiple
> hitset intervals).
>
>> C. When flushing, the unchanged part is rewritten because flush operation
>> perform per-object based.
>
> Yes.
>
> Is there a description of your overall approach somewhere?
>
> sage
>
>
>>
>> Do I have something wrong? or Could you give me a suggestion to improve
>> performance?
>>
>>
>> a. Write performance (KB/s)
>>
>> dedup_ratio  0 20 40 60 80 100
>>
>> PROXY  45586 47804 51120 52844 56167 55302
>>
>> WRITEBACK  13151 11078 9531 13010 9518 8319
>>
>> ORIGINAL  121209 124786 122140 121195 122540 132363
>>
>>
>> b. Read performance (KB/s)
>>
>> dedup_ratio  0 20 40 60 80 100
>>
>> PROXY  112231 118994 118070 120071 117884 132748
>>
>> WRITEBACK  34040 29109 19104 26677 24756 21695
>>
>> ORIGINAL  285482 284398 278063 277989 271793 285094
>>
>>
>> thanks,
>> Myoungwon Oh
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
