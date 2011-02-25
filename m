From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 10:36:13 -0800
Message-ID: <AANLkTin93Xn+jw+ROtLdw2cDVPR_9bu7y5OTBB0Fyyzw@mail.gmail.com>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
	<87AD89F7CCC04A709286360DDD9F65F1@gmail.com>
	<Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
	<AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49971 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab1BYSgO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 13:36:14 -0500
Received: by wwe15 with SMTP id 15so955503wwe.1
        for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 10:36:13 -0800 (PST)
In-Reply-To: <AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 25, 2011 at 10:31 AM, Colin Patrick McCabe
<colin.mccabe@dreamhost.com> wrote:
> I kind of want to prefix all the object operations with "obj_" just to
> make things clear. Then it would be rados_obj_rollback() /
> PoolHandle::obj_rollback().
> What do you think?
>

The 'o' in rados stands for object.

Yehuda
