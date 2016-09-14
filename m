From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: wip-denc
Date: Wed, 14 Sep 2016 00:47:46 +0000
Message-ID: <BLUPR0201MB15248B5B5C0392698B93CB56E8F10@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
 <a89da24e-7791-ef4a-acce-9f653eaac08e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:64795
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752289AbcINArt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 20:47:49 -0400
In-Reply-To: <a89da24e-7791-ef4a-acce-9f653eaac08e@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Tuesday, September 13, 2016 4:46 PM
> To: Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
> Subject: Re: wip-denc
>=20
>=20
>=20
> On 09/13/2016 04:17 PM, Sage Weil wrote:
> > Hi everyone,
> >
> > Okay, I have a new wip-denc branch working and ready for some review:
> >
> > 	https://github.com/ceph/ceph/pull/11027
> >
> > Highlights:
> >
> > - This includes appender/iterator changes to buffer* to speed up
> > encoding and decoding (fewer bounds checks, simpler structures).
> >
> > - Accordingly, classes/types using the new-style have different
> > arguments types for encode/decode.  There is also a new bound_encode()
> > method that is used to calculate how big of a buffer to preallocate.
> >
> > - Most of the important helpers for doing types have new versions that
> > work with the new framework (e.g., the ENCODE_START macro has a new
> > DENC_START counterpart).
> >
> > - There is also a mechanism that lets you define the bound_encode,
> > encode, and decode methods all in one go using some template magic.
> > This only works for pretty simple types, but it is handy.  It looks lik=
e so:
> >
> >   struct foo_t {
> >     uint32_t a, b;
> >     ...
> >     DENC(foo_t, v, p) {
> >       DENC_START(1, 1, p);
> >       denc(v.a, p);
> >       denc(v.b, p);
> >       ...
> >       DENC_FINISH(p);
> >     }
> >   };
> >   WRITE_CLASS_DENC(foo_t)
> >
> >
> > - For new-style types, a new 'denc' function that is overload to do
> > either bound_encode, encode, or decode (based on argument types) is
> defined.
> > That means that
> >
> >   ::denc(v, p);
> >
> > will work for size_t& p, bufferptr::iterator& p, or
> > bufferlist::contiguous_appender& p.  This facilitates the DENC
> > definitions above.
> >
> > - There is glue to invoke new-style encode/decode when old-style
> > encode() and decode() are invoked, provided a denc_traits<T> is defined=
.
> >
> > - Most of the common containers are there list, vector, set, map,
> > pair, but others need to be converted.
> >
> > - Currently, we're a bit aggressive about using the new-style over the
> > old-style when we have the change.  For example, if you have
> >
> >   vector<int32_t> foo;
> >   ::encode(foo, bl);
> >
> > it will see that it knows how to do int32_t new-style and invoke the
> > new-style vector<> code.  I think this is going to be a net win, since
> > we avoid doing bounds checks on append for every element (and the
> > bound_encode is O(1) for thees base types).  On the other hand, it is
> > currently smart enough to not use new-style for individual integer
> > types, like so
> >
> >   int32_t v;
> >   ::encode(v, bl);
> >
> > although I suspect after the optimizer gets done with it the generated
> > machine code is almost identical.
> >
> > - Most of the key bluestore types are converted over so that we can do
> > some benchmarking.
> >
> > An overview is at the top of the new denc.h header here:
> >
> > 	https://github.com/liewegas/ceph/blob/wip-
> denc/src/include/denc.h#L55
> >
> > I think I've captured the best of Allen's, Varada's, and Sam's various
> > approaches, but we'll see how it behaves.  Let me know what you think!
>=20
> So far this is working pretty well!  It's not even crashing anymore. :D
>=20
> Just recapping from IRC for ceph-devel: Overall append overhead is lower
> than it was before, but not as low as we got it in the old code by creati=
ng a
> single appender all the way from ENCODE_START to ENCODE_FINISH and
> (manually) estimating the memory to allocate across the whole thing.  On =
the

Well the new framework certainly allows that to be done, so I think this si=
mply means that we have more work to do.
Probably there are some "bounded" cases that aren't being exploited.

> other hand we are faster overall now with the extentmap sharding, so we'r=
e
> on the right track!  Here we're calling encode_some potentially many time=
s in
> ExtentMap::update and creating a new appender for each encode_some
> call.  Not sure if we are flushing multiple times or only at the end, but
> buffer::list::append is still consuming a decent chunk of CPU, and

If append is consuming CPU that seems like a serious clue -- do you have an=
 idea of who is calling append?

> encode_some itself is too. I'm suspicious of the c_str() calls and pbl-
> >append(bufferptr(bp, 0, l) even though they aren't being explicitly sing=
led
> out by perf.  In any event there's probably some tweaking to do here.
>=20
> Beyond that I don't have much to report yet.  Rb_tree_increment in
> encode_spanning_blobs and BitMapAreaLeaf::child_check_n_lock are
> starting to show up as bigger % consumers than they used to, so that's go=
od
> news.
>=20
> FWIW, it looks like we are getting about a 1-4% performance improvement
> over master from this in my CPU limited case.  So far memory usage is sti=
ll
> pretty high, with OSDs using about 5.3GB of RSS per OSD at the end of a 5
> minute randwrite test.

I'm suspicious that that the large memory consumption and the relatively sl=
ow CPU performance are related. Especially if you're seeing Rb_tree_increme=
nt in the stats, that's suggesting that the maps are too big. Which correla=
tes exactly with the large memory footprint....

>=20
> Mark
>=20
> >
> > Thanks-
> > sage
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
