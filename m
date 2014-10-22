From: Sage Weil <sage@newdream.net>
Subject: Re: Can pid be reused ?
Date: Wed, 22 Oct 2014 15:43:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410221542450.29946@cobra.newdream.net>
References: <54471CA6.5040807@dachary.org> <0B26F614-B9E5-4E30-9471-A7F46656AA24@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40327 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483AbaJVWnQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 18:43:16 -0400
In-Reply-To: <0B26F614-B9E5-4E30-9471-A7F46656AA24@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 22 Oct 2014, David Zafman wrote:
> I just realized what it is.  The way killall is used when stopping a 
> vstart cluster, is to kill all processes by name!  You can't stop 
> vstarted tests running in parallel.

Ah.  FWIW I think we should avoid using stop.sh whenever possible and 
instead do ./init-ceph stop (which does an orderly shutdown via pid 
files).

sage
