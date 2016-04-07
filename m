From: Owen Synge <osynge@suse.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 17:40:06 +0200
Message-ID: <57067F56.2000705@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
 <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
 <570666AB.8090408@suse.com>
 <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:46316 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531AbcDGPkN (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 7 Apr 2016 11:40:13 -0400
In-Reply-To: <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com



On 04/07/2016 04:03 PM, Sage Weil wrote:
> On Thu, 7 Apr 2016, Owen Synge wrote:
>> Hi Sage,
>>
>> On 04/07/2016 02:26 PM, Sage Weil wrote:
>>> Hi Owen,
>>>
>>> I never really liked ceph-create-keys either, but it simplified the=
=20
>>> deployment process. =20
>>
>> I would propose we do this in two stages.
>>
>> (A) Remove calling the command from the init scripts as a side effec=
t of
>> starting the mon.
>>
>> This allows us to get most of the issues solved.
>>
>> (B) Remove the command.
>>
>> This is the long term goal, which is not as urgent in my opinion but
>> others may disagree.
>=20
> Works for me.  We just need to change ceph-deploy and get the other=20
> install/deploy tool folks on board before A.

Are you intending to get this into Jewel?

I had assumed this would only be done on master, and only come into the
next release.

As a change to master I felt that we could just do (A) as soon as
ceph-deploy works without the mon boot up scripts calling
ceph-create-keys, ideally without having  ceph-create-keys in
ceph-deploy's process.

We can then file bugs as needed against other install processes that
depend on ceph-create-keys, and they can test against master.

>>> I have no problem with removing it as long as we make
>>> sure the deployment process doesn't too much harder for ceph-deploy=
 users.
>>
>> The documentation for the manual process without using ceph-deploy w=
ill
>> need to be changed if we remove calling ceph-create-keys from the bo=
ot
>> scripts.
>=20
> Yeah.
>=20
>> For ceph-deploy users I think we should see if any changes to the
>> process are needed, the next question is will any be wanted?
>=20
> Actually, thinking about it a bit more, I don't think ceph-deploy usa=
ge=20
> has to change at all.  The old way was
>=20
>  1. ceph-create-keys creates and installs the keys on the mons
>  2. ceph-deploy gatherkeys or create-initial slurps them up
>=20
> We can just change ceph-deploy so it creates and stores them locally,=
 and=20
> doesn't store them on the mons at all.  Users don't get the side-effe=
ct=20
> that the mons have the keys installed, but that is arguably better an=
yway.
>=20
>> https://github.com/SUSE/ceph-deploy/commit/58b030dbe0a964b32f1fbc9a3=
762e64dd74bf50c
>=20
> Instead of this, it should do the same steps as ceph-create-keys (use=
 the=20
> mon. internal key to authenticate to create the admin and bootstrap=20
> keys), but just write them to the local ceph-dpeloy work dir.

That sounds like a better plan than my idea of just using
ceph-create-keys in ceph-deploy to me.

Best regards

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
