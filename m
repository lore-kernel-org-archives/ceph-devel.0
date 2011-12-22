From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Do not understand some terms about cluster health
Date: Thu, 22 Dec 2011 12:40:09 -0800
Message-ID: <CAF3hT9DR0bHZfMZpidvDcF9+0pnNUHt8VnCq_+tOA8xgEqemyQ@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49DA7E3E2@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51899 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab1LVUkK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 15:40:10 -0500
Received: by iaeh11 with SMTP id h11so13993356iae.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 12:40:09 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49DA7E3E2@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On Wed, Dec 21, 2011 at 7:47 PM,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, All
>
> =A0 When I type 'ceph health' to get the status of cluster, it will s=
how
> some information.
>
> =A0 Would you please to explain the term?
>
> =A0 Ex: HEALTH_WARN 3/54 degraded (5.556%)
>
> =A0 =A0 =A0 =A0 What does "degraded" mean ? =A0Is it a serious error =
and how to
> fix it ?
>
> =A0 Ex: HEALTH_WARN 264 pgs degraded, 6/60 degraded (10.000%); 3/27
> unfound (11.111%)
There are two meanings of degraded here. The degraded PGs are those
which don't yet have the number of active OSDs as they should (ie, the
PG wants 3 OSDs to be holding it and only 2 are). The number of
degraded objects is the number of missing replicas of objects. The
difference here is that an OSD can be an active member of a PG without
holding all the objects yet; the general sequence is that you lose an
OSD so a bunch of PGs go degraded, and then the OSDs peer and bring in
a new replica so the PG is no longer degraded but most of the objects
are until they get copied over.
Unfound objects are those which the cluster believes should exist but
can't find anywhere, either because the only copy is on a down OSD or
because there's a bug which caused them to believe in non-existent
objects.
Are you using the RADOS gateway? If you are, that's probably where
your unfound objects came from; there was a long-standing accounting
bug which had a fix merged earlier this week.

> =A0 =A0 =A0 =A0 What does "unfound" mean? =A0Could we recover the dat=
a?
> =A0 =A0 =A0 =A0 Would it cause the whole data in rbd image corrupted =
and never
> access ?
Nope; unfound objects will only block access to that specific object.
I'll have to look into whether rbd could trigger the same bug that RGW
was or not.

>
> =A0 When I type 'ceph pg dump', it would show like this. =A0Would you
> please explain what is "hb in" and "hb out" ?
Those are the lists of OSDs which are heartbeating the given OSD, in
and out. The first group is OSDs which the one in question is keeping
track of; the second are OSDs which the one in question should be
reporting to.

> =A0And from the latest document, I know we can do the cluster snapsho=
t by
> " ceph osd cluster_snap <name>"
> =A0Is that means we can rollback the data from the snapshot? Do you h=
ave
> any related document to show how to operate it?
That's the intention, but it's not a well-tested or complete solution
at this time. You shouldn't use it yet.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
