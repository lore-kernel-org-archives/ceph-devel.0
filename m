From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Fri, 25 May 2012 10:19:08 +0200
Message-ID: <4FBF407C.70407@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <CAJCPpW+SKnnVUaDEAsCkKyZwMVrHCRJF2C8zqB4eORgwW5p=1Q@mail.gmail.com> <4FBE7ABC.5020502@profihost.ag> <4FBE838D.4000303@inktank.com> <4FBE8662.1070801@profihost.ag> <4FBEE5FF.7080907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47633 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2EYISw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 04:18:52 -0400
In-Reply-To: <4FBEE5FF.7080907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 25.05.2012 03:53, schrieb Mark Nelson:
> On 05/24/2012 02:05 PM, Stefan Priebe wrote:
>> 3.2.18 works fine too.
> 
> Honestly I don't know if tmpfs journal with dio = false would lead to
> that kind of behavior.  Anything interesting in the logs if you turn
> debugging up?

just stuff like this. But writing to the osd disk works - no idea why i
have seen a rate of 0 yesterday.

[INF] 2.2a scrub ok
2012-05-25 10:01:00.825442    pg v165: 768 pgs: 768 active+clean; 592 MB
data, 1181 MB used, 669 GB / 670 GB avail

2012-05-25 10:01:00.623252 osd.0 10.0.255.100:6800/7423 121 : [WRN] 1
slow requests, 1 included below; oldest blocked for > 30.042783 secs

2012-05-25 10:01:00.623259 osd.0 10.0.255.100:6800/7423 122 : [WRN] slow
request 30.042783 seconds old, received at 2012-05-25 10:00:30.580392:
osd_op(client.4111.0:74 proxmox1_154826_object73 [write 0~4194304]
0.5343bcc6) v4 currently waiting for sub ops


>> > I wonder if any of the data actually makes
>>> it to the disk... Can you run iostat or collectl or something and see
>>> what kind of write throughput you get to the OSD data disks?
>> none... so it seems get's never transferred from journal to disk.
> 
> This might be a stupid question, but writes to those partitions work
> outside of Ceph with the new kernel right?

I just tested with dd:
dd if=/dev/zero of=/srv/test bs=1M count=10000 oflag=direct

this gaves me a constant rate of 240MB/s on ALL osds.

Also an "ceph osd tell X bench" shows 260MB/s on all OSDs.

But when i use the rados bench i see the same for XFS and btrfs which
looks like an heavy up and down rate of the cur MB/s while doing the
rados bench.
See:
XFS:
http://pastebin.com/raw.php?i=8ahaePZw
btrfs:
http://pastebin.com/raw.php?i=BrwSC1yg

Stefan
