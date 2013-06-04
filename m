From: Sage Weil <sage@inktank.com>
Subject: Re: flatten rbd export / export-diff ?
Date: Tue, 4 Jun 2013 08:23:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306040821550.12900@cobra.newdream.net>
References: <51ADEE2B.4050403@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55088 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3FDPXG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 11:23:06 -0400
In-Reply-To: <51ADEE2B.4050403@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 4 Jun 2013, Stefan Priebe - Profihost AG wrote:
> Hi,
> 
> is there a way to flatten the rbd export-diff to a "new" image FILE. Or
> do i always have to:
> 
> rbd import "OLD BASE IMAGE"
> rbd import-diff diff1
> rbd import-diff diff1-2
> rbd import-diff diff2-3
> rbd import-diff diff3-4
> rbd import-diff diff4-5
> ...
> and so on?
> 
> I would like to apply the diffs on local disk and then import the new file.

Not currently.  The format is very simple, though; it should be pretty 
simple to implement a subcommand in the rbd tool to do it.

sage
