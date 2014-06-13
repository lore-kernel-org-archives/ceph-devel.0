From: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Fri, 13 Jun 2014 16:59:16 +0200
Message-ID: <539B11C4.1010400@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

while testint firefly i cam into the sitation where i had a client where 
the latest dumpling packages where installed (0.67.9).

As my pool has hashppool false and the tunables are set to default it 
can talk to my firefly ceph sotrage.

For random 4k writes using fio with librbd and 32 jobs and an iodepth of 32.

I get these results:

librbd / librados2 from dumpling:
   write: io=3020.9MB, bw=103083KB/s, iops=25770, runt= 30008msec
   WRITE: io=3020.9MB, aggrb=103082KB/s, minb=103082KB/s, 
maxb=103082KB/s, mint=30008msec, maxt=30008msec

librbd / librados2 from firefly:
   write: io=7344.3MB, bw=83537KB/s, iops=20884, runt= 90026msec
   WRITE: io=7344.3MB, aggrb=83537KB/s, minb=83537KB/s, maxb=83537KB/s, 
mint=90026msec, maxt=90026msec

Stefan
