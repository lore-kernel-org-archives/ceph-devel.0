From: Ugis <ugis22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: planning ceph from admin perspective. Ceph calculator?
Date: Mon, 20 May 2013 17:02:33 +0300
Message-ID: <CAE63xUN168QRyN-aGb+uepywqQtrr6aFt086wvNWPSBxhC-Onw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2016732474=="
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2016732474==
Content-Type: multipart/alternative; boundary=047d7bd76be6c8250c04dd26c8c1

--047d7bd76be6c8250c04dd26c8c1
Content-Type: text/plain; charset=UTF-8

Hi,

Seems more and more that ceph is out in the wild - people are using it for
production, development speeds up etc.

Still how can one pick the configuration suiting his needs?

For example, we wish to replace older SAN IBM/HP storages with ceph, we
know iops, bandwidth capabilities of those, but there is no "ceph
calculator" to get estimations how many OSDs/hosts we need to match
existing storage performance parameters.

We have done some tests internally with up to 7 OSDs(2-3 hosts), but
increasing OSD count in such small amounts does not  influence ceph
performance considerably/lineary to extrapolate till needed performance.
Have been following performance figures in maillists, Marks performance
tests and read Inktanks provided reference architecture at
http://www.inktank.com/resource/ceph-reference-architecture/ (btw, that doc
mentions other "Multi-Rack Object Storage Reference Architecture" which I
cannot find, anyone has fount it?). In the end I have come to wild guess
that starting ~24 spinning OSDs, 2-3 hosts should match our needed starting
performance. At this piont it would be helpful to have some estimation tool
or reliable reference that estimation is realistic :).

Sure ceph is dynamic creature, many parameters influence resulting
performance(SSD/spinning HDD, network, filesystems, journals, replication
count etc.) but still when people face question "can we do it with ceph?"
some metology or tools like "ceph calculator" could help to estimate needed
HW and consequently come to expected investment needed for that. Admins
need to convince management at times on certain solution, right? :)

I have been thinking for solutions to this informantion gap and I see 2
supplementing solutions:
1)create publically available ceph configurations+performance reference
lists from real life where people can add their cephs and compare. Just
standartized approach for conducting tests must be in place - to compare
apples to apples. For example people could specify their OSD host count,
OSD count, OSD filesystem, OSD server model, CPU, RAM, network,
interfaces(type, speed) ceph version, replica count and the like + provide
standardized performance test results of their ceph, like rados bench, fio
tests with 4K, 4M, random/sequential, read/write.
Other could look for matching working configuration and compare to their
clusters. This should encourage startups with real examples and for
existing ceph users look for possible tuning.

2)develop theoretical ceph calculator or formula where one can specify
needed performance characteristics(iops, bandwidth,size), specify planned
HW parameters(if available) and get estimated ceph configuration(needed
hosts,CPUs,RAM,OSDs,network). This should take into consideration HDD
count, size, smallest iops per HDD, network latency, RAM, replica count,
connection type to ceph(direct via kernel client, userland, via FC/iscsi
proxy etc.) and other influencing parameters. There will allways be palce
for advanced know-how tuning, this would just be for easy estimated
calculations to get started.

Both things seem to naturally land  to http://wiki.ceph.com/ and be hosted
there as current central ceph knowledge base, right? :)

What do you think on chances of implementing both things?

Ugis

--047d7bd76be6c8250c04dd26c8c1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>Seems more and more that c=
eph is out in the wild - people are using it for production, development sp=
eeds up etc. <br><br></div>Still how can one pick the configuration suiting=
 his needs?<br>
<br></div>For example, we wish to replace older SAN IBM/HP storages with ce=
ph, we know iops, bandwidth capabilities of those, but there is no &quot;ce=
ph calculator&quot; to get estimations how many OSDs/hosts we need to match=
 existing storage performance parameters.<br>
<div><br>We have done some tests internally with up to 7 OSDs(2-3 hosts), b=
ut increasing OSD count in such small amounts does not=C2=A0 influence ceph=
 performance considerably/lineary to extrapolate till needed performance. H=
ave been following performance figures in maillists, Marks performance test=
s and read Inktanks provided reference architecture at <a href=3D"http://ww=
w.inktank.com/resource/ceph-reference-architecture/">http://www.inktank.com=
/resource/ceph-reference-architecture/</a> (btw, that doc mentions other &q=
uot;Multi-Rack Object Storage Reference Architecture&quot; which I cannot f=
ind, anyone has fount it?). In the end I have come to wild guess that start=
ing ~24 spinning OSDs, 2-3 hosts should match our needed starting performan=
ce. At this piont it would be helpful to have some estimation tool or relia=
ble reference that estimation is realistic :).<br>
<br></div><div>Sure ceph is dynamic creature, many parameters influence res=
ulting performance(SSD/spinning HDD, network, filesystems, journals, replic=
ation count etc.) but still when people face question &quot;can we do it wi=
th ceph?&quot; some metology or tools like &quot;ceph calculator&quot; coul=
d help to estimate needed HW and consequently come to expected investment n=
eeded for that. Admins need to convince management at times on certain solu=
tion, right? :)<br>
<br></div><div>I have been thinking for solutions to this informantion gap =
and I see 2 supplementing solutions:<br></div><div>1)create publically avai=
lable ceph configurations+performance reference lists from real life where =
people can add their cephs and compare. Just standartized approach for cond=
ucting tests must be in place - to compare apples to apples. For example pe=
ople could specify their OSD host count, OSD count, OSD filesystem, OSD ser=
ver model, CPU, RAM, network, interfaces(type, speed) ceph version, replica=
 count and the like + provide standardized performance test results of thei=
r ceph, like rados bench, fio tests with 4K, 4M, random/sequential, read/wr=
ite.<br>
</div><div>Other could look for matching working configuration and compare =
to their clusters. This should encourage startups with real examples and fo=
r existing ceph users look for possible tuning.<br></div><div><br></div>
<div>2)develop theoretical ceph calculator or formula where one can specify=
 needed performance characteristics(iops, bandwidth,size), specify planned =
HW parameters(if available) and get estimated ceph configuration(needed hos=
ts,CPUs,RAM,OSDs,network). This should take into consideration HDD count, s=
ize, smallest iops per HDD,
network latency, RAM, replica count, connection type to ceph(direct via ker=
nel client, userland, via FC/iscsi proxy etc.) and other influencing
parameters. There will allways be palce for advanced know-how tuning, this =
would just be for easy estimated calculations to get started.<br><br></div>=
<div>Both things seem to naturally land=C2=A0 to <a href=3D"http://wiki.cep=
h.com/">http://wiki.ceph.com/</a> and be hosted there as current central ce=
ph knowledge base, right? :)<br>
</div><div><br></div><div>What do you think on chances of implementing both=
 things?<br></div><div><br></div><div>Ugis<br></div><div><br><br><br></div>=
<div><br></div></div>

--047d7bd76be6c8250c04dd26c8c1--

--===============2016732474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2016732474==--
