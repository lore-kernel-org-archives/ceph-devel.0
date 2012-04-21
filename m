From: Sage Weil <sage@newdream.net>
Subject: Re: Question in crush_add_tree_bucket_item
Date: Sat, 21 Apr 2012 10:47:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204211046370.29786@cobra.newdream.net>
References: <CALwGbPLPaAz3-NbXLtyQWt_QeA9v1bur7kygrAX47q8+_pyYzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39067 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab2DURrd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Apr 2012 13:47:33 -0400
In-Reply-To: <CALwGbPLPaAz3-NbXLtyQWt_QeA9v1bur7kygrAX47q8+_pyYzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 21 Apr 2012,  wrote:
> Hi, everyone.
> 
> While reading crush_remove_tree_bucket_item, I found that removed
> items will still occupy its original position in the tree, but set its
> weight to 0.

Yes.. moving items around can result in shifted data.

> And in crush_add_tree_bucket_item, why don't we reuse these items with
> 0 weight since I don't see additional data migration if we reuse these
> nodes?

Lazy implementation.  Ideally we should reuse those slots.  Patches 
welcome!  In most cases, people are probably well-served by the straw 
bucket, though, so this may not matter too much.

sage

