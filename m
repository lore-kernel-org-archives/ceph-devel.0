From: Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Deploy a Ceph cluster to play around with
Date: Mon, 16 Sep 2013 21:13:56 +0800
Message-ID: <29A25BA6-872E-410A-95B8-F188A63BA505@yahoo.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset="us-ascii"
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello ceph-users, ceph-devel,
Nice to meet you in the community!
Today I tried to deploy a Ceph cluster to play around with the API, and during the deployment, i have a couple of questions which may need you help:
  1) How many hosts do I need if I want to deploy a cluster with RadosGW (so that I can try with the S3 API)? Is it 3 OSD + 1 Mon + 1 GW =  5 hosts on minimum?

  2) I have a list of hardwares, however, my host only have 1 disk with two partitions, one for boot and another for LVM members, is it possible to deploy an OSD on such hardware (e.g. make a partition with ext4)? Or I will need another disk to do so?

-bash-4.1$ ceph-deploy disk list myserver.com
[ceph_deploy.osd][INFO  ] Distro info: RedHatEnterpriseServer 6.3 Santiago
[ceph_deploy.osd][DEBUG ] Listing disks on myserver.com...
[repl101.mobstor.gq1.yahoo.com][INFO  ] Running command: ceph-disk list
[repl101.mobstor.gq1.yahoo.com][INFO  ] /dev/sda :
[repl101.mobstor.gq1.yahoo.com][INFO  ]  /dev/sda1 other, ext4, mounted on /boot
[repl101.mobstor.gq1.yahoo.com][INFO  ]  /dev/sda2 other, LVM2_member

Thanks,
Guang
