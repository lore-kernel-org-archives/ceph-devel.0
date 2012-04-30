From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rados import/export
Date: Mon, 30 Apr 2012 14:01:24 -0700
Message-ID: <CAORUGqD=neAYCH2qPZTF6oG=V4yNKhfupXoViAbV5TiR0Qfotg@mail.gmail.com>
References: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
 <Pine.LNX.4.64.1204301348170.3920@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48373 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab2D3VBp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 17:01:45 -0400
Received: by vcqp1 with SMTP id p1so2354228vcq.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 14:01:44 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204301348170.3920@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Apr 30, 2012 at 13:50, Sage Weil <sage@newdream.net> wrote:
> The real question here is how *should* we be storing omap values when=
 we
> export to/import from regular files? =C2=A0A specially-marked (with x=
attr) .db
> file?

Does just adding a .db suffix make the name safe? If yes, xattr is not
needed; if no, it's not enough. Reading src/rados_export.cc and
src/rados_sync.cc, I see nothing like that. What if I have objects
"foo" and "foo.db" in a pool?

Note to self: the only thing avoiding collisions for e.g. "foo/" and
"foo$" is the hash.

> A related problem is how to store placement key strings for objects w=
ith
> modified placement; I can't remember if we already did something for =
that
> yet or not (maybe specially-named xattr?).

Commit 717621f66eb7da54c0000ff52985235dc6a17843, combined with nothing
else touching src/rados_export.cc after it, makes me think we don't
preserve the locator.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
