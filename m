From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: use an enum instead of 'static const' to define constants
Date: Mon, 8 Oct 2018 18:00:19 +0200
Message-ID: <CAOi1vP-bQR6aEbmyxUGtxTQACUbT2iEXr5Ld3w0p04_NWWxXuQ@mail.gmail.com>
References: <20181005161845.959919-1-arnd@arndb.de> <CAOi1vP8Wy0DjEWBWh05iSx-RJS41hTc1rs2TXdz_1mcNpf68Dg@mail.gmail.com>
 <CAK8P3a0xpFdKC0AtBDC9UvMfwpx3HTbAdio4ApmYhrb2FakK9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0xpFdKC0AtBDC9UvMfwpx3HTbAdio4ApmYhrb2FakK9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, pombredanne@nexb.com, Luis Henriques <lhenriques@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 8, 2018 at 5:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 8, 2018 at 4:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> > On Fri, Oct 5, 2018 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > @@ -71,7 +71,7 @@
> > >   * This ensures that no two versions who have different meanings for
> > >   * the bit ever speak to each other.
> > >   */
> > > -
> > > +enum ceph_features {
> > >  DEFINE_CEPH_FEATURE( 0, 1, UID)
> > >  DEFINE_CEPH_FEATURE( 1, 1, NOSRCADDR)
> > >  DEFINE_CEPH_FEATURE_RETIRED( 2, 1, MONCLOCKCHECK, JEWEL, LUMINOUS)
> > > @@ -170,13 +170,13 @@ DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
> > >
> > >  DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
> > >  DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
> > > -
> > > +};
> >
> > I don't particularly like this because it looks like lower constants
> > are actually ints and the rest are unsigned longs, even though they all
> > have ULL suffixes.  The standard seems to require that enum constants
> > be representable as ints, is the non-pedantic behaviour documented
> > somewhere?
>
> I had not realized that this is a gcc extension, or that it behaves slightly
> differently from the standard C++ behavior that apparently adopted a
> saner variant (all values in an enum have the same type).
>
> How about we just add a __maybe_unused to DEFINE_CEPH_FEATURE
> then to shut up the warning?

Fine with me.

Thanks,

                Ilya
