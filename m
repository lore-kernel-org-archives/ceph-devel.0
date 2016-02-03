From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Log spam in master with leveldb messages
Date: Wed, 3 Feb 2016 10:13:03 +0100
Message-ID: <CABZ+qqkgLnquPLRtXzS+YzDfg64oUtAkdjdpqorjJTNvFUGC1Q@mail.gmail.com>
References: <BN1PR02MB0552D50CE91834B14896AFAF4D00@BN1PR02MB055.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602022058310.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36136 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbcBCJNq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 04:13:46 -0500
Received: by mail-lb0-f178.google.com with SMTP id dx2so8110404lbd.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 01:13:45 -0800 (PST)
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com. [209.85.215.49])
        by smtp.gmail.com with ESMTPSA id 34sm770434lfv.35.2016.02.03.01.13.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Feb 2016 01:13:43 -0800 (PST)
Received: by mail-lf0-f49.google.com with SMTP id l143so9350474lfe.2
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 01:13:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602022058310.28963@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 3, 2016 at 2:59 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 3 Feb 2016, Somnath Roy wrote:
>> Hi,
>> I saw osd log is spamming with following leveldb messages..
>>
>> 2016-02-02 15:47:01.559086 7f6565fff700  1 leveldb: Compacting 2@0 + 6@1 files
>> 2016-02-02 15:47:01.601971 7f6565fff700  1 leveldb: Generated table #45588: 57785 keys, 2130651 bytes
>> 2016-02-02 15:47:01.645375 7f6565fff700  1 leveldb: Generated table #45589: 58653 keys, 2131228 bytes
>> 2016-02-02 15:47:01.692566 7f6565fff700  1 leveldb: Generated table #45590: 57729 keys, 2131490 bytes
>> 2016-02-02 15:47:01.696688 7f6565fff700  1 leveldb: Generated table #45591: 4131 keys, 167758 bytes
>> 2016-02-02 15:47:01.735986 7f6565fff700  1 leveldb: Generated table #45592: 44341 keys, 1684603 bytes
>> 2016-02-02 15:47:01.783394 7f6565fff700  1 leveldb: Generated table #45593: 57672 keys, 2130488 bytes
>> 2016-02-02 15:47:01.792750 7f6565fff700  1 leveldb: Generated table #45594: 11073 keys, 408429 bytes
>> 2016-02-02 15:47:01.792759 7f6565fff700  1 leveldb: Compacted 2@0 + 6@1 files => 10784647 bytes
>> 2016-02-02 15:47:01.793017 7f6565fff700  1 leveldb: compacted to: files[ 0 7 25 0 0 0 0 ]
>> 2016-02-02 15:47:01.793089 7f6565fff700  1 leveldb: Compacting 1@1 + 4@2 files
>> 2016-02-02 15:47:01.830144 7f6565fff700  1 leveldb: Generated table #45595: 32249 keys, 2130919 bytes
>> 2016-02-02 15:47:01.867178 7f6565fff700  1 leveldb: Generated table #45596: 32228 keys, 2131274 bytes
>> 2016-02-02 15:47:01.908135 7f6565fff700  1 leveldb: Generated table #45597: 32246 keys, 2130944 bytes
>> 2016-02-02 15:47:01.949642 7f6565fff700  1 leveldb: Generated table #45598: 32211 keys, 2130740 bytes
>> 2016-02-02 15:47:01.950102 7f6565fff700  1 leveldb: Generated table #45599: 60 keys, 4062 bytes
>> 2016-02-02 15:47:01.950110 7f6565fff700  1 leveldb: Compacted 1@1 + 4@2 files => 8527939 bytes
>> 2016-02-02 15:47:01.950356 7f6565fff700  1 leveldb: compacted to: files[ 0 6 26 0 0 0 0 ]
>> 2016-02-02 15:47:01.950566 7f6565fff700  1 leveldb: Delete type=2 #45577
>>
>> 2016-02-02 15:47:01.951127 7f6565fff700  1 leveldb: Delete type=2 #45578
>>
>> I found out now we are redirecting leveldb logs to ceph log based on config option "leveldb_log_to_ceph_log" which is by default true.
>>
>> If there is no strong reason I think it should be by default false.
>
> The problem is that otherwise the log goes to the db directory and is
> never rotated.  Or, we set it to /dev/null and we get no logs at all.
>

What about writing them to a separate file in /var/log/ceph:

  leveldb log = /var/log/ceph/ceph-osd.$id.leveldb.log

(we used to do this on the mons in the firefly days -- I only just
noticed today that the config option changed in hammer).

--

dan
