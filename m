From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 13:22:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005201314100.4397@cobra.newdream.net>
References: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
 <1274378233.5412.63.camel@wido-laptop.pcextreme.nl>
 <Pine.LNX.4.64.1005201102570.4397@cobra.newdream.net>
 <201005202210.02097.michal.humpula@hudrydum.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57488 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab0ETUTT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 16:19:19 -0400
In-Reply-To: <201005202210.02097.michal.humpula@hudrydum.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Humpula <michal.humpula@hudrydum.cz>
Cc: ceph-devel@vger.kernel.org

On Thu, 20 May 2010, Michal Humpula wrote:
> > > About more then one OSD on one machine, is there a way how you can bind
> > > an OSD to a specific IP? Can't seem to find any configuration for this.
> > >
> > > I assume you will need one IP per OSD on that machine?
> > 
> > Not currently via the .conf, only via the --bind 1.2.3.4:123 command line
> > argument.  Adding a bug for this.
> 
> Is that one IP per cosd daemon really necessary?  I'm currently running four 
> osd nodes, two disk/cosd per each with single IP per node. So far it seems 
> working:)

Oh sorry, I misunderstood the question.  You can force the daemon to bind 
to a specific IP/port, but that's not necessary.  

Normally the non-monitor daemons will just pick a random port (in the 
6800-6900 range) and identify themselves as whatever IP is used when 
contacting the monitor.  The monitors are the only daemons that have to 
bind to a specific well-known port (whatever you specify in ceph.conf).

sage
