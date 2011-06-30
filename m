From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Fwd: Data distribution
Date: Thu, 30 Jun 2011 21:27:08 +0200 (CEST)
Message-ID: <936851145.17887.1309462028038.JavaMail.root@mail.linserv.se>
References: <1266837122.17885.1309461874884.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:43928 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab1F3Tf5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 15:35:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 2852A1204D6
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2011 21:27:12 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GtaTfS6zpfDx for <ceph-devel@vger.kernel.org>;
	Thu, 30 Jun 2011 21:27:08 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id 3C578120029
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2011 21:27:08 +0200 (CEST)
In-Reply-To: <1266837122.17885.1309461874884.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello, 

I have made a new test with a new filesystem and it seems as if host3 osd5/osd6 is getting less data. I have check the distribution over time. At the end i got some I/O error as some of the disk are quite full. Can't read superblock when mounting
I guess there ar no tools to cerrect that yet ?

Start

/dev/sdc              137G  2.3M  135G   1% /data/osd0
/dev/sdd              137G  2.4M  135G   1% /data/osd1
/dev/sdc              137G  2.6M  135G   1% /data/osd2
/dev/sdd              137G  2.1M  135G   1% /data/osd3
/dev/sdb              137G  2.0M  135G   1% /data/osd4
/dev/sdc              137G  1.7M  135G   1% /data/osd5

later
/dev/sdc              137G  8.9G  126G   7% /data/osd0
/dev/sdd              137G  8.9G  126G   7% /data/osd1
/dev/sdc              137G  7.9G  126G   6% /data/osd2
/dev/sdd              137G  9.2G  125G   7% /data/osd3
/dev/sdb              137G  7.5G  127G   6% /data/osd4
/dev/sdc              137G  7.1G  127G   6% /data/osd5

later
/dev/sdc              137G   56G   78G  42% /data/osd0
/dev/sdd              137G   60G   75G  45% /data/osd1
/dev/sdc              137G   53G   81G  40% /data/osd2
/dev/sdd              137G   61G   74G  46% /data/osd3
/dev/sdb              137G   51G   84G  38% /data/osd4
/dev/sdc              137G   46G   88G  35% /data/osd5

last
/dev/sdc              137G  126G  7.7G  95% /data/osd0
/dev/sdd              137G  130G  3.2G  98% /data/osd1
/dev/sdc              137G  113G   22G  85% /data/osd2
/dev/sdd              137G  126G  7.3G  95% /data/osd3
/dev/sdb              137G  110G   24G  83% /data/osd4
/dev/sdc              137G   70G   64G  53% /data/osd5


>On Jun 27, 2011, at 12:19 PM, Josh Durgin wrote: 

>> On 06/25/2011 08:48 PM, Martin Wilderoth wrote: 
>>> Hello 
>>> 
>>> I have a ceph cluster of 6 osd 146gb each. I have copied a lot of data 
>>> filling to 87%. Between the osd's the data is not evenly distributed 
>>> 
>>> host1 
>>> /dev/sdb 137G 119G 15G 90% /data/osd0 
>>> /dev/sdc 137G 126G 7.4G 95% /data/osd1 
>>> 
>>> host2 
>>> /dev/sdc 137G 114G 21G 85% /data/osd2 
>>> /dev/sdd 137G 130G 3.6G 98% /data/osd3 
>>> 
>>> host3 
>>> /dev/sdb 137G 107G 27G 81% /data/osd4 
>>> /dev/sdc 137G 98G 36G 74% /data/osd5 
>>> 
>>> During the copy i got I/O error, but after restarting the cluster it seems >>>fine. 
>>> 
>>> By some reason osd3 seems to have much more data than osd5. Is there a way of geting the data distributed better ?. 
>> 
>> Hi Martin, 
>> 
>> Since the distribution is pseudo-random, you'll get some variance from an even >split. You can reweight the osds manually with: 
>> 
>> ceph osd reweight osd3 new_weight 
>> 
>> or use the more automatic: 
>> 
>> ceph osd reweight-by-utilization 110 
>> 
>> This reduces the weight of all osds that have a utilization that is more than 110% of the average utilization. 
>> 
>> Josh 

>That said if the data is this unevenly distributed something odd is going on. Are >you using anything besides the filesystem on this cluster? If not we probably need >to figure out if there's a problem with the hashing. 
>-Greg 
