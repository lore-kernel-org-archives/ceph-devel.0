From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 18:00:36 +0200
Message-ID: <4FEC7FA4.3010307@profihost.ag>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB2310.9080801@profihost.ag> <CAPYLRzj916kW=KLy3dMTVPJRoNtPMP_Ejz+YAxRUJ5jZc+HeMg@mail.gmail.com> <4FEB26A7.4070507@profihost.ag> <4FEB2E07.6010402@inktank.com> <4FEC5A4E.1090209@profihost.ag> <4FEC6C68.2030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49254 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab2F1QAi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 12:00:38 -0400
In-Reply-To: <4FEC6C68.2030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 28.06.2012 16:38, schrieb Mark Nelson:
> On 06/28/2012 08:21 AM, Stefan Priebe - Profihost AG wrote:
>> While doing sequential writes i see pretty low CPU usage. Random writes
>> is the problem.
>>
>> Stefan
>
> It would be interesting to see where all your CPU time is being spent.

Correct - what do you need?

> What benchmark are you using to do the random writes?
in KVM VM:
export DISK=/dev/vda

fio --filename=$DISK --direct=1 --rw=randwrite --bs=4k --size=200G 
--numjobs=50 --runtime=90 --group_reporting --name=file1

Stefan
