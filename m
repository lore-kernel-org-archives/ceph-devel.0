From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rbd layering
Date: Tue, 1 Feb 2011 09:43:39 -0800
Message-ID: <20110201174339.GB13828@dreamer>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46280 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab1BARnj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 12:43:39 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 31, 2011 at 10:08:31PM -0800, Sage Weil wrote:
> A few use cases for all of this:
>  - "golden" VM images
>  - writeable snapshots
>  - image migration between pools
>    - pause io
>    - mark parent read-only
>    - create "child" image
>    - unpause io, redirect to the new child
>    (these steps are all fast and O(1)!)
>    - asynchronously copy-up parent blocks to the child (this is O(n))
>    - once this is done, remove the child's parent reference and discard 
>      the parent

Two things to add:

- creating something that can be later used to do lazy deduplication
  in the background would be good; you don't always "start from the
  golden master", but you still have images that are 99% identical.

- the "child has zero extents that should not be read from master"
  case would happen mostly by TRIM operations, these days.

-- 
:(){ :|:&};:
