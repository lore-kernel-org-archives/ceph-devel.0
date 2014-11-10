From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw buffer overflow
Date: Mon, 10 Nov 2014 14:49:58 -0800
Message-ID: <CABBk=J_i_kwpGsaztD5+k_e9ZdOb5keCfuBkFziXEYDCAhBsZg@mail.gmail.com>
References: <CAMWPydSW-JAPrRx1ozzW-=b9F==Zs-x-iFTy47RwatKa0c_ggA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32948 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaKJWt7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 17:49:59 -0500
Received: by mail-ig0-f172.google.com with SMTP id a13so17492069igq.5
        for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 14:49:58 -0800 (PST)
In-Reply-To: <CAMWPydSW-JAPrRx1ozzW-=b9F==Zs-x-iFTy47RwatKa0c_ggA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 10, 2014 at 12:45 PM, Mustafa Muhammad
<mustafaa.alhamdaani@gmail.com> wrote:
> Hi,
> I am using radosgw to connect to my ceph cluster, I am testing it and
> with large number of requests, I get:
> *** buffer overflow detected ***: /bin/radosgw terminated
> in the syslog.
> I use CentOS 7, and this is the some of the last lines of the log:
>
>  ceph version 0.80.5 (38b73c67d375a2552d8ed67843c8a65c2c0feba6)
>  1: /bin/radosgw() [0x5daaf6]
>  2: (()+0xf130) [0x7f177cd4e130]
>  3: (gsignal()+0x39) [0x7f177bf905c9]
>  4: (abort()+0x148) [0x7f177bf91cd8]
>  5: (()+0x75dd7) [0x7f177bfd0dd7]
>  6: (__fortify_fail()+0x37) [0x7f177c0688f7]
>  7: (()+0x10bac0) [0x7f177c066ac0]
>  8: (()+0x10d867) [0x7f177c068867]
>  9: (OS_Accept()+0xc1) [0x7f177d4a18b1]
>  10: (FCGX_Accept_r()+0x9c) [0x7f177d49f91c]
>  11: (RGWFCGXProcess::run()+0x1c8) [0x4c9318]
>  12: (RGWProcessControlThread::entry()+0xe) [0x4cc25e]
>  13: (()+0x7df3) [0x7f177cd46df3]
>  14: (clone()+0x6d) [0x7f177c05101d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- logging levels ---
>    0/ 5 none
>    0/ 1 lockdep
>    0/ 1 context
>    1/ 1 crush
>    1/ 5 mds
>    1/ 5 mds_balancer
>    1/ 5 mds_locker
>    1/ 5 mds_log
>    1/ 5 mds_log_expire
>    1/ 5 mds_migrator
>    0/ 1 buffer
>    0/ 1 timer
>    0/ 1 filer
>    0/ 1 striper
>    0/ 1 objecter
>    0/ 5 rados
>    0/ 5 rbd
>    0/ 5 journaler
>    0/ 5 objectcacher
>    0/ 5 client
>    0/ 5 osd
>    0/ 5 optracker
>    0/ 5 objclass
>    1/ 3 filestore
>    1/ 3 keyvaluestore
>    1/ 3 journal
>    0/ 5 ms
>    1/ 5 mon
>    0/10 monc
>    1/ 5 paxos
>    0/ 5 tp
>    1/ 5 auth
>    1/ 5 crypto
>    1/ 1 finisher
>    1/ 5 heartbeatmap
>    1/ 5 perfcounter
>    1/ 5 rgw
>    1/ 5 javaclient
>    1/ 5 asok
>    1/ 1 throttle
>   -2/-2 (syslog threshold)
>   -1/-1 (stderr threshold)
>   max_recent     10000
>   max_new         1000
>   log_file /var/log/ceph/radosgw.log
> --- end dump of recent events ---

This might be an issue with the fastcgi library that radosgw uses (not
sure which one and what version is used in centos 7). How many
concurrent requests does it handle when it fails? You can try testing
it with the standalone web server (civetweb), see how it behaves.
>
> P.S. I get lots of errors like:
> RGWObjManifest::operator++(): result: ofs=20971520 stripe_ofs=20971520
> part_ofs=0 rule->part_size=104857600

This is just a too verbose log message, not necessarily pointing at
anything wrong.

Thanks,
Yehuda
