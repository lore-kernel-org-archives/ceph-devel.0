From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD not coming up after being set down
Date: Wed, 2 Mar 2016 21:21:38 +0100
Message-ID: <56D74B52.7060104@digiware.nl>
References: <56D70ED5.7080203@digiware.nl>
 <CANA9Uk4bgcG4P0RGWaZQwiJP_fp+2xC_3RJbfF25VJTAy7UPJQ@mail.gmail.com>
 <56D74555.7060004@digiware.nl>
 <CAN=+7FX-JXXy29y6m4=RkrivuwP0Kc9M7vkqTnmaqjKCdP4yow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:23376 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921AbcCBUfZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Mar 2016 15:35:25 -0500
In-Reply-To: <CAN=+7FX-JXXy29y6m4=RkrivuwP0Kc9M7vkqTnmaqjKCdP4yow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: M Ranga Swami Reddy <swamireddy@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2-3-2016 21:11, Samuel Just wrote:
> At this point, you will want to run the script and then dig through
> the logs until you find something that doesn't match.
> - Was osd.0 up to begin with?
> - Is its process running?
> - Did it get the map marking it down?
> - Did it send a boot message back to the mon requesting that it be
> marked back up?
> - Did the mon get that message?
> - Did the mon create a new map marking it up?

Right this is sort of a handholding I was looking for.

The first 2 items are true.
Who sends "the map marking it down"?
	ceph osd down 0 =3D> Mon =3D> Osd
Or does that go directly ceph =3D> Osd

Are there any statemachine pictures of this in the manuals?

--WjW

> Etc
> -Sam
>=20
> On Wed, Mar 2, 2016 at 11:56 AM, Willem Jan Withagen <wjw@digiware.nl=
> wrote:
>> On 2-3-2016 18:01, M Ranga Swami Reddy wrote:
>>> Please see the below:
>>> ---
>>> The If something is causing OSDs to =E2=80=98flap=E2=80=99 (repeate=
dly getting marked
>>> down and then up again), you can force the monitors to stop the
>>> flapping with:
>>>
>>> ceph osd set noup      # prevent OSDs from getting marked up
>>> ceph osd set nodown    # prevent OSDs from getting marked down
>>> ----
>>> ref: http://docs.ceph.com/docs/hammer/rados/troubleshooting/trouble=
shooting-osd/
>>
>> I don't think this is the issue.
>>
>> The testcode should run as is. This run on Linux oke, but FreeBSD is
>> giving trouble.
>> The OSD should get up, but does not.
>> - OSD not receiving the UP
>> - OSD not able to go UP
>> - Or the monitors are not picking up?
>>
>> --WjW
>>
>>> On Wed, Mar 2, 2016 at 9:33 PM, Willem Jan Withagen <wjw@digiware.n=
l> wrote:
>>>> Hi,
>>>>
>>>> Any handholding is welcomed!!
>>>>
>>>> In test/cephtool-mon-test.sh part of the excuted code is:
>>>>  ceph osd down 0
>>>>   ceph osd dump | grep 'osd.0 down'
>>>>   ceph osd unset noup
>>>>   for ((i=3D0; i < 120; i++)); do
>>>>     if ! ceph osd dump | grep 'osd.0 up'; then
>>>>       echo "waiting for osd.0 to come back up"
>>>>       sleep 1
>>>>     else
>>>>       break
>>>>     fi
>>>>   done
>>>>   ceph osd dump | grep 'osd.0 up'
>>>>
>>>> But the OSD refused to come back up.
>>>> Below the output of the dump.
>>>>
>>>> How would I start analyzing this issue?
>>>> What kind of things would I expect to see in the logfile?
>>>>   What if the OSD does come up
>>>>   What if the OSD stays down
>>>>
>>>> Thanx,
>>>> --WjW
>>>>
>>>>
>>>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH *=
**
>>>> epoch 170
>>>> fsid 8b5c0b4b-e08c-11e5-8cd4-1c6f6582ec12
>>>> created 2016-03-02 16:36:35.001700
>>>> modified 2016-03-02 16:45:17.802073
>>>> flags sortbitwise
>>>> pool 0 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_h=
ash
>>>> rjenkins pg_num 8 pgp_num 8 last_change 1 flags hashpspool stripe_=
width 0
>>>> max_osd 3
>>>> osd.0 down out weight 0 up_from 4 up_thru 163 down_at 166
>>>> last_clean_interval [0,0) 127.0.0.1:6804/2455 127.0.0.1:6805/2455
>>>> 127.0.0.1:6806/2455 127.0.0.1:6807/2455 autoout,exists
>>>> 8bc29c74-e08c-11e5-8cd4-1c6f6582ec12
>>>> osd.1 up   in  weight 1 up_from 8 up_thru 166 down_at 0
>>>> last_clean_interval [0,0) 127.0.0.1:6808/2475 127.0.0.1:6811/2475
>>>> 127.0.0.1:6813/2475 127.0.0.1:6816/2475 exists,up
>>>> 8d7a2cb5-e08c-11e5-8cd4-1c6f6582ec12
>>>> osd.2 up   in  weight 1 up_from 13 up_thru 166 down_at 0
>>>> last_clean_interval [0,0) 127.0.0.1:6817/2495 127.0.0.1:6818/2495
>>>> 127.0.0.1:6819/2495 127.0.0.1:6820/2495 exists,up
>>>> 8f46df05-e08c-11e5-8cd4-1c6f6582ec12
>>>> pg_temp 0.0 [0,2,1]
>>>> pg_temp 0.1 [2,0,1]
>>>> pg_temp 0.2 [0,1,2]
>>>> pg_temp 0.3 [2,0,1]
>>>> pg_temp 0.4 [0,2,1]
>>>> pg_temp 0.5 [0,2,1]
>>>> pg_temp 0.6 [0,1,2]
>>>> pg_temp 0.7 [1,0,2]
>>>> 2016-03-02 16:56:11.027977 8021d7800  0 lockdep stop
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
