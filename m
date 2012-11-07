From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: syncfs slower than without syncfs
Date: Wed, 07 Nov 2012 09:04:00 -0600
Message-ID: <509A7860.6020805@inktank.com>
References: <509A2CE6.1010100@profihost.ag> <509A62A6.5070104@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:57542 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2KGPD5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 10:03:57 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so1145185iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 07:03:56 -0800 (PST)
In-Reply-To: <509A62A6.5070104@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Whew, glad you found the problem Stefan!  I was starting to wonder what 
was going on. :)  Do you mind filling a bug about the control dependencies?

Mark

On 11/07/2012 07:31 AM, Stefan Priebe - Profihost AG wrote:
> Am 07.11.2012 10:41, schrieb Stefan Priebe - Profihost AG:
>> Hello list,
>>
>> syncfs is much slower than without syncfs to me.
>>
>> If i compile latest ceph master with wip-rbd-read:
>>
>> with syncfs:
>> rand 4K:
>>    write: io=1133MB, bw=12853KB/s, iops=3213, runt= 90277msec
>>    read : io=1239MB, bw=14046KB/s, iops=3511, runt= 90325msec
>> seq 4M:
>>    write: io=37560MB, bw=423874KB/s, iops=103, runt= 90738msec
>>    read : io=103852MB, bw=1151MB/s, iops=287, runt= 90237msec
>>
>> without syncfs:
>> rand 4K:
>>    write: io=3733MB, bw=42459KB/s, iops=10614, runt= 90039msec
>>    read : io=6018MB, bw=68446KB/s, iops=17111, runt= 90038msec
>> seq 4M:
>>    write: io=51204MB, bw=577328KB/s, iops=140, runt= 90820msec
>>    read : io=150320MB, bw=1666MB/s, iops=416, runt= 90228msec
>>
>> I thought syncfs should boost the performance.
>
> Fixed - my chroot env with glibc syncfs support didn't had the libcrypto
> installed and it isn't in the control dependencies. Now with libcrypto i
> get the same results as without syncfs.
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

