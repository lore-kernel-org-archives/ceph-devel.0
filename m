From: Sage Weil <sage@newdream.net>
Subject: Re: MDS Replay Issues
Date: Fri, 1 Jul 2011 09:13:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107010910210.21506@cobra.newdream.net>
References: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C9A@NC-SVR-09.netelligent.com>
 <BANLkTimFgvG2JhTuABwnpt8qWgwAp4vDaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53647 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776Ab1GAQKO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2011 12:10:14 -0400
In-Reply-To: <BANLkTimFgvG2JhTuABwnpt8qWgwAp4vDaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Mark Nigh <mnigh@netelligent.com>, ceph-devel@vger.kernel.org

On Fri, 1 Jul 2011, Gregory Farnum wrote:
> On Thu, Jun 30, 2011 at 5:54 PM, Mark Nigh <mnigh@netelligent.com> wrote:
> > Yes, I did increase the max_mds prior to starting the cmds on the second node. Should I have started the daemon and then increase the mds?
> Well if you increase the max_mds that tells the system to make more
> active MDSes. "Active" means that the MDS is authoritative for part of
> the namespace hierarchy, will be serving clients, etc.
> If you just want standbys then you simply need to start up extra cmds processes.
> 
> > I decrease it to one (1) and rebooted both cmds and they are still in replay. Is there a way to get them into active?
> Unfortunately we don't have a way right now to reduce the number of
> active MDSes. Most of the machinery is there but it's not complete or
> well-tested. You've probably confused the system by telling it to have
> fewer MDSes than it's already got, so you're going to have to put
> max_mds back to 2 to get this cluster back up.

There are two parts here:

 - 'ceph mds stop <num>' will tell the given mds rank to export its 
subtrees and leave the active set.  The daemon will either shut down or go 
back to standby (I forget which :).

 - Setting max_mds to a lower value will prevent any new or standby MDSs 
from (re)joining the active set.

The first part isn't yet part of our testing matrix but should work!

sage
