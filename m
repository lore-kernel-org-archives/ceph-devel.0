From: Sage Weil <sage@newdream.net>
Subject: Re: new dev cluster - using giant or hammer git?
Date: Fri, 6 Feb 2015 06:06:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502060606281.27042@cobra.newdream.net>
References: <54D4C7F2.1090505@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58930 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbbBFOGv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 09:06:51 -0500
In-Reply-To: <54D4C7F2.1090505@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 6 Feb 2015, Stefan Priebe - Profihost AG wrote:
> Hi,
> 
> for deploying a new ceph dev cluster can anybody recommand which git
> branch to use? hammer or giant-backport?

Hi Stefan!

If it's dev I'd recommend hammer.  If all of your clients will be new I'd 
also recommand 'ceph osd crush tunables hammer' as there is a new and 
improve crush bucket type.  :)

sage
