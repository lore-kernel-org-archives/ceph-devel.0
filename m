From: Loic Dachary <loic@dachary.org>
Subject: Re: Virtualenv tests still nort running...
Date: Thu, 31 Mar 2016 11:31:53 +0200
Message-ID: <56FCEE89.4080605@dachary.org>
References: <56FA67A8.6050809@digiware.nl> <56FA74F4.5040905@dachary.org>
 <56FA9B5C.5060307@digiware.nl> <56FB9BA0.2060901@digiware.nl>
 <56FBA5FC.6040001@dachary.org> <56FC397D.8020700@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58263 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781AbcCaJb5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 05:31:57 -0400
In-Reply-To: <56FC397D.8020700@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>



On 30/03/2016 22:39, Willem Jan Withagen wrote:
> On 30-3-2016 12:10, Loic Dachary wrote:
>> Hi Willem,
>>
>> Would you mind proposing a pull request with that change ? It looks =
good to me.
>>
>=20
> Loic,
>=20
> It does run from make.
>=20
> But just running it on the commandline, does not really deliver....
>=20
> [/usr/srcs/Ceph/work/ceph/src] wjw@freetest.digiware.nl>
> ceph-disk/run-tox.sh
> ceph-disk/run-tox.sh: line 21: ceph-disk-virtualenv/bin/activate: No
> such file or directory
> ceph-disk/run-tox.sh: line 22: ceph-disk-virtualenv/tox.out: No such
> file or directory
> ceph-disk/run-tox.sh: line 24: ceph-disk-virtualenv/tox.out: No such
> file or directory
>=20
> But perhaps the testscripts are not intended to run separate on the
> commandline?

They are. There still is something wrong...

>=20
> --WjW
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
