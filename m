From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: ceph osd df
Date: Fri, 16 Jan 2015 17:51:24 +0200
Message-ID: <20150116155123.GA11113@gmail.com>
References: <alpine.DEB.2.00.1501051101010.6168@cobra.newdream.net>
 <20150110093158.GA2288@gmail.com>
 <alpine.DEB.2.00.1501101027390.26676@cobra.newdream.net>
 <20150111163148.GA2749@gmail.com>
 <alpine.DEB.2.00.1501110932360.18957@cobra.newdream.net>
 <20150112082250.GA31325@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:53525 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbAPPvY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 10:51:24 -0500
Received: by mail-wi0-f176.google.com with SMTP id z2so1347976wiv.3
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 07:51:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150112082250.GA31325@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 12, 2015 at 10:22:51AM +0200, Mykola Golub wrote:
> On Sun, Jan 11, 2015 at 09:33:57AM -0800, Sage Weil wrote:
> 
> > By the way I took another look and I'm not sure that it is worth 
> > duplicating all of the tree logic for a tree view.  It seems easier to 
> > either include this optionally in the tree output (the utilzation calc is 
> > simpler than the tree traversal stack)... or generalize it somehow?
> 
> Note, we already have duplication, at least CrushWrapper::dump_tree()
> and OSDMap::print_tree(). I will work on generalization, I think some
> tree dumper in CrushWrapper.

I have updated the code. https://github.com/ceph/ceph/pull/3347

-- 
Mykola Golub
