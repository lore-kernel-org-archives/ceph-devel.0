From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: BUG: kvm crashing in void librbd::AioCompletion::complete_request
Date: Sun, 04 Nov 2012 20:17:46 +0100
Message-ID: <5096BF5A.1090803@profihost.ag>
References: <50967583.8000109@profihost.ag> <alpine.DEB.2.00.1211040604530.30792@cobra.newdream.net> <509676B9.1040505@profihost.ag> <alpine.DEB.2.00.1211040611470.30792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54290 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2KDTRt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 14:17:49 -0500
In-Reply-To: <alpine.DEB.2.00.1211040611470.30792@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 04.11.2012 15:12, schrieb Sage Weil:
> On Sun, 4 Nov 2012, Stefan Priebe wrote:
>> Can i merge wip-rbd-read into master?
>
> Yeah.  I'm going to do a bit more testing first before I do it, but it
> should apply cleanly.  Hopefully later today.

Any other branches to merge locally while benchmarking / testing?

Greets,
Stefan
