From: Loic Dachary <loic@dachary.org>
Subject: Re: QE validation infernalis v9.2.1 status
Date: Thu, 25 Feb 2016 19:13:37 +0700
Message-ID: <56CEEFF1.3020804@dachary.org>
References: <CAMMFjmG3ukLQQiw6=R8z4PaR=MxVBvME4Qh3e-RsqFvrgdpqug@mail.gmail.com>
 <CAMMFjmGzpf_a7jDbkyUX9cp0MtNajLcsAPHvi+2HLuYHfwm5Cg@mail.gmail.com>
 <56CE80A5.2050104@dachary.org>
 <CAC-Np1xtXyOBUVSJqC_mXUngh2+hj+mMBPyjGHUAOs0dCC4Qkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33066 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760290AbcBYMNu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 07:13:50 -0500
In-Reply-To: <CAC-Np1xtXyOBUVSJqC_mXUngh2+hj+mMBPyjGHUAOs0dCC4Qkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Gregory Farnum <gfarnum@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Gregory Meno <gmeno@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>



On 25/02/2016 18:55, Alfredo Deza wrote:
> On Wed, Feb 24, 2016 at 11:18 PM, Loic Dachary <loic@dachary.org> wro=
te:
>> Hi Alfredo & Yuri,
>>
>> Please note that the SHA for the infernalis release v9.2.1 is 71f380=
a81c6870466e11a74a597f847494ba23e9 as mentioned at http://tracker.ceph.=
com/issues/13750#Release-information. It is *not* the head of the infer=
nalis branch which contains two additional commits. These two additiona=
l commits have been tested and approved by Yehuda but they have not bee=
n tested by QE.
>=20
> This is very very unfortunate as we already had built the packages
> from the tip of infernalis.
>=20

What was the tip of infernalis when you built the packages ?

> As it currently stands we don't have the ability to configure a build
> from a distinct SHA commit.
>=20
> Please let me know when this is ready to build from the tip of the br=
anch.
>=20
>=20
>>
>> Cheers
>>
>>
>> *   commit d148ed64e4b865baceeadbe999dcba2ca956d932
>> |\  Merge: d9e3ffb 43f0305
>> | | Author: Loic Dachary <loic@dachary.org>
>> | | Date:   Thu Feb 25 11:08:07 2016 +0700
>> | |
>> | |     Merge pull request #7423 from Abhishekvrshny/wip-14324-infer=
nalis
>> | |
>> | |     infernalis: rgw: radosgw-admin bucket check --fix not work
>> | |
>> | |     Reviewed-by: Yehuda Sadeh <ysadehwe@redhat.com>
>> | |
>> | * commit 43f0305e596a51985fa06379ed6228e1c21aa445
>> | | Author: Weijun Duan <duanweijun@h3c.com>
>> | | Date:   Sun Jan 3 20:12:04 2016 -0500
>> | |
>> | |     rgw: radosgw-admin bucket check --fix not work
>> | |
>> | |     Fixed:#14215
>> | |
>> | |     Signed-off-by: Weijun Duan <duanweijun@h3c.com>
>> | |     (cherry picked from commit a17f4e27d608ef29cf499fe76246929ec=
7962783)
>> | |
>> * |   commit d9e3ffb2fe1061aa1035d507019216d76cd71664
>> |\ \  Merge: 71f380a beb4b66
>> | | | Author: Loic Dachary <loic@dachary.org>
>> | | | Date:   Thu Feb 25 11:07:44 2016 +0700
>> | | |
>> | | |     Merge pull request #7424 from Abhishekvrshny/wip-13887-inf=
ernalis
>> | | |
>> | | |     infernalis: rgw: orphans finish segfaults
>> | | |
>> | | |     Reviewed-by: Yehuda Sadeh <ysadehwe@redhat.com>
>> | | |
>> | * | commit beb4b66c2f2eb4a22e6213b4b87d1670c10e5227
>> | |/  Author: Igor Fedotov <ifedotov@mirantis.com>
>> | |   Date:   Thu Nov 19 13:38:40 2015 +0300
>> | |
>> | |       Fixing NULL pointer dereference
>> | |
>> | |       Signed-off-by: Igor Fedotov <ifedotov@mirantis.com>
>> | |       (cherry picked from commit 93d3dfe0441be50a6990d458ee0ee32=
89af39b20)
>> | |
>>
>>
>> On 25/02/2016 04:41, Yuri Weinstein wrote:
>>> Alfredo,
>>>
>>> QE validation for infernalis v9.2.1 is completed and it's ready for=
 publishing.
>>>
>>> Thx
>>> YuriW
>>>
>>> On Wed, Feb 24, 2016 at 8:24 AM, Yuri Weinstein <yweinste@redhat.co=
m> wrote:
>>>> Detailed summary of the QE Validation can be found here
>>>> http://tracker.ceph.com/issues/13750#note-32
>>>>
>>>> The following suites were in scope of this point release testing:
>>>>
>>>> rados (subset 1/7)
>>>> rbd
>>>> rgw
>>>> fs
>>>> krbd
>>>> kcephfs
>>>> knfs
>>>> hadoop
>>>> samba
>>>> rest
>>>> ceph-deploy
>>>> upgrade/client-upgrade
>>>> upgrade/hammer-x (infernalis)
>>>> upgrade/firefly-x (infernalis)
>>>> upgrade/firefly-hammer-x (infernalis)
>>>> upgrade/infernalis
>>>> powercycle
>>>>
>>>> Known issues (approved for release):
>>>>
>>>> krbd:
>>>> http://tracker.ceph.com/issues/14848 - approved by Jason
>>>>
>>>> ceph-deploy:
>>>> http://tracker.ceph.com/issues/14223 - assumed approved by Sage (?=
)
>>>>
>>>> powercycle:
>>>> http://tracker.ceph.com/issues/14810 - needs Sage approval
>>>>
>>>> Thx
>>>> YuriW
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
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
