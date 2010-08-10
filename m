From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: osd crashed after adding new osd
Date: Wed, 11 Aug 2010 01:27:18 +0800
Message-ID: <AANLkTiksxQ6EGpgBq7jZfR2KQdV4G=9eoK7ASBfDNtcQ@mail.gmail.com>
References: <AANLkTi=bUW_twak9n_jwcp2VkrRN_pztEzkUMzW72z5=@mail.gmail.com>
	<1281454926.2812.3.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44358 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440Ab0HJR1U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 13:27:20 -0400
Received: by wyb32 with SMTP id 32so944006wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Aug 2010 10:27:18 -0700 (PDT)
In-Reply-To: <1281454926.2812.3.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi Wido,

I am running unstable branch (commit: b72c1bb6e9b77e1ab6c2) dated July 30.
I just uploaded the core dumps to

http://home.anet.net.tw/cycbbb/coredumps/core.2580.gz
http://home.anet.net.tw/cycbbb/coredumps/core.2602.gz



On Tue, Aug 10, 2010 at 11:42 PM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi Henry,
>
> Is there a core-dump of these crashes in /? If so, these could help
> finding the cause of this.
>
> See: http://ceph.newdream.net/wiki/Troubleshooting
>
> And btw, which version of Ceph are you running?
>
> Wido
>
> On Tue, 2010-08-10 at 21:09 +0800, Henry C Chang wrote:
>> Hi,
>>
>> I have a ceph cluster: 3 (mon+osd) and 2 (mds).
>> When I tried to add the 4th osd to the cluster, osd0 and osd1 crashed.
>> The error logs are attached.
>>
>> My procedure to add the 4th osd is:
>>
>> add [osd3] in the conf file: /etc/ceph/ceph.conf
>> ceph -c /etc/ceph/ceph.conf mon getmap -o /tmp/monmap
>> cosd -c /etc/ceph/ceph.conf -i 3 --mkfs --monmap /tmp/monmap
>> ceph -c /etc/ceph/ceph.conf osd setmaxosd 4
>> osdmaptool --createsimple 4 --clobber /tmp/osdmap.junk --export-crush
>> /tmp/crush.new
>> ceph -c /etc/ceph.conf osd setcrushmap -i /tmp/crush.new
>> /etc/init.d/ceph -c
>> /etc/ceph/d2c5d946-b888-40b3-aac2-adda05477a81.conf start osd
>>
>> Is my procedure to add an osd incorrect?
>>
>> Thanks,
>> Henry
>
>
