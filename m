From: Haomai Wang <haomai@xsky.com>
Subject: Re: HowTo use spdk as Bluestore block device in v10.2.0
Date: Fri, 22 Apr 2016 00:54:28 -0400
Message-ID: <CACJqLya_Uw4J43bhNeT2=Dv7OqVhMrff45d81t_Wu23xwwOatw@mail.gmail.com>
References: <PS1PR0401MB149932A26F2B9D5893AF8A84AA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0111.outbound.protection.outlook.com ([104.47.124.111]:1888
	"EHLO APC01-HK2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751067AbcDVFI5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 01:08:57 -0400
Received: by mail-vk0-f47.google.com with SMTP id t129so123047002vkg.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2016 21:54:35 -0700 (PDT)
In-Reply-To: <PS1PR0401MB149932A26F2B9D5893AF8A84AA6F0@PS1PR0401MB1499.apcprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5p2OIOWkqeelpQ==?= <lanceflee@msn.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

as log showed:
EAL: open shared lib /usr/lib64/dpdk-pmds/librte_pmd_ixgbe.so.1
EAL: /usr/lib64/dpdk-pmds/librte_pmd_ixgbe.so.1: undefined symbol:
rte_eth_devices
PANIC in rte_eal_init():

It looks you failed to init dpdk env, plz ensure you have successfully
build dpdk library. spdk doesn't require any pmd driver.

On Thu, Apr 21, 2016 at 11:29 PM, =E6=9D=8E =E5=A4=A9=E7=A5=A5 <lancefl=
ee@msn.com> wrote:
>
> Hi,all:
>
> When I tried to use SPDK, some problems occurred as follows.
>
> It looks like something goes wrong in Libs of dpdk-devel
>
> Maybe the same as BUG#15386
>
> HowTo fix it? Any help?
>
>
> =E2=80=94
>  Best Regards!
>
>
>
> EAL: TSC frequency is ~2394457 KHz
> EAL: open shared lib /usr/lib64/dpdk-pmds/librte_pmd_ixgbe.so.1
> EAL: /usr/lib64/dpdk-pmds/librte_pmd_ixgbe.so.1: undefined symbol: rt=
e_eth_devices
> PANIC in rte_eal_init():
> Cannot init plugins
> 8: [/lib64/libc.so.6(clone+0x6d) [0x7f428051528d]]
> 7: [/lib64/libpthread.so.0(+0x7dc5) [0x7f4281e89dc5]]
> 6: [/lib64/libstdc++.so.6(+0xb5220) [0x7f4280dad220]]
> 5: [./ceph-osd(+0x77f58d) [0x7f428474758d]]
> 4: [./ceph-osd(+0x77eee5) [0x7f4284746ee5]]
> 3: [/lib64/librte_eal.so.2(rte_eal_init+0xecb) [0x7f42836d4f8b]]
> 2: [/lib64/librte_eal.so.2(__rte_panic+0xd0) [0x7f42836d3460]]
> 1: [/lib64/librte_eal.so.2(rte_dump_stack+0x2d) [0x7f42836db5fd]]
> *** Caught signal (Aborted) **
>  in thread 7f427c226700 thread_name:ceph-osd
>  ceph version 10.2.0 (3a9fba20ec743699b69bd0181dd6c54dc01c64b9)
>  1: (()+0x8fb342) [0x7f42848c3342]
>  2: (()+0xf100) [0x7f4281e91100]
>  3: (gsignal()+0x37) [0x7f42804545f7]
>  4: (abort()+0x148) [0x7f4280455ce8]
>  5: (rte_log()+0) [0x7f42836d346a]
>  6: (rte_eal_init()+0xecb) [0x7f42836d4f8b]
>  7: (()+0x77eee5) [0x7f4284746ee5]
>  8: (()+0x77f58d) [0x7f428474758d]
>  9: (()+0xb5220) [0x7f4280dad220]
>  10: (()+0x7dc5) [0x7f4281e89dc5]
>  11: (clone()+0x6d) [0x7f428051528d]
> 2016-04-22 10:45:31.345324 7f427c226700 -1 *** Caught signal (Aborted=
) **
>  in thread 7f427c226700 thread_name:ceph-osd
>
>  ceph version 10.2.0 (3a9fba20ec743699b69bd0181dd6c54dc01c64b9)
>  1: (()+0x8fb342) [0x7f42848c3342]
>  2: (()+0xf100) [0x7f4281e91100]
>  3: (gsignal()+0x37) [0x7f42804545f7]
>  4: (abort()+0x148) [0x7f4280455ce8]
>  5: (rte_log()+0) [0x7f42836d346a]
>  6: (rte_eal_init()+0xecb) [0x7f42836d4f8b]
>  7: (()+0x77eee5) [0x7f4284746ee5]
>  8: (()+0x77f58d) [0x7f428474758d]
>  9: (()+0xb5220) [0x7f4280dad220]
>  10: (()+0x7dc5) [0x7f4281e89dc5]
>  11: (clone()+0x6d) [0x7f428051528d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
>
>    -25> 2016-04-22 10:45:29.811045 7f4283f9cb00 -1 WARNING: the follo=
wing dangerous and experimental features are enabled: bluestore,rocksdb
>    -24> 2016-04-22 10:45:29.811247 7f4283f9cb00 -1 WARNING: the follo=
wing dangerous and experimental features are enabled: bluestore,rocksdb
>    -22> 2016-04-22 10:45:29.811282 7f4283f9cb00 -1 WARNING: experimen=
tal feature 'bluestore' is enabled
> Please be aware that this feature is experimental, untested,
> unsupported, and may result in data corruption, data loss,
> and/or irreparable damage to your cluster.  Do not use
> feature with important data.
>
>    -21> 2016-04-22 10:45:29.833866 7f4283f9cb00 -1 WARNING: the follo=
wing dangerous and experimental features are enabled: bluestore,rocksdb
>     -5> 2016-04-22 10:45:29.869880 7f4283f9cb00 -1 bluestore(/var/loc=
al/osd0) _read_fsid unparsable uuid
>      0> 2016-04-22 10:45:31.345324 7f427c226700 -1 *** Caught signal =
(Aborted) **
>  in thread 7f427c226700 thread_name:ceph-osd
>
>  ceph version 10.2.0 (3a9fba20ec743699b69bd0181dd6c54dc01c64b9)
>  1: (()+0x8fb342) [0x7f42848c3342]
>  2: (()+0xf100) [0x7f4281e91100]
>  3: (gsignal()+0x37) [0x7f42804545f7]
>  4: (abort()+0x148) [0x7f4280455ce8]
>  5: (rte_log()+0) [0x7f42836d346a]
>  6: (rte_eal_init()+0xecb) [0x7f42836d4f8b]
>  7: (()+0x77eee5) [0x7f4284746ee5]
>  8: (()+0x77f58d) [0x7f428474758d]
>  9: (()+0xb5220) [0x7f4280dad220]
>  10: (()+0x7dc5) [0x7f4281e89dc5]
>  11: (clone()+0x6d) [0x7f428051528d]
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
