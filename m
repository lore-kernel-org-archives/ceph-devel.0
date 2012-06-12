From: Sage Weil <sage@inktank.com>
Subject: Re: debian updates
Date: Tue, 12 Jun 2012 10:06:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206121004050.6742@cobra.newdream.net>
References: <Pine.LNX.4.64.1206111939390.10716@cobra.newdream.net>
 <1339471174.7726.71.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58943 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2FLRGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 13:06:25 -0400
In-Reply-To: <1339471174.7726.71.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

On Tue, 12 Jun 2012, Laszlo Boszormenyi (GCS) wrote:
> Hi Sage,
> 
> On Mon, 2012-06-11 at 19:41 -0700, Sage Weil wrote:
> > Can you take a look at the last 4 commits of
> > 	https://github.com/ceph/ceph/commits/debian
> > and let me know if they address the issues you mentioned?
>  Yes, they fixes those issues I've mentioned. However you could keep
> ceph-kdump-copy for Ubuntu. It's not installable on Debian through, as
> its dependency linux-crashdump is not available.

I already stuck it in a separate package in http://ceph.com/qa/debian, 
since it really isn't directly related to ceph itself anyway.

> I can package it if
> you want. Now my fingers are crossed to accept libs3 soon, it's freeze
> for Wheezy soon[1]. Ceph 0.47.2 is waiting for that to be in Wheezy.

Great!  Let me know if there's anything else that can be fixed up on this 
end.

sage


> Laszlo/GCS
> [1] http://lists.debian.org/debian-devel-announce/2012/05/msg00004.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
