From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer branch for v0.94.6 ready for QE
Date: Tue, 9 Feb 2016 12:38:38 +0700
Message-ID: <56B97B5E.3080501@dachary.org>
References: <56B843B7.1070002@dachary.org>
 <CAMMFjmFh9e2dM2ScPL1pj8eDN5k8Ndb7o5dog=-v7xE6gY7Tog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43487 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbcBIFjW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 00:39:22 -0500
In-Reply-To: <CAMMFjmFh9e2dM2ScPL1pj8eDN5k8Ndb7o5dog=-v7xE6gY7Tog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi,

On 09/02/2016 04:21, Yuri Weinstein wrote:
> Loic
>=20
> Copy and started testing today, thx
>=20
> ceph-deploy question - I see that you had failures during integration
> testing, what is the plan for those known issues?

Testing ceph-deploy is out of the scope of the stable release team. Hop=
efully it will be when there is more workforce.

Cheers

>=20
> Thx
> YuriW
>=20
> On Sun, Feb 7, 2016 at 11:28 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Yuri,
>>
>> The hammer branch for v0.94.6 as found at https://github.com/ceph/ce=
ph/commits/hammer has been approved by Greg, Yehuda, Josh and Sam and i=
s ready for QE. For the record, the head is https://github.com/ceph/cep=
h/commit/7abb6ae8f3cba67009bd022aaeee0a87cdfc6477 and the details of th=
e tests run are at http://tracker.ceph.com/issues/13356.
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
