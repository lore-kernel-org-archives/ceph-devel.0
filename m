From: Haomai Wang <haomai@xsky.com>
Subject: Re: HowTo use spdk as Bluestore block device in v10.2.0
Date: Fri, 22 Apr 2016 08:02:34 -0400
Message-ID: <CACJqLyb6Yjz=PddFWxhOapMX3xJ-CQQ9zBMSuqQbicK1PrHFEA@mail.gmail.com>
References: <PS1PR0401MB149932A26F2B9D5893AF8A84AA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
	<CACJqLya_Uw4J43bhNeT2=Dv7OqVhMrff45d81t_Wu23xwwOatw@mail.gmail.com>
	<PS1PR0401MB149938000DBFFBAB9B320FFCAA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
	<HK2PR0401MB14918377A1A14B3702B8BE3DAA6F0@HK2PR0401MB1491.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0121.outbound.protection.outlook.com ([104.47.124.121]:46048
	"EHLO APC01-HK2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752000AbcDVMCq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 08:02:46 -0400
Received: by mail-vk0-f53.google.com with SMTP id e185so132735075vkb.1
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 05:02:42 -0700 (PDT)
In-Reply-To: <HK2PR0401MB14918377A1A14B3702B8BE3DAA6F0@HK2PR0401MB1491.apcprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Tianxiang <lanceflee@msn.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Apr 22, 2016 at 5:52 AM, Li Tianxiang <lanceflee@msn.com> wrote=
:
>
> Sorry,
> I mean that we have two NVMe SSD each node,one for a OSD,. But only 1=
 OSD is up.
>
> It seams that the hugepages are all taken by 1 spdk instance, nothing=
 left for another.

Yep, this is probrem.....

we have two options now, one is use dpdk multi process to let two
ceph-osd aware, it need some codes. another is waiting for "fedora osd
process" feature which is more suitable......

>
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
>
>
>
>
>
> On 4/22/16, 17:28, "=E6=9D=8E =E5=A4=A9=E7=A5=A5" <ceph-devel-owner@v=
ger.kernel.org on behalf of lanceflee@msn.com> wrote:
>
>>1. Fisrt of all ,  $ yum remove  dpdk-devel  dpdk -y
>>2.get dpdk-2.2.0 source code , and compile it as shared library, As f=
ollows:
>>   a. vim config/common_linuxapp, modify "CONFIG_RTE_BUILD_SHARED_LIB=
=3Dy"
>>   b.make  install T=3Dx86_64-native-linuxapp-gcc DESTDIR=3D/usr
>>3.build ceph  ./configure --with-spdk
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
