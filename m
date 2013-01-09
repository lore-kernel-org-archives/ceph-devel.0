From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Crushmap Design Question
Date: Wed, 09 Jan 2013 15:00:47 +0000
Message-ID: <50ED861F.3040703@inktank.com>
References: <AEBA0243790A484AA72D5CDF477159BC1CEB087D@SN2PRD0106MB178.prod.exchangelabs.com> <6F3FA899187F0043BA1827A69DA2F7CC5D2C29@SHSMSX102.ccr.corp.intel.com> <50ED3175.8010304@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:39347 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976Ab3AIPAx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 10:00:53 -0500
Received: by mail-la0-f46.google.com with SMTP id fq13so1970389lab.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 07:00:51 -0800 (PST)
In-Reply-To: <50ED3175.8010304@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "Moore, Shawn M" <smmoore@catawba.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/09/2013 08:59 AM, Wido den Hollander wrote:
> Hi,
>=20
> On 01/09/2013 01:53 AM, Chen, Xiaoxi wrote:
>> Hi=A3=AC
>> 	Setting rep size to 3 only make the data triple-replication, that m=
eans when you "fail" all OSDs in 2 out of 3 DCs, the data still accessa=
ble.
>> 	But Monitor is another story, for monitor clusters with 2N+1 nodes,=
 it require at least N+1 nodes alive, and indeed this is why you Ceph f=
ailed.
>> 	It looks to me this discipline make it hard to design a proper depl=
oyment which is robust in DC outage. But hoping for inputs from communi=
ty,how to make Monitor cluster reliable.
>>
>=20
>  From what I understand he didn't kill the second mon, still leaving =
2
> out of 3 mons running.

Indeed. A good hint that this is the case is this bit of Shawn's messag=
e:

>> When I fail a datacenter (including 1 of 3 mon's) I eventually get:
>> 2013-01-08 13:58:54.020477 mon.0 [INF] pgmap v2712139: 7104 pgs: 710=
4 active+degraded; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avai=
l; 16362/49086 degraded (33.333%)
>>
>> At this point everything is still ok.  But when I fail the 2nd datac=
enter (still leaving 2 out of 3 mons running) I get:
>> 2013-01-08 14:01:25.600056 mon.0 [INF] pgmap v2712189: 7104 pgs: 710=
4 incomplete; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avail

If you still manage to get these messages, it means your monitors are
still handling and answering requests, and that only happens when you
have a quorum :)

  -Joao
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
