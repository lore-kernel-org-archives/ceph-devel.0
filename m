From: Mark Nelson <mnelson@redhat.com>
Subject: Re: BlueStore in-memory Onode footprint
Date: Fri, 16 Dec 2016 09:20:40 -0600
Message-ID: <dd3aab0d-3ac8-63cb-309c-3848153e23e2@redhat.com>
References: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760229AbcLPP3Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Dec 2016 10:29:24 -0500
In-Reply-To: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 12/16/2016 09:04 AM, Igor Fedotov wrote:
> Hey All!
>
> Recently I realized that I'm unable to fit all my onodes ( 32768
> objects/4Mb each/4K alloc unit/no csum) in 15G RAM cache.
>
> Hence decided to estimate Onode in-memory size.
>
> At first I filled 4Mb object with a single 4M write - mempools indicate
> ~5K mem usage for total onode metadata. Good enough.
>
> Secondly I refill that object with 4K writes. Resulting memusage =
> 574K!!! Onode itself 704 bytes in 1 object.  And 4120 other metadata
> items occupies all other space.
>
> Then I removed SharedBlob from mempools. Resulting mem usage = 355K. The
> same Onode size. And 3096 other metadata objects. Hence we had 1024
> SharedBlob instances thata took ~ 220K.
>
>
> And finally I removed Blob instances from measurements. Resulting mem
> usage = 99K. And 2072 other objects. Hence Blob instances take another
> ~250K
>
> Yeah, that's the worst case( actually csum enable will give even more
> mem use) but shouldn't we revisit some Onode internals due to such numbers?

Hrm, that's quite a bit higher than it was last time I looked.  Can you 
dump the hex for one of those during your run?

>
>
> Thanks,
>
> Igor
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
