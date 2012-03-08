From: Sage Weil <sage@newdream.net>
Subject: Re: Monitor Logs
Date: Thu, 8 Mar 2012 10:14:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203081013480.8347@cobra.newdream.net>
References: <CAFtEh-cpGwU2Uhm4aMRp-OHpPMB1fRAj-Xyq--Pk_PofPL_EFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57079 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab2CHSOU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 13:14:20 -0500
In-Reply-To: <CAFtEh-cpGwU2Uhm4aMRp-OHpPMB1fRAj-Xyq--Pk_PofPL_EFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 8 Mar 2012, Damien Churchill wrote:
> Hi,
> 
> Is it safe to delete the logs in the monitor data directory? I've just
> noticed they haven't been trimmed in months and have grown into the
> gigabytes :)

Yep!  Just don't touch the log/ directory directory itself or ceph-mon 
will get confused.

sage
