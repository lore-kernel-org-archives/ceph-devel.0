From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Data distribution
Date: Mon, 27 Jun 2011 12:23:08 -0700
Message-ID: <AEA16528-4055-48FE-A228-3E1EAAC324B5@dreamhost.com>
References: <1793430427.17772.1309060138965.JavaMail.root@mail.linserv.se> <4E08D7D7.4070704@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57356 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab1F0TXJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2011 15:23:09 -0400
In-Reply-To: <4E08D7D7.4070704@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>, Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On Jun 27, 2011, at 12:19 PM, Josh Durgin wrote:

> On 06/25/2011 08:48 PM, Martin Wilderoth wrote:
>> Hello
>> 
>> I have a ceph cluster of 6 osd 146gb each. I have copied a lot of data
>> filling to 87%. Between the osd's the data is not evenly distributed
>> 
>> host1
>> /dev/sdb              137G  119G   15G  90% /data/osd0
>> /dev/sdc              137G  126G  7.4G  95% /data/osd1
>> 
>> host2
>> /dev/sdc              137G  114G   21G  85% /data/osd2
>> /dev/sdd              137G  130G  3.6G  98% /data/osd3
>> 
>> host3
>> /dev/sdb              137G  107G   27G  81% /data/osd4
>> /dev/sdc              137G   98G   36G  74% /data/osd5
>> 
>> During the copy i got I/O error, but after restarting the cluster it seems fine.
>> 
>> By some reason osd3 seems to have much more data than osd5. Is there a way of geting the data distributed better ?.
> 
> Hi Martin,
> 
> Since the distribution is pseudo-random, you'll get some variance from an even split. You can reweight the osds manually with:
> 
> ceph osd reweight osd3 new_weight
> 
> or use the more automatic:
> 
> ceph osd reweight-by-utilization 110
> 
> This reduces the weight of all osds that have a utilization that is more than 110% of the average utilization.
> 
> Josh

That said if the data is this unevenly distributed something odd is going on. Are you using anything besides the filesystem on this cluster? If not we probably need to figure out if there's a problem with the hashing.
-Greg