From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Thu, 24 Mar 2016 11:26:11 +0100
Message-ID: <CAOi1vP9E4S1yrWAwQ6KSKL07-xZwt301UBBq6Z5QOoR3L+0ycQ@mail.gmail.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
	<1454742006-85706-3-git-send-email-zyan@redhat.com>
	<CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com>
	<4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com>
	<CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com>
	<040FA762-A7C8-47FE-A72B-03419C79C782@redhat.com>
	<CAOi1vP_v=iev1vQQrxGFYU2y7uTV1_imV5MkwqMgBQUCf2GnEg@mail.gmail.com>
	<CDD7EC25-57D8-4BD5-B8D0-41AAFC09EFA7@redhat.com>
	<CAOi1vP80kT5rE=pjefY09KByAj6upeb2zOG8BwkaXpziZfQJJw@mail.gmail.com>
	<21C799EB-4B5D-4F66-923F-FF52F0323146@redhat.com>
	<CAOi1vP9L7yN_RHHbMLK7Cwr84pBYgm8GpHFsygwUxj4Tpjabfg@mail.gmail.com>
	<A3CC3516-D528-4F4A-B1A9-3421844B1484@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35233 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbcCXK0N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 06:26:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id c62so493028lfc.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 03:26:12 -0700 (PDT)
In-Reply-To: <A3CC3516-D528-4F4A-B1A9-3421844B1484@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Thu, Mar 24, 2016 at 3:33 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On Mar 24, 2016, at 03:27, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Wed, Mar 23, 2016 at 2:02 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>>
>>>> On Mar 23, 2016, at 17:51, Ilya Dryomov <idryomov@gmail.com> wrote=
:
>>>>
>>>> On Wed, Mar 23, 2016 at 4:37 AM, Yan, Zheng <zyan@redhat.com> wrot=
e:
>>>>>
>>>>>> On Mar 23, 2016, at 00:13, Ilya Dryomov <idryomov@gmail.com> wro=
te:
>>>>>>
>>>>>> On Tue, Mar 22, 2016 at 2:57 PM, Yan, Zheng <zyan@redhat.com> wr=
ote:
>>>>>>>
>>>>>>>> On Mar 22, 2016, at 19:00, Ilya Dryomov <idryomov@gmail.com> w=
rote:
>>>>>>>>
>>>>>>>> On Tue, Mar 22, 2016 at 10:17 AM, Yan, Zheng <zyan@redhat.com>=
 wrote:
>>>>>>>>>
>>>>>>>>>> On Mar 22, 2016, at 14:05, Ilya Dryomov <idryomov@gmail.com>=
 wrote:
>>>>>>>>
>>>>>>>> [ snip ]
>>>>>>>>
>>>>>>>>>> Hi Zheng,
>>>>>>>>>>
>>>>>>>>>> A one and a half line commit message and an equally short co=
ver letter
>>>>>>>>>> for a series such as this isn't enough.  I *happen* to know =
that the
>>>>>>>>>> basic use case for namespaces in cephfs is going to be restr=
icting
>>>>>>>>>> users to different parts of the directory tree, with the enf=
orcement
>>>>>>>>>> happening in ceph on the server side, as opposed to in ceph =
on the
>>>>>>>>>> client side, but I would appreciate some details on what the=
 actual
>>>>>>>>>> namespace names are going to be, whether it's user input or =
not,
>>>>>>>>>> whether there are plans to use namespaces for anything else,=
 etc.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The namespace restriction you mentioned is for cephfs metadat=
a. This
>>>>>>>>> namespace is restricting users to different namespaces in cep=
hfs data
>>>>>>>>> pool. (At present, the only way to restrict data access is, c=
reating
>>>>>>>>> multiple cephfs data pools, restrict users to different data =
pool.
>>>>>>>>> Creating lost of pools is not efficient for the cluster)
>>>>>>>>
>>>>>>>> What about the namespace names, who is generating them, how lo=
ng are
>>>>>>>> they going to be?  Please describe in detail how this is going=
 to work
>>>>>>>> for both data and metadata pools.
>>>>>>>
>>>>>>> For example, to restrict user foo to directory /foo_dir
>>>>>>>
>>>>>>> // create auth caps for user foo.
>>>>>>> ceph auth get-or-create client.foo mon 'allow r' mds 'allow r, =
allow rw path=3D/foo_dir' osd 'allow rw pool=3Ddata namespace=3Dfoo_ns=E2=
=80=99
>>>>>>>
>>>>>>> // mount cephfs by user admin
>>>>>>> mount -t ceph 10.0.0.1:/ /mnt/ceph_mount -o name=3Dadmin,secret=
=3Dxxxx
>>>>>>>
>>>>>>> // set directory=E2=80=99s layout.pool_namespace
>>>>>>> setfattr -n ceph.dir.pool_namespace -v foo_ns /mnt/ceph_mount/f=
oo_dir
>>>>>>>
>>>>>>> Admin user chooses namespace name. In most cases, namespace nam=
e does not change.
>>>>>>
>>>>>> Good, I guess limiting it to 100 chars (or maybe even a smaller
>>>>>> number) is sensible then.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> I don't like the idea of sharing namespace name strings betw=
een libceph
>>>>>>>>>> and ceph modules, especially with the strings themselves hos=
ted in
>>>>>>>>>> libceph.  rbd has no use for namespaces, so libceph can live=
 with
>>>>>>>>>> namespace names embedded into ceph_osd_request by value or w=
ith
>>>>>>>>>> a simple non-owning pointer, leaving reference counting to t=
he outside
>>>>>>>>>> modules, if one of the use cases is "one namespace with a lo=
ng name for
>>>>>>>>>> the entire directory tree" or something close to it.
>>>>>>>>>>
>>>>>>>>>> I think the sharing infrastructure should be moved into ceph=
fs, and
>>>>>>>>>> probably changed to share entire file layouts along the way.=
  I don't
>>>>>>>>>> know this code well enough to be sure, but it seems that by =
sharing
>>>>>>>>>> file layouts and making ci->i_layout an owning pointer you m=
ight be
>>>>>>>>>> able to piggy back on i_ceph_lock and considerably simplify =
the whole
>>>>>>>>>> thing by dropping RCU and eliminating numerous get/put calls=
=2E
>>>>>>>>>
>>>>>>>>> RBD may use namespace later.
>>>>>>>>> http://tracker.ceph.com/projects/ceph/wiki/Rbd_-_namespace_su=
pport
>>>>>>>>
>>>>>>>> Well, compared to cephfs, it's hard to call that "using" - in =
that
>>>>>>>> case, there will only ever be one namespace per image.  My poi=
nt is
>>>>>>>> it's never going to use the string sharing infrastructure and =
is fine
>>>>>>>> with a non-owning pointer to a string in the file layout field=
 of the
>>>>>>>> in-memory rbd image header.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> The reason I use RCU here is that ci->i_layout.pool_ns can ch=
ange at
>>>>>>>>> any time. For the same reason, using non-owning pointer for n=
amespace
>>>>>>>>> or entire layout is unfeasible. Using embedded namespace is n=
ot
>>>>>>>>> elegant either. When allocating ceph_osd_request, cephfs need=
s to
>>>>>>>>> lock i_ceph_lock, copy namespace to a temporary buffer, unloc=
k
>>>>>>>>> i_ceph_lock, pass ci->i_layout and the temporary buffer to th=
e
>>>>>>>>> ceph_osdc_xxx_request().
>>>>>>>>
>>>>>>>> Hmm, RCU doesn't protect you from pool_ns or other file layout=
 fields
>>>>>>>> changing while the OSD request is in flight.  As used above, i=
t allows
>>>>>>>> ceph_try_get_string() to not take any locks and that's it.
>>>>>>>
>>>>>>> Yes.  But not taking lock simplify the code a lot.  we don't ne=
ed to
>>>>>>> lock/unlock i_ceph_lock each time i_layout is used.
>>>>>>
>>>>>> I wouldn't call a bunch of rcu_dereference_* variants sprinkled =
around
>>>>>> the code base a simplification, but, more importantly, is keepin=
g the
>>>>>> pool_ns pointer valid really all you need?  Shouldn't there be s=
ome
>>>>>> kind of synchronization around "OK, I'm switching to a new layou=
t for
>>>>>> this inode"?  As it is, pool_ns is grabbed in ceph_osdc_new_requ=
est(),
>>>>>> with two successive calls to ceph_osdc_new_request() potentially=
 ending
>>>>>> up with two different namespaces, e.g. ceph_uninline_data().
>>>>>
>>>>> There is synchronisation. When changing file layout, MDS revokes =
=46rw caps from client (block new read/write, for in-progress read/writ=
e). But this synchronisation is not complete reliable when client sessi=
on state is toggled between stale and active.
>>>>
>>>> I have a bit of trouble parsing "block new read/write, for in-prog=
ress
>>>> read/write".  So the client will stop issuing requests as soon as =
it
>>>> learns that it no longer has a cap, but what happens with the in-f=
light
>>>> requests?
>>>
>>> When client know MDS is revoking Frw caps, it stops issuing new req=
uest and waits for in-flight requests. After all in-flight requests com=
pletes, client releases Frw caps to MDS.
>>>
>>>>
>>>>>
>>>>>>>>
>>>>>>>> Why exactly can't file layouts be shared?  ci->i_layout would =
become
>>>>>>>> reference counted and you would give libceph a pointer to the =
pool_ns
>>>>>>>> string (or entire layout) after bumping it.  It doesn't matter=
 if
>>>>>>>> pool_ns or the rest of the layout changes due to a cap grant o=
r revoke
>>>>>>>> while libceph is servicing the OSD request: you would unlink i=
t from
>>>>>>>> the tree but the bumped reference will keep the layout around,=
 to be
>>>>>>>> put in the OSD request completion callback or so.  Layout look=
up would
>>>>>>>> have to happen in exactly two places: when newing an inode and=
 handling
>>>>>>>> cap grant/revoke, in other places you would simply bump the co=
unt on
>>>>>>>> the basis of already holding a valid pointer.  You wouldn't ha=
ve to
>>>>>>>> unlink in the destructor, so no hassle with kref_get_unless_ze=
ro() and
>>>>>>>> no need for RCU, with i_ceph_lock providing the exclusion arou=
nd the
>>>>>>>> tree.
>>>>>>>
>>>>>>> This means cephfs needs to set r_callback for all ceph_osd_requ=
est,
>>>>>>> ceph_osd_request also needs a new field to store layout pointer=
=2E
>>>>>>> I don=E2=80=99t think it=E2=80=99s better/simpler than referenc=
e counted namespace
>>>>>>> string.
>>>>>>
>>>>>> Not necessarily - you can put after ceph_osdc_wait_request() ret=
urns.
>>>>>> Somewhat unrelated, I'm working on refactoring osdc's handle_rep=
ly(),
>>>>>> and it'll probably be required that all OSD requests set one of =
the
>>>>>> callbacks, except for stateless fire-and-forget ones.
>>>>>
>>>>> For the r_callback case (no wait case), without saving a pointer =
in ceph_osd_request, how can I know which layout to put?
>>>>>
>>>>>>
>>>>>> Sharing ->i_layout as opposed to ->i_layout->pool_ns seemed sens=
ible to
>>>>>> me because a) it naturally hangs off of ceph inode and b) logica=
lly,
>>>>>> it is entire layouts and not just namespaces that are shared acr=
oss the
>>>>>> directory tree.  If you think reference counted pool_ns strings =
are
>>>>>> better, I won't argue with that, but, with cephfs being the only=
 user
>>>>>> of either solution, it'll have to live in fs/ceph.
>>>>>
>>>>> I=E2=80=99m OK with both approaches. When sharing i_layout, we ne=
ed to add a layout pointer to ceph_osd_request. After adding the layout=
 pointer, why not let libceph release it when request finishes.
>>>>>
>>>>>> Separately, I think passing non-owning pool_ns pointers into lib=
ceph is
>>>>>> worth exploring, but if that doesn't easily map onto cephfs life=
time or
>>>>>> ownership rules, we will go with embedding namespace names by va=
lue into
>>>>>> ceph_osd_request (or, rather, ceph_object_locator).
>>>>>>
>>>>>
>>>>> As I stated in previous mail, embedded namespace is nightmare for=
 cephfs. Every time namespace is used,  cephfs needs to lock i_ceph_loc=
k, copy namespace to a temporary buffer.
>>>>
>>>> So you are maintaining that all that is needed is to keep the memo=
ry
>>>> valid and there is no locking around installing a new namespace fo=
r an
>>>> inode.  I didn't realize that when I suggested layout sharing, it =
makes
>>>> it much less attractive.
>>>
>>> Yes.  That=E2=80=99s the main reason I decided to use RCU.
>>
>> For the record, I don't think it's a good design and I doubt the
>> implementation is going to work reliably, but that's your call.
>>
>> Why would embedded namespaces in ceph_object_locator in libceph be
>> a nightmare for cephfs?  What do you refer to as a temporary buffer?
>> This kind of copying already occurs: you grab a ceph_string with
>> ceph_try_get_string() in ceph_osdc_new_request() and it's copied int=
o
>> the request message, as part of encoding.  How is grabbing ceph_stri=
ng
>> before calling into libceph and explicitly copying into object locat=
or
>> different?
>
> I mean not using reference-counted ceph_string.
>
>
> Yes, we can make cephfs code manage the reference counting, call ceph=
_try_get_string() and ceph_put_string() each time we issue osd request.=
 But this approach requires more code/overhead for both ceph and libcep=
h (an extra parameter for ceph_osdc_xxx_request() functions, code that =
copies namespace to embedded buffer, lots of ceph_try_get_string()/ceph=
_put_string() pair in cephfs code).  All of this is just for removing o=
ne ceph_try_get_string() call and two ceph_put_string() call in libceph=
=2E does it worth the effort, does it make libceph code cleaner=EF=BC=9F

It'll be printed into the request after it's allocated, just like OID
is now, so e.g. ceph_osdc_alloc_request() won't need any changes.  You
may need to patch ceph_osdc_new_request(), but that's a cephfs-specific
function and should probably be moved out of libceph.  You won't need
to add lots of get/put pairs in cephfs either - a single helper around
filling in an object locator would do it.

The two disadvantages (extra strcpy() and larger OSD requests) are
real, but so are the benefits of modularity and keeping object locator
a simple value type.  I'm just trying to explore all available options.

TBH I still can't wrap my head around lockless layout/namespace pointer
updates and how that can ever work reliably...

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
