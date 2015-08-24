From: Sage Weil <sage@newdream.net>
Subject: Re: ceph branch status
Date: Mon, 24 Aug 2015 12:04:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508241201280.13116@cobra.newdream.net>
References: <20150824150044.B992E28265C@teuthology.front.sepia.ceph.com> <robbat2-20150824T180539-421145209Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39161 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169AbbHXTEn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 15:04:43 -0400
In-Reply-To: <robbat2-20150824T180539-421145209Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel@vger.kernel.org

On Mon, 24 Aug 2015, Robin H. Johnson wrote:
> Can we get the branch robot to follow forks as well? At least some of
> them? 
> 
> https://github.com/BCLibCoop/ceph  - last $dayjob
> https://github.com/robbat2/ceph - my personal
> https://github.com/dreamhost/ceph - new $dayjob
> 
> The latter one of the list has the almost-ready static-sites code.

Probably the simplest thing is to just set up your own cron job.  The 
script is here:  http://fpaste.org/258643/14404430/  For forked repos we'd 
probably not want to send the full report to ceph-devel...

sage
