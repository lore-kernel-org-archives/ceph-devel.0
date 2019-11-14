From: Sage Weil <sweil@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] ceph: safely use 'copy-from' Op on Octopus
 OSDs
Date: Thu, 14 Nov 2019 14:17:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.1911141416040.17979@piezo.novalocal>
References: <20191114105736.8636-1-lhenriques@suse.com> <cbda3a69d25b04e10332e7b3898064a93b2d04ae.camel@kernel.org> <alpine.DEB.2.21.1911141326260.17979@piezo.novalocal> <CAOi1vP9XaeJdqV-jMP3BM=mjHKqJW8-ynAjCi0xcDD3DtL94KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP9XaeJdqV-jMP3BM=mjHKqJW8-ynAjCi0xcDD3DtL94KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Gregory Farnum <gfarnum@redhat.com>, Luis Henriques <lhenriques@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 14 Nov 2019, Ilya Dryomov wrote:
> > > I'm just getting caught up on the discussion here, but why was it
> > > decided to do it this way instead of just adding a new OSD
> > > "copy-from-no-truncseq" operation? Once you tried it once and an OSD
> > > didn't support it, you could just give up on using it any longer? Tha=
t
> > > seems a lot simpler than trying to monkey with feature bits.
> >
> > I don't remember the original discussion either, but in retrospect that
> > does seem much simpler--especially since hte client is conditioning
> > sending this based on the the require_osd_release.  It seems like passi=
ng
> > a flag to the copy-from op would be more reasonable instead of conditio=
nal
> > feature-based behavior.
>=20
> Yeah, I suggested adding require_osd_release to the client portion just
> because we are running into it more and more: Objecter relies on it for
> RESEND_ON_SPLIT for example.  It needs to be accessible so that patches
> like that can be carried over to the kernel client without workarounds.
>=20
> copy-from in its existing form is another example.  AFAIU the problem
> is that copy-from op doesn't reject unknown flags.  Luis added a flag
> in https://github.com/ceph/ceph/pull/25374, but it is simply ignored on
> nautilus and older releases, potentially leading to data corruption.
>=20
> Adding a new op that would be an alias for CEPH_OSD_OP_COPY_FROM with
> CEPH_OSD_COPY_FROM_FLAG_TRUNCATE_SEQ like Jeff is suggesting, or a new
> copy-from2 op that would behave just like copy-from, but reject unknown
> flags to avoid similar compatibility issues in the future is probably
> the best thing we can do from the client perspective.

Yeah, I think copy-from2 is the best path.  I think that means we should=20
revert what we merged to ceph.git a few weeks back, Luis!  Sorry we didn't=
=20
put all the pieces together before...

sage
