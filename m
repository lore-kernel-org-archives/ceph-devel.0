From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Thu, 08 Nov 2012 09:01:51 -0600
Message-ID: <509BC95F.5090904@inktank.com>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47852 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2KHPBq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:01:46 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so4273394iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 07:01:45 -0800 (PST)
In-Reply-To: <509BC878.3090804@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

You might want to try running sysprof or perf while the OSDs are running 
during the tests and see where CPU time is being spent.  Also, how are 
you determining how much CPU usage is being used?

Mark

On 11/08/2012 08:58 AM, Stefan Priebe - Profihost AG wrote:
> Is there any way to find out why a ceph-osd process takes around 10
> times more load on rand 4k writes than on 4k reads?
>
> Stefan
>
> Am 07.11.2012 21:41, schrieb Stefan Priebe:
>> Hello list,
>>
>> whiling benchmarking i was wondering, why the ceph-osd load is so
>> extreme high while having random 4k write i/o.
>>
>> Here an example while benchmarking:
>>
>> random 4k write: 16.000 iop/s 180% CPU Load in top from EACH ceph-osd
>> process
>>
>> random 4k read: 16.000 iop/s 19% CPU Load in top from EACH ceph-osd
>> process
>>
>> seq 4M write: 800MB/s 14% CPU Load in top from EACH ceph-osd process
>>
>> seq 4M read: 1600MB/s 9% CPU Load in top from EACH ceph-osd process
>>
>> I can't understand why in this single case the load is so EXTREMELY high.
>>
>> Greets
>> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

