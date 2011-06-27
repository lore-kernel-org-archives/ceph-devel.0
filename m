From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Data distribution
Date: Mon, 27 Jun 2011 12:19:51 -0700
Message-ID: <4E08D7D7.4070704@dreamhost.com>
References: <1793430427.17772.1309060138965.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41365 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab1F0TTw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2011 15:19:52 -0400
In-Reply-To: <1793430427.17772.1309060138965.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 06/25/2011 08:48 PM, Martin Wilderoth wrote:
> Hello
>
> I have a ceph cluster of 6 osd 146gb each. I have copied a lot of data
> filling to 87%. Between the osd's the data is not evenly distributed
>
> host1
> /dev/sdb              137G  119G   15G  90% /data/osd0
> /dev/sdc              137G  126G  7.4G  95% /data/osd1
>
> host2
> /dev/sdc              137G  114G   21G  85% /data/osd2
> /dev/sdd              137G  130G  3.6G  98% /data/osd3
>
> host3
> /dev/sdb              137G  107G   27G  81% /data/osd4
> /dev/sdc              137G   98G   36G  74% /data/osd5
>
> During the copy i got I/O error, but after restarting the cluster it seems fine.
>
> By some reason osd3 seems to have much more data than osd5. Is there a way of geting the data distributed better ?.

Hi Martin,

Since the distribution is pseudo-random, you'll get some variance from 
an even split. You can reweight the osds manually with:

ceph osd reweight osd3 new_weight

or use the more automatic:

ceph osd reweight-by-utilization 110

This reduces the weight of all osds that have a utilization that is more 
than 110% of the average utilization.

Josh
