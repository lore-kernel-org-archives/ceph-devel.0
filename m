From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Tue, 22 Mar 2016 21:57:03 +0800
Message-ID: <040FA762-A7C8-47FE-A72B-03419C79C782@redhat.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com> <1454742006-85706-3-git-send-email-zyan@redhat.com> <CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com> <4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com> <CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbcCVN5J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 09:57:09 -0400
In-Reply-To: <CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>


> On Mar 22, 2016, at 19:00, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> On Tue, Mar 22, 2016 at 10:17 AM, Yan, Zheng <zyan@redhat.com> wrote:
>>=20
>>> On Mar 22, 2016, at 14:05, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> [ snip ]
>=20
>>> Hi Zheng,
>>>=20
>>> A one and a half line commit message and an equally short cover let=
ter
>>> for a series such as this isn't enough.  I *happen* to know that th=
e
>>> basic use case for namespaces in cephfs is going to be restricting
>>> users to different parts of the directory tree, with the enforcemen=
t
>>> happening in ceph on the server side, as opposed to in ceph on the
>>> client side, but I would appreciate some details on what the actual
>>> namespace names are going to be, whether it's user input or not,
>>> whether there are plans to use namespaces for anything else, etc.
>>>=20
>>=20
>> The namespace restriction you mentioned is for cephfs metadata. This
>> namespace is restricting users to different namespaces in cephfs dat=
a
>> pool. (At present, the only way to restrict data access is, creating
>> multiple cephfs data pools, restrict users to different data pool.
>> Creating lost of pools is not efficient for the cluster)
>=20
> What about the namespace names, who is generating them, how long are
> they going to be?  Please describe in detail how this is going to wor=
k
> for both data and metadata pools.

=46or example, to restrict user foo to directory /foo_dir

// create auth caps for user foo.
ceph auth get-or-create client.foo mon 'allow r' mds 'allow r, allow rw=
 path=3D/foo_dir' osd 'allow rw pool=3Ddata namespace=3Dfoo_ns=E2=80=99

// mount cephfs by user admin
mount -t ceph 10.0.0.1:/ /mnt/ceph_mount -o name=3Dadmin,secret=3Dxxxx

// set directory=E2=80=99s layout.pool_namespace
setfattr -n ceph.dir.pool_namespace -v foo_ns /mnt/ceph_mount/foo_dir

Admin user chooses namespace name. In most cases, namespace name does n=
ot change.=20

>=20
>>=20
>>=20
>>> I don't like the idea of sharing namespace name strings between lib=
ceph
>>> and ceph modules, especially with the strings themselves hosted in
>>> libceph.  rbd has no use for namespaces, so libceph can live with
>>> namespace names embedded into ceph_osd_request by value or with
>>> a simple non-owning pointer, leaving reference counting to the outs=
ide
>>> modules, if one of the use cases is "one namespace with a long name=
 for
>>> the entire directory tree" or something close to it.
>>>=20
>>> I think the sharing infrastructure should be moved into cephfs, and
>>> probably changed to share entire file layouts along the way.  I don=
't
>>> know this code well enough to be sure, but it seems that by sharing
>>> file layouts and making ci->i_layout an owning pointer you might be
>>> able to piggy back on i_ceph_lock and considerably simplify the who=
le
>>> thing by dropping RCU and eliminating numerous get/put calls.
>>=20
>> RBD may use namespace later.
>> http://tracker.ceph.com/projects/ceph/wiki/Rbd_-_namespace_support
>=20
> Well, compared to cephfs, it's hard to call that "using" - in that
> case, there will only ever be one namespace per image.  My point is
> it's never going to use the string sharing infrastructure and is fine
> with a non-owning pointer to a string in the file layout field of the
> in-memory rbd image header.
>=20
>>=20
>> The reason I use RCU here is that ci->i_layout.pool_ns can change at
>> any time. For the same reason, using non-owning pointer for namespac=
e
>> or entire layout is unfeasible. Using embedded namespace is not
>> elegant either. When allocating ceph_osd_request, cephfs needs to
>> lock i_ceph_lock, copy namespace to a temporary buffer, unlock
>> i_ceph_lock, pass ci->i_layout and the temporary buffer to the
>> ceph_osdc_xxx_request().
>=20
> Hmm, RCU doesn't protect you from pool_ns or other file layout fields
> changing while the OSD request is in flight.  As used above, it allow=
s
> ceph_try_get_string() to not take any locks and that's it.

Yes.  But not taking lock simplify the code a lot.  we don't need to lo=
ck/unlock i_ceph_lock each time i_layout is used.

>=20
> Why exactly can't file layouts be shared?  ci->i_layout would become
> reference counted and you would give libceph a pointer to the pool_ns
> string (or entire layout) after bumping it.  It doesn't matter if
> pool_ns or the rest of the layout changes due to a cap grant or revok=
e
> while libceph is servicing the OSD request: you would unlink it from
> the tree but the bumped reference will keep the layout around, to be
> put in the OSD request completion callback or so.  Layout lookup woul=
d
> have to happen in exactly two places: when newing an inode and handli=
ng
> cap grant/revoke, in other places you would simply bump the count on
> the basis of already holding a valid pointer.  You wouldn't have to
> unlink in the destructor, so no hassle with kref_get_unless_zero() an=
d
> no need for RCU, with i_ceph_lock providing the exclusion around the
> tree.

This means cephfs needs to set r_callback for all ceph_osd_request, cep=
h_osd_request also needs a new field to store layout pointer. I don=E2=80=
=99t think it=E2=80=99s better/simpler than reference counted namespace=
 string.=20

>=20
> Like I said, I'm not familiar with the code in question at the
> necessary level of detail, so feel free to destroy this, but I don't
> see a problem.
>=20
> Thanks,
>=20
>                Ilya

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
