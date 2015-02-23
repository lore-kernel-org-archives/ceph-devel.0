From: Nick Fisk <Nick.Fisk-l6U37TL90dgqdlJmJB21zg@public.gmane.org>
Subject: Re: Erasure Coding CPU Overhead Data
Date: Mon, 23 Feb 2015 19:41:11 +0000
Message-ID: <DB3PR06MB187C4908492F8EFC0578AA5E7290@DB3PR06MB187.eurprd06.prod.outlook.com>
References: <54E8CD00.5050606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <54E8CD00.5050606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Mark,

Thanks for publishing these results they are very interesting. I was wondering if you could spare a few minutes to answer a few questions

1. Can you explain why in the read graphs the runs are for different lengths of time? At first I thought this was due to the different profiles running faster than others so completing earlier, but the runtimes seem to be inverse to the bandwidth figures.

2. What queue depth were the benchmarks run at?

3. Did you come across any OSD dropouts, particularly in the scenarios where the CPU was pegged at 100%

4. During testing did you get a feel for how many OSD's the hardware could reasonably support without maxing out the CPU?

Many thanks,
Nick

-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Mark Nelson
Sent: 21 February 2015 18:23
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel
Subject: [ceph-users] Erasure Coding CPU Overhead Data

Hi All,

Last spring at the tail end of Firefly development we ran tests looking at erasure coding performance both during simple RADOS read/write tests and also during an OSD recovery event.  Recently we were asked if we had any data on CPU usage overhead with erasure coding.  We had collected CPU utilization statistics when we ran our tests, so we went back and plotted the CPU utilization results and wrote up a short document based on those plots.  This data is fairly old at this point so it's probably not going to be relevant for Hammer and may not be relevant for more recent releases of Firefly.

This system had 30 OSDs configured and 12 2.0GHz XEON cores which is likely slightly underpowered for EC.  Interestingly CPU usage for small object writes was not significantly higher than with replication though overall performance was quite a bit lower.  Let me know if you have any questions!

Thanks,
Mark


Nick Fisk
Technical Support Engineer

System Professional Ltd
tel: 01825 830000
mob: 07711377522
fax: 01825 830001
mail: Nick.Fisk-l6U37TL90dgqdlJmJB21zg@public.gmane.org
web: www.sys-pro.co.uk<http://www.sys-pro.co.uk>

IT SUPPORT SERVICES | VIRTUALISATION | STORAGE | BACKUP AND DR | IT CONSULTING

Registered Office:
Wilderness Barns, Wilderness Lane, Hadlow Down, East Sussex, TN22 4HU
Registered in England and Wales.
Company Number: 04754200


Confidentiality: This e-mail and its attachments are intended for the above named only and may be confidential. If they have come to you in error you must take no action based on them, nor must you copy or show them to anyone; please reply to this e-mail and highlight the error.

Security Warning: Please note that this e-mail has been created in the knowledge that Internet e-mail is not a 100% secure communications medium. We advise that you understand and observe this lack of security when e-mailing us.

Viruses: Although we have taken steps to ensure that this e-mail and attachments are free from any virus, we advise that in keeping with good computing practice the recipient should ensure they are actually virus free. Any views expressed in this e-mail message are those of the individual and not necessarily those of the company or any of its subsidiaries.
