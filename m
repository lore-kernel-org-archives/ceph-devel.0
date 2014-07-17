From: Guang Yang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: row geo-replication to another data store?
Date: Thu, 17 Jul 2014 21:51:42 +0800
Message-ID: <BLU436-SMTP1698E22620FB6AEF006A733DFF40@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
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
To: Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi cephers,
We are investigating a backup solution for Ceph, in short, we would like a solution to backup a Ceph cluster to another data store (not Ceph cluster, assume it has SWIFT API). We would like to have both full backup and incremental backup on top of the full backup.

After going through the geo-replication blueprint [1], I am thinking that we can leverage the effort and instead of replicate the data into another ceph cluster, we make it replicate to another data store. At the same time, I have a couple of questions which need your help:

1) How does the ragosgw-agent scale to multiple hosts? Our first investigation shows it only works on a single host but I would like to confirm.
2) Can we configure the interval  to do incremental backup like 1 hour / 1 day / 1 month?

[1] https://wiki.ceph.com/Planning/Blueprints/Dumpling/RGW_Geo-Replication_and_Disaster_Recovery

Thanks,
Guang
