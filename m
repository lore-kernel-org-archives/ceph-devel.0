From: Michael Morgan <mmorgan@dca.net>
Subject: Re: Errors attaching RBD image to a running VM
Date: Mon, 10 Dec 2012 18:29:35 -0500
Message-ID: <20121210232935.GD22300@staff.dca.net>
References: <20121207212247.GA12635@staff.dca.net> <50C272A0.9020506@inktank.com> <20121210204850.GC22300@staff.dca.net> <50C6504D.8090307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from staff.dca.net ([207.245.84.197]:36088 "EHLO staff.dca.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2LJX3f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Dec 2012 18:29:35 -0500
Content-Disposition: inline
In-Reply-To: <50C6504D.8090307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Dec 10, 2012 at 01:12:45PM -0800, Josh Durgin wrote:
> 
> There was a regression in 1.0.0 with attaching non-files, such as RBD.
> This is fixed by f0e72b2f5c675f927d04545dc5095f9e5998f171, which you
> could cherry-pick onto 1.0.0.
> 
> If you'd rather just use a released version, 0.10.2 should be fine.
> 

Libvirt 0.10.2 appears to have fixed my problems. Booting from RBD works as
well as attaching/detaching multiple additional volumes. Thanks so much Josh!

-Mike
