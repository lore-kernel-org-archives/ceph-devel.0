From: Sage Weil <sage@inktank.com>
Subject: RE: v0.67 Dumpling released
Date: Wed, 14 Aug 2013 08:41:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308140841180.1479@cobra.newdream.net>
References: <alpine.DEB.2.00.1308132222350.18836@cobra.newdream.net> <24E144B8C0207547AD09C467A8259F75590569E1@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51299 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759356Ab3HNPlp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 11:41:45 -0400
In-Reply-To: <24E144B8C0207547AD09C467A8259F75590569E1@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 14 Aug 2013, Dietmar Maurer wrote:
> > Another three months have gone by, and the next stable release of Ceph is
> > ready: Dumpling!  Thank you to everyone who has contributed to this release!
> 
> Seem there is a new dependency in the ceph-common debian package: python-ceph
> 
> Is that really required (previous release does not depend on that)?

It is.  The new 'ceph' CLI utility is written in python and uses the 
librados python bindings to communicate with the cluster.

sage
