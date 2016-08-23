From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: should we remove autotools from master?
Date: Tue, 23 Aug 2016 15:11:58 +0000
Message-ID: <DB5PR05MB16077097293BBD4CBF85D90EA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
 <57BC5B7A.8050103@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:24810
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751032AbcHXBGz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 21:06:55 -0400
In-Reply-To: <57BC5B7A.8050103@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adir Lev <adirl@mellanox.com>

For removing autotools support, I think that we should first announce that =
autotools will not be supported starting <some-future-day> and till then su=
pport both of them in parallel and response to questions about it.

Also, we first need to make sure that we have comprehensive instructions fo=
r using cmake.
Notice, that many developers are not familiar with cmake; hence, there migh=
t be need for extra explanations.

For example, I tried now the instructions in https://github.com/ceph/ceph/b=
lob/master/README.md=20
	./do_cmake.sh
	cd build
	make
and I got the error:
	make: *** No targets specified and no makefile found.  Stop.

Probably, because of the explanation "This assumes you make your build dir =
a subdirectory of the ceph.git checkout. If you put it elsewhere, just repl=
ace .. above with a correct path to the checkout." However, if you are not =
familiar with cmake, then this explanation does not tell you how to recover=
 from the error.

Also, I am not sure it is clear to all developers how to combine above inst=
ructions with options that you could provide to ./configure script.

Hence, I think removing autotools support should not be immediate
Avner=20

> -----Original Message-----
> From: Loic Dachary=20
>=20
>=20
> On 23/08/2016 15:58, Sage Weil wrote:
> > Should we remove the autotools stuff from master?
> >
> > Yes:
> > - It won't be maintained
> > - It sucks
> > - It confuses people and they use it by mistake
> > - We'll find any build scripts etc that haven't been converted sooner
> > rather than later
> >
> > No:
> > - Other architectures might rely on it
> > - It's possible some build scripts haven't been convert yet
> >
> > I'm thinking yes?
>=20
> I vote yes. The build scripts I know about are either converted or broken
> because autotools no longer works :-)
>=20
> Cheers
>=20
> > sage
> >
> >
> > On Tue, 23 Aug 2016, Nathan Cutler wrote:
> >
> >>> That's a different make-deb(s).sh
> >>
> >> Allow me to qualify that statement. This thread seems to be about
> >>
> >> https://github.com/ceph/ceph/blob/master/make-debs.sh
> >>
> >> while the "make-deb.sh" I am working on is
> >>
> >> https://github.com/ceph/ceph-qa-suite/blob/master/tasks/buildpackages
> >> /make-deb.sh
> >>
> >> which is used with the teuthology-openstack backend. However, I see
> >> the two scripts are similar.
> >>
> >> In general, although the autotools stuff is still there in master, it
> >> is not maintained and should not be expected to work (or continue to
> >> work). All build infrastructure targeting master should be converted t=
o
> cmake.
> >>
> >> Nathan
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >> in the body of a message to majordomo@vger.kernel.org More majordomo
> >> info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
