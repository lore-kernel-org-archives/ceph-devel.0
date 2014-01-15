From: Sage Weil <sage@inktank.com>
Subject: Re: ceph cli delay when one mon is down
Date: Tue, 14 Jan 2014 23:25:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401142323550.11815@cobra.newdream.net>
References: <24E144B8C0207547AD09C467A8259F75592E9F78@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46277 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbaAOHZf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 02:25:35 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F75592E9F78@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 15 Jan 2014, Dietmar Maurer wrote:
> Hi all,
> 
> I use a few helper scripts to automate things, and those scripts call 'ceph' command
> multiple times, like
> 
> ------------
> #/bin/sh
> 
> ceph do something
> ...
> ceph do something else
> ...
> ---------------
> 
> I get a delay when one monitor is down, until a working mon is found.
> That is OK so far.
> 
> But I get that delay each times when I run a 'ceph' command. It would
> be great if ceph remembers the last successful mon connection, so that such 
> delays are avoided. 

You can avoid this, and speed things up in general, by using the 
interactive mode:

#!/bin/sh
ceph <<EOM
do something
do something else
EOM

Caching the last successfully connected mon isn't a bad idea either... 
care to open a feature ticket?

sage
