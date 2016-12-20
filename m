From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: OSD rebind connects to ports of other OSDs
Date: Tue, 20 Dec 2016 19:31:55 +0200
Message-ID: <20161220173155.GC1510@gmail.com>
References: <2b061067-e839-054e-5166-619deecfae5e@digiware.nl>
 <42cd4fbb-6539-fe43-2b45-45d7958ddcce@digiware.nl>
 <alpine.DEB.2.11.1612201521120.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36434 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935651AbcLTRb7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 12:31:59 -0500
Received: by mail-lf0-f65.google.com with SMTP id o20so11162564lfg.3
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 09:31:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1612201521120.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 20, 2016 at 03:23:59PM +0000, Sage Weil wrote:
> On Tue, 20 Dec 2016, Willem Jan Withagen wrote:

> > So the question is:
> >  - how much rebinding is required.....
> 
> I think it's just for tests.  My recollection is that we did this just 
> because we can run out of ports since we can't reuse one until the tcp 
> finwait2 (or whatever) timeout expires.
> 
> >  - And why do we set SO_REUSEADDR if we are going to add the ports to
> >  	avoid_ports. And thus a complete new port is required.
> 
> I suspect it's safe to drop the option if the Linux vs FreeBSD semantics 
> are in fact different.

SO_REUSEADDR is good to have, so when restarting after a crash bind
wouldn't fail with EADDRINUSE. Thus I wouldn leave it.

For the rebind issue, I would investigate first if this is expected,
that it binds to all interfaces, but rebinds to only one address. If
this is wrong fixing this might also solve the issue on FreeBSD.

-- 
Mykola Golub
