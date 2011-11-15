From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Assert in OSDMap::Incremental::decode with recent git
Date: Tue, 15 Nov 2011 06:55:44 -0500
Message-ID: <20111115115544.GA1557@infradead.org>
References: <20111115113747.GA32287@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:35820
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752756Ab1KOLzq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Nov 2011 06:55:46 -0500
Content-Disposition: inline
In-Reply-To: <20111115113747.GA32287@rcn.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Pieper <jjp@pobox.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Nov 15, 2011 at 06:37:47AM -0500, Josh Pieper wrote:
> Hello,
> 
> I was trying to test http://tracker.newdream.net/issues/1708, but in
> the process of attempting to do so, keep getting asserts in one of my
> monitors.
> 
> Pretty much all I have done is bring up a simple 3 node cluster, each
> with a mon, osd, and mds.  All are using amd64 ubuntu 11.10, with git
> 2e195500.  Once the cluster is up, I have a rbd load applied which is
> a single VM reading large files.  Three times now, I have gotten the
> same assert out of mon, inlined below.

I hit the same when trying to bring up a test cluster on a single
physical machine.  As soon as moved to vstart.sh I couldn't reproduce
it anymore.

