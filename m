From: Sage Weil <sage@inktank.com>
Subject: Re: Inject configuration change into cluster
Date: Fri, 14 Sep 2012 12:12:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209141211010.18057@cobra.newdream.net>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl> <5045B928.1050706@widodh.nl> <1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet> <5045CB80.50508@widodh.nl> <alpine.DEB.2.00.1209040832550.13403@cobra.newdream.net>
 <CAMwB3Tj-9UOG+ax_BtuizUjr-NdCdG5RVRmhr7ntdr6-Cmtdrg@mail.gmail.com> <alpine.DEB.2.00.1209050852250.8916@cobra.newdream.net> <58915F57-D1DA-4BBE-A205-A5063DDCD789@grupaonet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37332 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940Ab2INTMH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 15:12:07 -0400
In-Reply-To: <58915F57-D1DA-4BBE-A205-A5063DDCD789@grupaonet.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>
Cc: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

<On Wed, 5 Sep 2012, Skowron S?awomir wrote:
> Dnia 5 wrz 2012 o godz. 17:53 "Sage Weil" <sage@inktank.com> napisa?(a):
> 
> > On Wed, 5 Sep 2012, S?awomir Skowron wrote:
> >> Ok, but in global case, when i use, a chef/puppet or any other, i wish
> >> to change configuration in ceph.conf, and reload daemon to get new
> >> configuration changes from ceph.conf, this feature would be very
> >> helpful in ceph administration.
> >> 
> >> Inject is ok, for testing, or debuging.
> > 
> > Opened http://tracker.newdream.net/issues/3086.  There is already an issue 
> > open for reloading the config file, 
> > http://tracker.newdream.net/issues/2459.
> > 
> 
> Thanks. This is what i mean. 
> Is this feature have a chance, to be implemented in next months ??

I pushed a branch, wip-tp, that implements this.  Want to give it a spin?  
Just inject the config option change (via the admin socket or injectargs) 
and it'll resize the thread pool.

sage

> 
> > sage
> > 
> >> 
> >> On Tue, Sep 4, 2012 at 5:34 PM, Sage Weil <sage@inktank.com> wrote:
> >>> On Tue, 4 Sep 2012, Wido den Hollander wrote:
> >>>> On 09/04/2012 10:30 AM, Skowron S?awomir wrote:
> >>>>> Ok, thanks.
> >>>>> 
> >>>>> Number of workers used for recover, or numer of disk threads.
> >>>>> 
> >>>> 
> >>>> I think those can be changed while the OSD is running. You could always give
> >>>> it a try.
> >>> 
> >>> The thread pool sizes can't currently be adjusted, unfortunately.  It
> >>> wouldn't be too difficult to change that...
> >>> 
> >>> sage
> >>> 
> >>>> 
> >>>> Wido
> >>>> 
> >>>>> -----Original Message-----
> >>>>> From: Wido den Hollander [mailto:wido@widodh.nl]
> >>>>> Sent: Tuesday, September 04, 2012 10:18 AM
> >>>>> To: Skowron S?awomir
> >>>>> Cc: ceph-devel@vger.kernel.org
> >>>>> Subject: Re: Inject configuration change into cluster
> >>>>> 
> >>>>> On 09/04/2012 07:04 AM, Skowron S?awomir wrote:
> >>>>>> Is there any way now, to inject new configuration change, without
> >>>>>> restarting daemons ??
> >>>>>> 
> >>>>> 
> >>>>> Yes, you can use the injectargs command.
> >>>>> 
> >>>>> $ ceph osd tell 0 injectargs '--debug-osd 20'
> >>>>> 
> >>>>> What do you want to change? Not everything can be changed while the OSD is
> >>>>> running.
> >>>>> 
> >>>>> Wido
> >>>>> 
> >>>>>> Regards
> >>>>>> 
> >>>>>> Slawomir Skowron--
> >>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
> >>>>>> info at  http://vger.kernel.org/majordomo-info.html
> >>>>>> 
> >>>>> 
> >>>>> N???????????????r??????y?????????b???X???????v???^???)?{.n???+?????????z???]z???{ay??? ?????,j ??????f?????????h?????????z??? ???w?????????
> >>>>> ?????????j:+v?????????w???j???m???????????? ????????????zZ+???????j"??????!tml=
> >>>>> 
> >>>> 
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>> 
> >>>> 
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> 
> >> 
> >> 
> >> -- 
> >> -----
> >> Pozdrawiam
> >> 
> >> S?awek "sZiBis" Skowron
> >> 
> >> 
> 
