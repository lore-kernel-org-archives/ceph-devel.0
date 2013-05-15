From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [ceph-users] OSD state flipping when cluster-network in
 high utilization
Date: Wed, 15 May 2013 09:38:40 -0600
Message-ID: <5193AC00.5020408@sandia.gov>
References: <6F3FA899187F0043BA1827A69DA2F7CC0145EFF6@SHSMSX102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>,
 <519259C5.3000109@inktank.com>
 <6AC1548D-DE2C-4E71-AC73-3903B57C76C6@intel.com>
 <alpine.DEB.2.00.1305141620410.12954@cobra.newdream.net>
 <6F3FA899187F0043BA1827A69DA2F7CC0145F746@SHSMSX102.ccr.corp.intel.com>,<5193A44F.1060509@sandia.gov>
 <1D3D7B6A-7C8B-4D7B-8B4E-8355F8512F47@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:58785 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757009Ab3EOPjL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 May 2013 11:39:11 -0400
In-Reply-To: <1D3D7B6A-7C8B-4D7B-8B4E-8355F8512F47@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Sage Weil <sage@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On 05/15/2013 09:12 AM, Chen, Xiaoxi wrote:
> Thanks=EF=BC=8C but i am not quite understand how to determine weathe=
r monitor overloaded=EF=BC=9F

I've also found it difficult, and a process of elimination.

Make sure your mon debugging is minimal.  If it's not,
lower it and see if it helps.

Watch your mon host with vmstat or iostat, to see what
it's disk write rate is during the periods you're having
trouble with OSDs having heartbeat issues.  If it's near
what you think the limiting rate is for whatever device
is holding the mon's store.db directory, that might be
your bottleneck.

> and if yes=EF=BC=8Cwill start several monitor help=EF=BC=9F

Sage or one of the other Ceph developers can speak better
to this.  I will note that with three monitors, if one
is too busy, it'll miss renewing its lease.  The result of
that will be an election to get a new quorum.  If you run
multiple mons and they hold frequent elections where a mon
drops out of quorum, then comes back in on the next election,
I've found that to be a sign that my mons are too busy.

-- Jim

>=20
> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84 iPhone
>=20
> =E5=9C=A8 2013-5-15=EF=BC=8C23:07=EF=BC=8C"Jim Schutt" <jaschut@sandi=
a.gov> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> On 05/14/2013 09:23 PM, Chen, Xiaoxi wrote:
>>>> How responsive generally is the machine under load?  Is there avai=
lable CPU?
>>>    The machine works well, and the issued OSDs are likely the same,=
 seems because they have relative slower disk( disk type are the same b=
ut the latency is a bit higher ,8ms -> 10ms).
>>>   =20
>>>    Top show no idle % but still have 30+% of io_wait,  my colleague=
 educate me that io_wait can be treated as free.
>>>
>>> Another information is offload the heartbeat to 1Gb nic doesn't sol=
ve the problem, what's more, when we doing random write test, we can st=
ill see this flipping happen. So I would like to say it may related wit=
h CPU scheduler ? The heartbeat thread (in busy OSD ) failed to get eno=
ugh cpu cycle.
>>>
>>
>> FWIW, also take a close look at your monitor daemons, and
>> whether they show any signs of being overloaded.
>>
>> I frequently see OSDs wrongly marked down when my
>> mons cannot keep up with their workload.
>>
>> -- Jim
>>
>>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
