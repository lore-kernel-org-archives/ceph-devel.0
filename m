From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] Cuttlefish: pool recreation results in cluster
 crash
Date: Sat, 19 Oct 2013 21:08:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310192107030.29488@cobra.newdream.net>
References: <CABYiri_RVXcd0KDx2rOjvaoUuKCrEZjF4oEubiZvO9XStZDEVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42261 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3JTEIx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Oct 2013 00:08:53 -0400
In-Reply-To: <CABYiri_RVXcd0KDx2rOjvaoUuKCrEZjF4oEubiZvO9XStZDEVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

Moved to ceph-devel, and opened http://tracker.ceph.com/issues/6598

Have you tried to reproduce this on dumpling or later?

Thanks!
sage


On Sat, 19 Oct 2013, Andrey Korolyov wrote:

> Hello,
> 
> I was able to reproduce following on the top of current cuttlefish:
> 
> - create pool,
> - delete it after all pgs initialized,
> - create new pool with same name after, say, ten seconds.
> 
> All osds dies immediately with attached trace. The problem exists in
> bobtail as well.
> 
