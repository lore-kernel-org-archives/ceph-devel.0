From: Sage Weil <sage@newdream.net>
Subject: Re: wip-pg-stale
Date: Fri, 27 Jan 2012 15:43:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201271542150.8285@cobra.newdream.net>
References: <Pine.LNX.4.64.1201271330420.8285@cobra.newdream.net>
 <CAF3hT9CZXERFnPOuiZiy12sKBzr7xmjWKo9HtEmD6AJueC_gDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1149120647-1327707795=:8285"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40148 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab2A0XnP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 18:43:15 -0500
In-Reply-To: <CAF3hT9CZXERFnPOuiZiy12sKBzr7xmjWKo9HtEmD6AJueC_gDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1149120647-1327707795=:8285
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 27 Jan 2012, Gregory Farnum wrote:
> On Fri, Jan 27, 2012 at 1:32 PM, Sage Weil <sage@newdream.net> wrote:
> > Please review.
> >
> > If the monitor sees an osdmap go by where nodes go down (or up) it will
> > scan its pg_map and mark any pg whose primary is down as 'stale'. =A0If=
/when
> > the pg recovers, that will get refreshed. =A0If not, the admin will kno=
w
> > something is up.
> Hmm. Without any kind of timeout this flag will get set every time an
> OSD goes down ? the replicas won't alert the new primary until after
> they get the map marking their old primary down, and this check will
> be run synchronously with the generation of the map marking the OSD
> down.
> The "spurious" stale marker on each PG isn't a big deal (it'll
> disappear after a few seconds), but if we're going to set HEALTH_WARN
> based on it, that seems like a bit much to me.

My thought is that as soon as we add the time stamps to the state=20
transition, it'll only warn once things are stale for a while.  We already=
=20
have the same problem with degraded/peering/etc with the health checks...

sage


>=20
> > We'll soon be adding the last_active, last_clean, and now last_unstale =
(?)
> > fields so that bigger alarms can go off when the pg stays stale for mor=
e
> > than a few seconds...
> Yeah; I think we want to use this to trigger big warnings, but not to
> trigger warnings without it.
> -Greg
>=20
>=20
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1149120647-1327707795=:8285--
