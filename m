From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 11:48:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102251143450.23080@cobra.newdream.net>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
 <87AD89F7CCC04A709286360DDD9F65F1@gmail.com> <Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
 <AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
 <AANLkTin93Xn+jw+ROtLdw2cDVPR_9bu7y5OTBB0Fyyzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45072 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710Ab1BYTqo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 14:46:44 -0500
In-Reply-To: <AANLkTin93Xn+jw+ROtLdw2cDVPR_9bu7y5OTBB0Fyyzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Colin Patrick McCabe <colin.mccabe@dreamhost.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 25 Feb 2011, Yehuda Sadeh Weinraub wrote:
> On Fri, Feb 25, 2011 at 10:31 AM, Colin Patrick McCabe
> <colin.mccabe@dreamhost.com> wrote:
> > I kind of want to prefix all the object operations with "obj_" just to
> > make things clear. Then it would be rados_obj_rollback() /
> > PoolHandle::obj_rollback().
> > What do you think?
> >
> 
> The 'o' in rados stands for object.

We're definitely moving into bikeshedding territory now, but one thing 
Yehuda suggested:

The pool handle (rados_pool_t, PoolHandle) has state associated with it, 
including the snap to read from or snap context to write with.  That's not 
obvious from the name.  Maybe it should be renamed rados_ioctx_t to be 
more clear.  Then the pool we're reading to/writing from becomes one more 
piece of state associated with the handle.

sage
