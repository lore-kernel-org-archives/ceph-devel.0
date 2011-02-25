From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated. v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 13:18:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102251317230.23080@cobra.newdream.net>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
 <87AD89F7CCC04A709286360DDD9F65F1@gmail.com> <Pine.LNX.4.64.1102250904540.21533@cobra.newdream.net>
 <AANLkTikq+3HoazmqJ8BY2zqs6zzOYAmmnCtOrjtcS557@mail.gmail.com>
 <AANLkTin93Xn+jw+ROtLdw2cDVPR_9bu7y5OTBB0Fyyzw@mail.gmail.com>
 <Pine.LNX.4.64.1102251143450.23080@cobra.newdream.net>
 <AANLkTimbiWABVRxffKz6XwzojtJAy2zpaX2LwL0npHMm@mail.gmail.com>
 <AANLkTi=XvPve25vPewN_37rbJVM8QauqU9Os9oEZpu2M@mail.gmail.com>
 <Pine.LNX.4.64.1102251256550.23080@cobra.newdream.net>
 <AANLkTikS+XPenn2gU2EaDLSq87U+H6=10z3uNKBCTWz4@mail.gmail.com>
 <AANLkTikcwTgkUzADa8tjqoZTW9AN7v7WtLA03Y_kTxUb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1014570776-1298668722=:23080"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58238 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475Ab1BYVRB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 16:17:01 -0500
In-Reply-To: <AANLkTikcwTgkUzADa8tjqoZTW9AN7v7WtLA03Y_kTxUb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1014570776-1298668722=:23080
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 25 Feb 2011, Colin Patrick McCabe wrote:
> rados_ioctx_t seems to describe this object pretty well...
> I would lean away from rados_handle_t because it's too generic
> sounding and could be confused with the cluster_t.

Sounds good to me.  And Rados::Ioctx I guess (IOCtx caps are too annoying=
=20
IMO).

rados_ioctx_{open,close}?

sage


>=20
> C.
>=20
>=20
> On Fri, Feb 25, 2011 at 1:01 PM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
> > On Fri, Feb 25, 2011 at 12:57 PM, Sage Weil <sage@newdream.net> wrote:
> >> On Fri, 25 Feb 2011, Colin Patrick McCabe wrote:
> >>> Another idea: pool_t -> pool_context_t, PoolHandle -> PoolContext
> >>
> >> I prefer rados_ioctx_t or rados_handle_t.. putting pool in the name is
> >> what is confusing (for me). =A0Which pool you're using is just one (of
> >> potentially many) pieces of context/state associated with the handle.
> >>
> >
> > Yeah. I'd also rename the rados_pool_open()/close() to something else,
> > e.g., rados_open() and rados_close() or rados_x_open() and
> > rados_x_close() where x is not pool.
> >
> > Yehuda
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1014570776-1298668722=:23080--
