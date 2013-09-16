From: "Don Talton (dotalton)" <dotalton-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Deploy a Ceph cluster to play around with
Date: Mon, 16 Sep 2013 15:37:35 +0000
Message-ID: <57ED724085B72141BB091CF1314E471F0171A1B4@xmb-rcd-x15.cisco.com>
References: <29A25BA6-872E-410A-95B8-F188A63BA505@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <29A25BA6-872E-410A-95B8-F188A63BA505-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

If you are just playing around, you could roll everything onto a single server. Or, if you wanted, put the MON and OSD on a single server and the radosgw on a different server. You can accomplish this in a virtual machine if you don't have all the hardware you would like to test with.

> -----Original Message-----
> From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org [mailto:ceph-users-
> bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Guang
> Sent: Monday, September 16, 2013 6:14 AM
> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; Ceph Development
> Subject: [ceph-users] Deploy a Ceph cluster to play around with
> 
> Hello ceph-users, ceph-devel,
> Nice to meet you in the community!
> Today I tried to deploy a Ceph cluster to play around with the API, and during
> the deployment, i have a couple of questions which may need you help:
>   1) How many hosts do I need if I want to deploy a cluster with RadosGW (so
> that I can try with the S3 API)? Is it 3 OSD + 1 Mon + 1 GW =  5 hosts on
> minimum?
> 
>   2) I have a list of hardwares, however, my host only have 1 disk with two
> partitions, one for boot and another for LVM members, is it possible to
> deploy an OSD on such hardware (e.g. make a partition with ext4)? Or I will
> need another disk to do so?
> 
> -bash-4.1$ ceph-deploy disk list myserver.com [ceph_deploy.osd][INFO  ]
> Distro info: RedHatEnterpriseServer 6.3 Santiago [ceph_deploy.osd][DEBUG ]
> Listing disks on myserver.com...
> [repl101.mobstor.gq1.yahoo.com][INFO  ] Running command: ceph-disk list
> [repl101.mobstor.gq1.yahoo.com][INFO  ] /dev/sda :
> [repl101.mobstor.gq1.yahoo.com][INFO  ]  /dev/sda1 other, ext4, mounted
> on /boot [repl101.mobstor.gq1.yahoo.com][INFO  ]  /dev/sda2 other,
> LVM2_member
> 
> Thanks,
> Guang
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
