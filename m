From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Ubuntu 12.04.1 + xfs + syncfs is still not our friend
Date: Tue, 06 Nov 2012 15:18:42 -0800
Message-ID: <50999AD2.8030507@inktank.com>
References: <50993755.8060800@filoo.de> <50993B61.3090500@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50376 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab2KFXSq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 18:18:46 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so749859pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Nov 2012 15:18:46 -0800 (PST)
In-Reply-To: <50993B61.3090500@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

Resolution: installing the packages built for precise, rather than 
squeeze, got versions that use syncfs.

On 11/06/2012 08:31 AM, Oliver Francke wrote:
> In answer to myself,
>
> On 11/06/2012 05:14 PM, Oliver Francke wrote:
>> Hi *,
>>
>> anybody out there who's in Ubuntu 12.04.1/ in connection with libc +
>> xfs + syncfs?
>
> ii  libc6                            2.15-0ubuntu10.3
>
> but:
> apt-cache show...
> .
> .
> Provides: glibc-2.13-1
> .
> .
>
> playing with numbers, I think. But make clear, why syncfs-call is not in
> :-\
>
> ... search continues...
>
>>
>> We bit the bullet and reinstalled two new nodes from debian to precise
>> in favour of possible performance increase?!
>>
>> *sigh*, still getting:
>>
>> 2012-11-06 17:05:51.863921 7f5cc52e3780  0 filestore(/data/osd6-3)
>> mount syncfs(2) syscall not support by glibc
>> 2012-11-06 17:05:51.863925 7f5cc52e3780  0 filestore(/data/osd6-3)
>> mount no syncfs(2), must use sync(2).
>>
>> as a show-stopper.
>>
>> That's with 3.2.* and 3.6.6 kernel. Should be new enough. And
>> ceph-0.48.2 ( eu.ceph.com mirror was installing 0.48.1.. though *ops*
>> ;) )
>>
>> But both should be capable of this system-call?!
>>
>> We've been so very near... but now clueless, please sched some light
>> in 8-)
>>
>> ( I hope this is not a very obvious human RTFM error ;) )
>>
>> And so I'm writing, should one enable directio + aio, as we're having
>> the journals on a SSD-partition?
>>
>> Kind regards,
>>
>> Oliver.
>>
>
>
