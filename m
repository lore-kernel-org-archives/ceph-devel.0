From: Sage Weil <sage@inktank.com>
Subject: Re: Blocking rados_* calls
Date: Thu, 10 Oct 2013 06:45:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310100644130.18301@cobra.newdream.net>
References: <52569498.2090109@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42034 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3JJNp4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Oct 2013 09:45:56 -0400
In-Reply-To: <52569498.2090109@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 10 Oct 2013, Wido den Hollander wrote:
> Hi,
> 
> Currently librados blocks all calls when something is not working inside the
> Ceph cluster.
> 
> This is common practice for fopen(), fread() and fwrite(), but I'm running
> into a use-case where I think the rados_connect() should not block
> indefinitely.
> 
> The use-case here is the RBD storage pool in libvirt. When for whatever reason
> libvirt is not able to connect to the Ceph cluster libvirt will simply block
> and wait on rados_connect() to complete.
> 
> This causes libvirt not being able to report new statistics about the RBD
> storage pool, which causes issues again for the applications using it.
> 
> Would it be an idea that you can configure librados not to block indefinitely
> and return for example ETIMEDOUT?
> 
> By default librados could stay blocking like it's now so nothing changes for
> existing users.

Yeah I think this is definitely doable.  The simplest would be to have a 
configurable (or configurables) that are set via rados_conf_set() (or put 
in the config).  There are several timeouts there already, but I think 
they don't capture the entire connect sequence.

Want to open a feature ticket?

sage
