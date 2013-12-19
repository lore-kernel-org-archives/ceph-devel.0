From: Sage Weil <sage@inktank.com>
Subject: Re: mds: fix Resetter locking
Date: Thu, 19 Dec 2013 08:10:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312190810020.9041@cobra.newdream.net>
References: <ord2kt71bg.fsf@livre.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41119 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab3LSQKO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Dec 2013 11:10:14 -0500
In-Reply-To: <ord2kt71bg.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org

Applied!

On Thu, 19 Dec 2013, Alexandre Oliva wrote:

> For some weird reason I couldn't figure out, after I simultaneously
> brought down all components of my ceph cluster and then brought them
> back up, the mds wouldn't come back, complaining about a zero-sized
> entry in its journal some 8+MB behind the end of the journal.  I hadn't
> ever got this problem, and it's not entirely unusual for me to restart
> all cluster components at once after some configuration change.
> 
> Anyway...  Long story short, after some poking at the mds journal to see
> if I could figure out how to get it back up, I gave up and decided to
> use the --reset-journal hammer.  Except that it just sat there, never
> completing or even getting noticed by the cluster.  After a bit of
> additional investigation, the following patch was born, and now my
> Emperor cluster is back up.  Phew! :-)
> 
> 
