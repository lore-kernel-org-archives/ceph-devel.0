From: Tanay Ganguly <tanayganguly-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: How to test rbd's Copy-on-Read Feature
Date: Mon, 30 Mar 2015 15:30:11 +0530
Message-ID: <CAGRVuSspg3tPgpHVFXL+NexEvNFYzr-VONAe44epC4XhsxgqDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0284354156=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0284354156==
Content-Type: multipart/alternative; boundary=001a1140a9d4396f3a05127e8c90

--001a1140a9d4396f3a05127e8c90
Content-Type: text/plain; charset=UTF-8

Hello All,

I went through the below link and checked that Copy-on-Read is currently
supported only on librbd and not on rbd kernel module.

https://wiki.ceph.com/Planning/Blueprints/Infernalis/rbd%3A_kernel_rbd_client_supports_copy-on-read

Can someone please let me know how to test Copy-on-Read using librbd ?
What should be the IO pattern to see the performance changes.

Any pointers appreciated.

Thank You,
Tanay

--001a1140a9d4396f3a05127e8c90
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello All,<br><br></div>I went th=
rough the below link and checked that Copy-on-Read is currently supported o=
nly on librbd and not on rbd kernel module.<br><br><a href=3D"https://wiki.=
ceph.com/Planning/Blueprints/Infernalis/rbd%3A_kernel_rbd_client_supports_c=
opy-on-read">https://wiki.ceph.com/Planning/Blueprints/Infernalis/rbd%3A_ke=
rnel_rbd_client_supports_copy-on-read</a><br><br></div>Can someone please l=
et me know how to test Copy-on-Read using librbd ?<br></div><div>What shoul=
d be the IO pattern to see the performance changes.<br></div><div><br></div=
>Any pointers appreciated.<br><br></div>Thank You,<br></div>Tanay<br></div>

--001a1140a9d4396f3a05127e8c90--

--===============0284354156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0284354156==--
