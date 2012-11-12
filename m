From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Disabling journal
Date: Mon, 12 Nov 2012 15:48:32 +0100
Message-ID: <50A10C40.9090909@profihost.ag>
References: <F905E0C9-46B6-4DD7-A57D-072CD4ADDFEE@profihost.ag> <alpine.DEB.2.00.1211110722100.28418@cobra.newdream.net> <50A019BE.9030002@profihost.ag> <alpine.DEB.2.00.1211120639540.28418@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35223 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2KLOse (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 09:48:34 -0500
In-Reply-To: <alpine.DEB.2.00.1211120639540.28418@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 12.11.2012 15:42, schrieb Sage Weil:
> On Sun, 11 Nov 2012, Stefan Priebe wrote:
>> Hi Sage,
>>
>>> With btrfs, yes, although this isn't something we have tested in a while.
>> I'm not using btrfs as long as the devs claim it is not ready for prod.
>
> In that case, the journal is needed for consistency of the fs; we rely on
> writeahead journaling.  It can't be turned off.
>
> Putting it on a ramdisk in this case is interesting for performance, but
> it means that a crash/reboot/powerloss event leaves the fs in an
> inconsistent and unusable state.

But only if for replicas 2 both nodes crash / have a powerloss?

> The only time tmpfs is potentially useful in production is when you're
> using btrfs *and* have independent backup power sources for replicas (and
> can thus avoid worrying about a site-wide power failure and loss of
> journal).  (Or have relaxed requirements for the durability of recent
> writes.)
What happens for XFS and replicas two and ONE host has a power loss? The 
other replica / journal should be still there.

I've no idea where to put the journal on.

I mean i've 8 SSDs per Host one per osd each with a write IOP/s speed of 
45.000 iops to whole IOP/s write speed of 360.000 IOP/s per Node.

Which journal device can handle this? And if i put the journal on the 
same disk as the OSD it has to copy the data around.

Greets,
Stefan
