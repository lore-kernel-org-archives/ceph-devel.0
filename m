From: kefu chai <tchaikov@gmail.com>
Subject: Re: 12.2.2 status
Date: Sat, 4 Nov 2017 04:54:40 +0800
Message-ID: <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com> <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
 <874lqbcl5p.fsf@suse.com> <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal>
 <871slfckae.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:45627 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKCUym (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Nov 2017 16:54:42 -0400
Received: by mail-oi0-f49.google.com with SMTP id f66so3112189oib.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Nov 2017 13:54:42 -0700 (PDT)
In-Reply-To: <871slfckae.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>, vumrao@redhat.com
Cc: Sage Weil <sweil@redhat.com>, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Karol Mroz <KMroz@suse.com>

On Sat, Nov 4, 2017 at 2:02 AM, Abhishek Lekshmanan <abhishek@suse.com> wro=
te:
> Sage Weil <sweil@redhat.com> writes:
>
>> It's probably https://github.com/ceph/ceph/pull/18589 ?
>
> Looks like it. I'm not sure whether this PR needs to go in for 12.2.2 or
> post 12.2.2,  and how the ceph-test breaks << 12.2.2 affects this. Can
> Kefu/ Ken comment on whether this needs to be included and what
> additional steps we need to get the packaging fixed.

+ vikyat.

all or nothing. if we want to backport the fix of
http://tracker.ceph.com/issues/21762, we will have to backport the
"debian: fix package relationships after" fixes. so i think pull/18589
is self-contained. and no additional step is needed.

and per http://tracker.ceph.com/issues/21762, we need to have it in
luminous. but i have no strong opinion on including it in 12.2.2 or
post 12.2.2. Vikhyat and Nathan, what do you think?

>
> Thanks
> Abhishek
>
>>
>> On Fri, 3 Nov 2017, Abhishek Lekshmanan wrote:
>>
>>> Patrick Donnelly <pdonnell@redhat.com> writes:
>>>
>>> > On Thu, Oct 26, 2017 at 8:19 AM, Abhishek Lekshmanan <abhishek@suse.c=
om> wrote:
>>> >> Also for the leads, Sage, Yehuda. Jason, Josh, Patrick are there any
>>> >> critical PRs that we need to have in 12.2.2 so that we can include
>>> >> them in the next round of testing before handing over to QE?
>>> >
>>> > Please include:
>>> >
>>> > https://github.com/ceph/ceph/pull/18019
>>> > https://github.com/ceph/ceph/pull/18008
>>>
>>> I've added the all the PRs in the milestone with the label wip-abhi-tes=
ting,
>>> https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+label%3Awip-ab=
hi-testing
>>>
>>> However all the ubuntu/debian tests in teuthology seem to fail with a
>>> dependency issue not seen in centos,
>>>
>>> For eg:
>>> http://pulpito.ceph.com/abhi-2017-11-03_16:49:11-ceph-disk-wip-luminous=
-backports-distro-basic-vps/
>>>
>>> or
>>> http://pulpito.ceph.com/abhi-2017-11-03_15:09:21-rados-wip-luminous-bac=
kports-distro-basic-smithi/
>>>
>>> something in the lines of
>>> ceph-mds : Depends: ceph-base (=3D 12.2.1-688-g83b8263-1trusty) but it =
is
>>> not going to be installed
>>>
>>> though not sure why these are failing as the packages themselves seem t=
o
>>> be present at the chacra url, so something else in the dependency chain
>>> somewhere? Has anyone else seen errors of this nature ?
>>>
>>>
>>> --
>>> Abhishek
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Abhishek Lekshmanan
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
,
> HRB 21284 (AG N=C3=BCrnberg)



--=20
Regards
Kefu Chai
