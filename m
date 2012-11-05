From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: BUG: kvm crashing in void librbd::AioCompletion::complete_request
Date: Mon, 05 Nov 2012 21:43:05 +0100
Message-ID: <509824D9.60503@profihost.ag>
References: <50967583.8000109@profihost.ag> <alpine.DEB.2.00.1211040604530.30792@cobra.newdream.net> <509676B9.1040505@profihost.ag> <alpine.DEB.2.00.1211040611470.30792@cobra.newdream.net> <50981480.4050300@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41476 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab2KEUnI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 15:43:08 -0500
In-Reply-To: <50981480.4050300@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 05.11.2012 20:33, schrieb Stefan Priebe:
> Am 04.11.2012 15:12, schrieb Sage Weil:
>> On Sun, 4 Nov 2012, Stefan Priebe wrote:
>>> Can i merge wip-rbd-read into master?
>>
>> Yeah.  I'm going to do a bit more testing first before I do it, but it
>> should apply cleanly.  Hopefully later today.
>
> Thanks - seems to be fixed with wip-rbd-read but i have a memory leak now.
>
> kvm process raises and raises and raises which each new test around 5GB
> of memory. Should i write a new mail?

Most mem get used while doing a lot of small reads.

Stefan
