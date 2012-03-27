From: Sage Weil <sage@newdream.net>
Subject: Re: Increasing the number of PGs
Date: Tue, 27 Mar 2012 11:06:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203271105180.1271@cobra.newdream.net>
References: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
 <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
 <1332848771.8411.68.camel@squire.doc.ic.ac.uk> <1332866711.8411.70.camel@squire.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46242 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab2C0SGp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 14:06:45 -0400
In-Reply-To: <1332866711.8411.70.camel@squire.doc.ic.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm@doc.ic.ac.uk>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

On Tue, 27 Mar 2012, David McBride wrote:
> On Tue, 2012-03-27 at 12:46 +0100, David McBride wrote:
> 
> > Does the act of adding OSDs itself result in the PG count being
> > increased?  
> 
> Correction to my last: it doesn't, but changing the replica-count (e.g.
> from 2 -> 3 using `ceph osd pool set rbd size 3`) does.

This shouldn't change the PG count either.  If you do

 ceph osd dump | grep ^pool

you'll see a pg_num value for each pool that should remain constant.  
Only the size should change (replica count)...

sage
