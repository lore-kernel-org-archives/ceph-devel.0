From: Matthew Roy <imjustmatthew@gmail.com>
Subject: Re: osd out states
Date: Wed, 4 Jan 2012 20:30:29 -0500
Message-ID: <CADXA5U386xd0FpcWWQDtm8CbUzUVh4XOPj8+D=G=m9YXAjFGWQ@mail.gmail.com>
References: <Pine.LNX.4.64.1201041557470.17055@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46114 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab2AEBaa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2012 20:30:30 -0500
Received: by vcbfk14 with SMTP id fk14so33655vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jan 2012 17:30:30 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201041557470.17055@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I would definitely support the false/true/true defaults over
true/true/true. Nothing is worse than trying to troubleshoot a
half-dead server in a web cluster and having it put itself back into
the load pool every time it restarts or reloads.

Matthew

On Wed, Jan 4, 2012 at 19:06, Sage Weil <sage@newdream.net> wrote:
> I pushed branch wip-osd-out-states that adds a few new osd state bits=
 to
> the osdmap:
>
> =A0* CEPH_OSD_AUTOOUT: osd was marked out automatically by the monito=
r
> because it was down for too long
> =A0* CEPH_OSD_NEW: osd is new and has never been marked in
>
> Both are implicitly cleared when the osd_weight becomes non-zero (i.e=
=2E
> when they are no longer out). =A0The AUTOOUT is set by the monitor wh=
en it
> automatically marks the osd out.
>
> There are then some new monitor options to go along with
>
> =A0* mon osd auto mark in (default true): mark osd in when it boots
> =A0* mon osd auto mark auto out in (default true): mark AUTOOUT osd i=
n when
> it boots
> =A0* mon osd auto mark new in (default true): mark NEW osd in when it=
 boots
>
> I would imagine an admin might want the first to be false (so that an=
 osd
> they mark out stays out, even if the daemon restarts). =A0In fact, we=
 should
> make that default to false, I think. =A0This is true for the teutholo=
gy
> thrashing tests, which explicity control the up/down and in/out state=
 of
> OSDs.
>
> For a new cluster, you want new osds to automatically get data. =A0Fo=
r an
> existing cluster, you might want that off, so that when you bring a n=
ew
> rack of storage online you can explicitly control when you want to st=
art
> using it (i.e., not necessarily when you first boot things up).
>
> The autoout one will likely ways be true, since it is probably safe t=
o
> automatically mark something in that we automatically marked out.
>
> Anyway, comments welcome!
>
> sage
>
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
