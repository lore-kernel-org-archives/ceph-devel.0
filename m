From: Sage Weil <sage@inktank.com>
Subject: Re: Strange behavior after upgrading to 0.48
Date: Thu, 5 Jul 2012 22:07:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207052206490.565@cobra.newdream.net>
References: <4FF53706.7070003@gmail.com> <Pine.LNX.4.64.1207050725550.6931@cobra.newdream.net>
 <72a6b171-725b-417c-9538-07f6a4ef5032@email.android.com>
 <Pine.LNX.4.64.1207050737400.6931@cobra.newdream.net> <4FF64FB7.90709@gmail.com>
 <4FF66624.1040607@catalyst.net.nz> <Pine.LNX.4.64.1207052117080.565@cobra.newdream.net>
 <4FF66F0A.7000804@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39771 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2GFFHg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 01:07:36 -0400
In-Reply-To: <4FF66F0A.7000804@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Xiaopong Tran <xiaopong.tran@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 6 Jul 2012, Mark Kirkwood wrote:
> On 06/07/12 16:17, Sage Weil wrote:
> > On Fri, 6 Jul 2012, Mark Kirkwood wrote:
> > > 
> > > FYI: I ran into this too - you need to do:
> > > 
> > > apt-get dist-upgrade
> > > 
> > > for the 0.47-2 packages to be replaced by 0.48 (of course purging 'em and
> > > reinstalling works too...just a bit more drastic)!
> > That's strange... anyone know why?
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> From the apt-get manual:
> 
>        upgrade
>            upgrade is used to install the newest versions of all packages
>            currently installed on the system from the sources enumerated in
>            /etc/apt/sources.list. Packages currently installed with new
>            versions available are retrieved and upgraded; under no
>            circumstances are currently installed packages removed, or packages
>            not already installed retrieved and installed. New versions of
>            currently installed packages that cannot be upgraded without
>            changing the install status of another package will be left at
>            their current version. An update must be performed first so that
>            apt-get knows that new versions of packages are available.
> 
>        dist-upgrade
>            dist-upgrade in addition to performing the function of upgrade,
>            also intelligently handles changing dependencies with new versions
>            of packages; apt-get has a "smart" conflict resolution system, and
>            it will attempt to upgrade the most important packages at the
>            expense of less important ones if necessary. So, dist-upgrade
>            command may remove some packages. The /etc/apt/sources.list file
>            contains a list of locations from which to retrieve desired package
>            files. See also apt_preferences(5) for a mechanism for overriding
>            the general settings for individual packages.
> 
> Does 0.48 have new dependancies perhaps?

Oh, yeah.  We switched to libnss from libcrypto++ by default, among other 
things; that would explain it!

Thanks-
sage

