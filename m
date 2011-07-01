From: Mark Nigh <mnigh@netelligent.com>
Subject: RE: MDS Replay Issues
Date: Fri, 1 Jul 2011 11:32:45 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C678862E5D8F@NC-SVR-09.netelligent.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C9A@NC-SVR-09.netelligent.com>
 <BANLkTimFgvG2JhTuABwnpt8qWgwAp4vDaQ@mail.gmail.com>
 <Pine.LNX.4.64.1107010910210.21506@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.netelligent.com ([199.255.228.141]:3817 "EHLO
	NC-SVR-11.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756943Ab1GAQcv convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Jul 2011 12:32:51 -0400
In-Reply-To: <Pine.LNX.4.64.1107010910210.21506@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Unfortunately, it won't let me stop it.

root@ceph00:~# ceph mds stop 1
2011-07-01 11:24:27.095093 mon <- [mds,stop,1]
2011-07-01 11:24:27.095803 mon0 -> 'mds1 not active (up:replay)' (-17)

Mark Nigh
Systems Architect
mnigh@netelligent.com
 (p) 314.392.6926


-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Friday, July 01, 2011 11:13 AM
To: Gregory Farnum
Cc: Mark Nigh; ceph-devel@vger.kernel.org
Subject: Re: MDS Replay Issues

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

This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
