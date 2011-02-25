From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 13:02:31 -0800
Message-ID: <AANLkTikcwTgkUzADa8tjqoZTW9AN7v7WtLA03Y_kTxUb@mail.gmail.com>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
	<87AD89F7CCC04A709286360DDD9F65F1@gmail.com>
	<Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
	<AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
	<AANLkTin93Xn+jw+ROtLdw2cDVPR_9bu7y5OTBB0Fyyzw@mail.gmail.com>
	<Pine.LNX.4.64.1102251143450.23080@cobra.newdream.net>
	<AANLkTimbiWABVRxffKz6XwzojtJAy2zpaX2LwL0npHMm@mail.gmail.com>
	<AANLkTi=XvPve25vPewN_37rbJVM8QauqU9Os9oEZpu2M@mail.gmail.com>
	<Pine.LNX.4.64.1102251256550.23080@cobra.newdream.net>
	<AANLkTikS+XPenn2gU2EaDLSq87U+H6=10z3uNKBCTWz4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37774 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab1BYVCm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 16:02:42 -0500
Received: by fxm17 with SMTP id 17so2084944fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 13:02:41 -0800 (PST)
In-Reply-To: <AANLkTikS+XPenn2gU2EaDLSq87U+H6=10z3uNKBCTWz4@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

rados_ioctx_t seems to describe this object pretty well...
I would lean away from rados_handle_t because it's too generic
sounding and could be confused with the cluster_t.

C.


On Fri, Feb 25, 2011 at 1:01 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Fri, Feb 25, 2011 at 12:57 PM, Sage Weil <sage@newdream.net> wrote=
:
>> On Fri, 25 Feb 2011, Colin Patrick McCabe wrote:
>>> Another idea: pool_t -> pool_context_t, PoolHandle -> PoolContext
>>
>> I prefer rados_ioctx_t or rados_handle_t.. putting pool in the name =
is
>> what is confusing (for me). =A0Which pool you're using is just one (=
of
>> potentially many) pieces of context/state associated with the handle=
=2E
>>
>
> Yeah. I'd also rename the rados_pool_open()/close() to something else=
,
> e.g., rados_open() and rados_close() or rados_x_open() and
> rados_x_close() where x is not pool.
>
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
