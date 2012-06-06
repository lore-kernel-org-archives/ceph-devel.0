From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: [PATCH] ceph.spec.in: Fix license to GPL-2.0 and use SPDX
 format
Date: Tue, 5 Jun 2012 23:59:46 -0400 (EDT)
Message-ID: <297035103.352.1338955186927.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <Pine.LNX.4.64.1206051928360.5946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([134.215.213.37]:1024 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab2FFEFN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jun 2012 00:05:13 -0400
In-Reply-To: <Pine.LNX.4.64.1206051928360.5946@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Holger Macht <hmacht@suse.de>

That wouldn't seem to make a lot of sense, no.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> On Tue, 5 Jun 2012, Holger Macht wrote:
> > Minor spec file fix. LGPLv2 in spec file is not correct, because
> some of
> > the included packages/binaries are GPLv2. For example:
> > 
> >  src/os/btrfs_ioctl.h -> package ceph, binary ceph-osd
> 
> My understanding is that including a header file (in this case, to get
> the 
> ioctl number) does not create a derivative work.  Is that incorrect?
> 


-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
