From: Srikanth Madugundi <srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: radosgw performance with small files
Date: Tue, 19 May 2015 09:31:26 -0700
Message-ID: <CACAg-u9vczzJ4eT0onf4RLqzaGrgGnVQA=kR4bJdSV1ieBA_Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0828453309=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0828453309==
Content-Type: multipart/alternative; boundary=001a113d7e3a88a24d051671d784

--001a113d7e3a88a24d051671d784
Content-Type: text/plain; charset=UTF-8

Hi,

I am seeing write performance hit with small files (60K) using radosgw. The
radosgw is configured to run with 600 threads. Here is the write speed I
get with file sizes of 60K


# sudo ceph -s
    cluster e445e46e-4d84-4606-9923-16fff64446dc
     health HEALTH_OK
     monmap e1: 1 mons at {osd187=13.24.0.7:6789/0}, election epoch 1,
quorum 0 osd187
     osdmap e205: 28 osds: 22 up, 22 in
      pgmap v17007: 1078 pgs, 9 pools, 154 GB data, 653 kobjects
            292 GB used, 8709 GB / 9002 GB avail
                1078 active+clean
  client io 1117 kB/s rd, *2878 kB/s wr*, 2513 op/s
#


If I run the same script with larger file sizes(1MB-3MB), I get a better
write speed.


# sudo ceph -s
    cluster e445e46e-4d84-4606-9923-16fff64446dc
     health HEALTH_OK
     monmap e1: 1 mons at {osd187=13.24.0.79:6789/0}, election epoch 1,
quorum 0 osd187
     osdmap e205: 28 osds: 22 up, 22 in
      pgmap v16883: 1078 pgs, 9 pools, 125 GB data, 140 kobjects
            192 GB used, 8809 GB / 9002 GB avail
                1078 active+clean
  client io *105 MB/s wr*, 1839 op/s
#

My cluster has 2 OSD hosts running total of 20 osd daemons, 1 mon and 1
radosgw hosts. Is the bottleneck coming from the single radosgw process? If
so, is it possible to run radosgw in multi process mode?

Regards
Srikanth

--001a113d7e3a88a24d051671d784
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am seeing write performance hit w=
ith small files (60K) using radosgw. The radosgw is configured to run with =
600 threads. Here is the write speed I get with file sizes of 60K<br><div><=
br></div><div><br></div><div><div># sudo ceph -s</div><div>=C2=A0 =C2=A0 cl=
uster e445e46e-4d84-4606-9923-16fff64446dc</div><div>=C2=A0 =C2=A0 =C2=A0he=
alth HEALTH_OK</div><div>=C2=A0 =C2=A0 =C2=A0monmap e1: 1 mons at {osd187=
=3D<a href=3D"http://13.24.0.7:6789/0">13.24.0.7:6789/0</a>}, election epoc=
h 1, quorum 0 osd187</div><div>=C2=A0 =C2=A0 =C2=A0osdmap e205: 28 osds: 22=
 up, 22 in</div><div>=C2=A0 =C2=A0 =C2=A0 pgmap v17007: 1078 pgs, 9 pools, =
154 GB data, 653 kobjects</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 292 GB used, 8709 GB / 9002 GB avail</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1078 active+clean</div><div>=C2=A0 client i=
o 1117 kB/s rd, <b>2878 kB/s wr</b>, 2513 op/s</div></div><div>#</div><div>=
<br></div><div><br></div><div>If I run the same script with larger file siz=
es(1MB-3MB), I get a better write speed.=C2=A0</div><div><div><br></div></d=
iv><div><br></div><div><div># sudo ceph -s</div><div>=C2=A0 =C2=A0 cluster =
e445e46e-4d84-4606-9923-16fff64446dc</div><div>=C2=A0 =C2=A0 =C2=A0health H=
EALTH_OK</div><div>=C2=A0 =C2=A0 =C2=A0monmap e1: 1 mons at {osd187=3D<a hr=
ef=3D"http://13.24.0.79:6789/0">13.24.0.79:6789/0</a>}, election epoch 1, q=
uorum 0 osd187</div><div>=C2=A0 =C2=A0 =C2=A0osdmap e205: 28 osds: 22 up, 2=
2 in</div><div>=C2=A0 =C2=A0 =C2=A0 pgmap v16883: 1078 pgs, 9 pools, 125 GB=
 data, 140 kobjects</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 192=
 GB used, 8809 GB / 9002 GB avail</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 1078 active+clean</div><div>=C2=A0 client io <b>10=
5 MB/s wr</b>, 1839 op/s</div></div><div>#</div></div><div><br></div><div>M=
y cluster has 2 OSD hosts running total of 20 osd daemons, 1 mon and 1 rado=
sgw hosts. Is the bottleneck coming from the single radosgw process? If so,=
 is it possible to run radosgw in multi process mode?</div><div><br></div><=
div>Regards</div><div>Srikanth</div><div><br></div></div>

--001a113d7e3a88a24d051671d784--

--===============0828453309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0828453309==--
