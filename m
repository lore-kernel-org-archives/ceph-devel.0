From: David McBride <dwm@doc.ic.ac.uk>
Subject: Re: Increasing the number of PGs
Date: Tue, 27 Mar 2012 22:04:13 +0100
Message-ID: <1332882253.8411.72.camel@squire.doc.ic.ac.uk>
References: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
	 <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
	 <1332848771.8411.68.camel@squire.doc.ic.ac.uk>
	 <1332866711.8411.70.camel@squire.doc.ic.ac.uk>
	 <Pine.LNX.4.64.1203271105180.1271@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from baza.doc.ic.ac.uk ([146.169.1.193]:56903 "EHLO
	baza.doc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494Ab2C0VER (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 17:04:17 -0400
In-Reply-To: <Pine.LNX.4.64.1203271105180.1271@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

On Tue, 2012-03-27 at 11:06 -0700, Sage Weil wrote:

> This shouldn't change the PG count either.  If you do
> 
>  ceph osd dump | grep ^pool
> 
> you'll see a pg_num value for each pool that should remain constant.  
> Only the size should change (replica count)...

Okay, that's what I was expecting.  I earlier rebuilt the cluster and
repeated my earlier results; however, I don't have the output of those
commands to hand.

I'll quickly run through the process a third-time, verify the before and
after counts, and report back.

Cheers,
David
-- 
David McBride <dwm@doc.ic.ac.uk>
Department of Computing, Imperial College, London

