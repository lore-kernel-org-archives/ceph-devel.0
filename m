From: Z Zhang <zhangz.david-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Write performance issue under rocksdb kvstore
Date: Tue, 20 Oct 2015 18:51:46 +0800
Message-ID: <SNT146-W53DA6FBD57581F19D681688C390@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Guys,

I am trying latest ceph-9.1.0 with rocksdb 4.1 and ceph-9.0.3 with rocksdb =
3.11 as OSD backend. I use rbd to test performance and following is my clus=
ter info.

[ceph@xxx ~]$ ceph -s
=A0 =A0 cluster b74f3944-d77f-4401-a531-fa5282995808
=A0 =A0 =A0health HEALTH_OK
=A0 =A0 =A0monmap e1: 1 mons at {xxx=3Dxxx.xxx.xxx.xxx:6789/0}
=A0 =A0 =A0 =A0 =A0 =A0 election epoch 1, quorum 0 xxx
=A0 =A0 =A0osdmap e338: 44 osds: 44 up, 44 in
=A0 =A0 =A0 =A0 =A0 =A0 flags sortbitwise
=A0 =A0 =A0 pgmap v1476: 2048 pgs, 1 pools, 158 MB data, 59 objects
=A0 =A0 =A0 =A0 =A0 =A0 1940 MB used, 81930 GB / 81932 GB avail
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2048 active+clean

All the disks are spinning ones with write cache turning on. Rocksdb's WAL =
and sst files are on the same disk as every OSD.

Using fio to generate following write load:=A0
fio -direct=3D1 -rw=3Drandwrite -ioengine=3Dsync -size=3D10M -bs=3D4K -grou=
p_reporting -directory /mnt/rbd_test/ -name xxx.1 -numjobs=3D1=A0=A0

Test result:
WAL enabled + sync: false + disk write cache: on =A0will get ~700 IOPS.
WAL enabled + sync: true (default) + disk write cache: on|off =A0will get o=
nly ~25 IOPS.

I tuned some other rocksdb options, but with no lock. I tracked down the ro=
cksdb code and found each writer's Sync operation would take ~30ms to finis=
h. And as shown above, it is strange that performance has no much differenc=
e no matters disk write cache is on or off.

Do your guys encounter the similar issue? Or do I miss something to cause r=
ocksdb's poor write performance?

Thanks.
Zhi Zhang (David) 		 	   		  =
