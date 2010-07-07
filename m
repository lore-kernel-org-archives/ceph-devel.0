From: Brian Jackson <iggy@theiggy.com>
Subject: Re: PATCH: link ceph-client version to kernel version
Date: Wed, 7 Jul 2010 12:34:35 -0500
Message-ID: <201007071234.35911.iggy@theiggy.com>
References: <i11fb7$mk1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from theiggy.com ([66.220.1.110]:41775 "EHLO mail.theiggy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699Ab0GGRnI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Jul 2010 13:43:08 -0400
In-Reply-To: <i11fb7$mk1$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Wednesday, July 07, 2010 03:54:00 am Thomas Mueller wrote:
> hi
> 
> reading the version in ceph_fs.h made me think, that now that ceph is in
> vanilla kernel, it would be nice to have the version linked to the kernel
> version. this is how the kvm guys work for their backported module.


That makes sense for KVM because it's reached a level of maturity where they 
only bother doing the backports of specific kernel releases. I don't think 
it's a good idea for ceph to go this direction yet. Mostly I'd hate to see the 
standalone client packages only released when there's a new kernel. It seems 
like something that would be more useful once ceph has some kernel releases 
under it's belt.



> 
> I've also patched super.c to expose the version to modinfo.
> 
> - Thomas
> 
> 
<snip>
