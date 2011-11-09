From: Sage Weil <sage@newdream.net>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Wed, 9 Nov 2011 12:56:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111091255150.31435@cobra.newdream.net>
References: <1771502131.44602.1320808517281.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49932 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850Ab1KIU44 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 15:56:56 -0500
In-Reply-To: <1771502131.44602.1320808517281.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <gregory.farnum@dreamhost.com>

On Tue, 8 Nov 2011, Noah Watkins wrote:
> ----- Original Message -----
> > From: "Tommi Virtanen" <tommi.virtanen@dreamhost.com>
> > 
> > The value in returning the number that *would have been written* is in
> > that now the caller can reallocate a buffer of exactly the right size
> > (barring races). Like snprintf() and friends. With just a generic
> > -ENOBUFS/-EMSGSIZE/whatever you cram in there, the caller must do a
> > series of increasing guesses.
> > 
> 
> Thanks for the feedback. I ended up using -ERANGE, and allow naddr=0 for 
> querying the actual size.

The only issue with this is that, in the event that you don't guess a 
sufficiently large array on the first call, you may need to call again, 
and in some cases that may mean multiple MDS requests.  Normally that's 
not the case.  And a smart caller should guess 4 and only pass 0 and then 
N if 4 failed.  But a naive caller will always make two calls, first with 
0 and then with N, and in some cases that's actually slower.

Does it matter?

sage

