From: Sage Weil <sage@newdream.net>
Subject: Re: Feature request: "max mon" setting
Date: Fri, 4 Nov 2011 08:15:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1111040811300.3652@cobra.newdream.net>
References: <201111031302.51236.a.ott@m-privacy.de>
 <CAORUGqCg815t-C_=+RPB3Z6xRWG6JeeSa1LtpQr1G-yo2wU=7g@mail.gmail.com>
 <201111040912.14250.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47798 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab1KDPPo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 11:15:44 -0400
In-Reply-To: <201111040912.14250.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 4 Nov 2011, Amon Ott wrote:
> On Thursday 03 November 2011 you wrote:
> > On Thu, Nov 3, 2011 at 05:02, Amon Ott <a.ott@m-privacy.de> wrote:
> > > Documentation recommends three monitors. In our special cluster
> > > configuration, this would mean that if accidentially two nodes with
> > > monitors fail (e.g. one in maintenance and one crashes), the whole
> > > cluster dies. What I would really
> >
> > If you feel two monitors going down is too likely, run a monitor
> > cluster of size 5. And if you feel 3 monitors going down is too
> > likely, run 7.
> 
> So there is no problem in having much more than three, as long as it is 
> an odd number.

It actually can be an odd number.  Just keep in mind that you need a 
strict majority (> N/2) for the cluster to go active.  That last monitor 
just doesn't buy you much because the number of survivors required goes up 
by one but the number of failures you can tolerate does not.  (e.g., a 4 
monitor cluster can only tolerate 1 failure, just like a 3 node cluster.)

sage
