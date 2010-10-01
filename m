From: Shingo TAKADA <takada_ml@mail.syonbori.net>
Subject: Re: Usage of rbd
Date: Fri, 01 Oct 2010 15:21:21 +0900
Message-ID: <4CA57DE1.4020800@mail.syonbori.net>
References: <AANLkTikUMZiGmjF9xPhn-9UiknrnQWLLrMgFEFU83PF7@mail.gmail.com>	<AANLkTi=mftr=1=KG18nBpKHycGO24QPvLT6FJvFjyh3w@mail.gmail.com>	<AANLkTin6oL-U4_0s4Qk5Uc9LctgP_71K0BxJDtbXuRtt@mail.gmail.com> <AANLkTik9gkz_2M-CNYoc8+uVLWdVdOyygef86giLDnp4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38324 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab0JAGV0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Oct 2010 02:21:26 -0400
Received: by iwn5 with SMTP id 5so3414819iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Sep 2010 23:21:25 -0700 (PDT)
In-Reply-To: <AANLkTik9gkz_2M-CNYoc8+uVLWdVdOyygef86giLDnp4@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi

I simply add the line into my config:
  [osd]
       osd class tmp = /var/lib/ceph/tmp

and my rbd works well.
Thanks Yehuda, and please add this option to the wiki.

what i did:
# mkdir -p /var/lib/ceph/tmp
# (add the "osd class tmp" clause into config)
# mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs
# /etc/init.d/ceph -c /usr/local/etc/ceph/ceph.conf --allhosts start
# cclass -a
# ceph class activate rbd 1.2
# rbd -p rbd create testdata --size 128
# rados -p rbd ls

(2010/09/29 13:39), Yehuda Sadeh Weinraub wrote:
> On Tue, Sep 28, 2010 at 5:32 PM, ml ml<takada_ml@mail.syonbori.net>  wrote:
>> Hi
>>
>> I also trying to use rbd in my environment, following the wiki's instruction.
>> and I did "ceph class activate rbd 1.2", but still not works.
>>
>>
>>
>> My situation:
>>
>> # mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs
>> # /etc/init.d/ceph -c /usr/local/etc/ceph/ceph.conf --allhosts start
>> # cclass -a
>> # ceph class activate rbd 1.2
>> (snip)
>> 10.09.29_09:01:30.047510 mon<- [class,activate,rbd,1.2]
>> (snip)
>> 10.09.29_09:01:31.067373 mon0 ->  'updated' (0)
>>
>> # ceph class list
>> (snip)
>> mon<- [class,list]
>> 192.168.101.41:0/2359 -->  mon0 192.168.101.41:6789/0 --
>> mon_command(class list v 0) v1 -- ?+0 0x1d4ce30
>> 192.168.101.41:0/2359<== mon0 192.168.101.41:6789/0 4 ====
>> mon_command_ack([class,list]=0 installed classes:
>> rbd (v1.2 [x86-64]) [active]
>>   v3) v1 ==== 96+0+0 (1704564143 0 0) 0x7f0268000bf0
>> 10.09.29_09:01:44.151874 mon0 ->  'installed classes:
>> rbd (v1.2 [x86-64]) [active]
>> ' (0)
>>
>>
>> -* looks like OK. create new pool named "testpool", and make
>> -* new image named "testdata" in it.
>>
>>
>> # rados lspools
>> (snip)
>> data
>> metadata
>> casdata
>> rbd
>>
>> # rados mkpool testpool
>> (snip)
>> successfully created pool testpool
>>
>>
>> # rbd -p testpool create testdata --size 128
>> :/2428 messenger.start
>> :/2428 -->  mon0 192.168.101.41:6789/0 -- auth(proto 0 30 bytes) v1 --
>> ?+0 0x25cfe10
>> 192.168.101.41:0/2428 learned my addr 192.168.101.41:0/2428
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 1 ====
>> auth_reply(proto 1 0 Success) v1 ==== 24+0+0 (1462504351 0 0)
>> 0x7ff88c000940
>> 192.168.101.41:0/2428 -->  mon0 192.168.101.41:6789/0 --
>> mon_subscribe({monmap=0+}) v1 -- ?+0 0x25d57d0
>> 192.168.101.41:0/2428 -->  mon0 192.168.101.41:6789/0 --
>> mon_subscribe({monmap=0+,osdmap=0}) v1 -- ?+0 0x25d59b0
>> 192.168.101.41:0/2428 -->  mon0 192.168.101.41:6789/0 --
>> mon_subscribe({monmap=0+,osdmap=0}) v1 -- ?+0 0x25d4180
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 2 ==== mon_map v1
>> ==== 191+0+0 (3527398169 0 0) 0x7ff88c000c40
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 3 ====
>> mon_subscribe_ack(300s) v1 ==== 20+0+0 (388814775 0 0) 0x7ff88c000920
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 4 ==== mon_map v1
>> ==== 191+0+0 (3527398169 0 0) 0x7ff88c000bf0
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 5 ====
>> osd_map(5,5) v1 ==== 1153+0+0 (1530501066 0 0) 0x7ff88c000920
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 6 ====
>> mon_subscribe_ack(300s) v1 ==== 20+0+0 (388814775 0 0) 0x7ff88c000920
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 7 ==== mon_map v1
>> ==== 191+0+0 (3527398169 0 0) 0x7ff88c000bf0
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 8 ====
>> osd_map(5,5) v1 ==== 1153+0+0 (1530501066 0 0) 0x7ff88c000920
>> 192.168.101.41:0/2428 -->  osd0 192.168.101.41:6801/2231 --
>> osd_op(client4104.0:1 testdata.rbd [stat 0~0] 4.49b3) v1 -- ?+0
>> 0x25d43c0
>> 192.168.101.41:0/2428<== mon0 192.168.101.41:6789/0 9 ====
>> mon_subscribe_ack(300s) v1 ==== 20+0+0 (388814775 0 0) 0x7ff88c0011e0
>> 192.168.101.41:0/2428<== osd0 192.168.101.41:6801/2231 1 ====
>> osd_op_reply(1 testdata.rbd [stat 0~0] = -2 (No such file or
>> directory)) v1 ==== 98+0+0 (1237653720 0 0) 0x7ff87c000990
>> 192.168.101.41:0/2428 -->  osd0 192.168.101.41:6801/2231 --
>> osd_op(client4104.0:2 rbd_info [write 0~0] 4.573a) v1 -- ?+0 0x25d43c0
>> 192.168.101.41:0/2428<== osd0 192.168.101.41:6801/2231 2 ====
>> osd_op_reply(2 rbd_info [write 0~0] = 0) v1 ==== 94+0+0 (3894334133 0
>> 0) 0x7ff87c000990
>> 192.168.101.41:0/2428 -->  osd0 192.168.101.41:6801/2231 --
>> osd_op(client4104.0:3 rbd_info [call rbd.assign_bid] 4.573a) v1 -- ?+0
>> 0x25d43a0
>
> This last operation never returns. What version are you using? Can you
> add the corresponding osd logs?
> Also, can you verify that /var/lib/ceph/tmp exists and is writable by
> the user running the cosd daemon, and make sure that there is no
> execution restriction there (this path can be configured by the 'osd
> class tmp' config variable).
>
> Thanks,
> Yehuda

-- 
Software Laboratory, Graduate school of Systems and Information
Engineering, Univ. of Tsukuba.
Shingo TAKADA

