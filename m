From: Samuel Just <sjust@redhat.com>
Subject: Re: OSD not coming up after being set down
Date: Wed, 2 Mar 2016 15:02:19 -0800
Message-ID: <CAN=+7FUp8oh2184dp7Y_RvCORsYyy0qUwye=1TWF7y4FTU9FDg@mail.gmail.com>
References: <56D70ED5.7080203@digiware.nl>
	<CANA9Uk4bgcG4P0RGWaZQwiJP_fp+2xC_3RJbfF25VJTAy7UPJQ@mail.gmail.com>
	<56D74555.7060004@digiware.nl>
	<CAN=+7FX-JXXy29y6m4=RkrivuwP0Kc9M7vkqTnmaqjKCdP4yow@mail.gmail.com>
	<56D74B52.7060104@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34346 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbcCBXCU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 18:02:20 -0500
Received: by mail-yk0-f171.google.com with SMTP id u9so1989150ykd.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 15:02:20 -0800 (PST)
In-Reply-To: <56D74B52.7060104@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: M Ranga Swami Reddy <swamireddy@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Maps are created by the mons (that's pretty much what they're for).
The entire paxos thing it there to make sure that two maps with the
same epoch number are identical and that we produce them in increasing
epoch number.  The ceph command therefore causes the mon cluster to
publish a new map at the next epoch number.  That map is then sent out
to some number of osds who then gossip it out to the rest.  As osds
find out that osd 0 is down, they should start responding to osd.0's
pings with a "you died" message and otherwise ignoring it.  osd.0 will
then contact the mon for a more up-to-date map (which must be at least
as recent as the one which marked it down).  osd.0 will then get that
map, find out that it died, kill and reopen it's network connections
(so that it's a new instance), and send a boot to the mons requesting
that it be marked back up.
-Sam

On Wed, Mar 2, 2016 at 12:21 PM, Willem Jan Withagen <wjw@digiware.nl> =
wrote:
> On 2-3-2016 21:11, Samuel Just wrote:
>> At this point, you will want to run the script and then dig through
>> the logs until you find something that doesn't match.
>> - Was osd.0 up to begin with?
>> - Is its process running?
>> - Did it get the map marking it down?
>> - Did it send a boot message back to the mon requesting that it be
>> marked back up?
>> - Did the mon get that message?
>> - Did the mon create a new map marking it up?
>
> Right this is sort of a handholding I was looking for.
>
> The first 2 items are true.
> Who sends "the map marking it down"?
>         ceph osd down 0 =3D> Mon =3D> Osd
> Or does that go directly ceph =3D> Osd
>
> Are there any statemachine pictures of this in the manuals?
>
> --WjW
>
>> Etc
>> -Sam
>>
>> On Wed, Mar 2, 2016 at 11:56 AM, Willem Jan Withagen <wjw@digiware.n=
l> wrote:
>>> On 2-3-2016 18:01, M Ranga Swami Reddy wrote:
>>>> Please see the below:
>>>> ---
>>>> The If something is causing OSDs to =E2=80=98flap=E2=80=99 (repeat=
edly getting marked
>>>> down and then up again), you can force the monitors to stop the
>>>> flapping with:
>>>>
>>>> ceph osd set noup      # prevent OSDs from getting marked up
>>>> ceph osd set nodown    # prevent OSDs from getting marked down
>>>> ----
>>>> ref: http://docs.ceph.com/docs/hammer/rados/troubleshooting/troubl=
eshooting-osd/
>>>
>>> I don't think this is the issue.
>>>
>>> The testcode should run as is. This run on Linux oke, but FreeBSD i=
s
>>> giving trouble.
>>> The OSD should get up, but does not.
>>> - OSD not receiving the UP
>>> - OSD not able to go UP
>>> - Or the monitors are not picking up?
>>>
>>> --WjW
>>>
>>>> On Wed, Mar 2, 2016 at 9:33 PM, Willem Jan Withagen <wjw@digiware.=
nl> wrote:
>>>>> Hi,
>>>>>
>>>>> Any handholding is welcomed!!
>>>>>
>>>>> In test/cephtool-mon-test.sh part of the excuted code is:
>>>>>  ceph osd down 0
>>>>>   ceph osd dump | grep 'osd.0 down'
>>>>>   ceph osd unset noup
>>>>>   for ((i=3D0; i < 120; i++)); do
>>>>>     if ! ceph osd dump | grep 'osd.0 up'; then
>>>>>       echo "waiting for osd.0 to come back up"
>>>>>       sleep 1
>>>>>     else
>>>>>       break
>>>>>     fi
>>>>>   done
>>>>>   ceph osd dump | grep 'osd.0 up'
>>>>>
>>>>> But the OSD refused to come back up.
>>>>> Below the output of the dump.
>>>>>
>>>>> How would I start analyzing this issue?
>>>>> What kind of things would I expect to see in the logfile?
>>>>>   What if the OSD does come up
>>>>>   What if the OSD stays down
>>>>>
>>>>> Thanx,
>>>>> --WjW
>>>>>
>>>>>
>>>>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH =
***
>>>>> epoch 170
>>>>> fsid 8b5c0b4b-e08c-11e5-8cd4-1c6f6582ec12
>>>>> created 2016-03-02 16:36:35.001700
>>>>> modified 2016-03-02 16:45:17.802073
>>>>> flags sortbitwise
>>>>> pool 0 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_=
hash
>>>>> rjenkins pg_num 8 pgp_num 8 last_change 1 flags hashpspool stripe=
_width 0
>>>>> max_osd 3
>>>>> osd.0 down out weight 0 up_from 4 up_thru 163 down_at 166
>>>>> last_clean_interval [0,0) 127.0.0.1:6804/2455 127.0.0.1:6805/2455
>>>>> 127.0.0.1:6806/2455 127.0.0.1:6807/2455 autoout,exists
>>>>> 8bc29c74-e08c-11e5-8cd4-1c6f6582ec12
>>>>> osd.1 up   in  weight 1 up_from 8 up_thru 166 down_at 0
>>>>> last_clean_interval [0,0) 127.0.0.1:6808/2475 127.0.0.1:6811/2475
>>>>> 127.0.0.1:6813/2475 127.0.0.1:6816/2475 exists,up
>>>>> 8d7a2cb5-e08c-11e5-8cd4-1c6f6582ec12
>>>>> osd.2 up   in  weight 1 up_from 13 up_thru 166 down_at 0
>>>>> last_clean_interval [0,0) 127.0.0.1:6817/2495 127.0.0.1:6818/2495
>>>>> 127.0.0.1:6819/2495 127.0.0.1:6820/2495 exists,up
>>>>> 8f46df05-e08c-11e5-8cd4-1c6f6582ec12
>>>>> pg_temp 0.0 [0,2,1]
>>>>> pg_temp 0.1 [2,0,1]
>>>>> pg_temp 0.2 [0,1,2]
>>>>> pg_temp 0.3 [2,0,1]
>>>>> pg_temp 0.4 [0,2,1]
>>>>> pg_temp 0.5 [0,2,1]
>>>>> pg_temp 0.6 [0,1,2]
>>>>> pg_temp 0.7 [1,0,2]
>>>>> 2016-03-02 16:56:11.027977 8021d7800  0 lockdep stop
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
