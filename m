From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Log spam in master with leveldb messages
Date: Wed, 3 Feb 2016 03:56:45 +0000
Message-ID: <BN1PR02MB055C314B3FB6F2A039815A0F4D00@BN1PR02MB055.namprd02.prod.outlook.com>
References: <BN1PR02MB0552D50CE91834B14896AFAF4D00@BN1PR02MB055.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602022058310.28963@cpach.fuggernut.com>
 <BN1PR02MB055E36916EBBC1C3503A8A1F4D00@BN1PR02MB055.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602022247170.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0094.outbound.protection.outlook.com ([207.46.100.94]:59501
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755181AbcBCD4u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Feb 2016 22:56:50 -0500
In-Reply-To: <alpine.DEB.2.11.1602022247170.28963@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

That would be ideal ,  BTW, it is the filestore kv store which is dumping this log for me not the monitor kv store..


-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Tuesday, February 02, 2016 7:51 PM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org
Subject: RE: Log spam in master with leveldb messages

On Wed, 3 Feb 2016, Somnath Roy wrote:
> In my single osd test, every one sec (~) it's dumping the below chunk..
> In past, was the leveldb log helpful, helped debugging in any environment ?
> If so, we have to keep it I guess :-(..

Hrm, yeah that's a lot.  It makes me nervous to just send it all to /dev/null, though, too.

Perhaps what we should really do is move the monitor kv store to rocksdb, which lets you adjust the logging level.  This will avoid our annoying distro-dependent leveldb issues since it's linked statically. (And get the distro folks up in arms, no doubt...)

sage


> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Tuesday, February 02, 2016 6:00 PM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Log spam in master with leveldb messages
> 
> On Wed, 3 Feb 2016, Somnath Roy wrote:
> > Hi,
> > I saw osd log is spamming with following leveldb messages..
> >
> > 2016-02-02 15:47:01.559086 7f6565fff700  1 leveldb: Compacting 2@0 +
> > 6@1 files
> > 2016-02-02 15:47:01.601971 7f6565fff700  1 leveldb: Generated table
> > #45588: 57785 keys, 2130651 bytes
> > 2016-02-02 15:47:01.645375 7f6565fff700  1 leveldb: Generated table
> > #45589: 58653 keys, 2131228 bytes
> > 2016-02-02 15:47:01.692566 7f6565fff700  1 leveldb: Generated table
> > #45590: 57729 keys, 2131490 bytes
> > 2016-02-02 15:47:01.696688 7f6565fff700  1 leveldb: Generated table
> > #45591: 4131 keys, 167758 bytes
> > 2016-02-02 15:47:01.735986 7f6565fff700  1 leveldb: Generated table
> > #45592: 44341 keys, 1684603 bytes
> > 2016-02-02 15:47:01.783394 7f6565fff700  1 leveldb: Generated table
> > #45593: 57672 keys, 2130488 bytes
> > 2016-02-02 15:47:01.792750 7f6565fff700  1 leveldb: Generated table
> > #45594: 11073 keys, 408429 bytes
> > 2016-02-02 15:47:01.792759 7f6565fff700  1 leveldb: Compacted 2@0 +
> > 6@1 files => 10784647 bytes
> > 2016-02-02 15:47:01.793017 7f6565fff700  1 leveldb: compacted to:
> > files[ 0 7 25 0 0 0 0 ]
> > 2016-02-02 15:47:01.793089 7f6565fff700  1 leveldb: Compacting 1@1 +
> > 4@2 files
> > 2016-02-02 15:47:01.830144 7f6565fff700  1 leveldb: Generated table
> > #45595: 32249 keys, 2130919 bytes
> > 2016-02-02 15:47:01.867178 7f6565fff700  1 leveldb: Generated table
> > #45596: 32228 keys, 2131274 bytes
> > 2016-02-02 15:47:01.908135 7f6565fff700  1 leveldb: Generated table
> > #45597: 32246 keys, 2130944 bytes
> > 2016-02-02 15:47:01.949642 7f6565fff700  1 leveldb: Generated table
> > #45598: 32211 keys, 2130740 bytes
> > 2016-02-02 15:47:01.950102 7f6565fff700  1 leveldb: Generated table
> > #45599: 60 keys, 4062 bytes
> > 2016-02-02 15:47:01.950110 7f6565fff700  1 leveldb: Compacted 1@1 +
> > 4@2 files => 8527939 bytes
> > 2016-02-02 15:47:01.950356 7f6565fff700  1 leveldb: compacted to:
> > files[ 0 6 26 0 0 0 0 ]
> > 2016-02-02 15:47:01.950566 7f6565fff700  1 leveldb: Delete type=2
> > #45577
> >
> > 2016-02-02 15:47:01.951127 7f6565fff700  1 leveldb: Delete type=2
> > #45578
> >
> > I found out now we are redirecting leveldb logs to ceph log based on config option "leveldb_log_to_ceph_log" which is by default true.
> >
> > If there is no strong reason I think it should be by default false.
> 
> The problem is that otherwise the log goes to the db directory and is never rotated.  Or, we set it to /dev/null and we get no logs at all.
> 
> Is the quantity of logging too much?  In rocksdb we can limit by log 
> level (warn/info/debug etc), but not so in leveldb.  :/
> 
> sage
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
