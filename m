From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next hammer release v0.94.6
Date: Mon, 8 Feb 2016 10:43:44 +0700
Message-ID: <56B80EF0.1080000@dachary.org>
References: <56B18773.6000304@dachary.org>
 <CAJ4mKGYBc5O312mGDYzfxYR3uwyVGBu0vgQr-0ofz60vtLLOyw@mail.gmail.com>
 <56B2E523.9030104@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58864 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbcBHDnx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Feb 2016 22:43:53 -0500
In-Reply-To: <56B2E523.9030104@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi Greg,

Do you think the hammer branch is ready for QE to start their own round=
 of testing ?

Cheers

On 04/02/2016 12:44, Loic Dachary wrote:
> Hi Greg,
>=20
> On 03/02/2016 16:23, Gregory Farnum wrote:
>> On Tue, Feb 2, 2016 at 8:52 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>> Hi Greg,
>>>
>>> The next hammer release as found at https://github.com/ceph/ceph/tr=
ee/hammer passed the fs suite (http://tracker.ceph.com/issues/13356#not=
e-25). A more recent run showed 3 failures and I'm not sure how to inte=
rpret them ( http://pulpito.ceph.com/loic-2016-01-29_03:02:05-fs-hammer=
---basic-multi/ ).
>>>
>>> Do you think the hammer branch is ready for QE to start their own r=
ound of testing ? Or should the above errors be investigated first ?
>>
>> Well, one of them looks to be an infrastructure issue of some kind.
>> You appear to have figured out the fsstress one
>> (http://tracker.ceph.com/issues/14584#change-65185), and the fsx one
>> is http://tracker.ceph.com/issues/14384. I'd get that quick backport
>=20
> Thanks for the pointer :-) (and to Nathan for backporting).
>=20
>> in as well (it's just a change to the qa script to point at a workin=
g
>> version of the repo).
>=20
> Do you think the hammer branch is ready for QE to start their own rou=
nd of testing ?
>=20
> Cheers
>=20
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
