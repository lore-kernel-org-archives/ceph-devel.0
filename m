From: Sage Weil <sage@newdream.net>
Subject: Re: Assertion in v0.40 - os/FileStore.cc: 2438: FAILED assert(0 ==
 "unexpected error")
Date: Sat, 14 Jan 2012 18:45:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201141835180.21391@cobra.newdream.net>
References: <4F1193DE.7040202@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59063 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab2AOCph (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2012 21:45:37 -0500
In-Reply-To: <4F1193DE.7040202@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Hi Martin-

On Sat, 14 Jan 2012, Martin Mailand wrote:

> Hi
> one of four OSD died during the update to v0.40 with an Assertion
> os/FileStore.cc: 2438: FAILED assert(0 == "unexpected error")
> Even after a complete shutdown of the cluster an a new start with all OSD at
> the same version, this osd did not start.
> 
> The OSD Log it attached.

It's trying to replay a transaction that appears to be invalid because the 
.2 clone is smaller than it thinks.  Is this the first time the OSD 
crashed, or did it crash once, and you cranked up logs and generated 
this one?  If you have the previous log, that would be helpful... it 
should have a similar tranasction dump but a different stack trace.

Also, are any of the 6 patches on top of 0.40 related to the filestore or 
osd?

Thanks!
sage

