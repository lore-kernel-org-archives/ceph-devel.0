From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: compile error on testing branch - missing
 anchor_create_prep_locks()
Date: Wed, 26 May 2010 10:58:34 -0600
Message-ID: <1274893114.4773.154.camel@sale659.sandia.gov>
References: <1274890657.4773.153.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1005260944410.24698@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:39516 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab0EZQ6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 May 2010 12:58:44 -0400
In-Reply-To: <Pine.LNX.4.64.1005260944410.24698@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2010-05-26 at 10:45 -0600, Sage Weil wrote:
> On Wed, 26 May 2010, Jim Schutt wrote:
> > FWIW, I'm getting this compile error on the testing branch:
> >=20
> > if g++ -DHAVE_CONFIG_H -I. -I. -I.    -Wall -D_FILE_OFFSET_BITS=3D6=
4 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT Server.o -MD -MP -MF=
 ".deps/Server.Tpo" -c -o Server.o `test -f 'mds/Server.cc' || echo './=
'`mds/Server.cc; \
> >         then mv -f ".deps/Server.Tpo" ".deps/Server.Po"; else rm -f=
 ".deps/Server.Tpo"; exit 1; fi
> > mds/Server.cc: In member function =C3=BF=C3=BFvoid Server::handle_c=
lient_unlink(MDRequest*)=C3=BF=C3=BF:
> > mds/Server.cc:3705: error: =C3=BF=C3=BFclass MDCache=C3=BF=C3=BF ha=
s no member named =C3=BF=C3=BFanchor_create_prep_locks=C3=BF=C3=BF
> >=20
> >=20
> > The missing function seems to have been introduced in commit 4a449e=
c7.
> >=20
> > It exists in the unstable branch, but I get conflicts if
> > I try to merge testing into unstable.
>=20
> Fixed this.  The missing unstable commit was 14dd8a9a.

Great, thanks!

-- Jim

>=20
> Thanks!
> sage


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
