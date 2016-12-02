From: Dan Jakubiec <dan.jakubiec@gmail.com>
Subject: Re: [ceph-users] stalls caused by scrub on jewel
Date: Fri, 2 Dec 2016 12:09:32 -0600
Message-ID: <E5777170-6704-4655-9B48-064D6BC04365@gmail.com>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
 <67e859f3-1aa6-e4b5-06b5-664583f668f1@univ-lorraine.fr>
 <0309fdb3-1924-dec4-9658-b8f3055b3518@epfl.ch>
 <9F915199-F93D-4F5E-82F8-ACA428ADFA30@univ-lorraine.fr>
 <7770A453-1C79-4B89-A402-481D6463AA87@gmail.com>
 <alpine.DEB.2.11.1612021643080.22800@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33724 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbcLBSJf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2016 13:09:35 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so22239532ywg.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Dec 2016 10:09:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612021643080.22800@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?utf-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass@univ-lorraine.fr>, Yoann Moulin <yoann.moulin@epfl.ch>, ceph-devel@vger.kernel.org, ceph-users@ceph.com


> On Dec 2, 2016, at 10:48, Sage Weil <sage@newdream.net> wrote:
>=20
> On Fri, 2 Dec 2016, Dan Jakubiec wrote:
>> For what it's worth... this sounds like the condition we hit we=20
>> re-enabled scrub on our 16 OSDs (after 6 to 8 weeks of noscrub).  =
They=20
>> flapped for about 30 minutes as most of the OSDs randomly hit suicide=20=

>> timeouts here and there.
>>=20
>> This settled down after about an hour and the OSDs stopped dying.  We=20=

>> have since left scrub enabled for about 4 days and have only seen =
three=20
>> small spurts of OSD flapping since then (which quickly resolved=20
>> themselves).
>=20
> Yeah.  I think what's happening is that with a cold cache it is slow=20=

> enough to suicide, but with a warm cache it manages to complete =
(although=20
> I bet it's still stalling other client IO for perhaps multiple =
seconds). =20
> I would leave noscrub set for now.

Ah... thanks for the suggestion!  We are indeed working through some =
jerky performance issues.  Perhaps this is a layer of that onion, thank =
you.

-- Dan

>=20
> sage
>=20
>=20
>=20
>=20
>>=20
>> -- Dan
>>=20
>>> On Dec 1, 2016, at 14:38, Fr=C3=A9d=C3=A9ric Nass =
<frederic.nass@univ-lorraine.fr> wrote:
>>>=20
>>> Hi Yoann,
>>>=20
>>> Thank you for your input. I was just told by RH support that it=E2=80=99=
s gonna make it to RHCS 2.0 (10.2.3). Thank you guys for the fix !
>>>=20
>>> We thought about increasing the number of PGs just after changing =
the merge/split threshold values but this would have led to a _lot_ of =
data movements (1.2 billion of XFS files) over weeks, without any =
possibility to scrub / deep-scrub to ensure data consistency. Still as =
soon as we get the fix, we will increase the number of PGs.
>>>=20
>>> Regards,
>>>=20
>>> Frederic.
>>>=20
>>>=20
>>>=20
>>>> Le 1 d=C3=A9c. 2016 =C3=A0 16:47, Yoann Moulin =
<yoann.moulin@epfl.ch> a =C3=A9crit :
>>>>=20
>>>> Hello,
>>>>=20
>>>>> We're impacted by this bug (case 01725311). Our cluster is running =
RHCS 2.0 and is no more capable to scrub neither deep-scrub.
>>>>>=20
>>>>> [1] http://tracker.ceph.com/issues/17859
>>>>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1394007
>>>>> [3] https://github.com/ceph/ceph/pull/11898
>>>>>=20
>>>>> I'm worried we'll have to live with a cluster that can't =
scrub/deep-scrub until March 2017 (ETA for RHCS 2.2 running Jewel =
10.2.4).
>>>>>=20
>>>>> Can we have this fix any sooner ?
>>>>=20
>>>> As far as I know about that bug, it appears if you have big PGs, a =
workaround could be increasing the pg_num of the pool that has the =
biggest PGs.
>>>>=20
>>>> --=20
>>>> Yoann Moulin
>>>> EPFL IC-IT
>>>=20
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20

