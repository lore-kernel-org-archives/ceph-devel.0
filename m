From: Chu Duc Minh <chu.ducminh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Speed limit on RadosGW?
Date: Wed, 25 Sep 2013 14:49:18 +0700
Message-ID: <CAGP-ymNSSPYSGSM+rWVHT--1Ojad3pLJ0oGB0ERzm3sXEnjZ-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2146842662=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2146842662==
Content-Type: multipart/alternative; boundary=e89a8f23463596b88704e7307d3e

--e89a8f23463596b88704e7307d3e
Content-Type: text/plain; charset=ISO-8859-1

I have a CEPH cluster with 9 nodes (6 data nodes & 3 mon/mds nodes)
And i setup 4 separate nodes to test performance of Rados-GW:
 - 2 node run Rados-GW
 - 2 node run multi-process put file to [multi] Rados-GW

Result:
a) When i use 1 RadosGW node & 1 upload-node, speed upload = 50MB/s
/upload-node, Rados-GW input/output speed = 50MB/s

b) When i use 2 RadosGW node & 1 upload-node, speed upload = 50MB/s
/upload-node; each RadosGW have input/output = 25MB/s ==> sum input/ouput
of 2 Rados-GW = 50MB/s

c) When i use 1 RadosGW node & 2 upload-node, speed upload = 25MB/s
/upload-node ==> sum output of 2 upload-node = 50MB/s, RadosGW have
input/output = 50MB/s

d) When i use 2 RadosGW node & 2 upload-node, speed upload = 25MB/s
/upload-node ==> sum output of 2 upload-node = 50MB/s; each RadosGW have
input/output = 25MB/s ==> sum input/ouput of 2 Rados-GW = 50MB/s

*Problem*: i can pass limit 50MB/s when put file over Rados-GW, regardless
of the number Rados-GW nodes and upload-nodes.
When i use this CEPH cluster over librados (openstack/kvm), i can easily
achieve > 300MB/s

I don't know why performance of RadosGW is so low. What's bottleneck?

Thank you very much!

--e89a8f23463596b88704e7307d3e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>I have a CEPH cluster with 9 nodes (6 =
data nodes &amp; 3 mon/mds nodes)<br>And i setup 4 separate nodes to test p=
erformance of Rados-GW:<br></div>=A0- 2 node run Rados-GW<br></div>=A0- 2 n=
ode run multi-process put file to [multi] Rados-GW <br>
<br></div>Result:<br></div><div>a) When i use 1 RadosGW node &amp; 1 upload=
-node, speed upload =3D 50MB/s /upload-node, Rados-GW input/output speed =
=3D 50MB/s<br><br></div><div>b)  When i use 2 RadosGW node &amp; 1 upload-n=
ode, speed upload =3D 50MB/s /upload-node; each RadosGW have input/output =
=3D 25MB/s =3D=3D&gt; sum input/ouput of 2 Rados-GW =3D 50MB/s<br>
<br></div><div>c) When i use 1 RadosGW node &amp; 2 upload-node, speed uplo=
ad =3D 25MB/s /upload-node =3D=3D&gt; sum output of 2 upload-node =3D 50MB/=
s, RadosGW have input/output =3D 50MB/s<br><br></div><div>d) When i use 2 R=
adosGW node &amp; 2 upload-node, speed upload =3D 25MB/s /upload-node =3D=
=3D&gt; sum output of 2 upload-node =3D 50MB/s; each RadosGW have input/out=
put =3D 25MB/s =3D=3D&gt; sum input/ouput of 2 Rados-GW =3D 50MB/s<br>
<br></div><div><u><b>Problem</b></u>: i can pass limit 50MB/s when put file=
 over Rados-GW, regardless of the number Rados-GW nodes and upload-nodes. <=
br>When i use  this CEPH cluster over librados (openstack/kvm), i can easil=
y achieve &gt; 300MB/s<br>
<br>I don&#39;t know why performance of RadosGW is so low. What&#39;s bottl=
eneck?<br><br></div><div>Thank you very much!<br></div><div><div><div><div>=
<br><br></div></div></div></div></div>

--e89a8f23463596b88704e7307d3e--

--===============2146842662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2146842662==--
