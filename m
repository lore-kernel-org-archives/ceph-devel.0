From: Vickey Singh <vickey.singh22693-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Opensource plugin for pulling out cluster recovery and
	client IO metric
Date: Mon, 24 Aug 2015 18:03:10 +0300
Message-ID: <CALL4jwPkeHemknEWypgTzAE7kSa9F+pyZZQUWJwYFY6OQWTFbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2068144623=="
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2068144623==
Content-Type: multipart/alternative; boundary=001a113f89fa70592c051e0fea03

--001a113f89fa70592c051e0fea03
Content-Type: text/plain; charset=UTF-8

Hello Ceph Geeks

I am planning to develop a python plugin that pulls out cluster *recovery
IO* and *client IO* operation metrics , that can be further used with
collectd.

*For example , i need to take out these values*

*recovery io 814 MB/s, 101 objects/s*
*client io 85475 kB/s rd, 1430 kB/s wr, 32 op/s*


Could you please help me in understanding how *ceph -s*  and *ceph -w*
outputs *prints cluster recovery IO and client IO information*.
Where this information is coming from. *Is it coming from perf dump* ? If
yes then which section of perf dump output is should focus on. If not then
how can i get this values.

I tried *ceph --admin-daemon /var/run/ceph/ceph-osd.48.asok perf dump* ,
but it generates hell lot of information and i am confused which section of
output should i use.


Please help

Thanks in advance
Vickey

--001a113f89fa70592c051e0fea03
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Ceph Geeks<br></div><div><br></div><div>I am pl=
anning to develop a python plugin that pulls out cluster <b>recovery IO</b>=
 and <b>client IO</b> operation metrics , that can be further used with col=
lectd.</div><div><br></div><div><b>For example , i need to take out these v=
alues</b></div><div><br></div><div><b>recovery io 814 MB/s, 101 objects/s</=
b></div><div><b>client io 85475 kB/s rd, 1430 kB/s wr, 32 op/s</b></div><di=
v><br></div><div><br></div><div>Could you please help me in understanding h=
ow <b>ceph -s</b> =C2=A0and <b>ceph -w</b> outputs <b>prints cluster recove=
ry IO and client IO information</b>.=C2=A0</div><div>Where this information=
 is coming from. <b>Is it coming from perf dump</b> ? If yes then which sec=
tion of perf dump output is should focus on. If not then how can i get this=
 values.</div><div><br></div><div>I tried <b>ceph --admin-daemon /var/run/c=
eph/ceph-osd.48.asok perf dump</b> , but it generates hell lot of informati=
on and i am confused which section of output should i use.</div><div><br></=
div><div><br></div><div>Please help=C2=A0</div><div><br></div><div>Thanks i=
n advance</div><div>Vickey</div><div><br></div><div><br></div><div><br></di=
v><div><br></div></div>

--001a113f89fa70592c051e0fea03--

--===============2068144623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2068144623==--
