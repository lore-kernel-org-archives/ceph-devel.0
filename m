From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Mon, 23 Jan 2012 10:44:20 -0800
Message-ID: <CAF3hT9AWjfzsPq5wwdy+PtqaM+=XCNh0MmCZr_LAAxi8-OghAg@mail.gmail.com>
References: <4F1ABD5C.1000907@smart-weblications.de>
	<4F1AE704.6010005@widodh.nl>
	<4F1AE824.3000006@smart-weblications.de>
	<CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com>
	<4F1AF955.9030103@smart-weblications.de>
	<CAC-hyiG6-CVi1F6iwZQNhReMoRvYg3K-NGn4h9s8LOJPEHNR7A@mail.gmail.com>
	<4F1C0047.6030908@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56632 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2AWSoU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2012 13:44:20 -0500
Received: by iacb35 with SMTP id b35so4095632iac.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2012 10:44:20 -0800 (PST)
In-Reply-To: <4F1C0047.6030908@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Sun, Jan 22, 2012 at 4:25 AM, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
> Am 22.01.2012 02:19, schrieb Yehuda Sadeh Weinraub:
>> On Sat, Jan 21, 2012 at 9:43 AM, Smart Weblications GmbH - Florian
>> Wiessner <f.wiessner@smart-weblications.de> wrote:
>>>
>>> 2) v1 -- ?+0 0x184dc00
>>> 2012-01-21 18:42:36.758683 7f60e26e0700 -- 192.168.0.6:6789/0 --> mon.3
>>> 192.168.0.7:6789/0 -- mon_probe(probe 6bac7900-17c9-47c4-8b8e-f3dd7c22c73d name
>>> 2) v1 -- ?+0 0x184d900
>>> 2012-01-21 18:42:36.759270 7f60e6d62700 cephx: verify_authorizer_reply exception
>>> in decode_decrypt with AQAM+RpP0JI9LRAAWyy1Flf5X6RUVxEjhAEFtg==
>>> 2012-01-21 18:42:36.759287 7f60e6d62700 -- 192.168.0.6:6789/0 >>
>>> 192.168.0.4:6789/0 pipe(0xc91500 sd=9 pgs=0 cs=0 l=0).failed verifying authorize
>>> reply
>>> ^C
>>>
>>>
>> Can you verify that there's no 'auth supported' line in your mon ceph.conf?
>>
>> Also, try running (with correct <ceph.conf>):
>>
>> # ceph-conf --lookup -c <ceph.conf> 'auth supported' --name mon.2
>>
>> or just:
>>
>> # ceph-conf --lookup -c <ceph.conf> 'auth supported'
> node04:/tmp# ceph-conf --lookup -c /etc/ceph/ceph.conf 'auth supported' --name mon.2
> none
> node04:/tmp# ceph-conf --lookup -c /etc/ceph/ceph.conf 'auth supported' --name mon.0
> none
>
>
> i now explicitly set auth supported = none, but still it is not working :(

Have you previously used cephx? I notice that it was a commented-out
line in your initial conf. :) I tried to reproduce quickly by creating
a v0.39 system and upgrading to v0.40 and didn't see any trouble.

Otherwise we'll need to start generating very explicit logs and stuff.
-Greg
