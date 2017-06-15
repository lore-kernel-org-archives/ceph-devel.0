From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: another scrub bug? blocked for > 10240.948831 secs
Date: Thu, 15 Jun 2017 14:49:05 +0200
Message-ID: <fba1ba38-cab0-3b9f-daf2-1e19c69590eb@brockmann-consult.de>
References: <94127293-3ba3-8bb8-db43-604b6a54eb55@brockmann-consult.de>
 <alpine.DEB.2.11.1704171316150.10661@piezo.novalocal>
 <456cafe7-ecaa-5c62-ca82-6c09a2b06ae7@brockmann-consult.de>
 <alpine.DEB.2.11.1704201421120.6575@piezo.novalocal>
 <d0b1c505-8ccd-dfbf-2dd8-c44fc3f7b96e@brockmann-consult.de>
 <alpine.DEB.2.11.1704201617120.6575@piezo.novalocal>
 <b8e72ba6-919b-e9f2-9fd3-577cb7ab6389@brockmann-consult.de>
 <27bfebcd-6a91-bd00-82c5-e56af6775d52@brockmann-consult.de>
 <cae31cf5-344a-d6f6-c810-4f0aec031ae4@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:56426 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdFOMtM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 08:49:12 -0400
In-Reply-To: <cae31cf5-344a-d6f6-c810-4f0aec031ae4@brockmann-consult.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 05/23/17 11:29, Peter Maloney wrote:
> On 04/28/17 09:24, Peter Maloney wrote:
>>
>> This still happens in 10.2.7
>>
>>> 2017-04-28 04:41:59.343443 osd.9 10.3.0.132:6808/2704 18 : cluster
>>> [WRN] slow request 10.040822 seconds old, received at 2017-04-28
>>> 04:41:49.302552: replica scrub(pg:
>>> 4.145,from:0'0,to:93267'6832180,epoch:93267,start:4:a2d2c99e:::rbd_data.4bf687238e1f29.000000000000f7a3:0,end:4:a2d2dcd6:::rbd_data.46820b238e1f29.000000000000bfbc:f25e,chunky:1,deep:0,seed:4294967295,version:6)
>>> currently reached_pg
>>> ...
>>> 2017-04-28 06:07:09.975902 osd.9 10.3.0.132:6808/2704 36 : cluster
>>> [WRN] slow request 5120.673291 seconds old, received at 2017-04-28
>>> 04:41:49.302552: replica scrub(pg: 4.145,from:0'0,to:93
>>> 267'6832180,epoch:93267,start:4:a2d2c99e:::rbd_data.4bf687238e1f29.000000000000f7a3:0,end:4:a2d2dcd6:::rbd_data.46820b238e1f29.000000000000bfbc:f25e,chunky:1,deep:0,seed:4294967295,version:
>> and there are snaps created and removed around that time.
> So I changed some settings a long time ago for unrelated reasons, and
> now it's far more rare (only happened once since, but had many more than
> 1 request blocked).
>
> Here are the old settings:
>
>> osd deep scrub stride = 524288  # 512 KiB
>> osd scrub chunk min = 1
>> osd scrub chunk max = 1
>> osd scrub sleep = 0.5
> And the new:
>> osd deep scrub stride = 4194304  # 4 MiB
>> osd scrub chunk min = 20
>> osd scrub chunk max = 25
>> osd scrub sleep = 4

So, it happened again today. This time the log said "currently waiting
for scrub" instead, and a client was affected... the VM would work for a
short time, then hang, then need kill -9, and work for a short time
again after restart. Restarting the osd which had the slow request in
its log (which cancels the scrub) made the VM work again without
restarting it. So now we're making a watchdog script to restart osds
that have that log.

Here are some log snippets:
> 2017-06-15 08:29:40.953017 7f31e2294700  0 log_channel(cluster) log
> [WRN] : 1 slow requests, 1 included below; oldest blocked for >
> 10.956689 secs
> 2017-06-15 08:29:40.953030 7f31e2294700  0 log_channel(cluster) log
> [WRN] : slow request 10.956689 seconds old, received at 2017-06-15
> 08:29:29.995548: osd_op(client.5057555.0:64922641 4.a565eedb
> rbd_data.4bf687238e1f29.000000000000b1dc [set-alloc-hint object_size
> 4194304 write_size 4194304,writefull 0~4194304] snapc 11e5f=[11e5f]
> ack+ondisk+write+known_if_redirected e123792) currently waiting for scrub

> 2017-06-15 12:50:25.100735 7f31e2294700  0 log_channel(cluster) log
> [WRN] : 4 slow requests, 1 included below; oldest blocked for >
> 15655.105139 secs
> 2017-06-15 12:50:25.100745 7f31e2294700  0 log_channel(cluster) log
> [WRN] : slow request 10240.544155 seconds old, received at 2017-06-15
> 09:59:44.556532: osd_op(client.8047070.0:182487 4.5
> 734eedb rbd_data.4bf687238e1f29.000000000000370b [set-alloc-hint
> object_size 4194304 write_size 4194304,writefull 0~4194304] snapc
> 11e5f=[11e5f] ack+ondisk+write+known_if_redirected e123820
> ) currently waiting for scrub
(and snaps are created and removed on all images daily)


Why should anything ever wait for scrub? Shouldn't a scrub just use the
data asynchronously, and if a client changes the data during scrub, you
can asynchronously skip that overwritten part (unless it's in a snap,
then scrub the copy when done).

And shouldn't it have timed out after 4 hours? What does the config
option "mon_scrub_timeout" (default "300") do? It's not documented here
http://docs.ceph.com/docs/master/rados/configuration/mon-config-ref/

-- 

--------------------------------------------
Peter Maloney
Brockmann Consult
Max-Planck-Str. 2
21502 Geesthacht
Germany
Tel: +49 4152 889 300
Fax: +49 4152 889 333
E-mail: peter.maloney@brockmann-consult.de
Internet: http://www.brockmann-consult.de
--------------------------------------------

