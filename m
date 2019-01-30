From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: ceph osd commit latency increase over time,
 until restart
Date: Wed, 30 Jan 2019 13:33:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1901301331580.5535@piezo.novalocal>
References: <395511117.2665.1548405853447.JavaMail.zimbra@oxygem.tv>
 <387140705.12275.1548407699184.JavaMail.zimbra@oxygem.tv>
 <alpine.DEB.2.11.1901250948390.1384@piezo.novalocal>
 <1548181710.219518.1548833599717.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1661526346-1548855206=:5535"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1548181710.219518.1548833599717.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1661526346-1548855206=:5535
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 30 Jan 2019, Alexandre DERUMIER wrote:
> Hi,
> 
> here some new results,
> different osd/ different cluster
> 
> before osd restart latency was between 2-5ms
> after osd restart is around 1-1.5ms
> 
> http://odisoweb1.odiso.net/cephperf2/bad.txt  (2-5ms)
> http://odisoweb1.odiso.net/cephperf2/ok.txt (1-1.5ms)
> http://odisoweb1.odiso.net/cephperf2/diff.txt

I don't see any smoking gun here... :/

The main difference between a warm OSD and a cold one is that on startup 
the bluestore cache is empty.  You might try setting the bluestore cache 
size to something much smaller and see if that has an effect on the CPU 
utilization?

Note that this doesn't necessarily mean that's what you want.  Maybe the 
reason why the CPU utilization is higher is because the cache is warm and 
the OSD is serving more requests per second...

sage



> 
> >From what I see in diff, the biggest difference is in tcmalloc, but maybe I'm wrong.
> 
> (I'm using tcmalloc 2.5-2.2)
> 
> 
> ----- Mail original -----
> De: "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
> À: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Envoyé: Vendredi 25 Janvier 2019 10:49:02
> Objet: Re: ceph osd commit latency increase over time, until restart
> 
> Can you capture a perf top or perf record to see where teh CPU time is 
> going on one of the OSDs wth a high latency? 
> 
> Thanks! 
> sage 
> 
> 
> On Fri, 25 Jan 2019, Alexandre DERUMIER wrote: 
> 
> > 
> > Hi, 
> > 
> > I have a strange behaviour of my osd, on multiple clusters, 
> > 
> > All cluster are running mimic 13.2.1,bluestore, with ssd or nvme drivers, 
> > workload is rbd only, with qemu-kvm vms running with librbd + snapshot/rbd export-diff/snapshotdelete each day for backup 
> > 
> > When the osd are refreshly started, the commit latency is between 0,5-1ms. 
> > 
> > But overtime, this latency increase slowly (maybe around 1ms by day), until reaching crazy 
> > values like 20-200ms. 
> > 
> > Some example graphs: 
> > 
> > http://odisoweb1.odiso.net/osdlatency1.png 
> > http://odisoweb1.odiso.net/osdlatency2.png 
> > 
> > All osds have this behaviour, in all clusters. 
> > 
> > The latency of physical disks is ok. (Clusters are far to be full loaded) 
> > 
> > And if I restart the osd, the latency come back to 0,5-1ms. 
> > 
> > That's remember me old tcmalloc bug, but maybe could it be a bluestore memory bug ? 
> > 
> > Any Hints for counters/logs to check ? 
> > 
> > 
> > Regards, 
> > 
> > Alexandre 
> > 
> > 
> 
> 
> 
--8323329-1661526346-1548855206=:5535
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1661526346-1548855206=:5535--
