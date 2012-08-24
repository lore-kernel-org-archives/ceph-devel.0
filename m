From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: RE: PG's
Date: Fri, 24 Aug 2012 02:07:59 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C260213FE@BLUPRD0411MB438.namprd04.prod.outlook.com>
References: <orboos1qyu.fsf@livre.localdomain>
	<Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
	<ork43bbbbb.fsf@livre.localdomain>
	<Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
	<ora9xsbm9w.fsf@livre.localdomain>	<orzk5ra8m9.fsf@livre.localdomain>
	<alpine.DEB.2.00.1208191415240.26858@cobra.newdream.net>
	<alpine.DEB.2.00.1208191422110.26858@cobra.newdream.net>
	<F5955DC568F9AF4DB00BE0F7E950BE0C26020729@BLUPRD0411MB438.namprd04.prod.outlook.com>
 <CAPYLRzggp+4STv4BWPQAt6EqjNLura9+FW2aB9N-h-CD5QAh_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:7808 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754841Ab2HXCIF convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Aug 2012 22:08:05 -0400
In-Reply-To: <CAPYLRzggp+4STv4BWPQAt6EqjNLura9+FW2aB9N-h-CD5QAh_g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

http://pastebin.com/5bRiUTxf

Greg I've also attached a "ceph osd tree" dump (above). From what I can tell, the tree is correct, and lines up with how I desire to weight the cluster(s), however, I do see that the reweight for the smaller osds (SCSI-Nodes) are less than 1. Perhaps I need to look at this?

Thanks,

Ryan Nicholson
(ryann)

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Gregory Farnum
Sent: Thursday, August 23, 2012 2:41 PM
To: Ryan Nicholson
Cc: ceph-devel@vger.kernel.org
Subject: Re: PG's

On Thu, Aug 23, 2012 at 2:51 PM, Ryan Nicholson <Ryan.Nicholson@kcrg.com> wrote:
> All:
>
> I have a 16-OSD cluster running 0.48 (Argonaut), built from source.
>
> I rebuilt the entire cluster on Sunday Evening 8-19-2012, and started some rados testing.
>
> I have a custom CRUSH map, that calls for the "rbd", "metadata" pools and a custom pool called "SCSI" to be pulled from osd.0-11, while the "data" pool is pulled from osd.12-15. While testing, I find that the cluster is putting data where I want it to, with one exception: the SCSI pool is not storing data evenly thoughout the osd.0-11. Through "df", I find that about every other osd is seeing space utilization.
>
> So, whether good or bad, I did a "ceph osd reweight-by-utilization", which did improve the situation.
>
> Now, after doing some more research in the mailing lists, I find that I should have just let the cluster figure it out on its own.
>
> All that to lead to the problem I'm having now, and, I wish to use this mistake as a learning tool. My ceph status is this:
>
> ceph -s
> ##
>    health HEALTH_WARN 377 pgs stale; 4 pgs stuck inactive; 377 pgs stuck stale; 948 pgs stuck unclean
>    monmap e1: 3 mons at {a=10.9.181.10:6789/0,b=10.9.181.11:6789/0,c=10.9.181.12:6789/0}, election epoch 2, quorum 0,1,2 a,b,c
>    osdmap e90: 16 osds: 16 up, 16 in
>     pgmap v5085: 3080 pgs: 4 creating, 1755 active+clean, 377 stale+active+clean, 944 active+remapped; 10175 MB data, 52057 MB used, 12244 GB / 12815 GB avail
>    mdsmap e16: 1/1/1 up {0=b=up:replay}, 2 up:standby ##
>
> Side-affects: I can create and map any Rados pools. I cannot for the life of me, write to them, format them, anything them. Making my entire cluster offline to clients.
>
> While I've parse and poured over the documentation, I really need experienced help, just to know how to get Ceph to recover, and then allow for operation again.
>
> I've restarted each daemon individually several times, after which I've also tried a complete stop and start of the cluster. After things settle, this reveals the same ceph -s status as I've posted above.
>
> Thanks for your time!

You'll want to start by running "ceph pg dump" and trying to find patterns in the PGs that are stale. If you put it up on pastebin or something I'm sure somebody will be happy to check it out too. PGs that are remapped are a problem with your CRUSH map - can you also post it?
And just for good measure we might as well see the output of "ceph osd dump" as well.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


