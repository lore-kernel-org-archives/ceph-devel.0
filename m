From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: wip-pg-stale
Date: Fri, 27 Jan 2012 14:11:49 -0800
Message-ID: <CAF3hT9CZXERFnPOuiZiy12sKBzr7xmjWKo9HtEmD6AJueC_gDg@mail.gmail.com>
References: <Pine.LNX.4.64.1201271330420.8285@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39753 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab2A0WLu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 17:11:50 -0500
Received: by iacb35 with SMTP id b35so2575385iac.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2012 14:11:49 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201271330420.8285@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 27, 2012 at 1:32 PM, Sage Weil <sage@newdream.net> wrote:
> Please review.
>
> If the monitor sees an osdmap go by where nodes go down (or up) it wi=
ll
> scan its pg_map and mark any pg whose primary is down as 'stale'. =A0=
If/when
> the pg recovers, that will get refreshed. =A0If not, the admin will k=
now
> something is up.
Hmm. Without any kind of timeout this flag will get set every time an
OSD goes down =97 the replicas won't alert the new primary until after
they get the map marking their old primary down, and this check will
be run synchronously with the generation of the map marking the OSD
down.
The "spurious" stale marker on each PG isn't a big deal (it'll
disappear after a few seconds), but if we're going to set HEALTH_WARN
based on it, that seems like a bit much to me.

> We'll soon be adding the last_active, last_clean, and now last_unstal=
e (?)
> fields so that bigger alarms can go off when the pg stays stale for m=
ore
> than a few seconds...
Yeah; I think we want to use this to trigger big warnings, but not to
trigger warnings without it.
-Greg


>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
