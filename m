From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 12:35:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42129 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab2H3TfH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 15:35:07 -0400
In-Reply-To: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 30 Aug 2012, Noah Watkins wrote:
> I'm experiencing delays of around 4-5 seconds when mounting the cephfs
> client. The setup is both client and servers are on a local machine
> which is otherwise idle, with the stock ceph.conf generated from
> ./vstart.sh. Is this length of delay expected, or do I have some
> configuration out of whack? I'm not sure its relevant, but I'm using
> 'admin' as the 'id' parameter to ceph_create.

That's not expected.  It may be that the mds isn't flushing the log after 
the client session event is queued.  What happens if you set 'mds tick 
interval = 1' (default is 5).  (Btw you can add random crap to vstart.sh's 
config with -o 'foo = bar'.)

sage
