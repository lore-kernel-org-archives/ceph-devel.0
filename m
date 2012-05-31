From: Sage Weil <sage@inktank.com>
Subject: Re: Question about libcephfs mounting mechanism
Date: Wed, 30 May 2012 21:40:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205302139140.21518@cobra.newdream.net>
References: <CAHwdYF15M3FuiQicZBqZThz63g6AVGYGEHFutXktx64XrWNyEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59539 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab2EaEkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 00:40:42 -0400
In-Reply-To: <CAHwdYF15M3FuiQicZBqZThz63g6AVGYGEHFutXktx64XrWNyEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nam Dang <namd@de.cs.titech.ac.jp>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 31 May 2012, Nam Dang wrote:
> Dear all,
> 
> I want to inquire on ceph's internal mounting mechanism. I am using
> wip-java-cephfs API to access Ceph internal file system directly.
> I want to create several threads that access cephFS simultaneously and
> independently, i.e. the mounting in each thread is
> independent from the other's, and there is no shared underlying data
> structure. As far as I know, java-ceph does not use shared structure,
> but I'm not so sure about the underlying code in libcephfs though. I'm
> worried that it may be similar to Virtual File System layer, upon
> which multiple threads can access concurrently but internally the
> mounting point is shared. I hope somebody with experience with Ceph
> can help me answer this question.

Each ceph_create() call instantiates a new instance of the client, and 
nothing is shared between clients.  This should get you the behavior 
you're after!

Cheers-
sage
