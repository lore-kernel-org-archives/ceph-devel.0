From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: hammer 0.94.10 QE status
Date: Thu, 2 Feb 2017 11:01:15 +0100
Message-ID: <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35375 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdBBKBR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 05:01:17 -0500
Received: by mail-wm0-f41.google.com with SMTP id b65so82373010wmf.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2017 02:01:16 -0800 (PST)
In-Reply-To: <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

On Wed, Feb 1, 2017 at 6:03 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Feb 1, 2017 at 5:52 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Here is snapshot of hammer 0.94.10 point release testing status.
>>
>> Suites were not tested on ubuntu 16.06 due to
>> http://tracker.ceph.com/issues/18382 and as a result were forced to test on
>> ubuntu 14.04 and centos 7.2 (note we don't have smithi with centos 7.3).
>>
>> There was an additional noise created by fact that since we tested last
>> hammer release in August 2016 we moved from gitbuilders to shaman build
>> system and it resulted in issues with some packages.
>>
>> Details of tests can be found here
>> http://tracker.ceph.com/issues/17151#note-61
>>
>> ======================
>> rados ubuntu - packaging issues, need approval - Josh
>> rados centos - packaging issues, need approval - Josh
>> ======================
>> rbd - PASSED
>> ======================
>> rgw ubuntu - PASSED
>> rgw centos - valgrind issues http://tracker.ceph.com/issues/18735, need
>> approval Yehuda, Sage
>> ======================
>> fs ubuntu - looks similar to v0.94.8, need Greg, John approval
>> fs centos - noise? need Greg, John review/approval
>> ======================
>> krbd ubuntu - looks like the same in v0.94.8
>> http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya
>> krbd centos -  looks like the same in v0.94.8
>> http://tracker.ceph.com/issues/15895#note-33 need approval Jason, Ilya
>
> I'll need to look at
>
> http://pulpito.ceph.com/teuthology-2017-01-26_20:58:56-krbd-master-testing-basic-smithi/752997
> http://pulpito.ceph.com/teuthology-2017-01-26_21:01:15-krbd-master-testing-basic-smithi/753036
>
> These are unexpected.

Turned out to be a buggy test -- hammer is missing an infernalis
commit f217865cf7c4 ("test_librbd_fsx: invalidate before discard in
krbd mode").

Approved.

Thanks,

                Ilya
