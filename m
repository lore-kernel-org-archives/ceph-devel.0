From: David Zafman <dzafman@redhat.com>
Subject: Re: [ceph-users] O_DIRECT on deep-scrub read
Date: Wed, 7 Oct 2015 12:51:57 -0700
Message-ID: <561577DD.1050107@redhat.com>
References: <56150598.1080604@sadziu.pl>
 <alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54702 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbbJGTwA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Oct 2015 15:52:00 -0400
In-Reply-To: <alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, =?UTF-8?Q?Pawe=c5=82_Sadowski?= <ceph@sadziu.pl>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel@vger.kernel.org


There would be a benefit to doing fadvise POSIX_FADV_DONTNEED after 
deep-scrub reads for objects not recently accessed by clients.

I see the NewStore objectstore sometimes using the O_DIRECT  flag for 
writes.  This concerns me because the open(2) man pages says:

"Applications should avoid mixing O_DIRECT and normal I/O to the same 
file, and especially to overlapping byte regions in the same file.  Even 
when the filesystem correctly handles the coherency issues in this 
situation, overall I/O throughput is likely to be slower than using 
either mode alone."

David

On 10/7/15 7:50 AM, Sage Weil wrote:
> It's not, but it would not be ahrd to do this.  There are fadvise-style
> hints being passed down that could trigger O_DIRECT reads in this case.
> That may not be the best choice, though--it won't use data that happens
> to be in cache and it'll also throw it out..
>
> On Wed, 7 Oct 2015, Pawe? Sadowski wrote:
>
>> Hi,
>>
>> Can anyone tell if deep scrub is done using O_DIRECT flag or not? I'm
>> not able to verify that in source code.
>>
>> If not would it be possible to add such feature (maybe config option) to
>> help keeping Linux page cache in better shape?
>>
>> Thanks,
>>
>> -- 
>> PS
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

