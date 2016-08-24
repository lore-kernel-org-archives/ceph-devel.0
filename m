From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: should we remove autotools from master?
Date: Wed, 24 Aug 2016 16:15:15 +0000
Message-ID: <DB5PR05MB1607058852F0548D10E2544BA9EA0@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
 <57BC5B7A.8050103@dachary.org>
 <DB5PR05MB16077097293BBD4CBF85D90EA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1608231517060.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0078.outbound.protection.outlook.com ([104.47.2.78]:49271
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752238AbcHXVtc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 17:49:32 -0400
In-Reply-To: <alpine.DEB.2.11.1608231517060.25681@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adir Lev <adirl@mellanox.com>

Hi,

Thanks for all the explanations. =20
I wrote a quick update inlined below.  However, I am still investigating an=
d I will probably have better status within a day or two

Regards,
  Avner

> -----Original Message-----
> From: Sage Weil=20
> Sent: Tuesday, August 23, 2016 18:21
>=20
> On Tue, 23 Aug 2016, Avner Ben Hanoch wrote:
> > For removing autotools support, I think that we should first announce
> > that autotools will not be supported starting <some-future-day> and
> > till then support both of them in parallel and response to questions
> > about it.
>=20
> I think we're basically proposing some-future-day as now.
>=20
> > Also, we first need to make sure that we have comprehensive
> > instructions for using cmake. Notice, that many developers are not
> > familiar with cmake; hence, there might be need for extra explanations.
> >
> > For example, I tried now the instructions in
> https://github.com/ceph/ceph/blob/master/README.md
> > 	./do_cmake.sh
> > 	cd build
> > 	make
> > and I got the error:
> > 	make: *** No targets specified and no makefile found.  Stop.
> >
> > Probably, because of the explanation "This assumes you make your build
> > dir a subdirectory of the ceph.git checkout. If you put it elsewhere,
> > just replace .. above with a correct path to the checkout." However,
> > if you are not familiar with cmake, then this explanation does not
> > tell you how to recover from the error.
>=20
> The do_cmake.sh script is doing 'mkdir build', so assuming you actually r=
an it
> from the git checkout (i.e., ./do_cmake.sh) then this should be the case.=
  Is
> that actually what caused the error?

I did run "cd build; make" from the git checkout (I did ./do_cmake.sh) when=
 I had the error
	make: *** No targets specified and no makefile found.  Stop.
I am still investigating, because sometimes it succeeds and sometimes it fa=
ils

>=20
> I agree that step 0 is to make README.md complete for cmake.  Perhaps ste=
p
> 1 is to remove autotools instructions too.
>=20
> > Also, I am not sure it is clear to all developers how to combine above
> > instructions with options that you could provide to ./configure script.
>=20
> There is no more ./configure :).  There are a new set of options you can =
pass
> cmake that are referenced here in README.md:
>=20
> 	https://github.com/ceph/ceph/blob/master/README.md#cmake-
> options

I have many link errors after using ./do_cmake.sh -DWITH_XIO=3DON
I am still investigating

>=20
> > Hence, I think removing autotools support should not be immediate
>=20
> Please help us identify any (other) documentation gaps so we can get past
> this.  I thought README.md was in good shape...
>=20
> sage
>=20
