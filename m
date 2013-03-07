From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS Space Accounting and Quotas
Date: Wed, 6 Mar 2013 16:18:30 -0800
Message-ID: <8B6963669A2E49C286B9241DCD62F557@inktank.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
 <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
 <51379FCD.9000502@sandia.gov>
 <D19243567199482692F961618A335817@inktank.com>
 <5137B4E9.1030505@sandia.gov>
 <1856965A675D4D5D971D5DC9AB01C657@inktank.com>
 <5137CDE2.70105@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:51899 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab3CGASe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 19:18:34 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so6820525pbb.20
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 16:18:33 -0800 (PST)
In-Reply-To: <5137CDE2.70105@sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On Wednesday, March 6, 2013 at 3:14 PM, Jim Schutt wrote:
> When I'm doing these stat operations the file system is otherwise
> idle.

What's the cluster look like? This is just one active MDS and a couple hundred clients?

> What is happening is that once one of these slow stat operations
> on a file completes, it never happens again for that file, from
> any client. At least, that's the case if I'm not writing to
> the file any more. I haven't checked if appending to the files
> restarts the behavior.

I assume it'll come back, but if you could verify that'd be good.

 
> On the client side I'm running with 3.8.2 + the ceph patch queue
> that was merged into 3.9-rc1.
> 
> On the server side I'm running recent next branch (commit 0f42eddef5),
> with the tcp receive socket buffer option patches cherry-picked.
> I've also got a patch that allows mkcephfs to use osd_pool_default_pg_num
> rather than pg_bits to set initial number of PGs (same for pgp_num),
> and a patch that lets me run with just one pool that contains both
> data and metadata. I'm testing data distribution uniformity with 512K PGs.
> 
> My MDS tunables are all at default settings.
> 
> > 
> > We'll probably want to get a high-debug log of the MDS during these slow stats as well.
> 
> OK.
> 
> Do you want me to try to reproduce with a more standard setup?
No, this is fine. 
 
> Also, I see Sage just pushed a patch to pgid decoding - I expect
> I need that as well, if I'm running the latest client code.

Yeah, if you've got the commit it references you'll want it.

> Do you want the MDS log at 10 or 20?
More is better. ;)

