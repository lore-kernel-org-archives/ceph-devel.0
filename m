From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Ceph scale testing
Date: Thu, 21 Jan 2016 17:21:29 +0800
Message-ID: <CACJqLyYfWHUPhWAUocDUv8SqjgG8HQxRBp6LPEYb2nbJTnsAjA@mail.gmail.com>
References: <CO1PR02MB208D28221FDCE8CDB8D3802F4C30@CO1PR02MB208.namprd02.prod.outlook.com>
	<CADr68Wa-CUThHr_N_J+jEcCYK_Vo2jH=bZpLreZNuPJGcRk4Yw@mail.gmail.com>
	<CO1PR02MB2080DFD074B56344F3BD4ECF4C30@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35930 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbcAUJVa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jan 2016 04:21:30 -0500
Received: by mail-io0-f181.google.com with SMTP id g73so49169307ioe.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jan 2016 01:21:30 -0800 (PST)
In-Reply-To: <CO1PR02MB2080DFD074B56344F3BD4ECF4C30@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Jens Rosenboom <j.rosenboom@x-ion.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 21, 2016 at 4:20 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> All the numbers other than the last write numbers are from Hammer...Last one with jewel + an outstanding write path patch..
> We used jemalloc based hammer + we have some tuning specific to our flash and environment..

So you mean that the improved performance from Jewel is caused by
filestore write path optimization(as listed in pr)?

BTW, I just see your IF100 in customer env, congratulations!

http://www.tiikoni.com/tis/view/?id=dcb1d53

>
> -----Original Message-----
> From: Jens Rosenboom [mailto:j.rosenboom@x-ion.de]
> Sent: Thursday, January 21, 2016 12:13 AM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Ceph scale testing
>
> 2016-01-21 5:03 GMT+01:00 Somnath Roy <Somnath.Roy@sandisk.com>:
>> Hi,
>> Here is the copy of the ppt I presented in today's performance meeting..
>>
>> https://docs.google.com/presentation/d/1j4Lcb9fx0OY7eQlQ_iUI6TPVJ6t_or
>> ZWKJyhz0S_3ic/edit?usp=sharing
>
> Wow, these number look pretty impressive. Did you use some additional patches in your Jewel build? In my own testing I'm seeing only marginal improvements in plain Jewel vs. Hammer.
>
> To have a fair comparison, you should also use the same QD for both Hammer and Jewel.
>
> Finally, the avg latency for 4k ops isn't that significant, could you also add numbers for max latency or 99.xx percentile?

-- 
Best Regards,

Wheat
