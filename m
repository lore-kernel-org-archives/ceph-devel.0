From: Sage Weil <sage@inktank.com>
Subject: Re: How to delete a mds?
Date: Mon, 25 Jun 2012 21:16:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206252114550.21315@cobra.newdream.net>
References: <CAPud5_4V=7U+OsVy7cyTwW3_dU8cEBhjw1bpEtM75WczyYvCqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57297 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2FZEQL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 00:16:11 -0400
In-Reply-To: <CAPud5_4V=7U+OsVy7cyTwW3_dU8cEBhjw1bpEtM75WczyYvCqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 25 Jun 2012, Nick Bartos wrote:
> We decided to stop using the posix filesystem, and as such have
> stopped running ceph-mds (and removed the mds things from ceph.conf).
> However we get warnings about the missing mds when running 'ceph
> health'.
> 
> How do I delete all the mdses?  I tried 'ceph mds rm <mdsname>' but
> that doesn't seem to do any good.

The 'rm' refuses to do it if it is in use.  Instead,

 - make sure the ceph-mds daemon(s) aren't running
 - ceph mds newfs metadata data

That will blow away the old mdsmap (and fs metadata!).  Until a new 
'first' ceph-mds starts up, ceph health won't complain.

sage

