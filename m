From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] ceph: safely use 'copy-from' Op on Octopus OSDs
Date: Thu, 14 Nov 2019 10:28:10 -0800
Message-ID: <CAJ4mKGZVV2dt6qKZGO-KyQt0p81hAUqFGBwRodB6MSdeLh=Tow@mail.gmail.com>
References: <20191114105736.8636-1-lhenriques@suse.com> <cbda3a69d25b04e10332e7b3898064a93b2d04ae.camel@kernel.org>
 <alpine.DEB.2.21.1911141326260.17979@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1911141326260.17979@piezo.novalocal>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sweil@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Nov 14, 2019 at 5:28 AM Sage Weil <sweil@redhat.com> wrote:
>
> On Thu, 14 Nov 2019, Jeff Layton wrote:
> > On Thu, 2019-11-14 at 10:57 +0000, Luis Henriques wrote:
> > > Hi!
> > >
> > > So, after the feedback I got from v1 [1] I've sent out a pull-request
> > > for the OSDs [2] which encodes require_osd_release into the OSDMap
> > > client data.  This allows the client to figure out which ceph release
> > > the OSDs cluster is running and decide whether or not it's safe to us=
e
> > > the copy-from Op for copy_file_range.
> > >
> > > This new patchset I'm sending simply adds enough functionality to the
> > > kernel client so that it can take advantage of this OSD patch:
> > >
> > > 0001 - adds the ability to decode TYPE_MSGR2 addresses.  This is a
> > >        required functionality for enabling SERVER_NAUTILUS in the
> > >        client.  I hope I got the new format right, as I couldn't figu=
re
> > >        out what the hard-coded values (see comments) really mean.
> > >
> >
> > nit: the first 3 patch subject lines should probably be prefixed with
> > "libceph:"
> >
> > > 0002 - allows the client to retrieve the new require_osd_release fiel=
d
> > >        from the OSDMap if available.  This patch also adds SERVER_MIM=
IC,
> > >        SERVER_NAUTILUS and SERVER_OCTOPUS to the supported features,
> > >        which TBH I'm not sure if that's a safe thing to do -- the onl=
y
> > >        issue I've seen was that Nautilus requires the ability to deco=
de
> > >        TYPE_MSGR2 address, but I may have missed others.
> > >
> >
> > Yes, this needs to be done with care. We have to ensure that the server
> > side isn't assuming that the client supports something that it doesn't.
> > I think that means just trawling through the code and verifying whether
> > this is safe.
> >
> > > 0003 - debug code to add require_osd_release to the osdmap debugfs fi=
le.
> > >
> > > 0004 - adds the truncate_{seq,size} fields to the 'copy-from' operati=
on
> > >        if the OSDs are >=3D Octopus.
> > >
> > > Also note that, as suggested by Ilya, I've dropped the patch that wou=
ld
> > > change the default mount options to 'copyfrom'.
> > >
> > > These patches have been tested with the xfstests generic test suite, =
and
> > > with a couple of other (local) tests that exercise the cephfs
> > > copy_file_range syscall.  I didn't saw any issues, but as I said abov=
e,
> > > I'm not really sure if adding the SERVER_* flags to the supported
> > > features have other side effects.
> > >
> > > [1] https://lore.kernel.org/lkml/20191108141555.31176-1-lhenriques@su=
se.com/
> > > [2] https://github.com/ceph/ceph/pull/31611
> > >
> >
> > I'm just getting caught up on the discussion here, but why was it
> > decided to do it this way instead of just adding a new OSD
> > "copy-from-no-truncseq" operation? Once you tried it once and an OSD
> > didn't support it, you could just give up on using it any longer? That
> > seems a lot simpler than trying to monkey with feature bits.
>
> I don't remember the original discussion either, but in retrospect that
> does seem much simpler--especially since hte client is conditioning
> sending this based on the the require_osd_release.  It seems like passing
> a flag to the copy-from op would be more reasonable instead of conditiona=
l
> feature-based behavior.
>
> Greg, do you remember why we ended up here?

Well, I can look it up. We discussed it being a different op in
February ("OSD 'copy-from' operation and truncate_seq value") and...it
looks like that conversation ended with that being the plan?

I can't see why it changed in the making though, and everyone seems to
have forgotten about it at the next pass.
-Greg

>
> sage
>
