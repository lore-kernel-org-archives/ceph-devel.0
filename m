From: Sage Weil <sage@newdream.net>
Subject: Re: avoid crashes from faulty crushmap
Date: Mon, 6 Feb 2012 10:47:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202061047140.27317@cobra.newdream.net>
References: <orpqdwnu16.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58730 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab2BFSrq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2012 13:47:46 -0500
In-Reply-To: <orpqdwnu16.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

On Fri, 3 Feb 2012, Alexandre Oliva wrote:

> I messed up a crush map the other day, mixing components of different
> types in a single rule.  The crushmap compiler didn't complain, but mons
> and osds would crash when applying those rules.  I had to use this patch
> to recover the cluster.  Only the second hunk was relevant, but I
> figured a BUG_ON that stops you from fixing the problem is best avoided
> ;-)

Applied this; thanks!  The only remaining BUG_ON is for a code invariant, 
not unexpected crush map data.

sage
