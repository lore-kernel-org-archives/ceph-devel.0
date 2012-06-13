From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: debian updates
Date: Wed, 13 Jun 2012 05:05:27 +0000
Message-ID: <1339563927.7726.90.camel@julia>
References: <Pine.LNX.4.64.1206111939390.10716@cobra.newdream.net>
	 <1339471174.7726.71.camel@julia>
	 <Pine.LNX.4.64.1206121004050.6742@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:46289 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab2FMFF1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 01:05:27 -0400
In-Reply-To: <Pine.LNX.4.64.1206121004050.6742@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 2012-06-12 at 10:06 -0700, Sage Weil wrote:
> On Tue, 12 Jun 2012, Laszlo Boszormenyi (GCS) wrote:
> > I can package it if
> > you want. Now my fingers are crossed to accept libs3 soon, it's freeze
> > for Wheezy soon[1]. Ceph 0.47.2 is waiting for that to be in Wheezy.
 libs3 got accepted into the archives and being built on all
architectures. In 12 hours the binaries will be available for the build
network itself. This means I can upload Ceph 0.47.2 soon.

> Great!  Let me know if there's anything else that can be fixed up on this 
> end.
 I had a minor issue with building system libs3 and leveldb libraries.
The build system of Ceph was still looking for
$(BUILDDIR)/src/leveldb/libleveldb.a . Put a symlink there
to /usr/lib/$(ARCH)/libleveldb.a and it was built. I'll recheck this
issue in the afternoon.

Laszlo/GCS

