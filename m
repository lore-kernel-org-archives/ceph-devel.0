From: Sage Weil <sage@newdream.net>
Subject: Re: Errors on compiling master-backport of ceph-client-standalone
Date: Thu, 16 Dec 2010 10:06:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012161005070.15523@cobra.newdream.net>
References: <AANLkTinJW=QHXpsq1K_arYW5goARdPV15UTpEi6hYz51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39826 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab0LPSBh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 13:01:37 -0500
In-Reply-To: <AANLkTinJW=QHXpsq1K_arYW5goARdPV15UTpEi6hYz51@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 16 Dec 2010, Henry C Chang wrote:
> Hi,
> 
> Just tried to compile master-backport of ceph-client-standalone and got errors.
> I did two modifications to fix the errors:
> 
> 1. include <linux/smp_lock.h> in ceph/mds_client.c for lock_kernel()

Pushed this to the master-backport branch.

> 2. Revert commit "convert ceph"
> (ff8a8d2006dca58f71b5dc5df0c95b8f837a0a4e) because mount operation
> does not exist before 2.6.37.

Sigh... this one is going to be a pain to surround with kernel version 
#ifdefs.  The commit that needs to be conditional on the version is Al's, 
ff8a8d20.  Any takers?

sage
