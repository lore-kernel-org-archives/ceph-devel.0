From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Erasure Coding CPU Overhead Data
Date: Mon, 23 Feb 2015 14:15:26 -0600
Message-ID: <54EB8A5E.5090105@redhat.com>
References: <54E8CD00.5050606@redhat.com>
	<DB3PR06MB187C4908492F8EFC0578AA5E7290@DB3PR06MB187.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <DB3PR06MB187C4908492F8EFC0578AA5E7290-5Qr72V/tsOA6G1BGxDT3KL9PrO6axcR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Nick Fisk <Nick.Fisk-l6U37TL90dgqdlJmJB21zg@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



On 02/23/2015 01:41 PM, Nick Fisk wrote:
> Hi Mark,
>
> Thanks for publishing these results they are very interesting. I was wondering if you could spare a few minutes to answer a few questions
>
> 1. Can you explain why in the read graphs the runs are for different lengths of time? At first I thought this was due to the different profiles running faster than others so completing earlier, but the runtimes seem to be inverse to the bandwidth figures.

RADOS bench writes out a bunch of objects for a specified amount of 
time, then those objects can optionally be read back in for a certain 
amount of time up to the amount of data that was written out.  IE if a 
write test is slow, you may not have enough data to read and the test 
may end early.  We probably should add an option to rados bench to let 
you write out a set amount of data.  The read tests may still finish at 
different times, but at least then it would more directly correlate with 
the read speed and not vary based on how much data had been previously 
written.

>
> 2. What queue depth were the benchmarks run at?


There were 4 rados bench processes with 32 concurrent ops each.

>
> 3. Did you come across any OSD dropouts, particularly in the scenarios where the CPU was pegged at 100%

No, though around that time we were having issues on the test node with 
heartbeat time outs due to unnecessary major page faults associated with 
the OSD processes.  This was fixed by setting vfs_cache_pressure and 
swappiness to 1.  It's likely in retrospect that this may have been 
related to the numa zone reclaim issues that have since been discovered. 
  Favoring dentry/inode cache and preferring not to swap out processes 
is probably a good idea for OSD nodes anyway though.

>
> 4. During testing did you get a feel for how many OSD's the hardware could reasonably support without maxing out the CPU?

I didn't do that extensive of testing at the time, but the feeling I got 
was that our recommendation of approximately 1GHz of 1 core per OSD is 
probably pretty reasonable.  It may be worth giving yourself a little 
extra CPU headroom for EC though if you have SSD journals and don't want 
your CPUs maxing out.  Probably the big takeaway is that if you want to 
use EC with really big 60+ drive servers and 40GbE network you probably 
are going to be maxing out the CPUs a lot on writes.

>
> Many thanks,
> Nick
>
> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Mark Nelson
> Sent: 21 February 2015 18:23
> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Cc: ceph-devel
> Subject: [ceph-users] Erasure Coding CPU Overhead Data
>
> Hi All,
>
> Last spring at the tail end of Firefly development we ran tests looking at erasure coding performance both during simple RADOS read/write tests and also during an OSD recovery event.  Recently we were asked if we had any data on CPU usage overhead with erasure coding.  We had collected CPU utilization statistics when we ran our tests, so we went back and plotted the CPU utilization results and wrote up a short document based on those plots.  This data is fairly old at this point so it's probably not going to be relevant for Hammer and may not be relevant for more recent releases of Firefly.
>
> This system had 30 OSDs configured and 12 2.0GHz XEON cores which is likely slightly underpowered for EC.  Interestingly CPU usage for small object writes was not significantly higher than with replication though overall performance was quite a bit lower.  Let me know if you have any questions!
>
> Thanks,
> Mark
>
>
> Nick Fisk
> Technical Support Engineer
>
> System Professional Ltd
> tel: 01825 830000
> mob: 07711377522
> fax: 01825 830001
> mail: Nick.Fisk-l6U37TL90dgqdlJmJB21zg@public.gmane.org
> web: www.sys-pro.co.uk<http://www.sys-pro.co.uk>
>
> IT SUPPORT SERVICES | VIRTUALISATION | STORAGE | BACKUP AND DR | IT CONSULTING
>
> Registered Office:
> Wilderness Barns, Wilderness Lane, Hadlow Down, East Sussex, TN22 4HU
> Registered in England and Wales.
> Company Number: 04754200
>
>
> Confidentiality: This e-mail and its attachments are intended for the above named only and may be confidential. If they have come to you in error you must take no action based on them, nor must you copy or show them to anyone; please reply to this e-mail and highlight the error.
>
> Security Warning: Please note that this e-mail has been created in the knowledge that Internet e-mail is not a 100% secure communications medium. We advise that you understand and observe this lack of security when e-mailing us.
>
> Viruses: Although we have taken steps to ensure that this e-mail and attachments are free from any virus, we advise that in keeping with good computing practice the recipient should ensure they are actually virus free. Any views expressed in this e-mail message are those of the individual and not necessarily those of the company or any of its subsidiaries.
>
