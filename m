From: Dan Mick <dan.mick@inktank.com>
Subject: Re: reproducable osd crash
Date: Mon, 25 Jun 2012 14:01:51 -0700
Message-ID: <4FE8D1BF.3090108@inktank.com>
References: <4FE319DF.3020106@profihost.ag> <B37E1F82-25E3-4ED4-B3E9-59BC2EC44CB6@profihost.ag> <4FE4F806.1080501@inktank.com> <CA+4uBUb9WVk7-htq_qBNF-T_8i4-3KEsJePhTYoAHXuXfyOuKA@mail.gmail.com> <7855C271-3A73-4090-9F5F-2F4FB12C4E73@profihost.ag> <B8C4CA17-911D-4BA4-BE1D-4E81168A4212@inktank.com> <4FE89DB0.1080606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43090 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab2FYVBz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 17:01:55 -0400
Received: by pbbrp8 with SMTP id rp8so7070553pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 14:01:55 -0700 (PDT)
In-Reply-To: <4FE89DB0.1080606@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sam Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 06/25/2012 10:19 AM, Stefan Priebe wrote:
>
>> I've yet to make the core match the binary.
>
> I'm sorry. Is there a way to provide more / better information.
>
> Stefan

Well, I was still looking at the possibility that it was my problem, but 
here are versions:

- the osd binary you sent is version 0.47.2-521-g88c7629, corresponding 
to sha1 5ce8d71fb6d2e3065c8b274e196c26288c7a93d0

- the corefile is from version 0.47.3 (sha1 
c467d9d1b2eac9d3d4706b8e044979aa63b009f8)

Using any combination of your binary or my build of the binary from 
either version does not result in a matching stack backtrace from gdb.

If you can get a corefile and binary that match and send them again, 
perhaps we can get further; I'm not sure why what you sent didn't seem 
to match.  Are you running the same version of Ceph on each host?

