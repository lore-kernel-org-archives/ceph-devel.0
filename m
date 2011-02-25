From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 12:57:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102251256550.23080@cobra.newdream.net>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
 <87AD89F7CCC04A709286360DDD9F65F1@gmail.com> <Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
 <AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
 <AANLkTin93Xn+jw+ROtLdw2cDVPR_9bu7y5OTBB0Fyyzw@mail.gmail.com>
 <Pine.LNX.4.64.1102251143450.23080@cobra.newdream.net>
 <AANLkTimbiWABVRxffKz6XwzojtJAy2zpaX2LwL0npHMm@mail.gmail.com>
 <AANLkTi=XvPve25vPewN_37rbJVM8QauqU9Os9oEZpu2M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48445 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab1BYU4Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 15:56:16 -0500
In-Reply-To: <AANLkTi=XvPve25vPewN_37rbJVM8QauqU9Os9oEZpu2M@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 25 Feb 2011, Colin Patrick McCabe wrote:
> Another idea: pool_t -> pool_context_t, PoolHandle -> PoolContext

I prefer rados_ioctx_t or rados_handle_t.. putting pool in the name is 
what is confusing (for me).  Which pool you're using is just one (of 
potentially many) pieces of context/state associated with the handle.

sage
