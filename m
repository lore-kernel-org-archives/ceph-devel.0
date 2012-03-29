From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-osd and ceph-mon
Date: Thu, 29 Mar 2012 08:56:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203290854120.32695@cobra.newdream.net>
References: <CAMvP8PCiyciY8keCKbmOzv+Ay+LY+oUfaTow37xMBKhKz7ik2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759504Ab2C2P4S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Mar 2012 11:56:18 -0400
In-Reply-To: <CAMvP8PCiyciY8keCKbmOzv+Ay+LY+oUfaTow37xMBKhKz7ik2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 29 Mar 2012, Tomasz Paszkowski wrote:
> Hi,
> 
> I'am working on improving security level for ceph (osd and mon). Are
> there any specific consideratons to run ceph-osd and ceph-mon as non
> root user with apparmor profile ?

There is no reason these can't run as non-root users.  The only 
requirement is that for ceph-osd, if you are using btrfs, you need to 
mount with '-o user_subvol_rm_allowed'.

Beyond that, I'm not familiar enough with apparmor to know what specific 
considerations there may be.

sage
