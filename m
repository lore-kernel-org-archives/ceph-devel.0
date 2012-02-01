From: Sage Weil <sage@newdream.net>
Subject: Re: efficient removal of old objects
Date: Wed, 1 Feb 2012 11:43:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202011128110.3156@cobra.newdream.net>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
 <CAC-hyiG512de2h+R98g1POOy0Lw18A15TPwE=ge-OgjofdR8Wg@mail.gmail.com>
 <CAF3hT9DXMz6Ga-=FHz35KGMaj+bS8pA2bZky3mvo7xbEejxppQ@mail.gmail.com>
 <CAC-hyiFR6AXFTdb1majNg85sVfQ8NDyP6K+o1YBuEzGPszF24Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41019 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221Ab2BATnQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 14:43:16 -0500
In-Reply-To: <CAC-hyiFR6AXFTdb1majNg85sVfQ8NDyP6K+o1YBuEzGPszF24Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

An expiration API seems sufficiently general and useful to ignore the 
other bike shed options.

I don't buy the readonly vs readwrite issue with scrub triggering 
deletions.  On the other hand, having scrub trigger it is a problem in 
general because the time periods may not align.  It would make garbage 
collection only useful when it is on the same order of magnitude as scrub.

Viewing the deletion workload in isolation, doing it from scrub is 
significantly more efficient.  (Assuming it is implemented well. I think 
the current scrub needs to be reworked before that could happen.)

However, in general, deletion is only a fraction of the overall system 
load.  In fact, we'd have one deletion to follow up every overwrite PUT, 
so we effectively double the number of write ops if the client does it for 
that case.  I don't think that will be a large part of the workload.

Doing it from the client also means we can control the period independent 
of scrub... e.g. 1 hour instead of a day or days.

In any case, I think we should leave it on the client, at least for this 
sprint.  We need to make the scrubbing incremental first.

sage

