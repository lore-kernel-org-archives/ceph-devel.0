From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: SUSE install/config issue...
Date: Mon, 27 Dec 2010 17:00:32 -0700
Message-ID: <1293494432.12960.16.camel@hermosa.morreale.net>
References: <1293491636.12960.8.camel@hermosa.morreale.net>
	 <AANLkTikqntKK1sWbt-bVOQYviNZxpL6bGkysyeKvhFKS@mail.gmail.com>
Reply-To: pmorreale@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:52278 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751530Ab0L1AAj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Dec 2010 19:00:39 -0500
In-Reply-To: <AANLkTikqntKK1sWbt-bVOQYviNZxpL6bGkysyeKvhFKS@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 2010-12-27 at 15:30 -0800, Colin McCabe wrote:
> Hi Peter,
> 
> The cfuse binary is part of ceph. Normally, it would be installed by
> make install. Try re-running configure and make, making sure to
> specify ./configure --with-fuse
> 
> Also, you might want to consider using the kernel client, since its
> performance is higher.
> 
> P.S. I just changed the "installing on SuSE" wiki page to recommend
> configure --with-fuse, since it also recommends cfuse.
> 
> cheers,
> Colin

Thanks Colin. 

Totally confused at this point.  :-)  I had assumed that by using the
SUSE packages, everything *was* built and installed.  

So this means the SUSE packages are incomplete?  (Yes, I realize it is
11.2, thus old...)

As for performance, not too worried at the moment, I have this installed
on 3 VMs, merely for testing and gaining familiarity...  I will move it
to a lab after I get a chance to play with it and understand what I am
doing. 

Am I to understand that one has a choice of using a user-space client or
a kernel client?  The SUSE packages did reference a kernel module.   

Perhaps the src tree has documentation on this?  Obviously I am missing
the bigger picture...

Best,
-PWM

 
> 
> 
> On Mon, Dec 27, 2010 at 3:13 PM, Peter W. Morreale <pmorreale@novell.com> wrote:
> >
> > I'm attempting to install ceph for the first time on openSUSE 11.2,
> > using the packages out of factory.  I used the wiki page:
> > http://ceph.newdream.net/wiki/Installing_on_SuSE under the "Complex
> > System" part.  All appears to be fine other than I cannot seem to find
> > the 'cfuse' comand/script.  A find of root failed to locate it as well.
> >
> >
> > Where do I find the 'cfuse' command/script?
> >
> > Thx
> > -PWM
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


