From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Fri, 07 Dec 2012 12:29:57 +0100
Message-ID: <50C1D335.9050706@profihost.ag>
References: <50BF1A43.4060605@profihost.ag> <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net> <BC8B71E3-1BE1-49ED-B578-34A0CBACAB98@profihost.ag> <alpine.DEB.2.00.1212051534530.14332@cobra.newdream.net> <50C0677B.4090400@profihost.ag> <alpine.DEB.2.00.1212061634520.22833@cobra.newdream.net> <50C19F8F.10902@profihost.ag> <alpine.DEB.2.00.1212070301330.17681@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36947 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab2LGLaH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 06:30:07 -0500
In-Reply-To: <alpine.DEB.2.00.1212070301330.17681@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Sage,

that would be great. Can you comeback then to me?

Greets
Stefan

Am 07.12.2012 12:02, schrieb Sage Weil:
> On Fri, 7 Dec 2012, Stefan Priebe - Profihost AG wrote:
>> Hi Sage,
>>
>> thanks for patching this. I'm not sure whether i can test this. I've moved my
>> systems to first productional tests and i can't create a downtime or loss of
>> data again ;-)
>>
>> How stable are these fixes?
>
> Only tested on my laptop.  :)
>
> I'll put them through our qa first, and make sure our stress tests
> can trigger the old failure.
>
> Thanks!
> sage
>
>
>>
>> Am 07.12.2012 01:38, schrieb Sage Weil:
>>> Hi Stefan,
>>>
>>> I've pushed a few patches to wip-filestore2 that simplify and fix this
>>> code.  Can you give it a go?
>>>
>>> Thanks!
>>> sage
>>
>> Greets,
>> Stefan
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
