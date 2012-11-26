From: Dan Mick <dan.mick@inktank.com>
Subject: Re: bobtail release candidates
Date: Mon, 26 Nov 2012 09:35:48 -0800
Message-ID: <CAHybQB0CDr7H=Yk5_kDxAW5i-M5CS54at6yRS7XyLbCkRVBGWA@mail.gmail.com>
References: <alpine.DEB.2.00.1211250953400.23552@cobra.newdream.net>
	<50B372DF.3090001@widodh.nl>
	<50B37C0F.60605@inktank.com>
	<50B37E81.9030705@widodh.nl>
	<50B38459.7070906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60657 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933715Ab2KZRfu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 12:35:50 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so2287859wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 09:35:49 -0800 (PST)
In-Reply-To: <50B38459.7070906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

+1

On Mon, Nov 26, 2012 at 7:01 AM, Sam Lang <sam.lang@inktank.com> wrote:
> On 11/26/2012 08:36 AM, Wido den Hollander wrote:
>>
>>
>>
>> On 11/26/2012 10:26 PM, Sam Lang wrote:
>>>
>>> On 11/26/2012 07:47 AM, Wido den Hollander wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 11/26/2012 01:57 AM, Sage Weil wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> There are automatic builds of the prerelease bobtail code available
>>>>> under
>>>>> the 'next' branch.
>>>>>
>>>>> For debs,
>>>>>
>>>>>
>>>>> http://ceph.com/docs/master/install/debian/#add-development-testing-packages
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> For example, for Ubuntu 12.04 precise,
>>>>>     http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/next/
>>>>>
>>>>> And RPMs for el6,
>>>>>
>>>>>
>>>>> http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/RPMS/x86_64/
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Any testing and early feedback is greatly appreciated.
>>>>>
>>>>
>>>> I found another issue which I'm not sure about.
>>>>
>>>> I did the upgrade from 0.48.2 to 0.54 by simply running apt-get upgrade.
>>>>
>>>> The mon restarted fine, but when trying to connect I get:
>>>>
>>>> "-1 unable to authenticate as client.admin"
>>>>
>>>> I ran with debug ms/auth = 20 and I got:
>>>>
>>>> 2012-11-26 14:41:13.039615 7fed35bc7780  1 -- :/0 messenger.start
>>>> 2012-11-26 14:41:13.039878 7fed35bc7780 10 -- :/29176 ready :/29176
>>>> 2012-11-26 14:41:13.039905 7fed32a70700 10 -- :/29176 reaper_entry start
>>>> 2012-11-26 14:41:13.040309 7fed32a70700 10 -- :/29176 reaper
>>>> 2012-11-26 14:41:13.040324 7fed32a70700 10 -- :/29176 reaper done
>>>> 2012-11-26 14:41:13.041255 7fed35bc7780  2 auth: KeyRing::load: loaded
>>>> key file /etc/ceph/ceph.keyring
>>>> 2012-11-26 14:41:13.041943 7fed35bc7780 10 -- :/29176 connect_rank to
>>>> 192.168.6.250:6789/0, creating pipe and registering
>>>> 2012-11-26 14:41:13.042119 7fed35bc7780 10 -- :/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=-1 :0 pgs=0 cs=0
>>>> l=1).register_pipe
>>>> 2012-11-26 14:41:13.042329 7fed35bc7780 10 -- :/29176 get_connection
>>>> mon.0 192.168.6.250:6789/0 new 0x1361670
>>>> 2012-11-26 14:41:13.042152 7fed35bc3700 10 -- :/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=-1 :0 pgs=0 cs=0 l=1).writer:
>>>> state = connecting policy.server=0
>>>> 2012-11-26 14:41:13.042408 7fed35bc3700 10 -- :/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=-1 :0 pgs=0 cs=0 l=1).connect 0
>>>> 2012-11-26 14:41:13.042534 7fed35bc3700 10 -- :/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :0 pgs=0 cs=0 l=1).connecting
>>>> to 192.168.6.250:6789/0
>>>> 2012-11-26 14:41:13.042638 7fed35bc7780  1 -- :/29176 -->
>>>> 192.168.6.250:6789/0 -- auth(proto 0 26 bytes epoch 0) v1 -- ?+0
>>>> 0x1361df0 con 0x13618b0
>>>> 2012-11-26 14:41:13.042690 7fed35bc7780 20 -- :/29176 submit_message
>>>> auth(proto 0 26 bytes epoch 0) v1 remote, 192.168.6.250:6789/0, have
>>>> pipe.
>>>> 2012-11-26 14:41:13.043255 7fed35bc3700 20 -- :/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=0 cs=0 l=1).connect
>>>> read peer addr 192.168.6.250:6789/0 on socket 3
>>>> 2012-11-26 14:41:13.043331 7fed35bc3700 20 -- :/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=0 cs=0 l=1).connect
>>>> peer addr for me is 192.168.6.250:41567/0
>>>> 2012-11-26 14:41:13.043403 7fed35bc3700  1 -- 192.168.6.250:0/29176
>>>> learned my addr 192.168.6.250:0/29176
>>>> 2012-11-26 14:41:13.043548 7fed35bc3700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=0 cs=0 l=1).connect
>>>> sent my addr 192.168.6.250:0/29176
>>>> 2012-11-26 14:41:13.043634 7fed35bc3700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=0 cs=0 l=1).connect
>>>> sending gseq=1 cseq=0 proto=15
>>>> 2012-11-26 14:41:13.043723 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=0 cs=0 l=1).connect
>>>> wrote (self +) cseq, waiting for reply
>>>> 2012-11-26 14:41:13.043942 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=0 cs=0 l=1).connect
>>>> got reply tag 1 connect_seq 1 global_seq 5 proto 15 flags 1
>>>> 2012-11-26 14:41:13.044008 7fed35bc3700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).connect
>>>> success 1, lossy = 1, features 33554431
>>>> 2012-11-26 14:41:13.044147 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).connect
>>>> starting reader
>>>> 2012-11-26 14:41:13.044425 7fed35bc3700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).writer:
>>>> state = open policy.server=0
>>>> 2012-11-26 14:41:13.044500 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).writer
>>>> encoding 1 0x1361df0 auth(proto 0 26 bytes epoch 0) v1
>>>> 2012-11-26 14:41:13.044740 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).writer
>>>> sending 1 0x1361df0
>>>> 2012-11-26 14:41:13.044521 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> reading tag...
>>>> 2012-11-26 14:41:13.044799 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).Pipe:
>>>> write_message:  session security NULL for this pipe.
>>>> 2012-11-26 14:41:13.044842 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1
>>>> l=1).write_message 0x1361df0
>>>> 2012-11-26 14:41:13.045001 7fed35bc3700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).writer:
>>>> state = open policy.server=0
>>>> 2012-11-26 14:41:13.045048 7fed35bc3700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).writer
>>>> sleeping
>>>> 2012-11-26 14:41:13.045779 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got ACK
>>>> 2012-11-26 14:41:13.045864 7fed30a6c700 15 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got ack seq 1
>>>> 2012-11-26 14:41:13.045906 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> reading tag...
>>>> 2012-11-26 14:41:13.045957 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got MSG
>>>> 2012-11-26 14:41:13.046015 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got envelope type=18 src mon.0 front=24 data=0 off 0
>>>> 2012-11-26 14:41:13.046099 7fed30a6c700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> wants 24 from dispatch throttler 0/104857600
>>>> 2012-11-26 14:41:13.046176 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got front 24
>>>> 2012-11-26 14:41:13.046230 7fed30a6c700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1
>>>> l=1).aborted = 0
>>>> 2012-11-26 14:41:13.046269 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got 24 + 0 + 0 byte message
>>>> 2012-11-26 14:41:13.046362 7fed30a6c700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).No
>>>> session security set
>>>> 2012-11-26 14:41:13.046426 7fed30a6c700 10 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got message 1 0x7fed14001660 auth_reply(proto 0 -95 Operation not
>>>> supported) v1
>>>> 2012-11-26 14:41:13.046536 7fed30a6c700 20 -- 192.168.6.250:0/29176
>>>> queue 0x7fed14001660 prio 196
>>>> 2012-11-26 14:41:13.046595 7fed30a6c700 20 -- 192.168.6.250:0/29176 >>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> reading tag...
>>>> 2012-11-26 14:41:13.046625 7fed2226f700  1 -- 192.168.6.250:0/29176 <==
>>>> mon.0 192.168.6.250:6789/0 1 ==== auth_reply(proto 0 -95 Operation not
>>>> supported) v1 ==== 24+0+0 (3632875112 0 0) 0x7fed14001660 con 0x13618b0
>>>> 2012-11-26 14:41:13.046858 7fed2226f700 10 -- 192.168.6.250:0/29176
>>>> dispatch_throttle_release 24 to dispatch throttler 24/104857600
>>>> 2012-11-26 14:41:13.046883 7fed35bc7780 -1 unable to authenticate as
>>>> client.admin
>>>> 2012-11-26 14:41:13.046890 7fed2226f700 20 -- 192.168.6.250:0/29176 done
>>>> calling dispatch on 0x7fed14001660
>>>> 2012-11-26 14:41:13.046904 7fed35bc7780 10 -- 192.168.6.250:0/29176
>>>> shutdown 192.168.6
>>>>
>>>> It seems to read /etc/ceph/ceph.keyring, but then it can't connect?
>>>>
>>>> 192.168.6.250:6789/0 pipe(0x1361670 sd=3 :41567 pgs=5 cs=1 l=1).reader
>>>> got message 1 0x7fed14001660 auth_reply(proto 0 -95 Operation not
>>>> supported) v1
>>>>
>>>> Not sure what that means?
>>>>
>>>> My ceph.conf is minimal as possible, there is not even an [global]
>>>> section and my mon section only lists one monitor, no other options.
>>>>
>>>> I tried to keep everything to its defaults to keep the setup simple.
>>>>
>>>> Suggestions?
>>>>
>>>
>>> Hi Wido,
>>>
>>> The defaults for auth parameters changed in bobtail.  With no settings
>>> in your config, you probably weren't using auth, but after the upgrade,
>>> the defaults became cephx.
>>>
>>> I think you can fix it by disabling auth (which is what you had in 0.48):
>>>
>>> [global]
>>> auth cluster required = none
>>> auth service required = none
>>>
>>>
>>> Here's the commit where the options changed:
>>>
>>>
>>> https://github.com/ceph/ceph/commit/66bda162e1acad34d37fa97e3a91e277df174f42
>>>
>>>
>>
>> Argh, should have spotted this one. I thought this had changed in 0.48.2
>> already, but that was my mistake.
>>
>> I had to add "auth client required = none" on my client though, since
>> that still tried cephx.
>
>
> This is going to trip up a lot of people.  On an upgrade from 0.48 to 0.54,
> can we check that the config is setup this way and either warn the user or
> add the right config options on their behalf?
>
> -sam
>
>
>>
>> Works now!
>>
>> Thanks,
>>
>> Wido
>>
>>>
>>> -sam
>>>
>>>> Wido
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>> Thanks!
>>>>> sage
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
