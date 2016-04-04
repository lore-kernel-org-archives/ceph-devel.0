From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Tue, 5 Apr 2016 01:51:25 +1000
Message-ID: <20160404155125.GA26105@onthe.net.au>
References: <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
 <CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com>
 <20160402050505.GA23763@onthe.net.au>
 <CAJ4mKGYPyqy9tUJH8eUEHFAt25Sqm6uKQpr84ckwDERqsRxUKA@mail.gmail.com>
 <alpine.DEB.2.11.1604030921090.19675@cpach.fuggernut.com>
 <20160404153330.GB25148@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:59079 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbcDDPvd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 11:51:33 -0400
Content-Disposition: inline
In-Reply-To: <20160404153330.GB25148@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Marcel Lauhoff <lauhoff@uni-mainz.de>, Gregory Farnum <gfarnum@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Apr 05, 2016 at 01:33:30AM +1000, Chris Dunlop wrote:
> On Sun, Apr 03, 2016 at 09:27:22AM -0400, Sage Weil wrote:
> > In any case, it seems like the way to proceed is to have a variable length 
> > checksum_block_size, since we need that anyway for other reasons (e.g., 
> > balancing minimum read size and read amplification for small IOs vs 
> > metadata overhead).
> 
> Or a selectable checksum routine (like ZFS)? If going this way, the
> checksum_type would determine the checksum_block_size.

...and, also like ZFS, a cryptographic strength checksum could tie in with
Marcel's deduplication effort.

Chris
