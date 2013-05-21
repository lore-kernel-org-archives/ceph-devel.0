From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] mon IO usage
Date: Tue, 21 May 2013 08:57:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305210854320.16413@cobra.newdream.net>
References: <CAF6-1L4oWCwNxywALb=cUNP_pbD=ND631MJqvCWyvAfvNdWauQ@mail.gmail.com> <519B6F28.9000400@scholarstack.com> <519B75B2.4070405@scholarstack.com> <CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39870 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab3EUP5f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:57:35 -0400
In-Reply-To: <CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Mike Dawson <mike.dawson@scholarstack.com>, ceph-users@lists.ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 21 May 2013, Sylvain Munaut wrote:
> So, AFAICT, the bulk of the write would be writing out the pgmap to
> disk every second or so.

It should be writing out the full map only every N commits... see 'paxos 
stash full interval', which defaults to 25.

> Is it really needed to write it in full ? It doesn't change all that
> much AFAICT, so writing incremental changes with only periodic flush
> might be a better option ?

Right.  It works this way now only because we haven't fully transitioned 
from the old scheme.  The next step is to store the PGMap over lots of 
leveldb keys (one per pg) so that there is no big encode/decode of the 
entire PGMap structure...

sage
