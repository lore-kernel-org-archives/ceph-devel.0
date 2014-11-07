From: Andrew Shewmaker <agshew@gmail.com>
Subject: Re: =?utf-8?Q?=CE=99nstrumentin?= =?utf-8?Q?g?= RADOS with Zipkin +
 LTTng
Date: Fri, 7 Nov 2014 10:29:05 -0700
Message-ID: <20141107172905.GA7184@localhost>
References: <20141030184938.GA10197@radon.localdomain>
 <alpine.DEB.2.00.1411070230091.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49271 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbaKGR3K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Nov 2014 12:29:10 -0500
Received: by mail-pd0-f179.google.com with SMTP id g10so3711816pdj.10
        for <ceph-devel@vger.kernel.org>; Fri, 07 Nov 2014 09:29:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1411070230091.15135@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Nov 07, 2014 at 02:32:51AM -0800, Sage Weil wrote:
> 
> On Thu, 30 Oct 2014, Andrew Shewmaker wrote:
> > 
> > Should I put effort into adding a "--with-blkin" or "--with-zipkin"
> > option to autoconf?
> 
> Is it statically or dynamically linked?
> 
> Probably a first step is to get it in the gitbuilder (test/qa) builds.  

Okay, I'll work on getting it in gitbuilder.

It's dynamically linked, and I imagine blkin will be useful outside 
of Ceph, at least for apps built on top of Ceph.

So before getting it in gitbuilder, I'm thinking I'll add blkin as a
submodule that is always built. Then after it's in gitbuilder I'll put
in autoconf support and build libblkin and libblkin-dev packages?
Would you prefer autoconf to enable blkin by default?

Andrew
