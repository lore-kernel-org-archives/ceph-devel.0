From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: v0.44 released
Date: Wed, 21 Mar 2012 14:56:56 +0100
Message-ID: <CAMvP8PCofyuio+P0XY0d-DVq8YRkb1wzSajq3K3Wf8Tgg5Xz1g@mail.gmail.com>
References: <Pine.LNX.4.64.1203210638450.28797@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38402 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038Ab2CUN5R convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 09:57:17 -0400
Received: by yenl12 with SMTP id l12so920555yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 06:57:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203210638450.28797@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,

Can write sth more about new key/value api or point part of the source
where we can get familiar with it.


On Wed, Mar 21, 2012 at 2:39 PM, Sage Weil <sage@newdream.net> wrote:
> v0.44 is ready! =A0Changes since v0.43 include:
>
> =A0* osd: key/value objects (objects are now blobs, key/value bundles=
, and
> =A0 xattrs)
> =A0* osd: cleaned up PG state, stats
> =A0* osd: fixed transaction replay on non-btrfs after ill-timed failu=
res
> =A0* osd: several recovery fixes
> =A0* radosgw: improved PUT performance
> =A0* radosgw: improved list objects performance, filtering
> =A0* radosgw: manifests for large objects
> =A0* radosgw: Swift/S3 ACL interoperability (last set ACL type wins)
> =A0* librados: new key/value object API
> =A0* Ubuntu 12.04 precise packages
>
> The exciting part of this release is that the key/value "object map"
> work has been merged, along with radosgw changes to take advantage of=
 the
> new API. =A0This allows you to use a key/value interface to manage ma=
ny
> small records in a single object, in addition of the regular object d=
ata
> and attributes. =A0Keys in the same object are stored together on dis=
k--just
> like object data would be--so there are locality advantages to puttin=
g
> related keys in the same object. =A0However, there are no limits on h=
ow many
> keys per object beyond concerns about load and space balancing (all k=
eys
> in an object are stored together on the same set of Ceph OSDs). =A0Th=
is
> provides an interesting alternative to conventional distributed key/v=
alue
> stores like Cassandra that distribute all keys in a single namespace
> across all nodes. =A0For example, radosgw now uses the new object map=
 API to
> manage the index object for each bucket.
>
> For v0.45, we're continuing work on RBD caching, performance and bug
> fixes, and working around xattr size limitations in ext3/4.
>
> You can get v0.44 from the usual locations:
>
> =A0* Git at git://github.com/ceph/ceph.git
> =A0* Tarball at http://ceph.newdream.net/download/ceph-0.44.tar.gz
> =A0* For Debian/Ubuntu packages, see
> =A0 http://ceph.newdream.net/docs/master/ops/install/mkcephfs/#instal=
ling-the-packages
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
