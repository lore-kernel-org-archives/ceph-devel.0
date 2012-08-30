From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 12:55:48 -0700
Message-ID: <CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
	<alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37692 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab2H3Tzs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 15:55:48 -0400
Received: by iahk25 with SMTP id k25so34484iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 12:55:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Using a tick interval of 1 drops the cost down to 3 seconds, but still
a long time for running many unit tests that use fresh mounts.

-Noah

On Thu, Aug 30, 2012 at 12:35 PM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 30 Aug 2012, Noah Watkins wrote:
>> I'm experiencing delays of around 4-5 seconds when mounting the cephfs
>> client. The setup is both client and servers are on a local machine
>> which is otherwise idle, with the stock ceph.conf generated from
>> ./vstart.sh. Is this length of delay expected, or do I have some
>> configuration out of whack? I'm not sure its relevant, but I'm using
>> 'admin' as the 'id' parameter to ceph_create.
>
> That's not expected.  It may be that the mds isn't flushing the log after
> the client session event is queued.  What happens if you set 'mds tick
> interval = 1' (default is 5).  (Btw you can add random crap to vstart.sh's
> config with -o 'foo = bar'.)
>
> sage
