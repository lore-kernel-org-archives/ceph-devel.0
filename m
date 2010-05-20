From: Sage Weil <sage@newdream.net>
Subject: Re: phantom MDS, blacklisted OSDs?
Date: Thu, 20 May 2010 10:14:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005201011170.4397@cobra.newdream.net>
References: <879378.31395.qm@web114302.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50208 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0ETRLU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 13:11:20 -0400
In-Reply-To: <879378.31395.qm@web114302.mail.gq1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fred Ar <ar.fred@yahoo.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 20 May 2010, Fred Ar wrote:
> Hello,
> 
> today I noticed some strange things on my 3 machines with each 1 hard 
> disk, 1 osd, 1 mds, 1 mon. They are named r1-9, r1-10, r1-11.
> [...]
> why do r1-9 and r1-10 appear twice, and why does r1-11 appear 5 times? Is it a problem, how to fix it ?
> 
> I also had a 2 blacklisted OSDs (out of 3). Could it be because I 
> restarted them many times in a row? How to clear the blacklisted status 
> by hand (if I don't want to wait the delay)?

Yeah.  The monitor doesn't clear our 'laggy' (unresponsive, possibly dead) 
mds entries if they are standby, since they might come back and nothing 
is depending on them.  We can add a longer timeout to clean these out if 
its clear the system is otherwise functional (e.g., other mds's are 
responsive).

The blacklist entries can't be cleaned out manually right now, but there 
is no significant 'cost' to them being there, so you can ignore them.  The 
blacklist just means that any IO they attempt with the OSDs will be 
rejected, to avoid a partitioned or misbehaving or laggy daemon from 
fighting with another mds instance.

sage
