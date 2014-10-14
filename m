From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] the state of cephfs in giant
Date: Tue, 14 Oct 2014 07:23:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410140718050.10462@cobra.newdream.net>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net> <543CD16C.6060708@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35402 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbaJNOXl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 10:23:41 -0400
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

There are important bug fixes missing from 3.14.  IIRC, the EC, cache 
tiering, and firefly CRUSH changes aren't there yet either (they landed in 
3.15), and that is not appropriate for a stable series.

They can be backported, but no commitment yet on that :)

sage
