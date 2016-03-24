From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Thu, 24 Mar 2016 21:18:00 +0800
Message-ID: <C4A3841F-3310-446D-9DC1-CEB2FE40CB4E@redhat.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com> <1454742006-85706-3-git-send-email-zyan@redhat.com> <CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com> <4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com> <CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com> <040FA762-A7C8-47FE-A72B-03419C79C782@redhat.com> <CAOi1vP_v=iev1vQQrxGFYU2y7uTV1_imV5MkwqMgBQUCf2GnEg@mail.gmail.com> <CDD7EC25-57D8-4BD5-B8D0-41AAFC09EFA7@redhat.com> <CAOi1vP80kT5rE=pjefY09KByAj6upeb2zOG8BwkaXpziZfQJJw@mail.gmail.com> <21C799EB-4B5D-4F66-923F-FF52F0323146@redhat.com> <CAOi1vP9L7yN_RHHbMLK7Cwr84pBYgm8GpHFsygwUxj4Tpjabfg@mail.gmail.com> <A3CC3516-D528-4F4A-B1A9-3421844B1484@redhat.com> <CAOi1vP9E4S1yrWAwQ6KSKL07-xZwt301UBBq6Z5QOoR3L+0ycQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbcCXNSG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 09:18:06 -0400
In-Reply-To: <CAOi1vP9E4S1yrWAwQ6KSKL07-xZwt301UBBq6Z5QOoR3L+0ycQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>


> On Mar 24, 2016, at 18:26, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> On Thu, Mar 24, 2016 at 3:33 AM, Yan, Zheng <zyan@redhat.com> wrote:
>>=20
>>> On Mar 24, 2016, at 03:27, Ilya Dryomov <idryomov@gmail.com> wrote:
>>>=20
>>> On Wed, Mar 23, 2016 at 2:02 PM, Yan, Zheng <zyan@redhat.com> wrote=
:
>>>>=20
>>>>> On Mar 23, 2016, at 17:51, Ilya Dryomov <idryomov@gmail.com> wrot=
e:
>>>>>=20
>>>>> On Wed, Mar 23, 2016 at 4:37 AM, Yan, Zheng <zyan@redhat.com> wro=
te:
>>>>>>=20
>>>>>>> On Mar 23, 2016, at 00:13, Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>>>>>>>=20
>>>>>>> On Tue, Mar 22, 2016 at 2:57 PM, Yan, Zheng <zyan@redhat.com> w=
rote:
>>>>>>>>=20
>>>>>>>>> On Mar 22, 2016, at 19:00, Ilya Dryomov <idryomov@gmail.com> =
wrote:
>>>>>>>>>=20
>>>>>>>>> On Tue, Mar 22, 2016 at 10:17 AM, Yan, Zheng <zyan@redhat.com=
> wrote:
>>>>>>>>>>=20
>>>>>>>>>>> On Mar 22, 2016, at 14:05, Ilya Dryomov <idryomov@gmail.com=
> wrote:
>>>>>>>>>=20
>>>>>>>>> [ snip ]
>>>>>>>>>=20
>>>>>>>>>>> Hi Zheng,
>>>>>>>>>>>=20
>>>>>>>>>>> A one and a half line commit message and an equally short c=
over letter
>>>>>>>>>>> for a series such as this isn't enough.  I *happen* to know=
 that the
>>>>>>>>>>> basic use case for namespaces in cephfs is going to be rest=
ricting
>>>>>>>>>>> users to different parts of the directory tree, with the en=
forcement
>>>>>>>>>>> happening in ceph on the server side, as opposed to in ceph=
 on the
>>>>>>>>>>> client side, but I would appreciate some details on what th=
e actual
>>>>>>>>>>> namespace names are going to be, whether it's user input or=
 not,
>>>>>>>>>>> whether there are plans to use namespaces for anything else=
, etc.
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> The namespace restriction you mentioned is for cephfs metada=
ta. This
>>>>>>>>>> namespace is restricting users to different namespaces in ce=
phfs data
>>>>>>>>>> pool. (At present, the only way to restrict data access is, =
creating
>>>>>>>>>> multiple cephfs data pools, restrict users to different data=
 pool.
>>>>>>>>>> Creating lost of pools is not efficient for the cluster)
>>>>>>>>>=20
>>>>>>>>> What about the namespace names, who is generating them, how l=
ong are
>>>>>>>>> they going to be?  Please describe in detail how this is goin=
g to work
>>>>>>>>> for both data and metadata pools.
>>>>>>>>=20
>>>>>>>> For example, to restrict user foo to directory /foo_dir
>>>>>>>>=20
>>>>>>>> // create auth caps for user foo.
>>>>>>>> ceph auth get-or-create client.foo mon 'allow r' mds 'allow r,=
 allow rw path=3D/foo_dir' osd 'allow rw pool=3Ddata namespace=3Dfoo_ns=
=E2=80=99
>>>>>>>>=20
>>>>>>>> // mount cephfs by user admin
>>>>>>>> mount -t ceph 10.0.0.1:/ /mnt/ceph_mount -o name=3Dadmin,secre=
t=3Dxxxx
>>>>>>>>=20
>>>>>>>> // set directory=E2=80=99s layout.pool_namespace
>>>>>>>> setfattr -n ceph.dir.pool_namespace -v foo_ns /mnt/ceph_mount/=
foo_dir
>>>>>>>>=20
>>>>>>>> Admin user chooses namespace name. In most cases, namespace na=
me does not change.
>>>>>>>=20
>>>>>>> Good, I guess limiting it to 100 chars (or maybe even a smaller
>>>>>>> number) is sensible then.
>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>> I don't like the idea of sharing namespace name strings bet=
ween libceph
>>>>>>>>>>> and ceph modules, especially with the strings themselves ho=
sted in
>>>>>>>>>>> libceph.  rbd has no use for namespaces, so libceph can liv=
e with
>>>>>>>>>>> namespace names embedded into ceph_osd_request by value or =
with
>>>>>>>>>>> a simple non-owning pointer, leaving reference counting to =
the outside
>>>>>>>>>>> modules, if one of the use cases is "one namespace with a l=
ong name for
>>>>>>>>>>> the entire directory tree" or something close to it.
>>>>>>>>>>>=20
>>>>>>>>>>> I think the sharing infrastructure should be moved into cep=
hfs, and
>>>>>>>>>>> probably changed to share entire file layouts along the way=
=2E  I don't
>>>>>>>>>>> know this code well enough to be sure, but it seems that by=
 sharing
>>>>>>>>>>> file layouts and making ci->i_layout an owning pointer you =
might be
>>>>>>>>>>> able to piggy back on i_ceph_lock and considerably simplify=
 the whole
>>>>>>>>>>> thing by dropping RCU and eliminating numerous get/put call=
s.
>>>>>>>>>>=20
>>>>>>>>>> RBD may use namespace later.
>>>>>>>>>> http://tracker.ceph.com/projects/ceph/wiki/Rbd_-_namespace_s=
upport
>>>>>>>>>=20
>>>>>>>>> Well, compared to cephfs, it's hard to call that "using" - in=
 that
>>>>>>>>> case, there will only ever be one namespace per image.  My po=
int is
>>>>>>>>> it's never going to use the string sharing infrastructure and=
 is fine
>>>>>>>>> with a non-owning pointer to a string in the file layout fiel=
d of the
>>>>>>>>> in-memory rbd image header.
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> The reason I use RCU here is that ci->i_layout.pool_ns can c=
hange at
>>>>>>>>>> any time. For the same reason, using non-owning pointer for =
namespace
>>>>>>>>>> or entire layout is unfeasible. Using embedded namespace is =
not
>>>>>>>>>> elegant either. When allocating ceph_osd_request, cephfs nee=
ds to
>>>>>>>>>> lock i_ceph_lock, copy namespace to a temporary buffer, unlo=
ck
>>>>>>>>>> i_ceph_lock, pass ci->i_layout and the temporary buffer to t=
he
>>>>>>>>>> ceph_osdc_xxx_request().
>>>>>>>>>=20
>>>>>>>>> Hmm, RCU doesn't protect you from pool_ns or other file layou=
t fields
>>>>>>>>> changing while the OSD request is in flight.  As used above, =
it allows
>>>>>>>>> ceph_try_get_string() to not take any locks and that's it.
>>>>>>>>=20
>>>>>>>> Yes.  But not taking lock simplify the code a lot.  we don't n=
eed to
>>>>>>>> lock/unlock i_ceph_lock each time i_layout is used.
>>>>>>>=20
>>>>>>> I wouldn't call a bunch of rcu_dereference_* variants sprinkled=
 around
>>>>>>> the code base a simplification, but, more importantly, is keepi=
ng the
>>>>>>> pool_ns pointer valid really all you need?  Shouldn't there be =
some
>>>>>>> kind of synchronization around "OK, I'm switching to a new layo=
ut for
>>>>>>> this inode"?  As it is, pool_ns is grabbed in ceph_osdc_new_req=
uest(),
>>>>>>> with two successive calls to ceph_osdc_new_request() potentiall=
y ending
>>>>>>> up with two different namespaces, e.g. ceph_uninline_data().
>>>>>>=20
>>>>>> There is synchronisation. When changing file layout, MDS revokes=
 Frw caps from client (block new read/write, for in-progress read/write=
). But this synchronisation is not complete reliable when client sessio=
n state is toggled between stale and active.
>>>>>=20
>>>>> I have a bit of trouble parsing "block new read/write, for in-pro=
gress
>>>>> read/write".  So the client will stop issuing requests as soon as=
 it
>>>>> learns that it no longer has a cap, but what happens with the in-=
flight
>>>>> requests?
>>>>=20
>>>> When client know MDS is revoking Frw caps, it stops issuing new re=
quest and waits for in-flight requests. After all in-flight requests co=
mpletes, client releases Frw caps to MDS.
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Why exactly can't file layouts be shared?  ci->i_layout would=
 become
>>>>>>>>> reference counted and you would give libceph a pointer to the=
 pool_ns
>>>>>>>>> string (or entire layout) after bumping it.  It doesn't matte=
r if
>>>>>>>>> pool_ns or the rest of the layout changes due to a cap grant =
or revoke
>>>>>>>>> while libceph is servicing the OSD request: you would unlink =
it from
>>>>>>>>> the tree but the bumped reference will keep the layout around=
, to be
>>>>>>>>> put in the OSD request completion callback or so.  Layout loo=
kup would
>>>>>>>>> have to happen in exactly two places: when newing an inode an=
d handling
>>>>>>>>> cap grant/revoke, in other places you would simply bump the c=
ount on
>>>>>>>>> the basis of already holding a valid pointer.  You wouldn't h=
ave to
>>>>>>>>> unlink in the destructor, so no hassle with kref_get_unless_z=
ero() and
>>>>>>>>> no need for RCU, with i_ceph_lock providing the exclusion aro=
und the
>>>>>>>>> tree.
>>>>>>>>=20
>>>>>>>> This means cephfs needs to set r_callback for all ceph_osd_req=
uest,
>>>>>>>> ceph_osd_request also needs a new field to store layout pointe=
r.
>>>>>>>> I don=E2=80=99t think it=E2=80=99s better/simpler than referen=
ce counted namespace
>>>>>>>> string.
>>>>>>>=20
>>>>>>> Not necessarily - you can put after ceph_osdc_wait_request() re=
turns.
>>>>>>> Somewhat unrelated, I'm working on refactoring osdc's handle_re=
ply(),
>>>>>>> and it'll probably be required that all OSD requests set one of=
 the
>>>>>>> callbacks, except for stateless fire-and-forget ones.
>>>>>>=20
>>>>>> For the r_callback case (no wait case), without saving a pointer=
 in ceph_osd_request, how can I know which layout to put?
>>>>>>=20
>>>>>>>=20
>>>>>>> Sharing ->i_layout as opposed to ->i_layout->pool_ns seemed sen=
sible to
>>>>>>> me because a) it naturally hangs off of ceph inode and b) logic=
ally,
>>>>>>> it is entire layouts and not just namespaces that are shared ac=
ross the
>>>>>>> directory tree.  If you think reference counted pool_ns strings=
 are
>>>>>>> better, I won't argue with that, but, with cephfs being the onl=
y user
>>>>>>> of either solution, it'll have to live in fs/ceph.
>>>>>>=20
>>>>>> I=E2=80=99m OK with both approaches. When sharing i_layout, we n=
eed to add a layout pointer to ceph_osd_request. After adding the layou=
t pointer, why not let libceph release it when request finishes.
>>>>>>=20
>>>>>>> Separately, I think passing non-owning pool_ns pointers into li=
bceph is
>>>>>>> worth exploring, but if that doesn't easily map onto cephfs lif=
etime or
>>>>>>> ownership rules, we will go with embedding namespace names by v=
alue into
>>>>>>> ceph_osd_request (or, rather, ceph_object_locator).
>>>>>>>=20
>>>>>>=20
>>>>>> As I stated in previous mail, embedded namespace is nightmare fo=
r cephfs. Every time namespace is used,  cephfs needs to lock i_ceph_lo=
ck, copy namespace to a temporary buffer.
>>>>>=20
>>>>> So you are maintaining that all that is needed is to keep the mem=
ory
>>>>> valid and there is no locking around installing a new namespace f=
or an
>>>>> inode.  I didn't realize that when I suggested layout sharing, it=
 makes
>>>>> it much less attractive.
>>>>=20
>>>> Yes.  That=E2=80=99s the main reason I decided to use RCU.
>>>=20
>>> For the record, I don't think it's a good design and I doubt the
>>> implementation is going to work reliably, but that's your call.
>>>=20
>>> Why would embedded namespaces in ceph_object_locator in libceph be
>>> a nightmare for cephfs?  What do you refer to as a temporary buffer=
?
>>> This kind of copying already occurs: you grab a ceph_string with
>>> ceph_try_get_string() in ceph_osdc_new_request() and it's copied in=
to
>>> the request message, as part of encoding.  How is grabbing ceph_str=
ing
>>> before calling into libceph and explicitly copying into object loca=
tor
>>> different?
>>=20
>> I mean not using reference-counted ceph_string.
>>=20
>>=20
>> Yes, we can make cephfs code manage the reference counting, call cep=
h_try_get_string() and ceph_put_string() each time we issue osd request=
=2E But this approach requires more code/overhead for both ceph and lib=
ceph (an extra parameter for ceph_osdc_xxx_request() functions, code th=
at copies namespace to embedded buffer, lots of ceph_try_get_string()/c=
eph_put_string() pair in cephfs code).  All of this is just for removin=
g one ceph_try_get_string() call and two ceph_put_string() call in libc=
eph. does it worth the effort, does it make libceph code cleaner=EF=BC=9F
>=20
> It'll be printed into the request after it's allocated, just like OID
> is now, so e.g. ceph_osdc_alloc_request() won't need any changes.  Yo=
u
> may need to patch ceph_osdc_new_request(), but that's a cephfs-specif=
ic
> function and should probably be moved out of libceph.  You won't need
> to add lots of get/put pairs in cephfs either - a single helper aroun=
d
> filling in an object locator would do it.
>=20
> The two disadvantages (extra strcpy() and larger OSD requests) are
> real, but so are the benefits of modularity and keeping object locato=
r
> a simple value type.  I'm just trying to explore all available option=
s.

I agree that it=E2=80=99s easy for us to explore both options if we mov=
e ceph_osdc_new_request(), ceph_osdc_readpage and ceph_osdc_writepage i=
nto fs/ceph directory,=20

>=20
> TBH I still can't wrap my head around lockless layout/namespace point=
er
> updates and how that can ever work reliably=E2=80=A6

see Documentation/RCU/rcuref.txt. How RCU is used in my code is similar=
 to the second example.

Regards
Yan, Zheng


> Thanks,
>=20
>                Ilya

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
