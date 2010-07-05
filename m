From: Sage Weil <sage@newdream.net>
Subject: Re: POSIX ACL support?
Date: Mon, 5 Jul 2010 10:52:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007051050160.8676@cobra.newdream.net>
References: <1278351313.2552.26.camel@jdlaptop.lesbg.loc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50691 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0GERvV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jul 2010 13:51:21 -0400
In-Reply-To: <1278351313.2552.26.camel@jdlaptop.lesbg.loc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Dieter <jdieter@lesbg.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 5 Jul 2010, Jonathan Dieter wrote:
> Is there POSIX ACL support in ceph?  If not, what needs to be done to
> get it added?  I've set up a test system using Fedora 13 + a Rawhide
> 2.6.34.1-rc1 kernel, and copying files is working fine, but setting ACLs
> gives me an "Operation not supported" error message.

Very little, I suspect, if all you want is ACL enforcement on the client 
side.  The xattr support is there, so I think some vfs hooks just need to 
be implemented.  I'm not too familiar with that part of the vfs, but I 
suspect most of the work is done by generic vfs helpers.

http://tracker.newdream.net/issues/27

sage
