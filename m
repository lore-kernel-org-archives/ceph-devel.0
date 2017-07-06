From: Jiaying Ren <mikulely@gmail.com>
Subject: Re: RGW: Implement S3 storage class feature
Date: Thu, 6 Jul 2017 19:00:25 +0800
Message-ID: <CAF8OO3Pgrw4HQ0iQv+RoEyG5ygVUpyomA9PKii8X920iJ4PRFA@mail.gmail.com>
References: <CAF8OO3Mo3xFbxioTedym+rByF1Eu3kNhHayn9mx1V6N5h-LWbQ@mail.gmail.com>
 <2035535832.26037779.1498053843582.JavaMail.zimbra@redhat.com>
 <b2db655b-eec8-aeb3-3428-1f12d1c28796@redhat.com> <CADRKj5Q4YZaYoPEABhjnNRNoN-vC1T=49knL9npHQpsSzWUr=w@mail.gmail.com>
 <092f8bc6-8222-b3b0-1b74-7133ae1c320d@redhat.com> <CAF8OO3NR21ojUdaHLmcvUL+uhsyLf666iHV8im_k9j5ZpCx=KA@mail.gmail.com>
 <CAOi4hNd_wAshA_=4cW4X7Y_rijavs82-J2FbaE-L92P_Vy0RkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35568 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdGFLA1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 07:00:27 -0400
Received: by mail-oi0-f54.google.com with SMTP id 191so13100027oii.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jul 2017 04:00:27 -0700 (PDT)
In-Reply-To: <CAOi4hNd_wAshA_=4cW4X7Y_rijavs82-J2FbaE-L92P_Vy0RkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5pa56ZKw57+U?= <abcdeffyx@gmail.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, dang@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks all for your insight!
After more investigation,I'd like to
share some output, your comments are appreciated as always. ;-)

* proposal

** introduce tail_data_pool

Each storage class is presented as individual placement rule. Each
placement rule has serveral pools:

+ index_pool(for bucket index)
+ data_pool(for head)
+ tail_data_pool(for tail)

Finally,different storage classes use the same index_pool and
data_pool, but different tail_data_pool. Using different storage
classes means using different tail_data_pools.

Here's a placement rule/storage class config sample output:

#+BEGIN_EXAMPLE
    {
        "key": "STANDARD",
        "val": {
            "index_pool": "us-east-1.rgw.buckets.index",
            "data_pool": "us-east-1.rgw.buckets.data",
            "tail_data_pool": "us-east-1.rgw.buckets.3replica", <-
introduced for rgw_obj raw data
            "data_extra_pool": "us-east-1.rgw.buckets.non-ec",
            "index_type": 0,
            "compression": "",
            "inline_head": 1
        }
    },
#+END_EXAMPLE

Multipart rgw_obj will be stored at tail_data_pool. Further more,for
those rgw_obj only has head,not tail, we can refactor Manifest to
support disable inline first chunk data of rgw_obj into the head,
which can finally match the semantic of AWS S3 sotrage class:

#+BEGIN_EXAMPLE
    {
        "key": "STANDARD",
        "val": {
            "index_pool": "us-east-1.rgw.buckets.index",
            "data_pool": "us-east-1.rgw.buckets.data",
            "tail_data_pool": "us-east-1.rgw.buckets.3replica",
            "data_extra_pool": "us-east-1.rgw.buckets.non-ec",
            "index_type": 0,
            "compression": "",
            "inline_head": 1  <- introduced for inline first data
chunk of rgw_obj into head
        }
    },
#+END_EXAMPLE

** expose different storage class as individual placement rule

As draft ,placment list will list all storage class:

#+BEGIN_EXAMPLE
 ./bin/radosgw-admin -c ceph.conf zone  placement list
[
    {
        "key": "STANDARD",
        "val": {
            "index_pool": "us-east-1.rgw.buckets.index",
            "data_pool": "us-east-1.rgw.buckets.data",
            "tail_data_pool": "us-east-1.rgw.buckets.3replica",
            "data_extra_pool": "us-east-1.rgw.buckets.non-ec",
            "index_type": 0,
            "compression": "",
            "inline_head": 1
        }
    },

    {
        "key": "RRS",
        "val": {
            "index_pool": "us-east-1.rgw.buckets.index",
            "data_pool": "us-east-1.rgw.buckets.data",
            "tail_data_pool": "us-east-1.rgw.buckets.2replica",
            "data_extra_pool": "us-east-1.rgw.buckets.non-ec",
            "index_type": 0,
            "compression": ""
            "inline_head": 1
        }
    }
]
#+END_EXAMPLE

Another option would be expose serveral storage classes in the same
placement rule:

#+BEGIN_EXAMPLE
 ./bin/radosgw-admin -c ceph.conf zone  placement list
[
    {
        "key": "default-placement",
        "val": {
            "index_pool": "us-east-1.rgw.buckets.index",
            "storage_class"
            {
              "STANDARD" : {
                           "data_pool": "us-east-1.rgw.3replica",
                           "data_extra_pool": "us-east-1.rgw.buckets.non-ec=
",
                           "inline_head": 1
                           },
              "RRS" :      {
                           "data_pool": "us-east-1.rgw.2replica",
                           "data_extra_pool": "us-east-1.rgw.buckets.non-ec=
",
                           "inline_head": 1
                           },
            }
            "index_type": 0,
            "compression": ""
        }
    }
]
#+END_EXAMPLE

This approach strict the meaning of storage class as different data
pool. But we may support things like Multi-Regional Storage (
https://cloud.google.com/storage/docs/storage-classes#multi-regional )
in the future. So I'd prefer expost storage class at placement rule
level.

* issues

If we introduced the tail_data_pool,we need corresponding
modification. I'm not sure about this, feedback are appreciated.

** use rgw_pool instead of placment rule in the RGWManifest

In the RGWObjManifest, we've defined two placement rules:

+ head_placement_rule
(https://github.com/ceph/ceph/blob/master/src/rgw/rgw_rados.h#L406)
+ tail_placement.placement_rule
(https://github.com/ceph/ceph/blob/master/src/rgw/rgw_rados.h#L119)

then we use placment rule to find the data_pool of the placement
rule.If we introduced the tail_data_pool,there's no need to keep
tail_placement.placement_rule(although it is the same as
head_placement_rule)

In the RGWObjManifest internal, `class rgw_obj_select`also defined a
`placement_rule`
(https://github.com/ceph/ceph/blob/master/src/rgw/rgw_rados.h#L127),
which finally used placement rule to find the data_pool of that
placement rule.

So I suppose to instead of using placement rule in the
RGWManifest, replaced with rgw_pool.so that we've the chance to use
tail_data_pool and data_pool in the same placement rule.

On 23 June 2017 at 13:43, =E6=96=B9=E9=92=B0=E7=BF=94 <abcdeffyx@gmail.com>=
 wrote:
> I think storing the head object and tail objects in different pools is al=
so
> necessary.
>
> If we introduce a tail_data_pool in placement rule to store tail objects.=
 we
> can create replicated pool for data_pool and ec for tail_data_pool to
> leverage the performance and capacity.
>
> 2017-06-22 17:44 GMT+08:00 Jiaying Ren <mikulely@gmail.com>:
>>
>> On 21 June 2017 at 23:50, Daniel Gryniewicz <dang@redhat.com> wrote:
>> >>>
>> >> My original thinking was that when we reassign an object to a new
>> >> placement, we only touch its tail which is incompatible with that.
>> >> However, thinking about it some more I don't see why we need to have
>> >> this limitation, so it's probably possible to keep the data in the
>> >> head in one case, and modify the object and have the data in the tail
>> >> (object's head will need to be rewritten anyway because we modify the
>> >> manifest).
>> >> I think that the decision whether we keep data in the head could be a
>> >> property of the zone.
>>
>> Yes, I guess we also need to check the zone placement rule config when
>> pull the realm in the multisite env, to make sure the sync peer has
>> the same storage class support, multisite sync should also respect
>> object storage class.
>>
>> >> In any case, once an object is created changing
>> >> this property will only affect newly created objects, and old objects
>> >> could still be read correctly. Having data in the head is an
>> >> optimization that supposedly reduces small objects latency, and I
>> >> still think it's useful in a mixed pools situation. The thought is
>> >> that the bulk of the data will be at the tail anyway. However, we
>> >> recently changed the default head size from 512k to 4M, so this might
>> >> not be true any more. Anyhow, I favour having this as a configurable
>> >> (which should be simple to add).
>> >>
>> >> Yehuda
>> >>
>> >
>> >
>> > I would be strongly against keeping data in the head when the head is =
in
>> > a
>> > lower-level storage class.  That means that the entire object is
>> > violating
>> > the constraints of the storage class.
>>
>> Agreed. The default behavior of storage class require us to keep the
>> data in the head as the same pool as the tail. Even if we made this as
>> a configureable option, we should disable this kind of inline by
>> default to match the default behavior of storage class.
>>
>> >
>> > Of course, having the head in a lower storage class (data or not) is
>> > probably a violation.  Maybe we'd have to require that all heads go in
>> > the
>> > highest storage class.
>> >
>> > Daniel
>>
>> On 21 June 2017 at 23:50, Daniel Gryniewicz <dang@redhat.com> wrote:
>> > On 06/21/2017 11:14 AM, Yehuda Sadeh-Weinraub wrote:
>> >>
>> >> On Wed, Jun 21, 2017 at 7:46 AM, Daniel Gryniewicz <dang@redhat.com>
>> >> wrote:
>> >>>
>> >>> On 06/21/2017 10:04 AM, Matt Benjamin wrote:
>> >>>>
>> >>>>
>> >>>> Hi,
>> >>>>
>> >>>> Looks very coherent.
>> >>>>
>> >>>> My main question is about...
>> >>>>
>> >>>> ----- Original Message -----
>> >>>>>
>> >>>>>
>> >>>>> From: "Jiaying Ren" <mikulely@gmail.com>
>> >>>>> To: "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>
>> >>>>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> >>>>> Sent: Wednesday, June 21, 2017 7:39:24 AM
>> >>>>> Subject: RGW: Implement S3 storage class feature
>> >>>>>
>> >>>>
>> >>>>>
>> >>>>> * Todo List
>> >>>>>
>> >>>>> + the head of rgw-object should only contains the metadata of
>> >>>>>   rgw-object,the first chunk of rgw-object data should be stored i=
n
>> >>>>>   the same pool as the tail of rgw-object
>> >>>>
>> >>>>
>> >>>>
>> >>>> Is this always desirable?
>> >>>>
>> >>>
>> >>> Well, unless the head pool happens to have the correct storage class=
,
>> >>> it's
>> >>> necessary.  And I'd guess that verification of this is complicated,
>> >>> although
>> >>> maybe not.
>> >>>
>> >>> Maybe we can use the head pool if it has >=3D the correct storage cl=
ass?
>> >>>
>> >> My original thinking was that when we reassign an object to a new
>> >> placement, we only touch its tail which is incompatible with that.
>> >> However, thinking about it some more I don't see why we need to have
>> >> this limitation, so it's probably possible to keep the data in the
>> >> head in one case, and modify the object and have the data in the tail
>> >> (object's head will need to be rewritten anyway because we modify the
>> >> manifest).
>> >> I think that the decision whether we keep data in the head could be a
>> >> property of the zone. In any case, once an object is created changing
>> >> this property will only affect newly created objects, and old objects
>> >> could still be read correctly. Having data in the head is an
>> >> optimization that supposedly reduces small objects latency, and I
>> >> still think it's useful in a mixed pools situation. The thought is
>> >> that the bulk of the data will be at the tail anyway. However, we
>> >> recently changed the default head size from 512k to 4M, so this might
>> >> not be true any more. Anyhow, I favour having this as a configurable
>> >> (which should be simple to add).
>> >>
>> >> Yehuda
>> >>
>> >
>> >
>> > I would be strongly against keeping data in the head when the head is =
in
>> > a
>> > lower-level storage class.  That means that the entire object is
>> > violating
>> > the constraints of the storage class.
>> >
>> > Of course, having the head in a lower storage class (data or not) is
>> > probably a violation.  Maybe we'd have to require that all heads go in
>> > the
>> > highest storage class.
>> >
>> > Daniel
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
