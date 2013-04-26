From: Mike Dawson <mike.dawson@scholarstack.com>
Subject: Re: final mon issues
Date: Fri, 26 Apr 2013 16:18:40 -0400
Message-ID: <517AE120.4010801@scholarstack.com>
References: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net> <517AE005.2030608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:55304 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab3DZUSk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 16:18:40 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so5529391iec.9
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 13:18:40 -0700 (PDT)
In-Reply-To: <517AE005.2030608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>
Cc: greg@inktank.com, ceph-devel@vger.kernel.org

Agreed. I can confirm ceph version 0.60-669-ga2a23cc 
(a2a23ccd959f6e7ebe1533b27e7320902624523b) fixes the tcmalloc issue.

root@xxx:~# ceph -m 10.1.0.67 heap stats
mon.btcmalloc heap stats:------------------------------------------------
MALLOC:       25694552 (   24.5 MiB) Bytes in use by application
MALLOC: +     53272576 (   50.8 MiB) Bytes in page heap freelist
MALLOC: +      1756920 (    1.7 MiB) Bytes in central cache freelist
MALLOC: +      5027328 (    4.8 MiB) Bytes in transfer cache freelist
MALLOC: +      8341936 (    8.0 MiB) Bytes in thread cache freelists
MALLOC: +      1372312 (    1.3 MiB) Bytes in malloc metadata
MALLOC:   ------------
MALLOC: =     95465624 (   91.0 MiB) Actual memory used (physical + swap)
MALLOC: +      7954432 (    7.6 MiB) Bytes released to OS (aka unmapped)
MALLOC:   ------------
MALLOC: =    103420056 (   98.6 MiB) Virtual address space used
MALLOC:
MALLOC:           3760              Spans in use
MALLOC:             34              Thread heaps in use
MALLOC:           8192              Tcmalloc page size
------------------------------------------------
Call ReleaseFreeMemory() to release freelist memory to the OS (via 
madvise()).
Bytes released to the


- Mike


On 4/26/2013 4:13 PM, Mark Nelson wrote:
> On 04/26/2013 02:43 PM, Sage Weil wrote:
>> I've merged the double-forward fix.  I still have one remaining problem
>> that I can reproduce with my tests which looks like an overlap of mon
>> overload forwarded message priorities; I'm testing two possible fixes to
>> see which are necessary to resolve it.
>>
>> The memory issues with people using the gitbuilder appear to be because
>> our gitbuilders weren't linking in tcmalloc.  The latest 'next' build
>> *does* link it now, so if you are one of those people, please re-test!
>>
>> I don't think either of those problems is related to the sync issues Mike
>> is seeing, though.  I believe that is the final outstanding issue...?
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> fwiw, I'm seeing consistently lower mon usage now.  1-2GB instead of
> 5-14GB during performance tests.
>
> Mark
