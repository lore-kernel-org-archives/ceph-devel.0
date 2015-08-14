From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Signed-off-by and aliases
Date: Fri, 14 Aug 2015 09:49:54 +0100
Message-ID: <55CDABB2.4080401@suse.de>
References: <55BBD384.7030703@dachary.org>	<CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com>	<55BFCAAB.1040707@dachary.org> <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com> <55CB4163.9040504@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57562 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbbHNIt5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Aug 2015 04:49:57 -0400
In-Reply-To: <55CB4163.9040504@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 08/12/2015 01:51 PM, Loic Dachary wrote:
>=20
>=20
> On 12/08/2015 12:54, Gregory Farnum wrote:
>> I won't be merging any code with obvious aliases for exactly the
>> reasons John mentions. Obviously IANAL, but I think you'll find law
>> proceedings in the USA would look much less kindly on accepting
>> obvious aliases versus having a real name policy =E2=80=94 which we =
do, even
>> if it's not diligently checked.=20
>=20
> It would be more accurate to say it is not checked at all. And it is =
the same for the Linux kernel.
>=20
>> Keep in mind that we generally have a
>> background on our contributors to track them down even if they are
>> using a non-obvious alias.
>=20
> As of today the Ceph repository has 427 contributors and 96 of them a=
uthored more than 10 commits. I would not be surprised if one of them w=
as an alias. The only background check we do is when asking a new contr=
ibutor about his affiliation to an organization (see http://tracker.cep=
h.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide). 41 =
contributors declared that they are not affiliated to any organization =
and we did not investigate further. Nor do I think we should.
>=20
> You have a point: we know the vast majority of contributors, one way =
or the other. It is a small world :-) If a contributor you know insiste=
d on contributing using an alias, for ethical reasons, would you turn h=
er/him down ? Wouldn't it be better for you to be able to vouch for her=
/him somehow ?

Call me paranoid if you must, but if we were considering liability
exposure of the project in case of IP violation, then this could be bad
for the one person merging the code knowingly a given contributor was
using an alias.

Say this contributor did contribute something that he shouldn't have. I=
f
he did ask someone to use an alias instead, and this someone went on
with 'okay, let's do this' and merged the code, I can't stop wondering
whether a lawyer would not take advantage of it, arguing the developer
performing the merge was complicit in the IP violation. He did know thi=
s
one person was under an alias, he did know who this person was, made
sure this person was not identified - "he most certainly knew something
bad was happening, AND DID NOTHING!"

Also, what would the developer be expected to do if a court asked him
who was the real author of a merge containing patches that violated
someone's IP rights? Lying to protect the integrity of an alias doesn't
seem like the obvious choice.

If someone is indeed interested in contributing under an alias, they
should just get a sensible alias that would be assumed to be the real
deal. And everyone can go on with their lives without having to be
exposed, at some point, to the nastiness of IP litigation if things go
sower, or having to lie to cover someone else's track if they cannot
avoid being exposed to it.

  -Joao

>=20
> Cheers
>=20
>> -Greg
>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
