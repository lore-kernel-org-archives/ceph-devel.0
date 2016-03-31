From: Loic Dachary <loic@dachary.org>
Subject: Re: Virtualenv tests still nort running...
Date: Thu, 31 Mar 2016 12:14:41 +0200
Message-ID: <56FCF891.20706@dachary.org>
References: <56FA67A8.6050809@digiware.nl> <56FA74F4.5040905@dachary.org>
 <56FA9B5C.5060307@digiware.nl> <56FB9BA0.2060901@digiware.nl>
 <56FBA5FC.6040001@dachary.org> <56FC397D.8020700@digiware.nl>
 <56FCEE89.4080605@dachary.org> <56FCF63E.2060503@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39952 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbcCaKOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 06:14:47 -0400
In-Reply-To: <56FCF63E.2060503@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>



On 31/03/2016 12:04, Willem Jan Withagen wrote:
> On 31-3-2016 11:31, Loic Dachary wrote:
>>
>>
>> On 30/03/2016 22:39, Willem Jan Withagen wrote:
>>> On 30-3-2016 12:10, Loic Dachary wrote:
>>>> Hi Willem,
>>>>
>>>> Would you mind proposing a pull request with that change ? It look=
s good to me.
>>>>
>>>
>>> Loic,
>>>
>>> It does run from make.
>>>
>>> But just running it on the commandline, does not really deliver....
>>>
>>> [/usr/srcs/Ceph/work/ceph/src] wjw@freetest.digiware.nl>
>>> ceph-disk/run-tox.sh
>>> ceph-disk/run-tox.sh: line 21: ceph-disk-virtualenv/bin/activate: N=
o
>>> such file or directory
>>> ceph-disk/run-tox.sh: line 22: ceph-disk-virtualenv/tox.out: No suc=
h
>>> file or directory
>>> ceph-disk/run-tox.sh: line 24: ceph-disk-virtualenv/tox.out: No suc=
h
>>> file or directory
>>>
>>> But perhaps the testscripts are not intended to run separate on the
>>> commandline?
>>
>> They are. There still is something wrong...
>=20
> Anything I can do?

modified   src/ceph-disk/run-tox.sh
@@ -16,7 +16,7 @@
 #

 # run from the ceph-disk directory or from its parent
-: ${CEPH_DISK_VIRTUALENV:=3Dceph-disk-virtualenv}
+: ${CEPH_DISK_VIRTUALENV:=3D/tmp/ceph-disk-virtualenv}
 test -d ceph-disk && cd ceph-disk
 source ${CEPH_DISK_VIRTUALENV}/bin/activate
 tox > ${CEPH_DISK_VIRTUALENV}/tox.out 2>&1

Does it work with the above patch ? The default location of the virtual=
env was changed but this default was not updated.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
