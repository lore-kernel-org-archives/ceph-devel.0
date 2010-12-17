From: Sage Weil <sage@newdream.net>
Subject: Re: stripping of ceph class objects
Date: Fri, 17 Dec 2010 08:49:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012170847360.10393@cobra.newdream.net>
References: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
 <1292582942.3920.273.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49673 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0LQQoA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Dec 2010 11:44:00 -0500
In-Reply-To: <1292582942.3920.273.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 17 Dec 2010, Laszlo Boszormenyi wrote:
> Hi Yehuda,
> 
> On Thu, 2010-12-16 at 15:35 -0800, Yehuda Sadeh Weinraub wrote:
> >  we just installed the latest ceph debian packages and it seems that
> > the class objects (that are installed in /usr/lib/rados-classes/) are
> > stripped. [...] Our regular
> > automake resulted binaries keeps those symbols, but I guess that the
> > debian packaging strips them.
>  Indeed, the packaging stripped them. The attached patch fixes this
> issue. Also ceph.lintian should be ceph.lintian-overrides .

Thanks.

> I'm a bit confused, why ceph should depend explicitly on binutils? I may
> understand libedit2 as ceph build depends on its -dev counterpart; but I
> couldn't find a binary that is linked with it.

cclsinfo uses 'nm', which is in binutils.  And ceph is linked against 
-ledit.

I committed the rest.  Thanks!
sage

