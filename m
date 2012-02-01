From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: efficient removal of old objects
Date: Tue, 31 Jan 2012 17:02:34 -0800
Message-ID: <CAORUGqCkRzAbXVjGvVDGX=MxURMy5NijsdPGRgWDpgT3_CyMow@mail.gmail.com>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42631 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab2BABCz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 20:02:55 -0500
Received: by wgbdt10 with SMTP id dt10so638993wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 17:02:54 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 31, 2012 at 16:33, Sage Weil <sage@newdream.net> wrote:
> Currently rgw logs objects it wants to delete after some period of ti=
me,
> and an radosgw-admin command comes back later to process the log. =C2=
=A0It
> works, but is currently slow (one sync op at a time).
>
> A better approach would be to mark objects for later removal, and hav=
e the
> OSD do it in some more efficient way. =C2=A0wip-objs-expire has a cli=
ent side
> (librados) interface for this.

Is there some reason why this would be significantly more performant
when done by the OSD itself? It seems like the deletion times can be
bucketed by time nicely, then each bucket just contains a set of ids
-- a good fit for the map data type -- and the client for running this
deletion just streams the bucket contents over and issues delete
messages for everything. What makes that inherently slow?

> Should this be generalized to saying "do these osd ops at time X" ins=
tead
> of "delete at time X". =C2=A0Then it could setxattr, remove, call int=
o a class,
> whatever.

That sounds like a really complex API, for quite marginal gain.

To make my point even clearer: point me to another data store that has
that idiom.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
