From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Request for ceph.conf environment extension
Date: Mon, 6 May 2013 15:35:07 +0200
Message-ID: <CAJH6TXiCQdL-vdwGVQoEa5nJYg9i9RZYVaGEJCqeiSsfjMcvsA@mail.gmail.com>
References: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
	<CAJH6TXgHoRocVNDvThbK6Wc65POD9E_bLSoOGuVJswGt7EqW=w@mail.gmail.com>
	<5187AEDC.6070202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:55640 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3EFNfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 09:35:08 -0400
Received: by mail-we0-f173.google.com with SMTP id r3so2917916wey.18
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 06:35:07 -0700 (PDT)
In-Reply-To: <5187AEDC.6070202@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

2013/5/6 Mark Nelson <mark.nelson@inktank.com>:
> It would be very interesting to hear how SDP does.  With IPoIB I've gotten
> about 2GB/s on QDR with Ceph, which is roughly also what I can get in an
> ideal round-robin setup with 2 bonded 10GbE links.

Yes, but IB costs 1/4 than 10GbE and will be much expandible in future.
