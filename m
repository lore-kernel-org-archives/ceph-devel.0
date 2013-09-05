From: Sage Weil <sage@inktank.com>
Subject: Re: wip-libcephfs-rebased-v65 ready for pull
Date: Wed, 4 Sep 2013 17:59:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309041758470.16076@cobra.newdream.net>
References: <669764413.145.1373569860896.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51234 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760774Ab3IEA7u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Sep 2013 20:59:50 -0400
In-Reply-To: <669764413.145.1373569860896.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Matt,

I've just rebased wip-libcephfs on master and will be kicking off some 
tests shortly.  Please take a look at let me know if there is anything 
missing or if you've run into any issues since this branch was prepared.  
If everything looks okay I'd like to pull it in this week.

Thanks!
sage


On Thu, 11 Jul 2013, Matt W. Benjamin wrote:

> Hi Sage,
> 
> It's up to you folks.  If the next window works better, let's just enter it early.
> 
> Matt
> 
> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
> > Hi,
> > 
> > I've rebased this on master, and cherry-picked the fixes from Ilya on
> > top.  
> > The exception is the xattr changes, which turned out to be an MDS bug
> > 
> > turned by up the unit test.
> > 
> > Is there a particular need for this to be in dumpling?  I'm inclined
> > to 
> > delay a release to avoid potentially destabliizing things this late in
> > the 
> > game.
> > 
> > Thanks!
> > sage
> > 
> > 
> > On Wed, 10 Jul 2013, Matt W. Benjamin wrote:
> > 
> > > Hi,
> > > 
> > > We tracked down the refcount issue found Sat., and have
> > rebased/pushed wip-libcephfs-rebased-v65
> > > with the fix.
> > > 
> > > Thanks!
> > > 
> > > Matt
> > > 
> > > -- 
> > > Matt Benjamin
> > > The Linux Box
> > > 206 South Fifth Ave. Suite 150
> > > Ann Arbor, MI  48104
> > > 
> > > http://linuxbox.com
> > > 
> > > tel.  734-761-4689 
> > > fax.  734-769-8938 
> > > cel.  734-216-5309 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > >
> 
> -- 
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel.  734-761-4689 
> fax.  734-769-8938 
> cel.  734-216-5309 
> 
> 
