From: Sage Weil <sweil@redhat.com>
Subject: Re: Sorting pull requests per label
Date: Sat, 4 Oct 2014 20:50:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410042050270.31126@cobra.newdream.net>
References: <542FD332.6040408@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46042 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaJEDui (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Oct 2014 23:50:38 -0400
In-Reply-To: <542FD332.6040408@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is soo much better!  Thanks, Loic :)

sage

On Sat, 4 Oct 2014, Loic Dachary wrote:

> Hi Ceph,
> 
> The bug / feature labels were added to make them easier to find:
> 
> Pending bugs https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+label%3A%22bug+fix%22
> Pending features https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+label%3Afeature
> 
> There also is one tag per release:
> 
> Pending for giant https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+label%3Agiant
> Pending firefly backports https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+label%3Afirefly
> etc.
> 
> Cheers
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
