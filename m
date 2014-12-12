From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-disk handling journal device with persistent path name
Date: Fri, 12 Dec 2014 14:18:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412121416060.22847@cobra.newdream.net>
References: <CAPHS-z5CuGOHtjpBSuVY0XfaLbMmWi2pZWBVKXvyu3HFXDBoiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51134 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaLLWSR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 17:18:17 -0500
In-Reply-To: <CAPHS-z5CuGOHtjpBSuVY0XfaLbMmWi2pZWBVKXvyu3HFXDBoiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fred Yang <frederic.yang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, adeza@redhat.com, trhoden@redhat.com

On Fri, 12 Dec 2014, Fred Yang wrote:
> ceph-disk does not support journal device using path /dev/disk/by-path
> currently since the the device name has colon, this has been reported
> over 1 year ago:
> 
> http://tracker.ceph.com/issues/5283
> 
> But it was set to "Won't fix" few months ago, can particular reason?
> >From user's perspective, after journal disk got replaced, the device
> name can shift to be different as original /dev/sdX, instead of
> relinking the journal device in OSD after disk replace, it's much
> easier to just reference H/W path like /dev/disk/by-path.

I think it was Won't Fix for lack of a vocal user or reasonable use-case 
for wanting it.  IIRC the issue is just that it breaks the ceph-deploy 
syntax of host:dev[:journaldev].  Perhaps it is enough to just choose an 
alternate separator character (one that won't appear in a device 
path)...

sage
