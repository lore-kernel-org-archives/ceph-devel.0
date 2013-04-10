From: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: ceph recovering results in offline VMs
Date: Wed, 10 Apr 2013 21:16:22 +0200
Message-ID: <5165BA86.10509@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello list,

i'm using ceph 0.56.4 and i've to replace some drives. But while ceph is 
backfilling / recovering all VMs have high latencies and sometimes 
they're even offline. I just replace one drive at a time.

I putted in the new drives and i'm reweighting them from 0.0 to 1.0 in 
0.1 steps.

I already lowered osd recovery max active = 2 and osd max backfills = 3, 
but when i put them back at 1.0 the vms are nearly all down.

Right now some drives are SSDs so they're a lot faster than the HDDs i'm 
going to replace them too.

Nothing in the logs but it is recovering at 3700MB/s that this is not 
possible on SATA HDDs is clear.

Log example:
2013-04-10 20:55:33.711289 mon.0 [INF] pgmap v9293315: 8128 pgs: 233 
active, 7876 active+clean, 19 active+recovery_wait; 557 GB data, 1168 GB 
used, 7003 GB / 8171 GB avail; 2108KB/s wr, 329op/s; 31/309692 degraded 
(0.010%);  recovering 840 o/s, 3278MB/s

Greets,
Stefan
