From: kefu chai <tchaikov@gmail.com>
Subject: Re: [ceph-users] v12.0.2 Luminous (dev) released
Date: Wed, 26 Apr 2017 20:15:12 +0800
Message-ID: <CAJE9aOP-6f3-GVy2EbpW=qwerQPWKat8k=K5iXSUh-PLs3OJhA@mail.gmail.com>
References: <319cffed-6ef8-bb3f-186a-77b2be62a2db@suse.com>
 <CABZ+qq=MkZBRe2_NADF0LXobbLfVRV-kyqfvxPiNfJLcW_B_fA@mail.gmail.com>
 <CABZ+qqnDSxaoa_JaFLTA9qMXKYxi7-TzdyXFgtY8ujPQqfZQUA@mail.gmail.com>
 <CABZ+qq=EuD3Nq6OUeD2U4Ug-BsZXk6jJGYSMxK49bFrJ=gutxw@mail.gmail.com> <CAJ4mKGZEVyNXSBvrkMkRfXX+mmV3qVydOASsT+O+eK04uAjN+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34060 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954803AbdDZMPP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Apr 2017 08:15:15 -0400
Received: by mail-ua0-f195.google.com with SMTP id 110so20788183uas.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Apr 2017 05:15:13 -0700 (PDT)
In-Reply-To: <CAJ4mKGZEVyNXSBvrkMkRfXX+mmV3qVydOASsT+O+eK04uAjN+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Dan van der Ster <dan@vanderster.com>, Kefu Chai <kchai@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Apr 25, 2017 at 9:15 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> This is more likely a result of Kefu's work to move the creating_pgs
> members around. It may not have been versioned in a way that allowed
> luminous RC upgrades; I'm not sure what feature bits are involved or
> if there's a good way to resolve that. :/

sage's patch fixes it. we have the mon's FEATURE_LUMINOUS already.

> -Greg
>
> On Tue, Apr 25, 2017 at 5:55 AM, Dan van der Ster <dan@vanderster.com> wr=
ote:
>> Created ticket to follow up: http://tracker.ceph.com/issues/19769
>>
>>
>>
>> On Tue, Apr 25, 2017 at 11:34 AM, Dan van der Ster <dan@vanderster.com> =
wrote:
>>> Could this change be the culprit?
>>>
>>> commit 973829132bf7206eff6c2cf30dd0aa32fb0ce706
>>> Author: Sage Weil <sage@redhat.com>
>>> Date:   Fri Mar 31 09:33:19 2017 -0400
>>>
>>>     mon/OSDMonitor: spinlock -> std::mutex
>>>
>>>     I think spinlock is dangerous here: we're doing semi-unbounded
>>>     work (decode).  Also seemingly innocuous code like dout macros
>>>     take mutexes.
>>>
>>>     Signed-off-by: Sage Weil <sage@redhat.com>
>>>
>>>
>>> diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
>>> index 543338bdf3..6fa5e8de4b 100644
>>> --- a/src/mon/OSDMonitor.cc
>>> +++ b/src/mon/OSDMonitor.cc
>>> @@ -245,7 +245,7 @@ void OSDMonitor::update_from_paxos(bool *need_boots=
trap)
>>>      bufferlist bl;
>>>      mon->store->get(OSD_PG_CREATING_PREFIX, "creating", bl);
>>>      auto p =3D bl.begin();
>>> -    std::lock_guard<Spinlock> l(creating_pgs_lock);
>>> +    std::lock_guard<std::mutex> l(creating_pgs_lock);
>>>      creating_pgs.decode(p);
>>>      dout(7) << __func__ << " loading creating_pgs e" <<
>>> creating_pgs.last_scan_epoch << dendl;
>>>    }
>>> ...
>>>
>>>
>>> Cheers, Dan
>>>
>>>
>>> On Tue, Apr 25, 2017 at 11:15 AM, Dan van der Ster <dan@vanderster.com>=
 wrote:
>>>> Hi,
>>>>
>>>> The mon's on my test luminous cluster do not start after upgrading
>>>> from 12.0.1 to 12.0.2. Here is the backtrace:
>>>>
>>>>      0> 2017-04-25 11:06:02.897941 7f467ddd7880 -1 *** Caught signal
>>>> (Aborted) **
>>>>  in thread 7f467ddd7880 thread_name:ceph-mon
>>>>
>>>>  ceph version 12.0.2 (5a1b6b3269da99a18984c138c23935e5eb96f73e)
>>>>  1: (()+0x797e7f) [0x7f467e58ce7f]
>>>>  2: (()+0xf370) [0x7f467d18d370]
>>>>  3: (gsignal()+0x37) [0x7f467a44f1d7]
>>>>  4: (abort()+0x148) [0x7f467a4508c8]
>>>>  5: (__gnu_cxx::__verbose_terminate_handler()+0x165) [0x7f467ad539d5]
>>>>  6: (()+0x5e946) [0x7f467ad51946]
>>>>  7: (()+0x5e973) [0x7f467ad51973]
>>>>  8: (()+0x5eb93) [0x7f467ad51b93]
>>>>  9: (ceph::buffer::list::iterator_impl<false>::copy(unsigned int,
>>>> char*)+0xa5) [0x7f467e2fc715]
>>>>  10: (creating_pgs_t::decode(ceph::buffer::list::iterator&)+0x3c)
>>>> [0x7f467e211e8c]
>>>>  11: (OSDMonitor::update_from_paxos(bool*)+0x225a) [0x7f467e1cd16a]
>>>>  12: (PaxosService::refresh(bool*)+0x1a5) [0x7f467e196335]
>>>>  13: (Monitor::refresh_from_paxos(bool*)+0x19b) [0x7f467e12953b]
>>>>  14: (Monitor::init_paxos()+0x115) [0x7f467e129975]
>>>>  15: (Monitor::preinit()+0x93d) [0x7f467e13b07d]
>>>>  16: (main()+0x2518) [0x7f467e07f848]
>>>>  17: (__libc_start_main()+0xf5) [0x7f467a43bb35]
>>>>  18: (()+0x32671e) [0x7f467e11b71e]
>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>> needed to interpret this.
>>>>
>>>> Cheers, Dan
>>>>
>>>>
>>>> On Mon, Apr 24, 2017 at 5:49 PM, Abhishek Lekshmanan <abhishek@suse.co=
m> wrote:
>>>>> This is the third development checkpoint release of Luminous, the nex=
t
>>>>> long term
>>>>> stable release.
>>>>>
>>>>> Major changes from v12.0.1
>>>>> --------------------------
>>>>> * The original librados rados_objects_list_open (C) and objects_begin
>>>>>   (C++) object listing API, deprecated in Hammer, has finally been
>>>>>   removed.  Users of this interface must update their software to use
>>>>>   either the rados_nobjects_list_open (C) and nobjects_begin (C++) AP=
I or
>>>>>   the new rados_object_list_begin (C) and object_list_begin (C++) API
>>>>>   before updating the client-side librados library to Luminous.
>>>>>
>>>>>   Object enumeration (via any API) with the latest librados version
>>>>>   and pre-Hammer OSDs is no longer supported.  Note that no in-tree
>>>>>   Ceph services rely on object enumeration via the deprecated APIs, s=
o
>>>>>   only external librados users might be affected.
>>>>>
>>>>>   The newest (and recommended) rados_object_list_begin (C) and
>>>>>   object_list_begin (C++) API is only usable on clusters with the
>>>>>   SORTBITWISE flag enabled (Jewel and later).  (Note that this flag i=
s
>>>>>   required to be set before upgrading beyond Jewel.)
>>>>>
>>>>> * CephFS clients without the 'p' flag in their authentication capabil=
ity
>>>>>   string will no longer be able to set quotas or any layout fields.  =
This
>>>>>   flag previously only restricted modification of the pool and namesp=
ace
>>>>>   fields in layouts.
>>>>>
>>>>> * CephFS directory fragmentation (large directory support) is enabled
>>>>>   by default on new filesystems.  To enable it on existing filesystem=
s
>>>>>   use "ceph fs set <fs_name> allow_dirfrags".
>>>>>
>>>>> * CephFS will generate a health warning if you have fewer standby dae=
mons
>>>>>   than it thinks you wanted.  By default this will be 1 if you ever h=
ad
>>>>>   a standby, and 0 if you did not.  You can customize this using
>>>>>   ``ceph fs set <fs> standby_count_wanted <number>``.  Setting it
>>>>>   to zero will effectively disable the health check.
>>>>>
>>>>> * The "ceph mds tell ..." command has been removed.  It is superseded
>>>>>   by "ceph tell mds.<id> ..."
>>>>>
>>>>> * RGW introduces server side encryption of uploaded objects with 3
>>>>> options for
>>>>>   the management of encryption keys, automatic encryption (only
>>>>> recommended for
>>>>>   test setups), customer provided keys similar to Amazon SSE KMS
>>>>> specification &
>>>>>   using a key management service (openstack barbician)
>>>>>
>>>>> For a more detailed changelog, refer to
>>>>> http://ceph.com/releases/ceph-v12-0-2-luminous-dev-released/
>>>>>
>>>>> Getting Ceph
>>>>> ------------
>>>>>
>>>>> * Git at git://github.com/ceph/ceph.git
>>>>> * Tarball at http://download.ceph.com/tarballs/ceph-12.0.2.tar.gz
>>>>> * For packages, see http://docs.ceph.com/docs/master/install/get-pack=
ages/
>>>>> * For ceph-deploy, see
>>>>> http://docs.ceph.com/docs/master/install/install-ceph-deploy
>>>>> * Release sha1: 5a1b6b3269da99a18984c138c23935e5eb96f73e
>>>>>
>>>>> --
>>>>> Abhishek Lekshmanan
>>>>> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham No=
rton,
>>>>> HRB 21284 (AG N=C3=BCrnberg)
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
