From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Weekly performance meeting
Date: Fri, 26 Sep 2014 06:02:39 -0700
Message-ID: <20140926130239.GA4577@infradead.org>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
 <CACJqLyba+ODROaTno844jCt8JHuhb35A_f4qAawrmUQa+oR=Fg@mail.gmail.com>
 <CAMm-wcJVtmbgr0wW28OmVg+7B_DMszSM0E7YTUJFFNiBuC7OVg@mail.gmail.com>
 <CANP1eJGTx6vwBgnKZjHmwwwDbYOTs-Q6sUjYAt7ei1YqsDdeaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40724 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbaIZNCp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 09:02:45 -0400
Content-Disposition: inline
In-Reply-To: <CANP1eJGTx6vwBgnKZjHmwwwDbYOTs-Q6sUjYAt7ei1YqsDdeaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Dong Yuan <yuandong1222@gmail.com>, Haomai Wang <haomaiwang@gmail.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Somnath Roy <Somnath.Roy@sandisk.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Kasper Dieter <dieter.kasper@ts.fujitsu.com>, PVonStamwitz@us.fujitsu.com, "Shu, Xinxin" <xinxin.shu@intel.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, xiaoxi.chen@intel.com, "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, jianpeng.ma@intel.com, gdror@mellanox.com, vuhuong@mellanox.com, Mark Nelson <mark.nelson@inktank.com>

On Fri, Sep 26, 2014 at 08:58:56AM -0400, Milosz Tanski wrote:
> First, I have recently submitted a series of patches to kernel to add
> a new preadv2 syscall that lets you do a "fast read" out of the page
> cache the point being that you can skip the whole disk IO queue in
> user space in the cases it's already cached (thus reducing the
> latency). Obviously this doesn't do much for writes (yet, Christoph
> Heldwig is working on that). Samba expressed an interest using these
> new syscalls as well.

We could also implement it for writes, but if would be a bit more
complicated.  If there is a compelling use case it might be worth
exploring.

