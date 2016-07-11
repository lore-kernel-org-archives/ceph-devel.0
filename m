From: Sage Weil <sage@newdream.net>
Subject: Re: drop i386 support
Date: Mon, 11 Jul 2016 12:58:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1607111256190.2776@piezo.us.to>
References: <CAJE9aONDn6S+8e7GNDpLX+6YaqSSEpQcFUDH_WeCXZrHfePAhg@mail.gmail.com> <20160711073205.GA14502@predictor> <1382742234.736.1468223238352@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-165667003-1468241885=:2776"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53271 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbcGKM6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 08:58:07 -0400
In-Reply-To: <1382742234.736.1468223238352@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <branch@predictor.org.pl>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-165667003-1468241885=:2776
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 11 Jul 2016, Wido den Hollander wrote:
> > Op 11 juli 2016 om 9:32 schreef Piotr Dałek <branch@predictor.org.pl>:
> > On Mon, Jul 11, 2016 at 02:57:12PM +0800, kefu chai wrote:
> > > Hi Cephers,
> > > 
> > > I am proposing drop the support of i386. as we don't compile Ceph with
> > > any i386 gitbuilder now[1] and hence don't test the i386 builds on
> > > sepia on a regular basis. Also, based on the assumption that people
> > > don't use i386 in production, I think we can drop it from the minimum
> > > hardware document[2]?
> > > 
> > > And we won't explicitly disable the i386 build in code if we decide to
> > > drop the i386 support, as we always try to be portable if possible.
> > > But just don't claim the i386 as the officially supported arch
> > > anymore.
> > > 
> > > What do you think?
> > 
> > +1 from my side. Regular users are on amd64, and those willing to run on
> > small devices are using ARM anyway.
> > 
> 
> Indeed. In my experience I have never seen a cluster run on i386.
> 
> +1 from my side to drop i386.

Yep.

The only value is the i386 builder, which serves as a canary for 32-bit 
build issues, and is a more convenient that building on 32-bit arm 
hardware.  So +.5 from me to keeping the builder around...

sage
--8323329-165667003-1468241885=:2776--
