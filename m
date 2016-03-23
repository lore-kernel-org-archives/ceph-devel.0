From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Wed, 23 Mar 2016 10:51:04 +0100
Message-ID: <CAOi1vP80kT5rE=pjefY09KByAj6upeb2zOG8BwkaXpziZfQJJw@mail.gmail.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
	<1454742006-85706-3-git-send-email-zyan@redhat.com>
	<CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com>
	<4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com>
	<CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com>
	<040FA762-A7C8-47FE-A72B-03419C79C782@redhat.com>
	<CAOi1vP_v=iev1vQQrxGFYU2y7uTV1_imV5MkwqMgBQUCf2GnEg@mail.gmail.com>
	<CDD7EC25-57D8-4BD5-B8D0-41AAFC09EFA7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34787 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbcCWJvH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 05:51:07 -0400
Received: by mail-lf0-f68.google.com with SMTP id i75so667681lfb.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 02:51:05 -0700 (PDT)
In-Reply-To: <CDD7EC25-57D8-4BD5-B8D0-41AAFC09EFA7@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Wed, Mar 23, 2016 at 4:37 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On Mar 23, 2016, at 00:13, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Tue, Mar 22, 2016 at 2:57 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>>
>>>> On Mar 22, 2016, at 19:00, Ilya Dryomov <idryomov@gmail.com> wrote=
:
>>>>
>>>> On Tue, Mar 22, 2016 at 10:17 AM, Yan, Zheng <zyan@redhat.com> wro=
te:
>>>>>
>>>>>> On Mar 22, 2016, at 14:05, Ilya Dryomov <idryomov@gmail.com> wro=
te:
>>>>
>>>> [ snip ]
>>>>
>>>>>> Hi Zheng,
>>>>>>
>>>>>> A one and a half line commit message and an equally short cover =
letter
>>>>>> for a series such as this isn't enough.  I *happen* to know that=
 the
>>>>>> basic use case for namespaces in cephfs is going to be restricti=
ng
>>>>>> users to different parts of the directory tree, with the enforce=
ment
>>>>>> happening in ceph on the server side, as opposed to in ceph on t=
he
>>>>>> client side, but I would appreciate some details on what the act=
ual
>>>>>> namespace names are going to be, whether it's user input or not,
>>>>>> whether there are plans to use namespaces for anything else, etc=
=2E
>>>>>>
>>>>>
>>>>> The namespace restriction you mentioned is for cephfs metadata. T=
his
>>>>> namespace is restricting users to different namespaces in cephfs =
data
>>>>> pool. (At present, the only way to restrict data access is, creat=
ing
>>>>> multiple cephfs data pools, restrict users to different data pool=
=2E
>>>>> Creating lost of pools is not efficient for the cluster)
>>>>
>>>> What about the namespace names, who is generating them, how long a=
re
>>>> they going to be?  Please describe in detail how this is going to =
work
>>>> for both data and metadata pools.
>>>
>>> For example, to restrict user foo to directory /foo_dir
>>>
>>> // create auth caps for user foo.
>>> ceph auth get-or-create client.foo mon 'allow r' mds 'allow r, allo=
w rw path=3D/foo_dir' osd 'allow rw pool=3Ddata namespace=3Dfoo_ns=E2=80=
=99
>>>
>>> // mount cephfs by user admin
>>> mount -t ceph 10.0.0.1:/ /mnt/ceph_mount -o name=3Dadmin,secret=3Dx=
xxx
>>>
>>> // set directory=E2=80=99s layout.pool_namespace
>>> setfattr -n ceph.dir.pool_namespace -v foo_ns /mnt/ceph_mount/foo_d=
ir
>>>
>>> Admin user chooses namespace name. In most cases, namespace name do=
es not change.
>>
>> Good, I guess limiting it to 100 chars (or maybe even a smaller
>> number) is sensible then.
>>
>>>
>>>>
>>>>>
>>>>>
>>>>>> I don't like the idea of sharing namespace name strings between =
libceph
>>>>>> and ceph modules, especially with the strings themselves hosted =
in
>>>>>> libceph.  rbd has no use for namespaces, so libceph can live wit=
h
>>>>>> namespace names embedded into ceph_osd_request by value or with
>>>>>> a simple non-owning pointer, leaving reference counting to the o=
utside
>>>>>> modules, if one of the use cases is "one namespace with a long n=
ame for
>>>>>> the entire directory tree" or something close to it.
>>>>>>
>>>>>> I think the sharing infrastructure should be moved into cephfs, =
and
>>>>>> probably changed to share entire file layouts along the way.  I =
don't
>>>>>> know this code well enough to be sure, but it seems that by shar=
ing
>>>>>> file layouts and making ci->i_layout an owning pointer you might=
 be
>>>>>> able to piggy back on i_ceph_lock and considerably simplify the =
whole
>>>>>> thing by dropping RCU and eliminating numerous get/put calls.
>>>>>
>>>>> RBD may use namespace later.
>>>>> http://tracker.ceph.com/projects/ceph/wiki/Rbd_-_namespace_suppor=
t
>>>>
>>>> Well, compared to cephfs, it's hard to call that "using" - in that
>>>> case, there will only ever be one namespace per image.  My point i=
s
>>>> it's never going to use the string sharing infrastructure and is f=
ine
>>>> with a non-owning pointer to a string in the file layout field of =
the
>>>> in-memory rbd image header.
>>>>
>>>>>
>>>>> The reason I use RCU here is that ci->i_layout.pool_ns can change=
 at
>>>>> any time. For the same reason, using non-owning pointer for names=
pace
>>>>> or entire layout is unfeasible. Using embedded namespace is not
>>>>> elegant either. When allocating ceph_osd_request, cephfs needs to
>>>>> lock i_ceph_lock, copy namespace to a temporary buffer, unlock
>>>>> i_ceph_lock, pass ci->i_layout and the temporary buffer to the
>>>>> ceph_osdc_xxx_request().
>>>>
>>>> Hmm, RCU doesn't protect you from pool_ns or other file layout fie=
lds
>>>> changing while the OSD request is in flight.  As used above, it al=
lows
>>>> ceph_try_get_string() to not take any locks and that's it.
>>>
>>> Yes.  But not taking lock simplify the code a lot.  we don't need t=
o
>>> lock/unlock i_ceph_lock each time i_layout is used.
>>
>> I wouldn't call a bunch of rcu_dereference_* variants sprinkled arou=
nd
>> the code base a simplification, but, more importantly, is keeping th=
e
>> pool_ns pointer valid really all you need?  Shouldn't there be some
>> kind of synchronization around "OK, I'm switching to a new layout fo=
r
>> this inode"?  As it is, pool_ns is grabbed in ceph_osdc_new_request(=
),
>> with two successive calls to ceph_osdc_new_request() potentially end=
ing
>> up with two different namespaces, e.g. ceph_uninline_data().
>
> There is synchronisation. When changing file layout, MDS revokes Frw =
caps from client (block new read/write, for in-progress read/write). Bu=
t this synchronisation is not complete reliable when client session sta=
te is toggled between stale and active.

I have a bit of trouble parsing "block new read/write, for in-progress
read/write".  So the client will stop issuing requests as soon as it
learns that it no longer has a cap, but what happens with the in-flight
requests?

>
>>>>
>>>> Why exactly can't file layouts be shared?  ci->i_layout would beco=
me
>>>> reference counted and you would give libceph a pointer to the pool=
_ns
>>>> string (or entire layout) after bumping it.  It doesn't matter if
>>>> pool_ns or the rest of the layout changes due to a cap grant or re=
voke
>>>> while libceph is servicing the OSD request: you would unlink it fr=
om
>>>> the tree but the bumped reference will keep the layout around, to =
be
>>>> put in the OSD request completion callback or so.  Layout lookup w=
ould
>>>> have to happen in exactly two places: when newing an inode and han=
dling
>>>> cap grant/revoke, in other places you would simply bump the count =
on
>>>> the basis of already holding a valid pointer.  You wouldn't have t=
o
>>>> unlink in the destructor, so no hassle with kref_get_unless_zero()=
 and
>>>> no need for RCU, with i_ceph_lock providing the exclusion around t=
he
>>>> tree.
>>>
>>> This means cephfs needs to set r_callback for all ceph_osd_request,
>>> ceph_osd_request also needs a new field to store layout pointer.
>>> I don=E2=80=99t think it=E2=80=99s better/simpler than reference co=
unted namespace
>>> string.
>>
>> Not necessarily - you can put after ceph_osdc_wait_request() returns=
=2E
>> Somewhat unrelated, I'm working on refactoring osdc's handle_reply()=
,
>> and it'll probably be required that all OSD requests set one of the
>> callbacks, except for stateless fire-and-forget ones.
>
> For the r_callback case (no wait case), without saving a pointer in c=
eph_osd_request, how can I know which layout to put?
>
>>
>> Sharing ->i_layout as opposed to ->i_layout->pool_ns seemed sensible=
 to
>> me because a) it naturally hangs off of ceph inode and b) logically,
>> it is entire layouts and not just namespaces that are shared across =
the
>> directory tree.  If you think reference counted pool_ns strings are
>> better, I won't argue with that, but, with cephfs being the only use=
r
>> of either solution, it'll have to live in fs/ceph.
>
> I=E2=80=99m OK with both approaches. When sharing i_layout, we need t=
o add a layout pointer to ceph_osd_request. After adding the layout poi=
nter, why not let libceph release it when request finishes.
>
>> Separately, I think passing non-owning pool_ns pointers into libceph=
 is
>> worth exploring, but if that doesn't easily map onto cephfs lifetime=
 or
>> ownership rules, we will go with embedding namespace names by value =
into
>> ceph_osd_request (or, rather, ceph_object_locator).
>>
>
> As I stated in previous mail, embedded namespace is nightmare for cep=
hfs. Every time namespace is used,  cephfs needs to lock i_ceph_lock, c=
opy namespace to a temporary buffer.

So you are maintaining that all that is needed is to keep the memory
valid and there is no locking around installing a new namespace for an
inode.  I didn't realize that when I suggested layout sharing, it makes
it much less attractive.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
