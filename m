From: Sage Weil <sage@newdream.net>
Subject: Re: why package ceph-fuse needs packages ceph?
Date: Mon, 26 Oct 2015 00:19:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510260014500.3986@cobra.newdream.net>
References: <CAKZcxgdm9fQEDqV3=t36_YfxoejzxAyEUL6MNCXn0MwEzCGjkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58105 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbJZHTS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 03:19:18 -0400
In-Reply-To: <CAKZcxgdm9fQEDqV3=t36_YfxoejzxAyEUL6MNCXn0MwEzCGjkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 26 Oct 2015, Jaze Lee wrote:
> Hello,
>     I think the ceph-fuse is just a client, why it needs packages ceph?
>     I found when i install ceph-fuse, it will install package ceph.
>     But when i install ceph-common, it will not install package ceph.
> 
>     May be ceph-fuse is not just a ceph client?
> 

It is, and the Debian packaging works as expected.  This is a simple 
error in the spec file.  I'll submit a patch.

sage
