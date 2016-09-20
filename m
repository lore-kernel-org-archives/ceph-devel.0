From: David <dclistslinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Jewel Docs | error on mount.ceph page
Date: Tue, 20 Sep 2016 18:48:17 +0100
Message-ID: <CAGxt-avsxSa9BcD-E+YTB5OKpduy02s3=AoytDPqZ4370Rwyfg@mail.gmail.com>
References: <CAGxt-as_LjROO8=gAfDk+y1DsQvvmvfo78dCFH+pYBgx-wdzhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0671753150=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGxt-as_LjROO8=gAfDk+y1DsQvvmvfo78dCFH+pYBgx-wdzhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0671753150==
Content-Type: multipart/alternative; boundary=001a1141c640a94ce1053cf408f7

--001a1141c640a94ce1053cf408f7
Content-Type: text/plain; charset=UTF-8

Sorry I don't know the correct way to report this.

Potential error on this page:

on http://docs.ceph.com/docs/jewel/man/8/mount.ceph/

Currently:

rsize
int (bytes), max readahead, multiple of 1024, Default: 524288 (512*1024)

Should it be something like the following?

rsize
int (bytes), max read size. Default: none

rasize
int (bytes), max readahead, multiple of 1024, Default: 8388608 (8192*1024)

--001a1141c640a94ce1053cf408f7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Sorry I don&#39;t know the correct way to report this.</p>
<p dir=3D"ltr">Potential error on this page:</p>
<p dir=3D"ltr">on=C2=A0<a href=3D"http://docs.ceph.com/docs/jewel/man/8/mou=
nt.ceph/">http://docs.ceph.com/docs/jewel/man/8/mount.ceph/</a></p>
<p dir=3D"ltr">Currently:</p>
<p dir=3D"ltr">rsize<br>
int (bytes), max readahead, multiple of 1024, Default: 524288 (512*1024)</p=
>
<p dir=3D"ltr">Should it be something like the following?</p>
<p dir=3D"ltr">rsize<br>
int (bytes), max read size. Default: none</p>
<p dir=3D"ltr">rasize<br>
int (bytes), max readahead, multiple of 1024, Default: 8388608 (8192*1024)<=
/p>

--001a1141c640a94ce1053cf408f7--

--===============0671753150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0671753150==--
