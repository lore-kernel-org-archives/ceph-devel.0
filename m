From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 12:50:02 -0500
Message-ID: <4FC50C4A.4090101@inktank.com>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56130 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab2E2RuI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 13:50:08 -0400
Received: by obbtb18 with SMTP id tb18so7157508obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 10:50:07 -0700 (PDT)
In-Reply-To: <4FC4E0A9.8010008@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

On 05/29/2012 09:43 AM, Stefan Priebe - Profihost AG wrote:
> Am 29.05.2012 15:39, schrieb Yann Dupont:
>> On 29/05/2012 11:46, Stefan Priebe - Profihost AG wrote:
>>> It would be really nice if somebody from inktank can comment this whole
>>> sitation.
>>>
>> Hello.
>> I think I have the same bug :
>>
>> My setup is with 8 OSD nodes, 3 MDS (1 active)&  3 MON.
>> All my machines are debian, using a custom 3.4.0 kernel. Ceph is
>> 0.47.2-1~bpo60+1 (debian package)
> That sounds absolutely like the same issue. Sadly nobody from inktank
> has replied to this problems for the last days.

Sorry about that, yesterday was a holiday in the US.

I did some quick tests on a couple of nodes I had laying around this 
morning.

Distro: Oneiric (IE no syncfs in glibc)
Ceph: 0.46-65-gf6c5dff

1 1GbE Client node
3 1GbE Mon nodes
2 1GbE OSD nodes with 1 OSD on each mounted on a 7200rpm SAS drive.  
btrfs with -l 64k -n64k, mounted using noatime.  H700 Raid controller 
with each drive in a 1 disk raid0.  Journals are partitioned on a 
separate drive.

/proc/version:
Linux version 3.4.0-ceph (autobuild-ceph@gitbuilder-kernel-amd64)

rados -p data bench 120 write:

Total time run:        120.601286
Total writes made:     2979
Write size:            4194304
Bandwidth (MB/sec):    98.805

Average Latency:       0.647507
Max latency:           1.39966
Min latency:           0.181663

Once I get these nodes up to 0.47 and get them switched over to 10GbE 
I'll redo the btrfs tests and try out xfs as well with longer running tests.

>> As you can see, much more stable bandwith with this pool.
> That's pretty strange...

Indeed, that is very strange!  Can you check to see how many pgs are in 
each?  Any difference in replication level?  You can check with:

ceph osd pool get <pool> size
ceph osd pool get <pool> pg_num

>> I understand data&  rbd pool probably don't use the same internals, but
>> is this difference expected ?
> There must be differences in pool handling.
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Mark
