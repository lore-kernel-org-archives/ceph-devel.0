From: lin zhou <hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: near 300 pg per osd make cluster very very unstable?
Date: Sun, 23 Jun 2019 07:33:27 +0800
Message-ID: <CAKO+7k304JfiN3Drgy9BDsKxXzCip7180NckQoeBo2BJxb2xgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

recently our ceph cluster very unstable, even replace a failed disk
may trigger a chain reaction,  cause large quantities of osd been
wrongly marked down.
I am not sure if it is because we have near 300 pgs in each sas osds
and small bigger than 300  pgs for ssd osd.

from logs, it all starts from osd_op_tp timed out, then osd no reply,
then large wrongly mark down.

1. 45 machines, each machine has 16 sas and 8 ssd, all file journal in
the osd data dir.
2. use rbd in this cluster
3. 300+ compute node to hold vm
4. osd node current has a hundred thousand threads and fifty thousand
established network connection.
5. dell R730xd, and dell say no hardware error log

so someone else faces the same unstable problem or using 300+ pgs?
