From: Sage Weil <sage@newdream.net>
Subject: Re: Minor inconsistency with ceph-deploy on Giant
Date: Mon, 2 Feb 2015 07:43:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502020742130.10626@cobra.newdream.net>
References: <CANPbtN-WELLaMUQmoaOZnJ1Q1AUgSiehPLBhDw_yy6d==TfEYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55482 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbbBBPna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 10:43:30 -0500
In-Reply-To: <CANPbtN-WELLaMUQmoaOZnJ1Q1AUgSiehPLBhDw_yy6d==TfEYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Hindle <shindle@llnw.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 2 Feb 2015, Stephen Hindle wrote:
> Hi!
> 
>   Just thought I'd mention a minor inconsistency I noticed while
> re-installing our cluster...
> preparing an OSD with ceph-deploy will NOT activate it on a parttion
> (node1:/sda1/sda2)
> preparting an OSD with ceph-deploy WILL activate it on a disk (
> node1:/dev/sdc)
> 
> I think I noticed similiar behavior with ceph-deploy osd create, but I
> assumed I just messed up,
> so I didnt document it.  This is probably more of an 'issue' as create is
> supposed to activate it for you.
> 
> Manually issuing a ceph-deploy osd activate works fine to bring the
> partition OSDs up.

This is an artifact of how activation works: we label GPT partitions so 
that udev can launch ceph-osd.  If you use existing partitions, they 
aren't GPT (probably) and aren't labeled accordingly.

I think the "fix" is to make sure the existing partitions are GPT 
partitions, and make sure that ceph-disk will relabel is possible (I 
forget if it does this now...)

sage

