From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 10:19:44 -0700
Message-ID: <CAPYLRzgARD7K0WtB6O=pj-vbePCet2atcq447cugvdbFppZfjg@mail.gmail.com>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
	<e7039ceecb224324acb2466f87efff8b@SIXPR04MB304.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:64583 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933237AbaGPRTp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 13:19:45 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so1049730qcr.20
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 10:19:44 -0700 (PDT)
In-Reply-To: <e7039ceecb224324acb2466f87efff8b@SIXPR04MB304.apcprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james@ejbdigital.com.au>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Wed, Jul 16, 2014 at 1:50 AM, James Harper <james@ejbdigital.com.au> wrote:
> Can you offer some comments on what the impact is likely to be to the data in an affected cluster? Should all data now be treated with suspicion and restored back to before the firefly upgrade?

I am under the impression that it's not actually a data corruption
bug, so much as a "reveal garbage data in sparse files" bug. So far
everybody who's run into this has run a repair and not seen any
issues, at least. Backups *should* be unnecessary, but we're still
nailing down *exactly* what the bug is, so it's possible our
suspicions are wrong or my information is out of date.

On Wed, Jul 16, 2014 at 2:49 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> On Wed, Jul 16, 2014 at 10:50 AM, James Harper <james@ejbdigital.com.au> wrote:
>> Can you offer some comments on what the impact is likely to be to the data in an affected cluster? Should all data now be treated with suspicion and restored back to before the firefly upgrade?
>
> Yes, I'd definitely like to know that too ... I upgraded a couple
> weeks ago to firefly and I run precise with a 3.2 kernel on XFS. I
> didn't see any deep scrubs error however.
>
> Also does this affect RBD only or can also affect radosgw ?

RBD-only, and if you haven't seen/don't get deep-scrub errors you
won't have any issues.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
