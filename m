From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Mon, 4 Apr 2016 17:58:02 +0000
Message-ID: <CY1PR0201MB189790D18927D34265F8D2A0E89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
 <CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com>
 <20160402050505.GA23763@onthe.net.au>
 <CAJ4mKGYPyqy9tUJH8eUEHFAt25Sqm6uKQpr84ckwDERqsRxUKA@mail.gmail.com>
 <alpine.DEB.2.11.1604030921090.19675@cpach.fuggernut.com>
 <20160404153330.GB25148@onthe.net.au> <20160404155125.GA26105@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0077.outbound.protection.outlook.com ([65.55.169.77]:38112
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754687AbcDDR6G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 13:58:06 -0400
In-Reply-To: <20160404155125.GA26105@onthe.net.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>, Sage Weil <sage@newdream.net>
Cc: Marcel Lauhoff <lauhoff@uni-mainz.de>, Gregory Farnum <gfarnum@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

That is an interesting observation. Unfortunately, it probably is a third-order optimization. (You'll be saving 4 or 8 bytes per ONODE, not much to write home about).

> -----Original Message-----
> From: Chris Dunlop [mailto:chris@onthe.net.au]
> Sent: Monday, April 04, 2016 8:51 AM
> To: Sage Weil <sage@newdream.net>
> Cc: Marcel Lauhoff <lauhoff@uni-mainz.de>; Gregory Farnum
> <gfarnum@redhat.com>; Allen Samuels <Allen.Samuels@sandisk.com>; Igor
> Fedotov <ifedotov@mirantis.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: Re: Adding compression/checksum support for bluestore.
> 
> On Tue, Apr 05, 2016 at 01:33:30AM +1000, Chris Dunlop wrote:
> > On Sun, Apr 03, 2016 at 09:27:22AM -0400, Sage Weil wrote:
> > > In any case, it seems like the way to proceed is to have a variable
> > > length checksum_block_size, since we need that anyway for other
> > > reasons (e.g., balancing minimum read size and read amplification
> > > for small IOs vs metadata overhead).
> >
> > Or a selectable checksum routine (like ZFS)? If going this way, the
> > checksum_type would determine the checksum_block_size.
> 
> ...and, also like ZFS, a cryptographic strength checksum could tie in with
> Marcel's deduplication effort.
> 
> Chris
