From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: pg time stamps
Date: Tue, 17 Jan 2012 15:48:57 -0800
Message-ID: <CAF3hT9AOvm-AhnDsv=0fd-GBGCS4f-j1R184_yewVXz+8kbzVA@mail.gmail.com>
References: <Pine.LNX.4.64.1201130919540.7683@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53917 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab2AQXs7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 18:48:59 -0500
Received: by iagf6 with SMTP id f6so4993545iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 15:48:59 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201130919540.7683@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 13, 2012 at 9:24 AM, Sage Weil <sage@newdream.net> wrote:
> wip-osd-pg-stats adds a time stamp and epoch number to the pg_stat_t
> struct. =A0The epoch is updated when the mapping changes, and the tim=
e stamp
> is updated when the pg state changes.
>
> The state timestamp is the interesting one, since it'll make it easie=
r to
> identify PGs that are stuck in, say, down or peering states for long
> periods of time.
Thumbs up!

> What it doesn't help with is when the pg state is toggling between tw=
o
> undesireable states (the stamp will still get updated). =A0In practic=
e, what
> we probably care about is active vs not active, and degraded vs not
> degraded. =A0We could add additional time stamps for those, but that =
may be
> overkill.
I think we'll want these; or at least more than we've got right now.
I'm not sure what a good way to track "stuck" PGs from an external
tool would be without building a lot of smarts into it (tracking the
states a PG can take), while it would be easy to serve them by adding
an inactive_stamp and a degraded_stamp.

> Previously we had planned on doing this sort of monitoring using an
> external agent, but that's kind of a pain, duplicates storage, etc. =A0=
This
> is simple to add into the pg_stat_t update logic.
>
> I expect this will be rebased on top of the new encoding strategy stu=
ff so
> that the object versioning is backward and forwards compatible, so do=
n't
> worry about that part here.
>
> https://github.com/NewDreamNetwork/ceph/commit/f43282796af50d760a6209=
70ad691e0a20bcf178
>
> Thoughts?
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
