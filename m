From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: endless flying slow requests
Date: Wed, 28 Nov 2012 08:23:14 +0100
Message-ID: <50B5BBE2.9010201@profihost.ag>
References: <50A3607A.6050209@profihost.ag> <alpine.DEB.2.00.1211140656590.6512@cobra.newdream.net> <50A4A351.8020506@profihost.ag> <alpine.DEB.2.00.1211150657110.4011@cobra.newdream.net> <alpine.DEB.2.00.1211271751290.23594@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59598 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab2K1HXU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 02:23:20 -0500
In-Reply-To: <alpine.DEB.2.00.1211271751290.23594@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 28.11.2012 02:51, schrieb Sage Weil:
> Hi Stefan,
>
>>> Yes it is. So i have to specify admin socket at the KVM host?
>>
>> Right.  IIRC the disk line is a ; (or \;) separated list of key/value
>> pairs.
>>
>>> How do i query the admin socket for requests?
>>
>> ceph --admin-daemon /path/to/socket help
>> ceph --admin-daemon /path/to/socket objecter_dump     (i think)
>
> Were you able to reproduce this?

No not right now. But i've saved your answers and will make the tests 
when i see this again.

Right now i'm just seeing extremely slow OSD recovery.

Stefan
