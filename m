From: Brian Jackson <iggy@theiggy.com>
Subject: Re: PATCH: link ceph-client version to kernel version
Date: Wed, 7 Jul 2010 13:04:18 -0500
Message-ID: <201007071304.18434.iggy@theiggy.com>
References: <i11fb7$mk1$1@dough.gmane.org> <201007071234.35911.iggy@theiggy.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from theiggy.com ([66.220.1.110]:42648 "EHLO mail.theiggy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424Ab0GGSEU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Jul 2010 14:04:20 -0400
In-Reply-To: <201007071234.35911.iggy@theiggy.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Wednesday, July 07, 2010 12:34:35 pm Brian Jackson wrote:
> On Wednesday, July 07, 2010 03:54:00 am Thomas Mueller wrote:
> > hi
> > 
> > reading the version in ceph_fs.h made me think, that now that ceph is in
> > vanilla kernel, it would be nice to have the version linked to the kernel
> > version. this is how the kvm guys work for their backported module.
> 
> That makes sense for KVM because it's reached a level of maturity where
> they only bother doing the backports of specific kernel releases. I don't
> think it's a good idea for ceph to go this direction yet. Mostly I'd hate
> to see the standalone client packages only released when there's a new
> kernel. It seems like something that would be more useful once ceph has
> some kernel releases under it's belt.


Cancel that. Talked to sagewk on irc and he said development of the kclient is 
taking place in upstream git now, so I guess this does make sense.



> 
> > I've also patched super.c to expose the version to modinfo.
> > 
> > - Thomas
> 
> <snip>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
