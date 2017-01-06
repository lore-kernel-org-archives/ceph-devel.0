From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Hammer 0.94.10 release - last call
Date: Fri, 6 Jan 2017 08:01:54 -0500
Message-ID: <CAC-Np1yn6i=FDM16rxOX8ZjXVj=u6GatC0u2tg8w9YHRvKZ9dw@mail.gmail.com>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz> <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
 <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz> <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
 <243fa727-c055-d1a0-6f51-5f5db87ed953@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36132 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936907AbdAFNCB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 08:02:01 -0500
Received: by mail-qk0-f179.google.com with SMTP id n21so463668729qka.3
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 05:01:55 -0800 (PST)
In-Reply-To: <243fa727-c055-d1a0-6f51-5f5db87ed953@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 5, 2017 at 7:12 PM, Loic Dachary <loic@dachary.org> wrote:
>
> On 01/05/2017 10:47 PM, Yuri Weinstein wrote:
>> May ceph-disk ?
>> Loic FYI
>
> What Nathan said, unfortunately. No ceph-disk tests in hammer. And backporting tests would require changes in ceph-disk that are too extensive for a stable branch.
>
>>
>> On Thu, Jan 5, 2017 at 1:36 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>>>> Is it possible to re-do this PR that went into Jewel for Hammer?
>>>>
>>>> http://tracker.ceph.com/issues/17754
>>>
>>>
>>> OK, https://github.com/ceph/ceph/pull/12805
>>>
>>> Any suggestions how to test it? I.e. do you know if there's a teuthology or
>>> ceph-qa-suite task that exercises ceph-create-keys?

The way to test this would be to create a cluster with monitors that
can't form a quorum. For example, with 2 monitors or by giving
bad short hostnames in the configuration. The test would need to
verify that it doesn't hang forever, it just fails after 10 minutes.

>>>
>>>
>>> --
>>> Nathan Cutler
>>> Software Engineer Distributed Storage
>>> SUSE LINUX, s.r.o.
>>> Tel.: +420 284 084 037
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
