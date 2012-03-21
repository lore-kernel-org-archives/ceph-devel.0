From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: v0.44 released
Date: Wed, 21 Mar 2012 09:39:18 -0700
Message-ID: <CACLRD_1-Fq_oR=iGZorm5z-6MpnT=zBOUcLi72=ofKYTf9CEog@mail.gmail.com>
References: <Pine.LNX.4.64.1203210638450.28797@cobra.newdream.net>
	<CAMvP8PCofyuio+P0XY0d-DVq8YRkb1wzSajq3K3Wf8Tgg5Xz1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47713 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100Ab2CUQjT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 12:39:19 -0400
Received: by wgbdr13 with SMTP id dr13so788330wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 09:39:18 -0700 (PDT)
In-Reply-To: <CAMvP8PCofyuio+P0XY0d-DVq8YRkb1wzSajq3K3Wf8Tgg5Xz1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

The relevant api functions are the omap_* methods of
ObjectWriteOperation and ObjectReadOperation, which can be found in
src/include/rados/librados.hpp.  Note, ObjectWriteOperation and
ObjectReadOperation are transactions which are submitted using
aio_operate or operate.  src/test/rados-api/aio.cc has some usage
examples in the OmapPP test.

-Sam

On Wed, Mar 21, 2012 at 6:56 AM, Tomasz Paszkowski <ss7pro@gmail.com> w=
rote:
> Hi,
>
> Can write sth more about new key/value api or point part of the sourc=
e
> where we can get familiar with it.
>
>
> On Wed, Mar 21, 2012 at 2:39 PM, Sage Weil <sage@newdream.net> wrote:
>> v0.44 is ready! =C2=A0Changes since v0.43 include:
>>
>> =C2=A0* osd: key/value objects (objects are now blobs, key/value bun=
dles, and
>> =C2=A0 xattrs)
>> =C2=A0* osd: cleaned up PG state, stats
>> =C2=A0* osd: fixed transaction replay on non-btrfs after ill-timed f=
ailures
>> =C2=A0* osd: several recovery fixes
>> =C2=A0* radosgw: improved PUT performance
>> =C2=A0* radosgw: improved list objects performance, filtering
>> =C2=A0* radosgw: manifests for large objects
>> =C2=A0* radosgw: Swift/S3 ACL interoperability (last set ACL type wi=
ns)
>> =C2=A0* librados: new key/value object API
>> =C2=A0* Ubuntu 12.04 precise packages
>>
>> The exciting part of this release is that the key/value "object map"
>> work has been merged, along with radosgw changes to take advantage o=
f the
>> new API. =C2=A0This allows you to use a key/value interface to manag=
e many
>> small records in a single object, in addition of the regular object =
data
>> and attributes. =C2=A0Keys in the same object are stored together on=
 disk--just
>> like object data would be--so there are locality advantages to putti=
ng
>> related keys in the same object. =C2=A0However, there are no limits =
on how many
>> keys per object beyond concerns about load and space balancing (all =
keys
>> in an object are stored together on the same set of Ceph OSDs). =C2=A0=
This
>> provides an interesting alternative to conventional distributed key/=
value
>> stores like Cassandra that distribute all keys in a single namespace
>> across all nodes. =C2=A0For example, radosgw now uses the new object=
 map API to
>> manage the index object for each bucket.
>>
>> For v0.45, we're continuing work on RBD caching, performance and bug
>> fixes, and working around xattr size limitations in ext3/4.
>>
>> You can get v0.44 from the usual locations:
>>
>> =C2=A0* Git at git://github.com/ceph/ceph.git
>> =C2=A0* Tarball at http://ceph.newdream.net/download/ceph-0.44.tar.g=
z
>> =C2=A0* For Debian/Ubuntu packages, see
>> =C2=A0 http://ceph.newdream.net/docs/master/ops/install/mkcephfs/#in=
stalling-the-packages
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
>
> --
> Tomasz Paszkowski
> SS7, Asterisk, SAN, Datacenter, Cloud Computing
> +48500166299
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
