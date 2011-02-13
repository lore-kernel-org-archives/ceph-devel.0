From: Sage Weil <sage@newdream.net>
Subject: Re: Removing an OSD?
Date: Sun, 13 Feb 2011 10:32:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102131030140.27567@cobra.newdream.net>
References: <4D581B82.4090507@nadir-seen-fire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59720 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab1BMSb1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Feb 2011 13:31:27 -0500
In-Reply-To: <4D581B82.4090507@nadir-seen-fire.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: daniel@nadir-seen-fire.com
Cc: ceph-devel@vger.kernel.org

On Sun, 13 Feb 2011, Daniel Friesen wrote:
> I read through most of the documentation on the wiki, though there is one
> thing I couldn't find.
> The OSD cluster expansion/contraction page lists information on adding a node,
> but nothing about removing one.
> In particular there are two things I'm curious about.
> 
> Firstly, when you want to remove a node (decommissioning the hardware, etc...)
> how do you mark it so that ceph will start migrating data away from it onto
> other OSDs?

$ ceph osd out <osd number>

Once it's empty, you can safely shut it off.

> Secondly, how does removing an osd interact with the sequential ids of OSDs?
> The importance of that, including not skipping numbers was underlined strongly
> on another page.

OSD information is assumed to be relatively sequential by the code 
(there are some arrays), so you should avoid doing something like osd1, 
osd2, and osd200.  Other than that it doesn't really matter.  An ID can 
also be reused later if old hardware is phased out and new hardware is 
added.

sage
