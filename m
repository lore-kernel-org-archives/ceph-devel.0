From: Wido den Hollander <wido@42on.com>
Subject: Re: osd: new pool flags: noscrub, nodeep-scrub
Date: Fri, 11 Sep 2015 15:27:40 +0200
Message-ID: <55F2D6CC.2010501@42on.com>
References: <20150911064256.GA12899@gmail.com>
 <CAJ4mKGZPXnH+z=aBp7vLY35pj4JXq6c_Sq1PFknWj5y0fs2-zQ@mail.gmail.com>
 <20150911124704.GB12899@gmail.com>
 <alpine.DEB.2.00.1509110559300.7527@cobra.newdream.net>
 <E94976F6-E5E7-4BC6-BC6D-FB6E1BAA3754@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:49858 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbIKNdM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 09:33:12 -0400
In-Reply-To: <E94976F6-E5E7-4BC6-BC6D-FB6E1BAA3754@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <seb@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 11-09-15 15:11, Sebastien Han wrote:
> I like the idea of being able to control on which pool we want to run=
 scrub on.
> Some data might deserve better protection than others, it=E2=80=99s r=
eally up to the admin.
>=20

Indeed. Let the admin be in control. If he/she doesn't want that pool t=
o
be scrubbed Ceph shouldn't care.

Same like you can mount a filesystem with nobarrier if you want to. Not
that it is a wise thing to do.

> The default behaviour will be to apply scrub to default pool and ever=
y new created pools.
> The operator can change this behaviour either with a config flag or d=
irectly with a ceph mon command.
>=20
>> On 11 Sep 2015, at 14:59, Sage Weil <sweil@redhat.com> wrote:
>>
>> On Fri, 11 Sep 2015, Mykola Golub wrote:
>>> On Fri, Sep 11, 2015 at 11:08:29AM +0100, Gregory Farnum wrote:
>>>> On Fri, Sep 11, 2015 at 7:42 AM, Mykola Golub <mgolub@mirantis.com=
> wrote:
>>>>> Hi,
>>>>>
>>>>> I would like to add new pool flags: noscrub and nodeep-scrub, to =
be
>>>>> able to control scrubbing on per pool basis. In our case it could=
 be
>>>>> helpful in order to disable scrubbing on cache pools, which does =
not
>>>>> work well right now, but I can imagine other scenarios where it c=
ould
>>>>> be useful too.
>>>>
>>>> Can you talk more about this? It sounds to me like maybe you disli=
ke
>>>> the performance impact of scrubbing, but it's fairly important in
>>>> terms of data integrity. I don't think we want to permanently disa=
ble
>>>> them. A corruption in the cache pool isn't any less important than=
 in
>>>> the backing pool ? it will eventually get flushed, and it's where =
all
>>>> the reads will be handled!
>>>
>>> I was talking about this:
>>>
>>> http://tracker.ceph.com/issues/8752
>>>
>>> (false-negative on a caching pool). Although the best solution is
>>> definitely to fix the bug, I am not sure it will be resolved soon (=
the
>>> bug is open for a year). Still these false-negatives are annoying, =
as
>>> they complicate monitoring for real inconsistent pgs. In this case =
I
>>> might want to disable periodic scrub for caching pools, as a
>>> workaround (I could do scrub for them manually though).
>>>
>>> This might be not the best example where these flags could be helpf=
ul
>>> (I just came to the idea when thinking about a workaround for that
>>> problem, and this looked useful to me in general). We already have
>>> 'ceph osd set no[deep-]scrub', and users use it to temporary resolv=
e
>>> high I/O load. Being able to do this per pool looks useful too.
>>>
>>> You might have pools of different importance for you, and disabling
>>> scrub for some of them might be ok.
>>
>> I wonder if, in addition, we should also allow scrub and deep-scrub
>> intervals to be set on a per-pool basis?
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> Cheers.
> =E2=80=93=E2=80=93=E2=80=93=E2=80=93
> S=C3=A9bastien Han
> Senior Cloud Architect
>=20
> "Always give 100%. Unless you're giving blood."
>=20
> Mail: seb@redhat.com
> Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
