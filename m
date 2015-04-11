From: Sage Weil <sage@newdream.net>
Subject: RE: loadable objectstore
Date: Sat, 11 Apr 2015 07:51:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
References: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com> <alpine.DEB.2.00.1504101545120.4469@cobra.newdream.net> <C226B0AB34511445928D9882AA519F601C3DB5ED@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56971 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbbDKOvV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Apr 2015 10:51:21 -0400
In-Reply-To: <C226B0AB34511445928D9882AA519F601C3DB5ED@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 11 Apr 2015, Varada Kari wrote:
> Hi Matt/ Sage,
> 
> Thanks for sharing the pull request. Will work on the items what sage 
> was mentioning in the comments along with the items in the tracker.

I pushed a wip-plugin branch with the pattern I had in mind... does this 
make sense?  It's only compile tested, and still needs preload() methods 
implemented so that long-running daemons (or perhaps others?) can preload 
it all at once.

Ideally we would replace ErasurePluginRegistry with this too, which means 
the naming of the .so's needs to be a bit more flexible as the EC plugin 
scheme is something like /usr/lib/ceph/erasure-code/libec_$name.so (not a 
strict function of type and name).  Or actually, we can just rename the 
EC .so's when this goes in?  Since they're explicitly incompatible 
between versions there is no reason the names need to remain 
consistent...

sage

> 
> Varada
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Saturday, April 11, 2015 4:16 AM
> To: Matt W. Benjamin
> Cc: Varada Kari; ceph-devel
> Subject: Re: loadable objectstore
> 
> On Fri, 10 Apr 2015, Matt W. Benjamin wrote:
> > Hi Varada,
> >
> > I pushed branch hammer-osfactory to
> > https://github.com/linuxbox2/ceph.git
> >
> > It can at least provide a starting point for discussion, if not a
> > jumping off point;  I do think it's basically what Sage described.
> 
> I made a few comments on the pull request.  I think a factory class is the way to go, but we should be able to make the plugin loading part generic and not interface specific at all...
> 
> sage
> 
> >
> > I was able to update the CMake build system to build the tree, I
> > haven't attempted Autotools. :(
> >
> > Regards,
> >
> > Matt
> >
> > --
> > Matt Benjamin
> > CohortFS, LLC.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> >
> > http://cohortfs.com
> >
> > tel.  734-761-4689
> > fax.  734-769-8938
> > cel.  734-216-5309
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
