From: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Subject: ceph osd commit latency increase over time,
 until restart
Date: Fri, 25 Jan 2019 10:14:59 +0100 (CET)
Message-ID: <387140705.12275.1548407699184.JavaMail.zimbra@oxygem.tv>
References: <395511117.2665.1548405853447.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <395511117.2665.1548405853447.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


Hi, 

I have a strange behaviour of my osd, on multiple clusters, 

All cluster are running mimic 13.2.1,bluestore, with ssd or nvme drivers, 
workload is rbd only, with qemu-kvm vms running with librbd + snapshot/rbd export-diff/snapshotdelete each day for backup 

When the osd are refreshly started, the commit latency is between 0,5-1ms. 

But overtime, this latency increase slowly (maybe around 1ms by day), until reaching crazy 
values like 20-200ms. 

Some example graphs:

http://odisoweb1.odiso.net/osdlatency1.png
http://odisoweb1.odiso.net/osdlatency2.png

All osds have this behaviour, in all clusters. 

The latency of physical disks is ok. (Clusters are far to be full loaded) 

And if I restart the osd, the latency come back to 0,5-1ms. 

That's remember me old tcmalloc bug, but maybe could it be a bluestore memory bug ? 

Any Hints for counters/logs to check ? 


Regards, 

Alexandre 
