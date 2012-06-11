From: Sage Weil <sage@inktank.com>
Subject: Re: class exec test
Date: Mon, 11 Jun 2012 09:54:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206110954270.10557@cobra.newdream.net>
References: <Pine.LNX.4.64.1206102200490.3347@cobra.newdream.net>
 <4FD59539.6000902@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46249 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab2FKQy5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 12:54:57 -0400
In-Reply-To: <4FD59539.6000902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Sun, 10 Jun 2012, Josh Durgin wrote:
> On 06/10/2012 10:03 PM, Sage Weil wrote:
> > Hey-
> > 
> > The librados api tests were calling a dummy "test_exec" method in cls_rbd
> > that apparently got removed.  We probably want to replace the test with
> > *something*, though...  maybe a "version" or similar command that just
> > returns the version of the class?  Or an OSD built-in dummy class with
> > no-op methods?
> 
> I replaced this with a get_all_features method in the wip-rados-test
> branch. With this, the rbd tool can report the features that can be used
> to create a new image.

Looks good, pushed to master.

s
