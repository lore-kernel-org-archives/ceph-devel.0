From: Sage Weil <sage@inktank.com>
Subject: Re: Strange behavior after upgrading to 0.48
Date: Thu, 5 Jul 2012 21:17:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207052117080.565@cobra.newdream.net>
References: <4FF53706.7070003@gmail.com> <Pine.LNX.4.64.1207050725550.6931@cobra.newdream.net>
 <72a6b171-725b-417c-9538-07f6a4ef5032@email.android.com>
 <Pine.LNX.4.64.1207050737400.6931@cobra.newdream.net> <4FF64FB7.90709@gmail.com>
 <4FF66624.1040607@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42519 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab2GFER2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 00:17:28 -0400
In-Reply-To: <4FF66624.1040607@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Xiaopong Tran <xiaopong.tran@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 6 Jul 2012, Mark Kirkwood wrote:
> On 06/07/12 14:38, Xiaopong Tran wrote:
> > 
> > Thanks for the quick reply, I didn't have the computer with me last
> > night. But you were right. I checked the version of ceph on ubuntu,
> > and it's still stuck with 0.47.3, despite upgrading. I redid the
> > upgrade, and it's still stuck with that version. That's something
> > I didn't pay attention to.
> > 
> > I had to purge the ceph, ceph-common and other related packages,
> > and re-install it, then I got 0.48. And now ceph -s works just
> > as it should.
> > 
> > So, somehow, the upgrade on ubuntu does not work properly.
> > 
> > Thinking about this issue just right now, I think ceph -s
> > still worked right because there was still an older version
> > of mon when the first two nodes were being upgraded. When
> > the last one was upgraded, there's no mon of the same version
> > anymore.
> > 
> > Sorry, should have checked if apt upgrade was done properly
> > first :)
> > 
> > 
> 
> FYI: I ran into this too - you need to do:
> 
> apt-get dist-upgrade
> 
> for the 0.47-2 packages to be replaced by 0.48 (of course purging 'em and
> reinstalling works too...just a bit more drastic)!

That's strange... anyone know why?

sage
