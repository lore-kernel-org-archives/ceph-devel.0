From: Jianjian Huo-SSI <jianjian.huo@ssi.samsung.com>
Subject: RE: rocksdb related build error
Date: Tue, 03 May 2016 18:52:35 +0000
Message-ID: <3F3468645DC82146857A5E1C91E23F4B1B2A0A73@SSIEXCH-MB3.ssi.samsung.com>
References: <CAF1ivSbg-n6o2_mHzCS_Y9rDZTD+ySess8TqOto-ox7MV012bA@mail.gmail.com>
 <alpine.DEB.2.11.1605030824500.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:42423 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934490AbcECTCk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 15:02:40 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O6M00MD673O0550@usmailout4.samsung.com> for
 ceph-devel@vger.kernel.org; Tue, 03 May 2016 14:52:36 -0400 (EDT)
In-reply-to: <alpine.DEB.2.11.1605030824500.26967@cpach.fuggernut.com>
Content-language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ming Lin <minggr@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, John Spray <john.spray@redhat.com>

Hi Sage,

When we are going to pull in latest RocksDB release? We are still using code base from last year.
RocksDB stops working with Bluestore after 6 hours writes, maybe it's related to old RocksDB code or recycled log files?
http://tracker.ceph.com/issues/15600

Jianjian

On Tue, May 3, 2016 at 5:26 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 3 May 2016, Ming Lin wrote:
>> Hi John,
>>
>> I got rocksdb related build error (commit bb7d9c15).
>> Any hint to fix it?
>>
>> It's OK if I build in the ceph source tree.
>
> Out of tree builds don't work currently with autotools.
>
> sage
>
>
>> mlin@ssi:~/ceph$ ./autogen.sh
>> ...
>>
>> mlin@ssi:~/ceph-build$ ../ceph/configure
>> ...
>>
>> mlin@ssi:~/ceph-build$ make -j8
>> ...
>> make[3]: Entering directory `/home/mlin/ceph-build/src'
>> cd rocksdb && CC="gcc" CXX="g++" EXTRA_CXXFLAGS=-fPIC PORTABLE=1 make
>> -j8 static_lib
>> /bin/bash: line 0: cd: rocksdb: No such file or directory
>> make[3]: *** [rocksdb/librocksdb.a] Error 1
>> make[3]: *** Waiting for unfinished jobs....
>> make[3]: Leaving directory `/home/mlin/ceph-build/src'
>> make[2]: *** [all-recursive] Error 1
>> make[2]: Leaving directory `/home/mlin/ceph-build/src'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/home/mlin/ceph-build/src'
>> make: *** [all-recursive] Error 1
>>
>>
>> mlin@ssi:~/ceph-build$ ls src/
>> acconfig.h  client      crush         java             kv
>>  log       mount     os        rbd_fuse    test
>> arch        cls         erasure-code  journal          librados
>>  Makefile  msg       osd       rbd_replay  tools
>> auth        common      global        json_spirit      libradosstriper
>>  mds       objclass  osdc      rgw         tracing
>> civetweb    compressor  gmock         key_value_store  librbd
>>  mon       ocf       perfglue  stamp-h1    xxHash
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
