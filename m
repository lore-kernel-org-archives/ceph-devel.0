From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Fwd: Data distribution
Date: Thu, 30 Jun 2011 16:55:43 -0700
Message-ID: <4E0D0CFF.4070107@dreamhost.com>
References: <936851145.17887.1309462028038.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45501 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1F3Xzn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 19:55:43 -0400
In-Reply-To: <936851145.17887.1309462028038.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 06/30/2011 12:27 PM, Martin Wilderoth wrote:
> Hello,
>
> I have made a new test with a new filesystem and it seems as if host3 osd5/osd6 is getting less data. I have check the distribution over time. At the end i got some I/O error as some of the disk are quite full. Can't read superblock when mounting
> I guess there ar no tools to cerrect that yet ?

When an OSD is full beyond a threshold (defaults to 95%, configured by 
mon_osd_full_ratio), no more writes are accepted. Mounting the FS 
requires the MDS to open a new session, which involves writing to its 
journal on the OSDs. This is why you see the error when mounting.

You can increase the full ratio to let you mount the FS and delete files 
to free up space, e.g.:

ceph mon injectargs '--mon_osd_full_ratio 99'

>
> Start
>
> /dev/sdc              137G  2.3M  135G   1% /data/osd0
> /dev/sdd              137G  2.4M  135G   1% /data/osd1
> /dev/sdc              137G  2.6M  135G   1% /data/osd2
> /dev/sdd              137G  2.1M  135G   1% /data/osd3
> /dev/sdb              137G  2.0M  135G   1% /data/osd4
> /dev/sdc              137G  1.7M  135G   1% /data/osd5
>
> later
> /dev/sdc              137G  8.9G  126G   7% /data/osd0
> /dev/sdd              137G  8.9G  126G   7% /data/osd1
> /dev/sdc              137G  7.9G  126G   6% /data/osd2
> /dev/sdd              137G  9.2G  125G   7% /data/osd3
> /dev/sdb              137G  7.5G  127G   6% /data/osd4
> /dev/sdc              137G  7.1G  127G   6% /data/osd5
>
> later
> /dev/sdc              137G   56G   78G  42% /data/osd0
> /dev/sdd              137G   60G   75G  45% /data/osd1
> /dev/sdc              137G   53G   81G  40% /data/osd2
> /dev/sdd              137G   61G   74G  46% /data/osd3
> /dev/sdb              137G   51G   84G  38% /data/osd4
> /dev/sdc              137G   46G   88G  35% /data/osd5
>
> last
> /dev/sdc              137G  126G  7.7G  95% /data/osd0
> /dev/sdd              137G  130G  3.2G  98% /data/osd1
> /dev/sdc              137G  113G   22G  85% /data/osd2
> /dev/sdd              137G  126G  7.3G  95% /data/osd3
> /dev/sdb              137G  110G   24G  83% /data/osd4
> /dev/sdc              137G   70G   64G  53% /data/osd5

That's a very high variance - can you post your crushmap, pg dump, and 
osd dump?

ceph osd getcrushmap -o /tmp/crushmap && crushtool -d /tmp/crushmap -o 
/tmp/crushmap.txt
ceph pg dump -o /tmp/pgdump
ceph osd dump -o /tmp/osddump

Thanks!
Josh
