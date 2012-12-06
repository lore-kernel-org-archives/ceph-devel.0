From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Thu, 06 Dec 2012 15:47:51 +0100
Message-ID: <50C0B017.7020003@profihost.ag>
References: <50BF1A43.4060605@profihost.ag> <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net> <BC8B71E3-1BE1-49ED-B578-34A0CBACAB98@profihost.ag> <alpine.DEB.2.00.1212051534530.14332@cobra.newdream.net> <50C0677B.4090400@profihost.ag> <alpine.DEB.2.00.1212060615100.13653@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45628 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423553Ab2LFOr7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Dec 2012 09:47:59 -0500
In-Reply-To: <alpine.DEB.2.00.1212060615100.13653@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

as it were crashing pretty often i had a few minutes where only 9 of 20 
OSDs were still alive i reverted back to 
3ace9a7c66c79847d215f4bd38f40ca8b07bab8e

Which works fine ;-)

Stefan

Am 06.12.2012 15:43, schrieb Sage Weil:
> On Thu, 6 Dec 2012, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>> here a new dump / crash:
>> https://www.dropbox.com/s/1qhg0dd0fv17q10/ceph-osd.54.log.gz
>
> Awesome, thanks!  I see the bug now.  Working out a fix.
>
> In the meantime, you can revert 85574a36226611ccf0fb7591fd275a2bdcca2bad
> and 528108485be7912069087822e5b7a1a2f1dd515e.
>
> sage

Stefan
