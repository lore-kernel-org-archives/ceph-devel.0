From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: measure performance / latency in blustore
Date: Thu, 14 Dec 2017 12:22:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712141221340.2838@piezo.novalocal>
References: <71b773a4-18a1-c206-2fe4-83b51cdf368c@profihost.ag>
 <231b2674-d2b6-b66a-ae29-72c0f2a7f1a0@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <231b2674-d2b6-b66a-ae29-72c0f2a7f1a0-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 14 Dec 2017, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> Am 21.11.2017 um 11:06 schrieb Stefan Priebe - Profihost AG:
> > Hello,
> > 
> > to measure performance / latency for filestore we used:
> > filestore:apply_latency
> > filestore:commitcycle_latency
> > filestore:journal_latency
> > filestore:queue_transaction_latency_avg
> > 
> > What are the correct ones for bluestore?
> 
> really nobody? Does nobody track the latency under bluestore?

I forget the long names off the top of my head, but the interesting 
latency measures are marked with a low priority and come up (with a wide 
terminal) when you do 'ceph daemonperf osd.N'. You can see the metrics, 
pririties, and descriptions with 'ceph daemon osd.N perf schema'.

sage
