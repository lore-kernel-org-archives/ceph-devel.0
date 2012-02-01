From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: efficient removal of old objects
Date: Wed, 1 Feb 2012 00:26:04 -0800
Message-ID: <CAC-hyiG512de2h+R98g1POOy0Lw18A15TPwE=ge-OgjofdR8Wg@mail.gmail.com>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56788 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab2BAI0E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 03:26:04 -0500
Received: by ggnh1 with SMTP id h1so440215ggn.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2012 00:26:04 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 31, 2012 at 4:33 PM, Sage Weil <sage@newdream.net> wrote:
> Currently rgw logs objects it wants to delete after some period of ti=
me,
> and an radosgw-admin command comes back later to process the log. =A0=
It
> works, but is currently slow (one sync op at a time).

Intent log generation doesn't come free of charge, it adds some load
on the system.

>
> A better approach would be to mark objects for later removal, and hav=
e the
> OSD do it in some more efficient way. =A0wip-objs-expire has a client=
 side
> (librados) interface for this.

Note that setting expiration on an object is a more lightweight
operation than appending the intent log, as it would be done as a sub
op in the compound operation that created the object.

>
> I think there are a couple questions:
>
> Should this be generalized to saying "do these osd ops at time X" ins=
tead
> of "delete at time X". =A0Then it could setxattr, remove, call into a=
 class,
> whatever.

While I think it'd make a nice feature, I also think that the problem
space of a garbage collection is a bit different, and given the time
constraints it wouldn't make sense implementing this right now anyway.
>
> How would the OSD implement this? =A0A kludgey way would be to do it =
during
> scrub. =A0The current scrub implementation may make that problematic =
because
> it does a whole PG at time, and we probably don't want to issue a who=
le
> PG's worth of deletes at a time. =A0Is there a way to make that less
> painful?

If we need to lock the entire pg while removing the objects it wouldn't=
 work.
I'm not too familiar with the scrub code, and I don't want to dive
here into possible implementation details, but getting the scrub to
generate a list of objects for removal may be possible.

>
> Not using scrub means we need some sort of index to keep track of obj=
ects
> with delayed events. =A0Using a collection for this might work, but l=
oading
> all this state into memory would be slow if there were too many event=
s
> registered.
>
> Given all that, and that we need a solution to the expiration soon
> (weeks), do we
> =A0- do a complete solution now,
> =A0- parallelize radosgw-admin log processing,
> =A0- or hack it into scrub?
>
I don't expect to see many hands going up for "hacking" anything. I
would argue that having a garbage collection related job going on
inside a maintenance activity is not that far fetched. Not at any cost
though.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
