From: Sage Weil <sage@newdream.net>
Subject: Re: v0.28.1 still seeing "wrongly marked me down"
Date: Wed, 25 May 2011 08:58:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105250857580.29945@cobra.newdream.net>
References: <201105251236.08622.michal.humpula@hudrydum.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45901 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1EYP5C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 11:57:02 -0400
In-Reply-To: <201105251236.08622.michal.humpula@hudrydum.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Humpula <michal.humpula@hudrydum.cz>
Cc: ceph-devel@vger.kernel.org

On Wed, 25 May 2011, Michal Humpula wrote:
> Hi, 
> 
> I've just compiled the recent version of ceph v0.28.1. I wanted to give it a 
> try on a setup of 8 machines (1 core Opterons). The design is 3 mons, 2 mds 
> and 10 osds. Running latest vanilla kernel 2.6.29 with btrfs as a filestore.
> 
> After initial setup, ceph -w is printing a lot of these
> 
> 2011-05-25 12:19:38.720110   log 2011-05-25 12:19:37.671620 osd5 
> 192.168.0.23:6803/18299 151 : [WRN] map e3577 wrongly marked me down or wrong 
> addr
> 2011-05-25 12:19:18.398004   log 2011-05-25 12:19:18.333978 mon0 
> 192.168.0.10:6789/0 3968 : [INF] osd6 192.168.0.24:6800/2830 failed (by osd7 
> 192.168.0.24:6801/3064)
> 
> I've tried to setup
> 
> osd op threads = 1
> 
> and
> 
> osd op threads = 0
> 
> but it doesn't seem to have any impact on a number of cosd daemon threads. 
> Still seeing +20 of them and still seeing messages about degradation. 
> 
> Any hint, what to setup differently, would be appreciated.

If you can reproduce this behavior with

	debug osd = 10
	debug ms = 10

in your [osd] section it should have enough information for us to identify 
the problem.

Thanks!
sage
