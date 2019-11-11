From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC PATCH 0/2] ceph: safely use 'copy-from' Op on Octopus OSDs
Date: Mon, 11 Nov 2019 21:51:47 +0100
Message-ID: <CAOi1vP-kFnu_mJaTERHbSjBxQRvfXhFWF=9_nCaaFbh7ACiVhg@mail.gmail.com>
References: <20191108141555.31176-1-lhenriques@suse.com> <CAOi1vP-sVQKvpiPLoZ=9s7Hy=c2eQRocxSs1nPrXAUCbbZUZ-g@mail.gmail.com>
 <20191108164758.GA1760@hermes.olymp> <alpine.DEB.2.21.1911081656320.10553@piezo.novalocal>
 <20191108171616.GA2569@hermes.olymp> <alpine.DEB.2.21.1911081721120.28682@piezo.novalocal>
 <20191108173101.GA3300@hermes.olymp> <20191111163036.GA20513@hermes.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111163036.GA20513@hermes.olymp>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Sage Weil <sage@newdream.net>, Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <ukernel@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Nov 11, 2019 at 5:30 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> On Fri, Nov 08, 2019 at 05:31:01PM +0000, Luis Henriques wrote:
> <snip>
> > > - You'll need to add it for both OSDMap::Incremental and OSDMap
> > > - You'll need to make the encoding condition by updating the block like
> > > the one below from OSDMap::encode()
> > >
> > >     uint8_t v = 9;
> > >     if (!HAVE_FEATURE(features, SERVER_LUMINOUS)) {
> > >       v = 3;
> > >     } else if (!HAVE_FEATURE(features, SERVER_MIMIC)) {
> > >       v = 6;
> > >     } else if (!HAVE_FEATURE(features, SERVER_NAUTILUS)) {
> > >       v = 7;
> > >     }
> > >
> > > to include a SERVER_OCTOPUS case too.  Same goes for Incremental::encode()
> >
> > Awesome, thanks!  I'll give it a try, and test it with the appropriate
> > kernel client side changes to use this.
>
> Ok, I've got the patch bellow for the OSD code, which IIRC should do
> exactly what we want: duplicate the require_osd_release in the client
> side.
>
> Now, in order to quickly test this I've started adding flags to the
> CEPH_FEATURES_SUPPORTED_DEFAULT definition.  SERVER_MIMIC *seemed* to be
> Ok, but once I've added SERVER_NAUTILUS I've realized that we'll need to
> handle TYPE_MSGR2 address.  Which is a _big_ thing.  Is anyone already
> looking into adding support for msgr v2 to the kernel client?

It should be easy enough to hack around it for testing purposes.

I made some initial steps and hope to be able to dedicate the 5.6 cycle
to it.

Thanks,

                Ilya
