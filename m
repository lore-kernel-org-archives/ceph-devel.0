From: Sage Weil <sage@inktank.com>
Subject: Re: file system creation
Date: Tue, 12 Jun 2012 12:47:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206121245530.6742@cobra.newdream.net>
References: <4FD797F8.7090606@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33527 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab2FLTrR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 15:47:17 -0400
In-Reply-To: <4FD797F8.7090606@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 12 Jun 2012, Matt Weil wrote:
> is there a parallel option for mkcephfs? seems to create one osd at a time.

No, but if you look at the top of /sbin/mkcephfs, you can see that it is 
built to be run in distinct steps that can be parallelized with your 
favorite tools.

sage
