From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: ceph osd commit latency increase over time,
 until restart
Date: Fri, 25 Jan 2019 09:49:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1901250948390.1384@piezo.novalocal>
References: <395511117.2665.1548405853447.JavaMail.zimbra@oxygem.tv>
 <387140705.12275.1548407699184.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <387140705.12275.1548407699184.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Can you capture a perf top or perf record to see where teh CPU time is 
going on one of the OSDs wth a high latency?

Thanks!
sage


On Fri, 25 Jan 2019, Alexandre DERUMIER wrote:

> 
> Hi, 
> 
> I have a strange behaviour of my osd, on multiple clusters, 
> 
> All cluster are running mimic 13.2.1,bluestore, with ssd or nvme drivers, 
> workload is rbd only, with qemu-kvm vms running with librbd + snapshot/rbd export-diff/snapshotdelete each day for backup 
> 
> When the osd are refreshly started, the commit latency is between 0,5-1ms. 
> 
> But overtime, this latency increase slowly (maybe around 1ms by day), until reaching crazy 
> values like 20-200ms. 
> 
> Some example graphs:
> 
> http://odisoweb1.odiso.net/osdlatency1.png
> http://odisoweb1.odiso.net/osdlatency2.png
> 
> All osds have this behaviour, in all clusters. 
> 
> The latency of physical disks is ok. (Clusters are far to be full loaded) 
> 
> And if I restart the osd, the latency come back to 0,5-1ms. 
> 
> That's remember me old tcmalloc bug, but maybe could it be a bluestore memory bug ? 
> 
> Any Hints for counters/logs to check ? 
> 
> 
> Regards, 
> 
> Alexandre 
> 
> 
