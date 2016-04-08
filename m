From: Owen Synge <osynge@suse.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Fri, 8 Apr 2016 22:57:30 +0200
Message-ID: <57081B3A.20601@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
 <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
 <570666AB.8090408@suse.com>
 <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
 <57067F56.2000705@suse.com>
 <alpine.DEB.2.11.1604071143000.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:52118 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758751AbcDHU5q (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 8 Apr 2016 16:57:46 -0400
In-Reply-To: <alpine.DEB.2.11.1604071143000.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

On 04/07/2016 05:43 PM, Sage Weil wrote:
> On Thu, 7 Apr 2016, Owen Synge wrote:
>> On 04/07/2016 04:03 PM, Sage Weil wrote:
>>> On Thu, 7 Apr 2016, Owen Synge wrote:
>>>> Hi Sage,
>>>>
>>>> On 04/07/2016 02:26 PM, Sage Weil wrote:
>>>>> Hi Owen,
>>>>>
>>>>> I never really liked ceph-create-keys either, but it simplified t=
he=20
>>>>> deployment process. =20
>>>>
>>>> I would propose we do this in two stages.
>>>>
>>>> (A) Remove calling the command from the init scripts as a side eff=
ect of
>>>> starting the mon.
>>>>
>>>> This allows us to get most of the issues solved.
>>>>
>>>> (B) Remove the command.
>>>>
>>>> This is the long term goal, which is not as urgent in my opinion b=
ut
>>>> others may disagree.
>>>
>>> Works for me.  We just need to change ceph-deploy and get the other=
=20
>>> install/deploy tool folks on board before A.
>>
>> Are you intending to get this into Jewel?
>>
>> I had assumed this would only be done on master, and only come into =
the
>> next release.
>=20
> Yeah, too late for jewel.
>=20
>> As a change to master I felt that we could just do (A) as soon as
>> ceph-deploy works without the mon boot up scripts calling
>> ceph-create-keys, ideally without having  ceph-create-keys in
>> ceph-deploy's process.
>>
>> We can then file bugs as needed against other install processes that
>> depend on ceph-create-keys, and they can test against master.
>=20
> That works for me.
>=20
> sage

Great,

I have a fix, that is tested and working for ceph-deploy without
depending upon ceph-create-keys based upon a rewrite of the method

  ceph-deploy gatherkeys mon-node-01 mon-node-02 mon-node-03

Works nicely for the old and new methods, and seems to have little
impact apart from no new keys are wrote to disk on the mon nodes. OSD's
and rgw can be deployed without change, (I haven=92t tested mds)

Previous behavior with the admin keys being deployed can be achieved
simply by executing:

  ceph-deploy admin mon-node-01 mon-node-02 mon-node-03

If we definitely what to enforce the admin code being persisted on all
mon nodes can be changed later, but I think its cleaner if we do not.

I will submit a PR on Monday.

Best wishes

Owen
--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer, HR=
B
21284 (AG
N=FCrnberg)

Maxfeldstra=DFe 5

90409 N=FCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
