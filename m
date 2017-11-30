From: Peter Woodman <peter@shortbus.org>
Subject: Re: [ceph-users] ceph-disk removal roadmap (was ceph-disk is now deprecated)
Date: Thu, 30 Nov 2017 16:36:15 +0000
Message-ID: <CADfA06QOg6Lm3hjX=m0dgSfRM-J-3n+P+U9CZvAZhqz1erWBcA@mail.gmail.com>
References: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:44223 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbdK3QgQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Nov 2017 11:36:16 -0500
Received: by mail-ot0-f179.google.com with SMTP id d27so6600757ote.11
        for <ceph-devel@vger.kernel.org>; Thu, 30 Nov 2017 08:36:16 -0800 (PST)
In-Reply-To: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

How quickly are you planning to cut 12.2.3?

On Thu, Nov 30, 2017 at 4:25 PM, Alfredo Deza <adeza@redhat.com> wrote:
> Thanks all for your feedback on deprecating ceph-disk, we are very
> excited to be able to move forwards on a much more robust tool and
> process for deploying and handling activation of OSDs, removing the
> dependency on UDEV which has been a tremendous source of constant
> issues.
>
> Initially (see "killing ceph-disk" thread [0]) we planned for removal
> of Mimic, but we didn't want to introduce the deprecation warnings up
> until we had an out for those who had OSDs deployed in previous
> releases with ceph-disk (we are now able to handle those as well).
> That is the reason ceph-volume, although present since the first
> Luminous release, hasn't been pushed forward much.
>
> Now that we feel like we can cover almost all cases, we would really
> like to see a wider usage so that we can improve on issues/experience.
>
> Given that 12.2.2 is already in the process of getting released, we
> can't undo the deprecation warnings for that version, but we will
> remove them for 12.2.3, add them back again in Mimic, which will mean
> ceph-disk will be kept around a bit longer, and finally fully removed
> by N.
>
> To recap:
>
> * ceph-disk deprecation warnings will stay for 12.2.2
> * deprecation warnings will be removed in 12.2.3 (and from all later
> Luminous releases)
> * deprecation warnings will be added again in ceph-disk for all Mimic rel=
eases
> * ceph-disk will no longer be available for the 'N' release, along
> with the UDEV rules
>
> I believe these four points address most of the concerns voiced in
> this thread, and should give enough time to port clusters over to
> ceph-volume.
>
> [0] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-October/0213=
58.html
>
> On Thu, Nov 30, 2017 at 8:22 AM, Daniel Baumann <daniel.baumann@bfh.ch> w=
rote:
>> On 11/30/17 14:04, Fabian Gr=C3=BCnbichler wrote:
>>> point is - you should not purposefully attempt to annoy users and/or
>>> downstreams by changing behaviour in the middle of an LTS release cycle=
,
>>
>> exactly. upgrading the patch level (x.y.z to x.y.z+1) should imho never
>> introduce a behaviour-change, regardless if it's "just" adding new
>> warnings or not.
>>
>> this is a stable update we're talking about, even more so since it's an
>> LTS release. you never know how people use stuff (e.g. by parsing stupid
>> things), so such behaviour-change will break stuff for *some* people
>> (granted, most likely a really low number).
>>
>> my expection to an stable release is, that it stays, literally, stable.
>> that's the whole point of having it in the first place. otherwise we
>> would all be running git snapshots and update randomly to newer ones.
>>
>> adding deprecation messages in mimic makes sense, and getting rid of
>> it/not provide support for it in mimic+1 is reasonable.
>>
>> Regards,
>> Daniel
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
