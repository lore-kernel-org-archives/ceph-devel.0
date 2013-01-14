From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their performance
 impact
Date: Mon, 14 Jan 2013 07:46:51 -0600
Message-ID: <50F40C4B.6000301@inktank.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:44896 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab3ANNqx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 08:46:53 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so3594070iad.27
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 05:46:53 -0800 (PST)
In-Reply-To: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On 01/14/2013 06:17 AM, Florian Haas wrote:
> Hi everyone,
>
> we ran into an interesting performance issue on Friday that we were
> able to troubleshoot with some help from Greg and Sam (thanks guys),
> and in the process realized that there's little guidance around for
> how to optimize performance in OSD nodes with lots of spinning disks
> (and hence, hosting a relatively large number of OSDs). In that type
> of hardware configuration, the usual mantra of "put your OSD journals
> on an SSD" doesn't always hold up. So we wrote up some
> recommendations, and I'd ask everyone interested to critique this or
> provide feedback:
>
> http://www.hastexo.com/resources/hints-and-kinks/solid-state-drives-and-ceph-osd-journals
>
> It's probably easiest to comment directly on that page, but if you
> prefer instead to just respond in this thread, that's perfectly fine
> too.
>
> For some background of the discussion, please refer to the LogBot log
> from #ceph:
> http://irclogs.ceph.widodh.nl/index.php?date=2013-01-12
>
> Hope this is useful.
>
> Cheers,
> Florian
>

Hi Florian,

Couple of comments:

"OSDs use a write-ahead mode for local operations: a write hits the 
journal first, and from there is then being copied into the backing 
filestore."

It's probably important to mention that this is true by default only for 
non-btrfs file systems.  See:

http://ceph.com/wiki/OSD_journal

"Thus, for best cluster performance it is crucial that the journal is 
fast, whereas the filestore can be comparatively slow."

This is a bit misleading.  Having a faster journal is helpful when there 
are short bursts of traffic.  So long as the journal doesn't fill up and 
there are periods of inactivity for the data to get flushed, having slow 
filestore disk may be ok.  With lots of traffic, reality eventually 
catches up with you and you've gotta get all of that data flushed out to 
the backing file system.

Have you ever seen ceph performance bouncing around with periods of 
really high throughput followed by periods of really low (or no!) 
throughput?  That's usually the result of having a very fast journal 
paired with a slow data disk.  The journal writes out data very quickly, 
hits it's max ops or max bytes limit, then writes are stalled for a 
period while data in the journal gets flushed out to the data disk.

Another thing to remember is that writes to the journal happen without 
causing a lot of seeks.  Ceph doesn't have to do metadata or dentry 
lookups/writes to write data to the journal.  Because of this, it's been 
my experience that journals are primarily throughput bound rather than 
being random IOPS bound.  Just putting the journals on any old SSD isn't 
enough, you need to choose ones that get really high throughput like the 
Intel S3700s or other high performance models.

"By and large, try to go for a relatively small number of OSDs per node, 
ideally not more than 8. This combined with SSD journals is likely to 
give you the best overall performance."

The advice that I usually give people is that if performance is a big 
concern, try to match filestore disk and journal performance is nearly 
matched.  In my test setup, I use 1 intel 520 SSD to host 3 journals for 
7200rpm enterprise SATA disks.  A 1:4 ratio or even 1:6 ratio may also 
work fine depending on various factors.  So far the limits I've hit with 
very minimal tuning seem to be around 15 spinning disks and 5 SSDs for 
around 1.4GB/s (2.8GB/s including journal writes) to one node.

"If you do go with OSD nodes with a very high number of disks, consider 
dropping the idea of an SSD-based journal. Yes, in this kind of setup 
you might actually do better with journals on the spinners."

If your SSD(s) is/are slow you very well may be better off with putting 
the journals on the same spinning disks as the OSD data.  It's all a 
giant balancing act between write throughput, read throughput, and 
capacity.  If you look closely at the 8 spinning disk vs 6 spinning + 2 
SSD numbers in the argonaut vs bobtail article, you can see some of the 
tradeoffs:

http://ceph.com/uncategorized/argonaut-vs-bobtail-performance-preview/

Mark






