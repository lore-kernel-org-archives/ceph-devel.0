From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: wip-libcephfs-rebased-v65 ready for pull
Date: Wed, 4 Sep 2013 22:42:43 -0400 (EDT)
Message-ID: <432921236.178.1378348963552.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1309041758470.16076@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2226 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762639Ab3IECsw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Sep 2013 22:48:52 -0400
In-Reply-To: <alpine.DEB.2.00.1309041758470.16076@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Ok, I'll review this in the am.

Thanks for the heads up,

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> Hi Matt,
> 
> I've just rebased wip-libcephfs on master and will be kicking off some
> 
> tests shortly.  Please take a look at let me know if there is anything
> 
> missing or if you've run into any issues since this branch was
> prepared.  
> If everything looks okay I'd like to pull it in this week.
> 
> Thanks!
> sage
> 
> 
> On Thu, 11 Jul 2013, Matt W. Benjamin wrote:
> 
> > Hi Sage,
> > 
> > It's up to you folks.  If the next window works better, let's just
> enter it early.
> > 
> > Matt
> > 
> > ----- "Sage Weil" <sage@inktank.com> wrote:
> > 
> > > Hi,
> > > 
> > > I've rebased this on master, and cherry-picked the fixes from Ilya
> on
> > > top.  
> > > The exception is the xattr changes, which turned out to be an MDS
> bug
> > > 
> > > turned by up the unit test.
> > > 
> > > Is there a particular need for this to be in dumpling?  I'm
> inclined
> > > to 
> > > delay a release to avoid potentially destabliizing things this
> late in
> > > the 
> > > game.
> > > 
> > > Thanks!
> > > sage
> > > 
> > > 
> > > On Wed, 10 Jul 2013, Matt W. Benjamin wrote:
> > > 
> > > > Hi,
> > > > 
> > > > We tracked down the refcount issue found Sat., and have
> > > rebased/pushed wip-libcephfs-rebased-v65
> > > > with the fix.
> > > > 
> > > > Thanks!
> > > > 
> > > > Matt
> > > > 
> > > > -- 
> > > > Matt Benjamin
> > > > The Linux Box
> > > > 206 South Fifth Ave. Suite 150
> > > > Ann Arbor, MI  48104
> > > > 
> > > > http://linuxbox.com
> > > > 
> > > > tel.  734-761-4689 
> > > > fax.  734-769-8938 
> > > > cel.  734-216-5309 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > > > 
> > > >
> > 
> > -- 
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> > 
> > http://linuxbox.com
> > 
> > tel.  734-761-4689 
> > fax.  734-769-8938 
> > cel.  734-216-5309 
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
