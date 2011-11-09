From: Sage Weil <sage@newdream.net>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:24:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111091323570.31435@cobra.newdream.net>
References: <459545171.47237.1320873779453.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54017 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab1KIVYq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:24:46 -0500
In-Reply-To: <459545171.47237.1320873779453.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 9 Nov 2011, Noah Watkins wrote:
> ----- Original Message -----
> > From: "Gregory Farnum" <gregory.farnum@dreamhost.com>
> > 
> > I can't imagine anybody needing location data inside of a fast path,
> > in any case. So it probably shouldn't matter, and for any bizarre case
> > where it does we can probably expect a certain level of knowledge!
> > -Greg
> 
> Interestingly, Hadoop's start-up phase a big time sink. With 64 MB blocks
> and a 1 TB data set, we'd make something like 16,000 calls to get block
> location data which is serialized with the start of the job.

Hmm, interesting!  In our case we jsut need the inodes in the libceph 
client cache.   If it's doing stats on files it knows are there, that'll 
be O(num files), but if it is doing a readdir traversal type scan it'll be 
O(num directories).

sage
