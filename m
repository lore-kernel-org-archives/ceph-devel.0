From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 11:00:07 -0500
Message-ID: <4FEB2E07.6010402@inktank.com>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB2310.9080801@profihost.ag> <CAPYLRzj916kW=KLy3dMTVPJRoNtPMP_Ejz+YAxRUJ5jZc+HeMg@mail.gmail.com> <4FEB26A7.4070507@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:32891 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860Ab2F0QAZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 12:00:25 -0400
Received: by qcmt36 with SMTP id t36so841447qcm.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jun 2012 09:00:25 -0700 (PDT)
In-Reply-To: <4FEB26A7.4070507@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/27/2012 10:28 AM, Stefan Priebe wrote:
>  > Am 27.06.2012 17:21, schrieb Gregory Farnum:
>>
>>
>> Well, as we said, 1GHz/OSD was a WAG (wild-ass guess), but 3.6GHz+/OSD
>> is farther outside of that range than I would have expected. It might
>> just be a consequence of using SSDs, since they can sustain so much more
>> throughput.
>
> Sure it was just so much away from 1Ghz that i wanted to ask.
>
>> What is the cluster doing when you see those CPU usage numbers?
> random write I/O from one KVM. 14k I/Ops with random 4k writes.
>
> Stefan

I think I was seeing about 80-85% CPU utilization with 5 SSD OSDs on our 
6-core AMD nodes, but I was just doing sequential writes with rados bench.

Mark
