From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 20:47:08 +0100
Message-ID: <50CB823C.90501@profihost.ag>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag> <alpine.DEB.2.00.1212141140590.22306@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55675 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab2LNTrI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 14:47:08 -0500
In-Reply-To: <alpine.DEB.2.00.1212141140590.22306@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

this was just an idea and i need to fix MY uuid problem. But then the 
crash is still a problem of ceph. Have you looked into my log?
Am 14.12.2012 20:42, schrieb Sage Weil:
> On Fri, 14 Dec 2012, Stefan Priebe wrote:
>> One more IMPORTANT note. This might happen due to the fact that a disk was
>> missing (disk failure) afte the reboot.
>>
>> fstab and mountpoint are working with UUIDs so they match but the journal
>> block device:
>> osd journal  = /dev/sde1
>>
>> didn't match anymore - as the numbers got renumber due to the failed disk. Is
>> there a way to use some kind of UUIDs here too for journal?
>
> I think others have addressed the uuid question, but one note:
>
> The ceph-osd process has an internal uuid/fingerprint on the journal and
> data dir, and will refuse to start if they don't match.

Stefan
