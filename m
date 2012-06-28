From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 09:38:32 -0500
Message-ID: <4FEC6C68.2030307@inktank.com>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB2310.9080801@profihost.ag> <CAPYLRzj916kW=KLy3dMTVPJRoNtPMP_Ejz+YAxRUJ5jZc+HeMg@mail.gmail.com> <4FEB26A7.4070507@profihost.ag> <4FEB2E07.6010402@inktank.com> <4FEC5A4E.1090209@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47765 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab2F1Oiw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 10:38:52 -0400
Received: by qcro28 with SMTP id o28so1161096qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 07:38:51 -0700 (PDT)
In-Reply-To: <4FEC5A4E.1090209@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/28/2012 08:21 AM, Stefan Priebe - Profihost AG wrote:
> Am 27.06.2012 18:00, schrieb Mark Nelson:
>> On 06/27/2012 10:28 AM, Stefan Priebe wrote:
>>>> Well, as we said, 1GHz/OSD was a WAG (wild-ass guess), but 3.6GHz+/OSD
>>>> is farther outside of that range than I would have expected. It might
>>>> just be a consequence of using SSDs, since they can sustain so much
>>>> more
>>>> throughput.
>>>
>>> Sure it was just so much away from 1Ghz that i wanted to ask.
>>>
>>>> What is the cluster doing when you see those CPU usage numbers?
>>> random write I/O from one KVM. 14k I/Ops with random 4k writes.
>>>
>>> Stefan
>>
>> I think I was seeing about 80-85% CPU utilization with 5 SSD OSDs on our
>> 6-core AMD nodes, but I was just doing sequential writes with rados
>> bench.
>
> While doing sequential writes i see pretty low CPU usage. Random writes
> is the problem.
>
> Stefan

It would be interesting to see where all your CPU time is being spent. 
What benchmark are you using to do the random writes?

Mark
