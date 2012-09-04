From: Sage Weil <sage@inktank.com>
Subject: Re: Inject configuration change into cluster
Date: Tue, 4 Sep 2012 08:34:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209040832550.13403@cobra.newdream.net>
References: <1FC69721-C852-4B56-ACE6-073137C5290D@portal.onet.pl> <5045B928.1050706@widodh.nl> <1BF27E0D85AE8C45A1BB84890DC4BFFB8A7C49@MXMBON05.grupa.onet> <5045CB80.50508@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39616 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab2IDPe2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 11:34:28 -0400
In-Reply-To: <5045CB80.50508@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 4 Sep 2012, Wido den Hollander wrote:
> On 09/04/2012 10:30 AM, Skowron S?awomir wrote:
> > Ok, thanks.
> > 
> > Number of workers used for recover, or numer of disk threads.
> > 
> 
> I think those can be changed while the OSD is running. You could always give
> it a try.

The thread pool sizes can't currently be adjusted, unfortunately.  It 
wouldn't be too difficult to change that...

sage

> 
> Wido
> 
> > -----Original Message-----
> > From: Wido den Hollander [mailto:wido@widodh.nl]
> > Sent: Tuesday, September 04, 2012 10:18 AM
> > To: Skowron S?awomir
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: Inject configuration change into cluster
> > 
> > On 09/04/2012 07:04 AM, Skowron S?awomir wrote:
> > > Is there any way now, to inject new configuration change, without
> > > restarting daemons ??
> > > 
> > 
> > Yes, you can use the injectargs command.
> > 
> > $ ceph osd tell 0 injectargs '--debug-osd 20'
> > 
> > What do you want to change? Not everything can be changed while the OSD is
> > running.
> > 
> > Wido
> > 
> > > Regards
> > > 
> > > Slawomir Skowron--
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> > N???????????????r??????y?????????b???X???????v???^???)?{.n???+?????????z???]z???{ay????????,j??????f?????????h?????????z??????w?????????
> > ?????????j:+v?????????w???j???m????????????????????????zZ+???????j"??????!tml=
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
