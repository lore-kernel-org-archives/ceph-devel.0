From: Sage Weil <sage@newdream.net>
Subject: Re: Cehp - tip - build break ?
Date: Mon, 6 Apr 2015 09:07:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504060906550.4469@cobra.newdream.net>
References: <CAFkUHxdMwZDR7=Z1XeyF9zrNzV2e1U+OWcsRpVusi_GhzCPN1A@mail.gmail.com> <55210974.2010009@dachary.org> <CAFkUHxe_tHvkYM_As7A8x42UT5XTzGLB-mjROv=t9NVgd+EiEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-862071575-1428336434=:4469"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52491 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbbDFQHO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Apr 2015 12:07:14 -0400
In-Reply-To: <CAFkUHxe_tHvkYM_As7A8x42UT5XTzGLB-mjROv=t9NVgd+EiEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-862071575-1428336434=:4469
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Apr 2015, kernel neophyte wrote:
> On Sun, Apr 5, 2015 at 3:07 AM, Loic Dachary <loic@dachary.org> wrote:
> > Hi,
> >
> > My guess is that it's because the gmock directory has been replaced b=
y a gmock submodule and git pull won't be enough to do the right thing.
> > The simplest workaround is to git clone a fresh copy. Or you can try =
./autogen.sh which should also do what's necessary.
>=20
> Cloned a fresh copy, still the same.

Make sure you run make in teh top-level directory, not inside src/, at=20
least once to get the gmock stuff built.

sage

>=20
>=20
>=20
> -Neo
> >
> > Cheers
> >
> > On 05/04/2015 07:07, kernel neophyte wrote:
> >> Hi,
> >>
> >> I am seeing build break in ceph master.
> >>
> >> make[3]: *** No rule to make target
> >> `../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'.
> >> Stop.
> >>
> >> make[3]: *** Waiting for unfinished jobs....
> >>
> >>   CXX      test/erasure-code/ceph_erasure_code_non_regression.o
> >>
> >>
> >> Am I missing anything obvious ?
> >>
> >>
> >> -Neo
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> > --
> > Lo=C3=AFc Dachary, Artisan Logiciel Libre
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-862071575-1428336434=:4469--
