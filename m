From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Thu, 24 Nov 2011 13:03:28 -0800
Message-ID: <CAF3hT9CydOZnDJzG99UkFxj2hGC_08wpZETFAd-jKR_eeXXyRA@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
	<CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
	<CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
	<CAND_vCYXQQ4bokmAvV+Z46UT7_Pygd_h0kwXSch_r+HDg5W25Q@mail.gmail.com>
	<CAF3hT9AHSHf5Gd+9_AydBDWj2if01iNLjmQ5_PXLPna_-GwXQg@mail.gmail.com>
	<CAND_vCbSNbqL8faw0yAYp3guahexo7sAr0X1cQGS5rRZv=71xw@mail.gmail.com>
	<CAF3hT9DsujHNTBiAc=Fm2Vu=FsKBSW4nouwg0QPa73kfHF0mtg@mail.gmail.com>
	<CAND_vCZZjvmKYw7dfiqv_geY-upKLNAz_JVZ0_yr5aKQ6x_jKw@mail.gmail.com>
	<CAF3hT9Dh-byw6h5R633GPxxiMgGmkCtd-MpzRSARoka2RYw88Q@mail.gmail.com>
	<CAND_vCZccYerOQmU9hS3N=hKyjjYnNqTXtTw-Dgw0hUz67Tauw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52245 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab1KXVD3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Nov 2011 16:03:29 -0500
Received: by yenl6 with SMTP id l6so547375yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Nov 2011 13:03:28 -0800 (PST)
In-Reply-To: <CAND_vCZccYerOQmU9hS3N=hKyjjYnNqTXtTw-Dgw0hUz67Tauw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaofei Du <xiaofei.du008@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 24, 2011 at 12:31 PM, Xiaofei Du <xiaofei.du008@gmail.com> =
wrote:
> This means no matter how many clients I have I should always get
> around 79MB/s, right? This sounds reasonable. Thanks for the
> explanation. So do you guys have plans to solve this "unbalanced
> cluster" problem?
Eventually. Right now Ceph is pretty config-heavy, unfortunately. So
like I said, you can change the weights of the slow nodes =97 this will
map less of the data to them, so they have fewer writes and reads. But
even then you're going to be stuck pretty low due to your disk write
bandwidth. On a modern disk that doesn't matter so much since they can
push two simultaneous 50MB/s+ streams (ie, one 50MB/s journal and one
50MB/s data store), but even so we generally recommend separate
spindles for the journal.

> I guess several other distributed file systems have
> the same issue. HDFS has this issue too. I guess the solution is to
> use stable disk IO bandwidth hardware. If that couldn't be guaranteed=
,
> you need to detect slow nodes and kick them out of the cluster.
I'm not sure how other systems handle it =97=A0many don't, HDFS might o=
r
might not. But as I look at the description of how HDFS replicates
data it looks to me like it matters less.
http://hadoop.apache.org/common/docs/current/hdfs_design.html#Robustnes=
s
indicates that all data is written to a client-local file, then
(asynchronously from the client's write) it is written out to the
first DataNode, which copies the data to the second, which copies to
the third, etc. But in this scheme the file doesn't need to be fully
replicated to each DataNode for the client to close the file and
consider it data-safe.
These are the appropriate set of data consistency choices for HDFS,
but Ceph is designed to satisfy consistency requirements for a much
more stringent set of needs. :)

>
>> Are you using ceph-fuse or the kernel client? And if it's the kernel
>> client, what version?
> I am using ceph-fuse
Bah humbug. :( I've created http://tracker.newdream.net/issues/1752 to
keep track of this issue; it'll be properly prioritized next week.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
