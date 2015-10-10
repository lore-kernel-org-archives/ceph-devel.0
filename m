From: Sage Weil <sage@newdream.net>
Subject: Re: wip-addr
Date: Sat, 10 Oct 2015 05:07:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510100505330.5497@cobra.newdream.net>
References: <20151002232413.GA8939@degu.b.linuxbox.com> <alpine.DEB.2.00.1510091446090.29929@cobra.newdream.net> <CACJqLyZh4WQZv_3isjXJy=t6YL700C2GjWuen-QG1D5=RkKHYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-75370036-1444478848=:5497"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55700 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbJJMH3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Oct 2015 08:07:29 -0400
In-Reply-To: <CACJqLyZh4WQZv_3isjXJy=t6YL700C2GjWuen-QG1D5=RkKHYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Marcus Watts <mwatts@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, dzafman@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-75370036-1444478848=:5497
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Oct 2015, Haomai Wang wrote:
> On Sat, Oct 10, 2015 at 5:49 AM, Sage Weil <sage@newdream.net> wrote:
>       Hey Marcus,
>=20
>       On Fri, 2 Oct 2015, Marcus Watts wrote:
>       > wip-addr
>       >
>       > 1. where is it?
>       > 2. current state
>       > 3. more info
>       > 4. cheap fixes
>       > 5. in case you were wondering why?
>       >
>       > ____ 1. where is it?
>       >
>       > I've just pushed another update to wip-addr:
>       >
>       > git@github.com:linuxbox2/linuxbox-ceph.git
>       > wip-addr
>       >
>       > ____ 2. current state
>       >
>       > This version
>       > 1/ compiles
>       > 2/ ran an extremely limited set of tests successfully
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0(was able to bring up ceph-mon, ceph-=
osd).
>       >
>       > In theory, it should do everything a recent "master" branch
>       copy of ceph
>       > can do and little or nothing past that.=C2=A0 Internally it add=
s
>       "address vector"
>       > support, some parsing/print logic, and lots of encoding rules
>       to pass them
>       > around, but there's nothing that can create and little that
>       makes any
>       > sensible use of this.=C2=A0 So this is just the back end encodi=
ng
>       and storage rules.
>=20
>       This is looking pretty good. I left some comments.=C2=A0 There ar=
e
>       still a few
>       XXX's left... but not many.=C2=A0 Haomai, can you help with the a=
sync
>       msgr one?
>       (Also, Marcus, can you check if the msg/Simple/Pipe.cc connect()
>       and
>       accept() code doing the right thing?)
>=20
>=20
> I have a quick view among all commits, looks a great improvement for th=
e
> future enhancing.
> =C2=A0
>=20
>       One minor thing.. please put the subsystem as the prefix to the
>       commit
>       message instead of the branch name (e.g., mds: add features to
>       event
>       types).
>=20
>       > Phase 2 is to add logic to actually make it useful.
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0(the very start of this is on linuxbo=
x2 "wip-addr-p2",
>       >=C2=A0 =C2=A0 =C2=A0 =C2=A0just monmap changes so far...)
>       > ____ 3. more info
>       >
>       > There's an etherpad document that describes this in more
>       detail,
>       >
>       > http://pad.ceph.com/p/wip_addr
>       >
>       > ____ 4. cheap fixes
>       >
>       > a couple of minor issues that should be easy to resolve,
>       > 1.
>       > AsyncConnection.cc
>       > this passes addresses back and forth as it's setting up the
>       connection,
>       > and it also exchanges features.=C2=A0 As best I can tell, it lo=
oks
>       like
>       > it exchanges addresses before it knows what features the other
>       end
>       > supports.=C2=A0 There should be something in here that
>       > does this after knowing what features the other end supports.
>=20
>       Copying Haomai.
>=20
>=20
> Right, it should be the same as simple messenger. The "features" bit is
> exchanged in "ceph_msg_connect" and "ceph_msg_connect_reply".=C2=A0
>=20
> I'm afraid that making features before addr exchange isn't a smooth way=
.=20
> Maybe we need a middle release to help format migrating. Or we need to=20
> add retry mechanism, we could add proper way to let new-style addr side=
=20
> detect peer format. =C2=A0

Yeah... it seems like we need the initial exchange to share the addr that=
=20
we accepted on, and then a second tag + addrvec to share the full list=20
after that if both sides have the new feature bit.

In any case, I think in both these cases encoding wth 0 with a FIXME=20
comment is fine for the time being.

sage
--557981400-75370036-1444478848=:5497--
