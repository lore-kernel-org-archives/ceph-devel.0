From: Samuel Just <sjust@redhat.com>
Subject: Re: OSD leaks & selinux denials
Date: Wed, 7 Dec 2016 14:00:54 -0800
Message-ID: <CAN=+7FUxVZ+TTt8gP86qoM2mCR20iU+rwDPmUMTTydUfoFw+4Q@mail.gmail.com>
References: <CALe9h7c4UEeXznHF0KbghJGENEqd4KdAQEAAryVtp9yW67=M0w@mail.gmail.com>
 <CAN=+7FUrtzkHNBz308b3_LkoAT=thr_ocQoo5e=AjcNKPni+tg@mail.gmail.com> <CAN=+7FX4hD3R=y9Dq8o_a1-91o=Yjqre5SWSawGL_md7q0s8ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35862 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932777AbcLGWA4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 17:00:56 -0500
Received: by mail-qk0-f175.google.com with SMTP id n21so431522768qka.3
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 14:00:55 -0800 (PST)
In-Reply-To: <CAN=+7FX4hD3R=y9Dq8o_a1-91o=Yjqre5SWSawGL_md7q0s8ww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hmm, how reproducible is this?
-Sam

On Wed, Dec 7, 2016 at 1:53 PM, Samuel Just <sjust@redhat.com> wrote:
> http://tracker.ceph.com/issues/18180
>
> On Wed, Dec 7, 2016 at 1:43 PM, Samuel Just <sjust@redhat.com> wrote:
>> It's usually more efficient to file a bug and mark it immediate.  Taking a look.
>> -Sam
>>
>> On Wed, Dec 7, 2016 at 3:03 AM, John Spray <jspray@redhat.com> wrote:
>>> I generally ignore these on the assumption that they'd also be
>>> appearing in rados suite runs, but since we're so close to Kraken I'm
>>> flagging them:
>>>
>>> ['type=AVC msg=audit(1481075825.792:4517): avc:  denied  { open } for
>>> pid=24997 comm="ceph-osd" path="/var/lib/ceph/osd/ceph-1/type"
>>> dev="nvme0n1p3" ino=25 scontext=system_u:system_r:ceph_t:s0
>>> tcontext=unconfined_u:object_r:unlabeled_t:s0 tclass=file', 't...
>>>   http://pulpito.ceph.com/jspray-2016-12-07_00:24:14-fs-wip-jcsp-testing-20161206-distro-basic-smithi/612516
>>>
>>> osd (Leak_DefinitelyLost)
>>>   http://pulpito.ceph.com/jspray-2016-12-07_00:24:14-fs-wip-jcsp-testing-20161206-distro-basic-smithi/612548
>>>   http://pulpito.ceph.com/jspray-2016-12-07_00:24:14-fs-wip-jcsp-testing-20161206-distro-basic-smithi/612640
>>>
>>>
>>> John
