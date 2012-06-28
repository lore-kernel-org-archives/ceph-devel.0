From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 15:21:18 +0200
Message-ID: <4FEC5A4E.1090209@profihost.ag>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB2310.9080801@profihost.ag> <CAPYLRzj916kW=KLy3dMTVPJRoNtPMP_Ejz+YAxRUJ5jZc+HeMg@mail.gmail.com> <4FEB26A7.4070507@profihost.ag> <4FEB2E07.6010402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50917 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab2F1NVX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 09:21:23 -0400
In-Reply-To: <4FEB2E07.6010402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 27.06.2012 18:00, schrieb Mark Nelson:
> On 06/27/2012 10:28 AM, Stefan Priebe wrote:
>>> Well, as we said, 1GHz/OSD was a WAG (wild-ass guess), but 3.6GHz+/OSD
>>> is farther outside of that range than I would have expected. It might
>>> just be a consequence of using SSDs, since they can sustain so much more
>>> throughput.
>>
>> Sure it was just so much away from 1Ghz that i wanted to ask.
>>
>>> What is the cluster doing when you see those CPU usage numbers?
>> random write I/O from one KVM. 14k I/Ops with random 4k writes.
>>
>> Stefan
>
> I think I was seeing about 80-85% CPU utilization with 5 SSD OSDs on our
> 6-core AMD nodes, but I was just doing sequential writes with rados bench.

While doing sequential writes i see pretty low CPU usage. Random writes 
is the problem.

Stefan
