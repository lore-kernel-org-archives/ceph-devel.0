From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rados import/export
Date: Mon, 30 Apr 2012 14:20:31 -0700
Message-ID: <CAORUGqDFhA5focC=fvUJVai1ezi+rWp4PRJ=cEz5syxWhCz4aA@mail.gmail.com>
References: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
 <Pine.LNX.4.64.1204301348170.3920@cobra.newdream.net> <CAORUGqD=neAYCH2qPZTF6oG=V4yNKhfupXoViAbV5TiR0Qfotg@mail.gmail.com>
 <Pine.LNX.4.64.1204301406120.32303@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45270 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828Ab2D3VUx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 17:20:53 -0400
Received: by vcqp1 with SMTP id p1so2365822vcq.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 14:20:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204301406120.32303@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Apr 30, 2012 at 14:08, Sage Weil <sage@newdream.net> wrote:
>> Does just adding a .db suffix make the name safe? If yes, xattr is n=
ot
>> needed; if no, it's not enough. Reading src/rados_export.cc and
>> src/rados_sync.cc, I see nothing like that. What if I have objects
>> "foo" and "foo.db" in a pool?
>
> I'm pretty sure we need to mark the object with a magic xattr. =C2=A0=
Which
> probably means the filename itself needs to be mangled to avoid colli=
ding
> with other objects. =C2=A0Probably an xattr on the object file referr=
ing to the
> external mangled file with the k/v content.

Perhaps make the db file use one of the reserved characters that will
never appear in a plain old rados object. $ is the only one that's
really safe..

>> Note to self: the only thing avoiding collisions for e.g. "foo/" and
>> "foo$" is the hash.
> I vaguely recall Colin talking about the trailing /, but we may have
> decided to ignore the problem for now.

Oh I mean anything that gets mapped to @ can cause collisions. "foo@"
and "foo$" will collide. "foo\n" and "foo\\" will collide.

=46rankly, my gut instinct right now is "kill it with fire". Collisions
in object names is a miserable problem to have. This would have been
better off with e.g. a HTTP-style %20 escaping mechanism, or a \x20
style one; one that preserves the byte, and does not just replace it
with '@'.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
