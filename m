From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] rbd rm <image> results in osd marked down wrongly
 with 0.61.3
Date: Tue, 25 Jun 2013 17:30:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306251729550.4761@cobra.newdream.net>
References: <51B731F7.2050002@smart-weblications.de> <51B9BA40.6040901@smart-weblications.de> <alpine.DEB.2.00.1306171549520.7888@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52359 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab3FZAaP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 20:30:15 -0400
In-Reply-To: <alpine.DEB.2.00.1306171549520.7888@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Smart Weblications GmbH - Florian Wiessner <f.wiessner@smart-weblications.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

On Mon, 17 Jun 2013, Sage Weil wrote:
> Hi Florian,
> 
> If you can trigger this with logs, we're very eager to see what they say 
> about this!  The http://tracker.ceph.com/issues/5336 bug is open to track 
> this issue.

Downgrading this bug until we hear back.

sage

> 
> Thanks!
> sage
> 
> 
> On Thu, 13 Jun 2013, Smart Weblications GmbH - Florian Wiessner wrote:
> 
> > Hi,
> > 
> > Is really no one on the list interrested in fixing this? Or am i the only one
> > having this kind of bug/problem?
> > 
> > Am 11.06.2013 16:19, schrieb Smart Weblications GmbH - Florian Wiessner:
> > > Hi List,
> > > 
> > > i observed that an rbd rm <image> results in some osds mark one osd as down
> > > wrongly in cuttlefish.
> > > 
> > > The situation gets even worse if there are more than one rbd rm <image> running
> > > in parallel.
> > > 
> > > Please see attached logfiles. The rbd rm command was issued on 20:24:00 via
> > > cronjob, 40 seconds later the osd 6 got marked down...
> > > 
> > > 
> > > ceph osd tree
> > > 
> > > # id    weight  type name       up/down reweight
> > > -1      7       pool default
> > > -3      7               rack unknownrack
> > > -2      1                       host node01
> > > 0       1                               osd.0   up      1
> > > -4      1                       host node02
> > > 1       1                               osd.1   up      1
> > > -5      1                       host node03
> > > 2       1                               osd.2   up      1
> > > -6      1                       host node04
> > > 3       1                               osd.3   up      1
> > > -7      1                       host node06
> > > 5       1                               osd.5   up      1
> > > -8      1                       host node05
> > > 4       1                               osd.4   up      1
> > > -9      1                       host node07
> > > 6       1                               osd.6   up      1
> > > 
> > > 
> > > I have seen some patches to parallelize rbd rm, but i think there must be some
> > > other issue, as my clients seem to not be able to do IO when ceph is
> > > recovering... I think this has worked better in 0.56.x - there was IO while
> > > recovering.
> > > 
> > > I also observed in the log of osd.6 that after heartbeat_map reset_timeout, the
> > > osd tries to connect to the other osds, but it retries so fast that you could
> > > think this is a DoS attack...
> > > 
> > > 
> > > Please advise..
> > > 
> > 
> > 
> > -- 
> > 
> > Mit freundlichen Gr??en,
> > 
> > Florian Wiessner
> > 
> > Smart Weblications GmbH
> > Martinsberger Str. 1
> > D-95119 Naila
> > 
> > fon.: +49 9282 9638 200
> > fax.: +49 9282 9638 205
> > 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> > http://www.smart-weblications.de
> > 
> > --
> > Sitz der Gesellschaft: Naila
> > Gesch?ftsf?hrer: Florian Wiessner
> > HRB-Nr.: HRB 3840 Amtsgericht Hof
> > *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > 
> > 
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
