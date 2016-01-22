From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Ceph scale testing
Date: Fri, 22 Jan 2016 10:33:31 +0800
Message-ID: <CAEYCsVJSOE765RjaSzQQfm5PdbUfFTYd8JiumXdO+EJxaecPGg@mail.gmail.com>
References: <CO1PR02MB208D28221FDCE8CDB8D3802F4C30@CO1PR02MB208.namprd02.prod.outlook.com>
	<CADr68Wa-CUThHr_N_J+jEcCYK_Vo2jH=bZpLreZNuPJGcRk4Yw@mail.gmail.com>
	<CO1PR02MB2080DFD074B56344F3BD4ECF4C30@CO1PR02MB208.namprd02.prod.outlook.com>
	<CACJqLyYfWHUPhWAUocDUv8SqjgG8HQxRBp6LPEYb2nbJTnsAjA@mail.gmail.com>
	<CO1PR02MB208F1B40F44717D4A49C3C7F4C30@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33020 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbcAVCdc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jan 2016 21:33:32 -0500
Received: by mail-yk0-f169.google.com with SMTP id k129so72207104yke.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jan 2016 18:33:32 -0800 (PST)
In-Reply-To: <CO1PR02MB208F1B40F44717D4A49C3C7F4C30@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Jens Rosenboom <j.rosenboom@x-ion.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Somnath,

I remember Xinxin@Intel could get 150K + RW iops for 2X replication,
with DCS3700 as OSD and P3700 as Journal on a 4 nodes Haswell
cluster(based on infernalis + tuning + jemalloc + rocksdb). And seems
your patch doesnt works well in this environment.

Maybe I am wrong but I kind to feel that the patch seems doesn't work
with all vendor's SSD, or maybe work better with capacity-wise ssd?

Xiaoxi





2016-01-22 1:26 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> Haomai,
> This is not improved performance from stock jewel but from stock Hammer.
> Not 100% because of my changes, but *mostly* I guess at least in my environment with SAS SSDs..There are some improvements went in post hammer that improved performance (20% or so) as well..
>
> Good to see IF100 deploying widely :-)
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Haomai Wang [mailto:haomaiwang@gmail.com]
> Sent: Thursday, January 21, 2016 1:21 AM
> To: Somnath Roy
> Cc: Jens Rosenboom; ceph-devel@vger.kernel.org
> Subject: Re: Ceph scale testing
>
> On Thu, Jan 21, 2016 at 4:20 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> All the numbers other than the last write numbers are from Hammer...Last one with jewel + an outstanding write path patch..
>> We used jemalloc based hammer + we have some tuning specific to our flash and environment..
>
> So you mean that the improved performance from Jewel is caused by filestore write path optimization(as listed in pr)?
>
> BTW, I just see your IF100 in customer env, congratulations!
>
> http://www.tiikoni.com/tis/view/?id=dcb1d53
>
>>
>> -----Original Message-----
>> From: Jens Rosenboom [mailto:j.rosenboom@x-ion.de]
>> Sent: Thursday, January 21, 2016 12:13 AM
>> To: Somnath Roy
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: Ceph scale testing
>>
>> 2016-01-21 5:03 GMT+01:00 Somnath Roy <Somnath.Roy@sandisk.com>:
>>> Hi,
>>> Here is the copy of the ppt I presented in today's performance meeting..
>>>
>>> https://docs.google.com/presentation/d/1j4Lcb9fx0OY7eQlQ_iUI6TPVJ6t_o
>>> r
>>> ZWKJyhz0S_3ic/edit?usp=sharing
>>
>> Wow, these number look pretty impressive. Did you use some additional patches in your Jewel build? In my own testing I'm seeing only marginal improvements in plain Jewel vs. Hammer.
>>
>> To have a fair comparison, you should also use the same QD for both Hammer and Jewel.
>>
>> Finally, the avg latency for 4k ops isn't that significant, could you also add numbers for max latency or 99.xx percentile?
>
> --
> Best Regards,
>
> Wheat
