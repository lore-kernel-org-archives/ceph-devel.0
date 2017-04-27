From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Performance Measurement
Date: Thu, 27 Apr 2017 09:38:45 -0500
Message-ID: <f1ec7ff5-ed06-3736-eba5-4b96bd450311@redhat.com>
References: <alpine.LSU.2.20.1704270603070.1886@ancalagon.suse.de>
 <95a3c7e5-6f56-4254-895d-a89b3f0360f2@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162133AbdD0Oir (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 27 Apr 2017 10:38:47 -0400
In-Reply-To: <95a3c7e5-6f56-4254-895d-a89b3f0360f2@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>, Jesse Williamson <jwilliamson@suse.de>, Squid Cybernetic <ceph-devel@vger.kernel.org>

On 04/27/2017 08:11 AM, Piotr Dałek wrote:
> On 04/27/2017 03:05 PM, Jesse Williamson wrote:
>>
>> Hi folks,
>>
>> Are there well-known benchmark suites that come with or are usually used
>> with Ceph? A magical load generator powered by unicorns and fuzzy
>> bunnies?
>> If such magic exists, where would I find it?
>
> CBT - https://github.com/ceph/cbt
> FIO (RBD engine)
> "rados bench" (CLI command)
>

For swift object benchmarks, I've started using Mark Seger's getput, 
though I have a custom branch that is necessary for it to work 
accurately with the cbt getput module:

https://github.com/markhpc/getput/tree/wip-fix-timing
