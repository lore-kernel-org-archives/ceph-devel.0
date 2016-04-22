From: Haomai Wang <haomai@xsky.com>
Subject: Re: HowTo use spdk as Bluestore block device in v10.2.0
Date: Fri, 22 Apr 2016 08:47:22 -0400
Message-ID: <CACJqLyZJZnAdNf2KhV-PSpZ-44bYHLuQ-Woec1dwL2oM7RizbA@mail.gmail.com>
References: <PS1PR0401MB149932A26F2B9D5893AF8A84AA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
	<CACJqLya_Uw4J43bhNeT2=Dv7OqVhMrff45d81t_Wu23xwwOatw@mail.gmail.com>
	<PS1PR0401MB149938000DBFFBAB9B320FFCAA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
	<HK2PR0401MB14918377A1A14B3702B8BE3DAA6F0@HK2PR0401MB1491.apcprd04.prod.outlook.com>
	<CACJqLyb6Yjz=PddFWxhOapMX3xJ-CQQ9zBMSuqQbicK1PrHFEA@mail.gmail.com>
	<PS1PR0401MB1499F35700266CEE600E43C2AA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0111.outbound.protection.outlook.com ([104.47.126.111]:27079
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753733AbcDVOU0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 10:20:26 -0400
Received: by mail-vk0-f42.google.com with SMTP id e185so134189504vkb.1
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 05:47:32 -0700 (PDT)
In-Reply-To: <PS1PR0401MB1499F35700266CEE600E43C2AA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5p2OIOWkqeelpQ==?= <lanceflee@msn.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Apr 22, 2016 at 8:43 AM, =E6=9D=8E =E5=A4=A9=E7=A5=A5 <lancefle=
e@msn.com> wrote:
>
> Thx!
>
> BTW,
>
> We have thought about if it is a waste to put only 1 OSD on a whole N=
VMe
> SSD, especially a high-end one, such as Intel DC P3700.
>
> And we read some spdk codes, noticed that it is band with NVMe namesp=
ace.
>
> Theoretically, a NVMe SSD can be multi-namespaces by partition LBAs.
> Each namespace has its own Submission/Completion Queues, so it would =
work well.
>
> But now, took P3700 as an example, it only supports NVMe v1.0, and th=
e Namespace
> Management Cmd Sets is not supported yet. It would be easier to creat=
e namespaces someday.
>
>
> And "os/bluestore/NVMEDevices.cc" identifies 1 namespace per SSD too.
>
> Hopes to see multi-namespaces support to make full use of SSDs.

yep, from my current view, I hope bluestore can do device sharding as
mentioned recently on ceph-devel ML. so nvmedevice can directly
divided into multi partition to make full use of.

And you can check the newest
pr(https://github.com/ceph/ceph/pull/8503) since I made a performance
regression for Jewel release....

>
>
>
> --
> Best Regards!
>
>
>
>
>
>
>
> On 4/22/16, 20:02, "Haomai Wang" <haomai@xsky.com> wrote:
>
>>On Fri, Apr 22, 2016 at 5:52 AM, Li Tianxiang <lanceflee@msn.com> wro=
te:
>>>
>>> Sorry,
>>> I mean that we have two NVMe SSD each node,one for a OSD,. But only=
 1 OSD is up.
>>>
>>> It seams that the hugepages are all taken by 1 spdk instance, nothi=
ng left for another.
>>
>>Yep, this is probrem.....
>>
>>we have two options now, one is use dpdk multi process to let two
>>ceph-osd aware, it need some codes. another is waiting for "fedora os=
d
>>process" feature which is more suitable......
>>
>>>
>>>
>>>
>>>
>>> --
>>> Best Regards!
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> On 4/22/16, 17:28, "=E6=9D=8E =E5=A4=A9=E7=A5=A5" <ceph-devel-owner=
@vger.kernel.org on behalf of lanceflee@msn.com> wrote:
>>>
>>>>1. Fisrt of all ,  $ yum remove  dpdk-devel  dpdk -y
>>>>2.get dpdk-2.2.0 source code , and compile it as shared library, As=
 follows:
>>>>   a. vim config/common_linuxapp, modify "CONFIG_RTE_BUILD_SHARED_L=
IB=3Dy"
>>>>   b.make  install T=3Dx86_64-native-linuxapp-gcc DESTDIR=3D/usr
>>>>3.build ceph  ./configure --with-spdk
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
