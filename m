From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw buffer overflow
Date: Wed, 12 Nov 2014 10:43:26 -0800
Message-ID: <CABBk=J9cBh7vUUd0KVMp47EuRf4y8S=sNN6AzQbmFmwc=oDqPw@mail.gmail.com>
References: <CAMWPydSW-JAPrRx1ozzW-=b9F==Zs-x-iFTy47RwatKa0c_ggA@mail.gmail.com>
	<CABBk=J_i_kwpGsaztD5+k_e9ZdOb5keCfuBkFziXEYDCAhBsZg@mail.gmail.com>
	<CAMWPydSenZzKD+zwbGTi_ZS3KU_bYJTkC4gdk4ojdgsU6dO1gQ@mail.gmail.com>
	<CAMc8nAUa3YCmoyeDdEDf8ACKVArPxa-M=mvkSMv1tU7y=mh7rw@mail.gmail.com>
	<CAMWPydQ3oTd5OAarsPLT6vSkXpGF7YAvrau0gsRzznuLtDXHYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61657 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaKLSn0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 13:43:26 -0500
Received: by mail-ie0-f180.google.com with SMTP id y20so14233142ier.39
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 10:43:26 -0800 (PST)
In-Reply-To: <CAMWPydQ3oTd5OAarsPLT6vSkXpGF7YAvrau0gsRzznuLtDXHYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 11, 2014 at 5:19 AM, Mustafa Muhammad
<mustafaa.alhamdaani@gmail.com> wrote:
> On Tue, Nov 11, 2014 at 3:44 PM, pushpesh sharma <pushpesh.eck@gmail.com> wrote:
>> Mustafa,
>>
>> You can get rid of these messages by setting your rgw_obj_chunk_size >=
>> 'Object size your are testing with'. It will also increase the performance.
>
> Thank you for answering, I am using multiple objects (ranging from 500
> MBs to 2 GBs), so I put "rgw obj chunk size = 4G" in
> /etc/ceph/ceph.conf? 4G is OK right? and what is the upper limit?

No, you shouldn't put that much for the chunk size. This will
effectively disable striping, and cause a significant memory
consumption per thread.

Yehuda

>
>>
>> For CivetWeb you just need to set 'rgw_frontends="civetweb port=8080" , you
>> can tune some of rgw_ config with it. I find the most useful one with
>> civetweb is 'rgw_thread_pool_size' which maps to 'num_op_thread' in civetweb
>> configs. I find value of '128' good enough, but you can play around.
> It worked, thank you, but it is very slow comared to apache (but
> lighter) and nginx, after changing object chunk size, it improved alot
> (from about 100 MB/s to about 100 MB/s, still slower that nginx (about
> 150~200 MB/s).
>
>>
>> Yehuda,
>> I didnt find any way to disable access logs in CivetWeb. I set all the
>> *enable_logs parameter to false.
>> I am not able to properly setup fcgi multiple instance on same host, any
>> information would be useful.
>>
>>
>> On Tue, Nov 11, 2014 at 4:40 PM, Mustafa Muhammad
>> <mustafaa.alhamdaani@gmail.com> wrote:
>>>
>>> On Tue, Nov 11, 2014 at 1:49 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>>> > On Mon, Nov 10, 2014 at 12:45 PM, Mustafa Muhammad
>>> > <mustafaa.alhamdaani@gmail.com> wrote:
>>> >> Hi,
>>> >> I am using radosgw to connect to my ceph cluster, I am testing it and
>>> >> with large number of requests, I get:
>>> >> *** buffer overflow detected ***: /bin/radosgw terminated
>>> >> in the syslog.
>>> >> I use CentOS 7, and this is the some of the last lines of the log:
>>> >>
>>> >>  ceph version 0.80.5 (38b73c67d375a2552d8ed67843c8a65c2c0feba6)
>>> >>  1: /bin/radosgw() [0x5daaf6]
>>> >>  2: (()+0xf130) [0x7f177cd4e130]
>>> >>  3: (gsignal()+0x39) [0x7f177bf905c9]
>>> >>  4: (abort()+0x148) [0x7f177bf91cd8]
>>> >>  5: (()+0x75dd7) [0x7f177bfd0dd7]
>>> >>  6: (__fortify_fail()+0x37) [0x7f177c0688f7]
>>> >>  7: (()+0x10bac0) [0x7f177c066ac0]
>>> >>  8: (()+0x10d867) [0x7f177c068867]
>>> >>  9: (OS_Accept()+0xc1) [0x7f177d4a18b1]
>>> >>  10: (FCGX_Accept_r()+0x9c) [0x7f177d49f91c]
>>> >>  11: (RGWFCGXProcess::run()+0x1c8) [0x4c9318]
>>> >>  12: (RGWProcessControlThread::entry()+0xe) [0x4cc25e]
>>> >>  13: (()+0x7df3) [0x7f177cd46df3]
>>> >>  14: (clone()+0x6d) [0x7f177c05101d]
>>> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>> >> needed to interpret this.
>>> >>
>>> >> --- logging levels ---
>>> >>    0/ 5 none
>>> >>    0/ 1 lockdep
>>> >>    0/ 1 context
>>> >>    1/ 1 crush
>>> >>    1/ 5 mds
>>> >>    1/ 5 mds_balancer
>>> >>    1/ 5 mds_locker
>>> >>    1/ 5 mds_log
>>> >>    1/ 5 mds_log_expire
>>> >>    1/ 5 mds_migrator
>>> >>    0/ 1 buffer
>>> >>    0/ 1 timer
>>> >>    0/ 1 filer
>>> >>    0/ 1 striper
>>> >>    0/ 1 objecter
>>> >>    0/ 5 rados
>>> >>    0/ 5 rbd
>>> >>    0/ 5 journaler
>>> >>    0/ 5 objectcacher
>>> >>    0/ 5 client
>>> >>    0/ 5 osd
>>> >>    0/ 5 optracker
>>> >>    0/ 5 objclass
>>> >>    1/ 3 filestore
>>> >>    1/ 3 keyvaluestore
>>> >>    1/ 3 journal
>>> >>    0/ 5 ms
>>> >>    1/ 5 mon
>>> >>    0/10 monc
>>> >>    1/ 5 paxos
>>> >>    0/ 5 tp
>>> >>    1/ 5 auth
>>> >>    1/ 5 crypto
>>> >>    1/ 1 finisher
>>> >>    1/ 5 heartbeatmap
>>> >>    1/ 5 perfcounter
>>> >>    1/ 5 rgw
>>> >>    1/ 5 javaclient
>>> >>    1/ 5 asok
>>> >>    1/ 1 throttle
>>> >>   -2/-2 (syslog threshold)
>>> >>   -1/-1 (stderr threshold)
>>> >>   max_recent     10000
>>> >>   max_new         1000
>>> >>   log_file /var/log/ceph/radosgw.log
>>> >> --- end dump of recent events ---
>>> >
>>> > This might be an issue with the fastcgi library that radosgw uses (not
>>> > sure which one and what version is used in centos 7). How many
>>> > concurrent requests does it handle when it fails? You can try testing
>>> > it with the standalone web server (civetweb), see how it behaves.
>>> I think I am using fcgi 2.4.0, I use nginx with "fastcgi_buffering
>>> off;" so it doesn't touch the disks.
>>> Somtimes it handles 4000 connections, sometimes 1000.
>>> I want to test civetweb but couldn't find any info about how to do so,
>>> can you please give me a link to docs or something.
>>>
>>> Thank you.
>>>
>>> Mustafa
>>> >>
>>> >> P.S. I get lots of errors like:
>>> >> RGWObjManifest::operator++(): result: ofs=20971520 stripe_ofs=20971520
>>> >> part_ofs=0 rule->part_size=104857600
>>> >
>>> > This is just a too verbose log message, not necessarily pointing at
>>> > anything wrong.
>>> >
>>> > Thanks,
>>> > Yehuda
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>> --
>> -Pushpesh
>>
>
>
>
> Now about the buffer overflow, should I file a bug?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
