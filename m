From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: v0.44 released
Date: Wed, 21 Mar 2012 12:53:47 -0700
Message-ID: <CAC-hyiHMV1PQD1gYzQMyTYttbQOdPpo9w0OGAHb6utJTyFNJ6g@mail.gmail.com>
References: <Pine.LNX.4.64.1203210638450.28797@cobra.newdream.net>
	<CAMvP8PCofyuio+P0XY0d-DVq8YRkb1wzSajq3K3Wf8Tgg5Xz1g@mail.gmail.com>
	<CACLRD_1-Fq_oR=iGZorm5z-6MpnT=zBOUcLi72=ofKYTf9CEog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34868 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316Ab2CUTxs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 15:53:48 -0400
Received: by bkcik5 with SMTP id ik5so1207627bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 12:53:47 -0700 (PDT)
In-Reply-To: <CACLRD_1-Fq_oR=iGZorm5z-6MpnT=zBOUcLi72=ofKYTf9CEog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Note that there are also high level synchronous api calls that were
added to librados that mirror the Object*Operation ones.

Yehuda

On Wed, Mar 21, 2012 at 9:39 AM, Samuel Just <sam.just@dreamhost.com> w=
rote:
>
> Hi,
>
> The relevant api functions are the omap_* methods of
> ObjectWriteOperation and ObjectReadOperation, which can be found in
> src/include/rados/librados.hpp. =A0Note, ObjectWriteOperation and
> ObjectReadOperation are transactions which are submitted using
> aio_operate or operate. =A0src/test/rados-api/aio.cc has some usage
> examples in the OmapPP test.
>
> -Sam
>
> On Wed, Mar 21, 2012 at 6:56 AM, Tomasz Paszkowski <ss7pro@gmail.com>
> wrote:
> > Hi,
> >
> > Can write sth more about new key/value api or point part of the sou=
rce
> > where we can get familiar with it.
> >
> >
> > On Wed, Mar 21, 2012 at 2:39 PM, Sage Weil <sage@newdream.net> wrot=
e:
> >> v0.44 is ready! =A0Changes since v0.43 include:
> >>
> >> =A0* osd: key/value objects (objects are now blobs, key/value bund=
les,
> >> and
> >> =A0 xattrs)
> >> =A0* osd: cleaned up PG state, stats
> >> =A0* osd: fixed transaction replay on non-btrfs after ill-timed fa=
ilures
> >> =A0* osd: several recovery fixes
> >> =A0* radosgw: improved PUT performance
> >> =A0* radosgw: improved list objects performance, filtering
> >> =A0* radosgw: manifests for large objects
> >> =A0* radosgw: Swift/S3 ACL interoperability (last set ACL type win=
s)
> >> =A0* librados: new key/value object API
> >> =A0* Ubuntu 12.04 precise packages
> >>
> >> The exciting part of this release is that the key/value "object ma=
p"
> >> work has been merged, along with radosgw changes to take advantage=
 of
> >> the
> >> new API. =A0This allows you to use a key/value interface to manage=
 many
> >> small records in a single object, in addition of the regular objec=
t
> >> data
> >> and attributes. =A0Keys in the same object are stored together on
> >> disk--just
> >> like object data would be--so there are locality advantages to put=
ting
> >> related keys in the same object. =A0However, there are no limits o=
n how
> >> many
> >> keys per object beyond concerns about load and space balancing (al=
l
> >> keys
> >> in an object are stored together on the same set of Ceph OSDs). =A0=
This
> >> provides an interesting alternative to conventional distributed
> >> key/value
> >> stores like Cassandra that distribute all keys in a single namespa=
ce
> >> across all nodes. =A0For example, radosgw now uses the new object =
map API
> >> to
> >> manage the index object for each bucket.
> >>
> >> For v0.45, we're continuing work on RBD caching, performance and b=
ug
> >> fixes, and working around xattr size limitations in ext3/4.
> >>
> >> You can get v0.44 from the usual locations:
> >>
> >> =A0* Git at git://github.com/ceph/ceph.git
> >> =A0* Tarball at http://ceph.newdream.net/download/ceph-0.44.tar.gz
> >> =A0* For Debian/Ubuntu packages, see
> >>
> >> http://ceph.newdream.net/docs/master/ops/install/mkcephfs/#install=
ing-the-packages
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
> >> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> >
> >
> > --
> > Tomasz Paszkowski
> > SS7, Asterisk, SAN, Datacenter, Cloud Computing
> > +48500166299
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
