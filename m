From: Sage Weil <sage@newdream.net>
Subject: Re: the state of cephfs in giant
Date: Tue, 14 Oct 2014 06:09:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410140606080.31128@cobra.newdream.net>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net> <543CD16C.6060708@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34920 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201AbaJNNJL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 09:09:11 -0400
In-Reply-To: <543CD16C.6060708@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Tue, 14 Oct 2014, Amon Ott wrote:
> Am 13.10.2014 20:16, schrieb Sage Weil:
> > We've been doing a lot of work on CephFS over the past few months. This
> > is an update on the current state of things as of Giant.
> ...
> > * Either the kernel client (kernel 3.17 or later) or userspace (ceph-fuse
> >   or libcephfs) clients are in good working order.
> 
> Thanks for all the work and specially for concentrating on CephFS! We
> have been watching and testing for years by now and really hope to
> change our Clusters to CephFS soon.
> 
> For kernel maintenance reasons, we only want to run longterm stable
> kernels. And for performance reasons and because of severe known
> problems we want to avoid Fuse. How good are our chances of a stable
> system with the kernel client in the latest longterm kernel 3.14? Will
> there be further bugfixes or feature backports?

We haven't been backporting CephFS bug fixes to the stable kernels the 
same way we've been doing RBD bugs; it's a bit of a chore.  This can be 
done retroactively but no promises.  Probably 3.14 makes the most sense.  
The RHEL7/CentOS7 kernel is also a likely target.

sage
