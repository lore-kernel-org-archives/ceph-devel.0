From: Sahana <shnal12-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Usage of Step choose
Date: Tue, 27 May 2014 19:25:25 +0530
Message-ID: <CAO65cbyC7wRfZyJ5MNh-c4UZnY4yjfxkgsF+xebYyR3Yx8Lcvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723758189=="
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
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0723758189==
Content-Type: multipart/alternative; boundary=20cf30223d3d35e2a404fa620c46

--20cf30223d3d35e2a404fa620c46
Content-Type: text/plain; charset=UTF-8

HI all,

Recently I was playing with crushmaps. I would like to know the difference
between step choose  and step chooseleaf.

when I used :

ruleset rule1{

...
step take default
step choose firstn 0 host
step emit
}

And I tested above using crushtool, it returned  ids of bucket host.

But when I used it in cluster, it chose osds.

If this works to get devices, then why we need chooseleaf.

Regards
Sahana.

--20cf30223d3d35e2a404fa620c46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">HI all,<div><br></div><div>Recently I was playing with cru=
shmaps. I would like to know the difference between step choose =C2=A0and s=
tep chooseleaf.</div><div><br></div><div>when I used :</div><div><br></div>=
<div>
ruleset rule1{</div><div><br></div><div>...</div><div>step take default</di=
v><div>step choose firstn 0 host</div><div>step emit</div><div>}</div><div>=
<br></div><div>And I tested above using crushtool, it returned =C2=A0ids of=
 bucket host.</div>
<div><br></div><div>But when I used it in cluster, it chose osds.</div><div=
><br></div><div>If this works to get devices, then why we need chooseleaf.<=
/div><div><br></div><div>Regards</div><div>Sahana.</div></div>

--20cf30223d3d35e2a404fa620c46--

--===============0723758189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0723758189==--
