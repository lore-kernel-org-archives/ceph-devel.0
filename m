From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [ceph-users] v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 11:49:53 +0200
Message-ID: <CAF6-1L6_TCzWiJZPySg9Mn1pWcbvWQEYxYbUEBCmPyVqYxjeew@mail.gmail.com>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
	<e7039ceecb224324acb2466f87efff8b@SIXPR04MB304.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52202 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaGPJtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 05:49:53 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so1011647pab.6
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 02:49:53 -0700 (PDT)
In-Reply-To: <e7039ceecb224324acb2466f87efff8b@SIXPR04MB304.apcprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james@ejbdigital.com.au>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Wed, Jul 16, 2014 at 10:50 AM, James Harper <james@ejbdigital.com.au> wrote:
> Can you offer some comments on what the impact is likely to be to the data in an affected cluster? Should all data now be treated with suspicion and restored back to before the firefly upgrade?

Yes, I'd definitely like to know that too ... I upgraded a couple
weeks ago to firefly and I run precise with a 3.2 kernel on XFS. I
didn't see any deep scrubs error however.

Also does this affect RBD only or can also affect radosgw ?

And finally, with 0.80.4, radosgw still crashes on multi-part upload
as I reported in another thread.

Cheers,

   Sylvain
