From: Sage Weil <sage@newdream.net>
Subject: Re: build dep or not: libatomic_ops
Date: Tue, 1 Jun 2010 09:45:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006010943330.14408@cobra.newdream.net>
References: <hu2phr$3kv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40121 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab0FAQpj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jun 2010 12:45:39 -0400
In-Reply-To: <hu2phr$3kv$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Tue, 1 Jun 2010, Thomas Mueller wrote:
> hi
> 
> in ceph.spec libatomic_ops is a build dep. in debian/control it is not.
> 
> is libatomic_ops build dep or not ?

The unstable branch has libatomic-ops-dev as a build dep in 
debian/control, but testing/master does not.  The ceph.spec added it in 
the testing/master branches, by accident it looks like.  It's used by the 
new include/atomic.h implementation that is in unstable (will be in 
v0.21).

sage
