From: Tim Zhang <cofol1986-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: why no likely() and unlikely() used in Ceph's source
	code?
Date: Mon, 15 Sep 2014 18:25:47 +0800
Message-ID: <CAGo8jtkpJpbLvMCV9nagNtWxcVBQssP1Mv=i5MYcWsh2GhOUeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1010747410=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1010747410==
Content-Type: multipart/alternative; boundary=001a11c11f64de8c710503180e6d

--001a11c11f64de8c710503180e6d
Content-Type: text/plain; charset=UTF-8

Hey guys,
After reading ceph source code, I find that there is a file named
common/likely.h and it implements the function likely() and unlikey() which
will optimize the prediction of code branch for cpu.
 But there isn't any place using these two functions, I am curious
about why the developer of ceph not using these two functions to achieve
more performance. Can anyone provide some hints?
BR

--001a11c11f64de8c710503180e6d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey guys,<div>After reading ceph source code, I find that =
there is a file named common/likely.h and it implements the function likely=
() and unlikey() which will optimize the prediction of code branch for cpu.=
</div><div>=C2=A0But there isn&#39;t any place using these two functions, I=
 am curious about=C2=A0why the developer of ceph not using these two functi=
ons to achieve more performance. Can anyone provide some hints?</div><div>B=
R</div><div><br></div></div>

--001a11c11f64de8c710503180e6d--

--===============1010747410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1010747410==--
