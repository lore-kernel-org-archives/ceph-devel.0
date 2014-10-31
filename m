From: Sage Weil <sage@newdream.net>
Subject: Re: Fix dead looping in Objecter::handle_osd_map
Date: Fri, 31 Oct 2014 08:06:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410310805390.27022@cobra.newdream.net>
References: <CANf+_kJEFtzt3r8Y0XuZsodw4AiFem8oezV4A+T-FnMcB18oFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52845 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbaJaPGL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Oct 2014 11:06:11 -0400
In-Reply-To: <CANf+_kJEFtzt3r8Y0XuZsodw4AiFem8oezV4A+T-FnMcB18oFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ding Dinghua <dingdinghua85@gmail.com>
Cc: ceph-devel@vger.kernel.org

These look correct to me.  Can I add your Signed-off-by: to the patch?

https://github.com/ceph/ceph/blob/master/SubmittingPatches

Thanks!
sage


On Fri, 31 Oct 2014, Ding Dinghua wrote:

> Hi all:
>         I hit this bug when I was using ceph-fuse client. I mount a
> ceph-fuse client, and left it idle for a long time, then when I copy
> some files to ceph,  ceph-fuse hang,  the following log shows that
> Objecter::handle_osd_map is dead-looping:
> 
> handle_osd_map missing epoch 6445, jumping to 6579
> handle_osd_map missing epoch 6445, jumping to 6579
> handle_osd_map missing epoch 6445, jumping to 6579
> handle_osd_map missing epoch 6445, jumping to 6579
> handle_osd_map missing epoch 6445, jumping to 6579
> handle_osd_map missing epoch 6445, jumping to 6579
> handle_osd_map missing epoch 6445, jumping to 6579
> handle_osd_map missing epoch 6445, jumping to 6579
> 
> the attached patch should have fixed the bug.
> 
> 
> -- 
> Ding Dinghua
> 
