From: Owen Synge <osynge@suse.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Fri, 20 May 2016 15:01:19 +0200
Message-ID: <573F0A9F.6000704@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
 <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
 <570666AB.8090408@suse.com>
 <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
 <57067F56.2000705@suse.com>
 <alpine.DEB.2.11.1604071143000.19675@cpach.fuggernut.com>
 <57081B3A.20601@suse.com> <570BAC52.4070404@suse.com>
 <alpine.DEB.2.11.1605120905220.23446@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:42647 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbcETNBv (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 20 May 2016 09:01:51 -0400
In-Reply-To: <alpine.DEB.2.11.1605120905220.23446@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

On 05/12/2016 03:06 PM, Sage Weil wrote:
> On Mon, 11 Apr 2016, Owen Synge wrote:
>> On 04/08/2016 10:57 PM, Owen Synge wrote:
>>> On 04/07/2016 05:43 PM, Sage Weil wrote:
>>>> On Thu, 7 Apr 2016, Owen Synge wrote:
>>>>> On 04/07/2016 04:03 PM, Sage Weil wrote:
>>>>>> On Thu, 7 Apr 2016, Owen Synge wrote:
>>>>>>> Hi Sage,
>>>>>>>
>>>>>>> On 04/07/2016 02:26 PM, Sage Weil wrote:
>>>>>>>> Hi Owen,
>>>>>>>>
>>>>>>>> I never really liked ceph-create-keys either, but it simplifie=
d the=20
>>>>>>>> deployment process. =20
>>>>>>>
>>>>>>> I would propose we do this in two stages.
>>>>>>>
>>>>>>> (A) Remove calling the command from the init scripts as a side =
effect of
>>>>>>> starting the mon.
>>>>>>>
>>>>>>> This allows us to get most of the issues solved.
>>>>>>>
>>>>>>> (B) Remove the command.
>>>>>>>
>>>>>>> This is the long term goal, which is not as urgent in my opinio=
n but
>>>>>>> others may disagree.
>>>>>>
>>>>>> Works for me.  We just need to change ceph-deploy and get the ot=
her=20
>>>>>> install/deploy tool folks on board before A.
>>>>>
>>>>> Are you intending to get this into Jewel?
>>>>>
>>>>> I had assumed this would only be done on master, and only come in=
to the
>>>>> next release.
>>>>
>>>> Yeah, too late for jewel.
>>>>
>>>>> As a change to master I felt that we could just do (A) as soon as
>>>>> ceph-deploy works without the mon boot up scripts calling
>>>>> ceph-create-keys, ideally without having  ceph-create-keys in
>>>>> ceph-deploy's process.
>>>>>
>>>>> We can then file bugs as needed against other install processes t=
hat
>>>>> depend on ceph-create-keys, and they can test against master.
>>>>
>>>> That works for me.
>>>>
>>>> sage
>>>
>>> Great,
>>>
>>> I have a fix, that is tested and working for ceph-deploy without
>>> depending upon ceph-create-keys based upon a rewrite of the method
>>>
>>>   ceph-deploy gatherkeys mon-node-01 mon-node-02 mon-node-03
>>>
>>> Works nicely for the old and new methods, and seems to have little
>>> impact apart from no new keys are wrote to disk on the mon nodes. O=
SD's
>>> and rgw can be deployed without change, (I haven=92t tested mds)
>>>
>>> Previous behavior with the admin keys being deployed can be achieve=
d
>>> simply by executing:
>>>
>>>   ceph-deploy admin mon-node-01 mon-node-02 mon-node-03
>>>
>>> If we definitely what to enforce the admin code being persisted on =
all
>>> mon nodes can be changed later, but I think its cleaner if we do no=
t.
>>>
>>> I will submit a PR on Monday.
>>
>> ceph-deploy bug raised:
>>
>> http://tracker.ceph.com/issues/15451
>>
>> PR submitted:
>>
>> https://github.com/ceph/ceph-deploy/pull/393
>=20
> Hey Owen-
>=20
> Now that jewel is out, now would be a good time to make this change. =
 The=20
> ceph-deploy pr looks basically ready to go, minus a doc piece and a r=
un=20
> through the ceph-deploy suite.  Yuri can probably handle the=20
> latter.
>=20
> Then we can do the ceph.git changes to kill the ceph-create-keys task=
=2E..

Dear Sage,

Sorry for the delay, I had a big pile of downstream work and test suite
development to do for my salt work, I have now added some documentation=
=2E

I hope Yuri can do the latter as I really dont know "the ceph-deploy su=
ite".

Best wishes

Owen


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
