From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] Initial performance cluster SimpleMessenger vs
 AsyncMessenger results
Date: Tue, 13 Oct 2015 10:56:47 +0800
Message-ID: <CACJqLyY+11d9ENxnMeNSTnJ-u-CAKbEED79GAjgJU7=nAAZ=9A@mail.gmail.com>
References: <561BE4E3.7050404@redhat.com>
	<CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36019 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbJMC4s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 22:56:48 -0400
Received: by vkgc187 with SMTP id c187so2551759vkg.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 19:56:47 -0700 (PDT)
In-Reply-To: <CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

resend

On Tue, Oct 13, 2015 at 10:56 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> COOL
>
> Interesting that async messenger will consume more memory than simple, in my
> mind I always think async should use less memory. I will give a look at this
>
> On Tue, Oct 13, 2015 at 12:50 AM, Mark Nelson <mnelson@redhat.com> wrote:
>>
>> Hi Guy,
>>
>> Given all of the recent data on how different memory allocator
>> configurations improve SimpleMessenger performance (and the effect of memory
>> allocators and transparent hugepages on RSS memory usage), I thought I'd run
>> some tests looking how AsyncMessenger does in comparison.  We spoke about
>> these a bit at the last performance meeting but here's the full write up.
>> The rough conclusion as of right now appears to be:
>>
>> 1) AsyncMessenger performance is not dependent on the memory allocator
>> like with SimpleMessenger.
>>
>> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB (ie
>> default) thread cache.
>>
>> 3) AsyncMessenger is consistently faster than SimpleMessenger for 128K
>> random reads.
>>
>> 4) AsyncMessenger is sometimes slower than SimpleMessenger when memory
>> allocator optimizations are used.
>>
>> 5) AsyncMessenger currently uses far more RSS memory than SimpleMessenger.
>>
>> Here's a link to the paper:
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view
>>
>> Mark
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
>
> --
>
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
