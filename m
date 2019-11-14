From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC PATCH v2 0/4] ceph: safely use 'copy-from' Op on Octopus OSDs
Date: Thu, 14 Nov 2019 15:13:37 +0100
Message-ID: <CAOi1vP9XaeJdqV-jMP3BM=mjHKqJW8-ynAjCi0xcDD3DtL94KQ@mail.gmail.com>
References: <20191114105736.8636-1-lhenriques@suse.com> <cbda3a69d25b04e10332e7b3898064a93b2d04ae.camel@kernel.org>
 <alpine.DEB.2.21.1911141326260.17979@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1911141326260.17979@piezo.novalocal>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sweil@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Gregory Farnum <gfarnum@redhat.com>, Luis Henriques <lhenriques@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Nov 14, 2019 at 2:28 PM Sage Weil <sweil@redhat.com> wrote:
>
> On Thu, 14 Nov 2019, Jeff Layton wrote:
> > On Thu, 2019-11-14 at 10:57 +0000, Luis Henriques wrote:
> > > Hi!
> > >
> > > So, after the feedback I got from v1 [1] I've sent out a pull-request
> > > for the OSDs [2] which encodes require_osd_release into the OSDMap
> > > client data.  This allows the client to figure out which ceph release
> > > the OSDs cluster is running and decide whether or not it's safe to use
> > > the copy-from Op for copy_file_range.
> > >
> > > This new patchset I'm sending simply adds enough functionality to the
> > > kernel client so that it can take advantage of this OSD patch:
> > >
> > > 0001 - adds the ability to decode TYPE_MSGR2 addresses.  This is a
> > >        required functionality for enabling SERVER_NAUTILUS in the
> > >        client.  I hope I got the new format right, as I couldn't figure
> > >        out what the hard-coded values (see comments) really mean.
> > >
> >
> > nit: the first 3 patch subject lines should probably be prefixed with
> > "libceph:"
> >
> > > 0002 - allows the client to retrieve the new require_osd_release field
> > >        from the OSDMap if available.  This patch also adds SERVER_MIMIC,
> > >        SERVER_NAUTILUS and SERVER_OCTOPUS to the supported features,
> > >        which TBH I'm not sure if that's a safe thing to do -- the only
> > >        issue I've seen was that Nautilus requires the ability to decode
> > >        TYPE_MSGR2 address, but I may have missed others.
> > >
> >
> > Yes, this needs to be done with care. We have to ensure that the server
> > side isn't assuming that the client supports something that it doesn't.
> > I think that means just trawling through the code and verifying whether
> > this is safe.
> >
> > > 0003 - debug code to add require_osd_release to the osdmap debugfs file.
> > >
> > > 0004 - adds the truncate_{seq,size} fields to the 'copy-from' operation
> > >        if the OSDs are >= Octopus.
> > >
> > > Also note that, as suggested by Ilya, I've dropped the patch that would
> > > change the default mount options to 'copyfrom'.
> > >
> > > These patches have been tested with the xfstests generic test suite, and
> > > with a couple of other (local) tests that exercise the cephfs
> > > copy_file_range syscall.  I didn't saw any issues, but as I said above,
> > > I'm not really sure if adding the SERVER_* flags to the supported
> > > features have other side effects.
> > >
> > > [1] https://lore.kernel.org/lkml/20191108141555.31176-1-lhenriques@suse.com/
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
> a flag to the copy-from op would be more reasonable instead of conditional
> feature-based behavior.

Yeah, I suggested adding require_osd_release to the client portion just
because we are running into it more and more: Objecter relies on it for
RESEND_ON_SPLIT for example.  It needs to be accessible so that patches
like that can be carried over to the kernel client without workarounds.

copy-from in its existing form is another example.  AFAIU the problem
is that copy-from op doesn't reject unknown flags.  Luis added a flag
in https://github.com/ceph/ceph/pull/25374, but it is simply ignored on
nautilus and older releases, potentially leading to data corruption.

Adding a new op that would be an alias for CEPH_OSD_OP_COPY_FROM with
CEPH_OSD_COPY_FROM_FLAG_TRUNCATE_SEQ like Jeff is suggesting, or a new
copy-from2 op that would behave just like copy-from, but reject unknown
flags to avoid similar compatibility issues in the future is probably
the best thing we can do from the client perspective.

Thanks,

                Ilya
