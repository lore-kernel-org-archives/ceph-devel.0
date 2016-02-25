From: Loic Dachary <loic@dachary.org>
Subject: Re: QE validation infernalis v9.2.1 status
Date: Thu, 25 Feb 2016 11:18:45 +0700
Message-ID: <56CE80A5.2050104@dachary.org>
References: <CAMMFjmG3ukLQQiw6=R8z4PaR=MxVBvME4Qh3e-RsqFvrgdpqug@mail.gmail.com>
 <CAMMFjmGzpf_a7jDbkyUX9cp0MtNajLcsAPHvi+2HLuYHfwm5Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36254 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759097AbcBYETA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 23:19:00 -0500
In-Reply-To: <CAMMFjmGzpf_a7jDbkyUX9cp0MtNajLcsAPHvi+2HLuYHfwm5Cg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Gregory Meno <gmeno@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>

Hi Alfredo & Yuri,

Please note that the SHA for the infernalis release v9.2.1 is 71f380a81=
c6870466e11a74a597f847494ba23e9 as mentioned at http://tracker.ceph.com=
/issues/13750#Release-information. It is *not* the head of the infernal=
is branch which contains two additional commits. These two additional c=
ommits have been tested and approved by Yehuda but they have not been t=
ested by QE.

Cheers


*   commit d148ed64e4b865baceeadbe999dcba2ca956d932
|\  Merge: d9e3ffb 43f0305
| | Author: Loic Dachary <loic@dachary.org>
| | Date:   Thu Feb 25 11:08:07 2016 +0700
| |=20
| |     Merge pull request #7423 from Abhishekvrshny/wip-14324-infernal=
is
| |    =20
| |     infernalis: rgw: radosgw-admin bucket check --fix not work
| |    =20
| |     Reviewed-by: Yehuda Sadeh <ysadehwe@redhat.com>
| |  =20
| * commit 43f0305e596a51985fa06379ed6228e1c21aa445
| | Author: Weijun Duan <duanweijun@h3c.com>
| | Date:   Sun Jan 3 20:12:04 2016 -0500
| |=20
| |     rgw: radosgw-admin bucket check --fix not work
| |    =20
| |     Fixed:#14215
| |    =20
| |     Signed-off-by: Weijun Duan <duanweijun@h3c.com>
| |     (cherry picked from commit a17f4e27d608ef29cf499fe76246929ec796=
2783)
| |    =20
* |   commit d9e3ffb2fe1061aa1035d507019216d76cd71664
|\ \  Merge: 71f380a beb4b66
| | | Author: Loic Dachary <loic@dachary.org>
| | | Date:   Thu Feb 25 11:07:44 2016 +0700
| | |=20
| | |     Merge pull request #7424 from Abhishekvrshny/wip-13887-infern=
alis
| | |    =20
| | |     infernalis: rgw: orphans finish segfaults
| | |    =20
| | |     Reviewed-by: Yehuda Sadeh <ysadehwe@redhat.com>
| | |   =20
| * | commit beb4b66c2f2eb4a22e6213b4b87d1670c10e5227
| |/  Author: Igor Fedotov <ifedotov@mirantis.com>
| |   Date:   Thu Nov 19 13:38:40 2015 +0300
| |  =20
| |       Fixing NULL pointer dereference
| |      =20
| |       Signed-off-by: Igor Fedotov <ifedotov@mirantis.com>
| |       (cherry picked from commit 93d3dfe0441be50a6990d458ee0ee3289a=
f39b20)
| |    =20


On 25/02/2016 04:41, Yuri Weinstein wrote:
> Alfredo,
>=20
> QE validation for infernalis v9.2.1 is completed and it's ready for p=
ublishing.
>=20
> Thx
> YuriW
>=20
> On Wed, Feb 24, 2016 at 8:24 AM, Yuri Weinstein <yweinste@redhat.com>=
 wrote:
>> Detailed summary of the QE Validation can be found here
>> http://tracker.ceph.com/issues/13750#note-32
>>
>> The following suites were in scope of this point release testing:
>>
>> rados (subset 1/7)
>> rbd
>> rgw
>> fs
>> krbd
>> kcephfs
>> knfs
>> hadoop
>> samba
>> rest
>> ceph-deploy
>> upgrade/client-upgrade
>> upgrade/hammer-x (infernalis)
>> upgrade/firefly-x (infernalis)
>> upgrade/firefly-hammer-x (infernalis)
>> upgrade/infernalis
>> powercycle
>>
>> Known issues (approved for release):
>>
>> krbd:
>> http://tracker.ceph.com/issues/14848 - approved by Jason
>>
>> ceph-deploy:
>> http://tracker.ceph.com/issues/14223 - assumed approved by Sage (?)
>>
>> powercycle:
>> http://tracker.ceph.com/issues/14810 - needs Sage approval
>>
>> Thx
>> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
