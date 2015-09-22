From: Giridhar Yasa <giridhar.yasa-ay2nrczjKqVWk0Htik3J/w@public.gmane.org>
Subject: Re: radosgw + civetweb latency issue on Hammer
Date: Tue, 22 Sep 2015 14:48:59 +0530
Message-ID: <CAKP7xVzChyvFyTA41UbQh7opF4n=zgKRey+xJMO-5H19wjJ6sA@mail.gmail.com>
References: <CACAg-u97BjhmGbjRogKzmyTL_iPzj9C0qAbEgF28-ONFqe5Drw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0596189916=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CACAg-u97BjhmGbjRogKzmyTL_iPzj9C0qAbEgF28-ONFqe5Drw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Srikanth Madugundi <srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0596189916==
Content-Type: multipart/alternative; boundary=089e0160b770f56af00520527c34

--089e0160b770f56af00520527c34
Content-Type: text/plain; charset=UTF-8

I encountered the same issue in my setup (with an AWS SDK client) and on
further investigation found that 'rgw print continue' was set to false for
a civetweb driven rgw.

Updated http://tracker.ceph.com/issues/12640

Giridhar

--
Giridhar Yasa | Flipkart Engineering | http://www.flipkart.com/

On Thu, Aug 6, 2015 at 5:31 AM, Srikanth Madugundi <
srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
>
> After upgrading to Hammer and moving from apache to civetweb. We
> started seeing high PUT latency in the order of 2 sec for every PUT
> request. The GET request lo
>
> Attaching the radosgw logs for a single request. The ceph.conf has the
> following configuration for civetweb.
>
> [client.radosgw.gateway]
> rgw frontends = civetweb port=5632
>
>
> Further investion reveled the call to get_data() at
> https://github.com/ceph/ceph/blob/hammer/src/rgw/rgw_op.cc#L1786 is
> taking 2 sec to respond. The cluster is running Hammer 94.2 release
>
> Did any one face this issue before? Is there some configuration I am
> missing?
>
> Regards
> Srikanth
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--089e0160b770f56af00520527c34
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I encountered the same issue in my setup (with an AWS=
 SDK client) and on further investigation found that &#39;rgw print continu=
e&#39; was set to false for a civetweb driven rgw.</div><div><br></div><div=
>Updated=C2=A0<a href=3D"http://tracker.ceph.com/issues/12640">http://track=
er.ceph.com/issues/12640</a></div><div><br></div><div><div>Giridhar<br></di=
v></div></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div>--<br></div>Giridhar Yasa | Flip=
kart Engineering | <a href=3D"http://www.flipkart.com/" target=3D"_blank">h=
ttp://www.flipkart.com/</a><br></div></div></div>
<br><div class=3D"gmail_quote">On Thu, Aug 6, 2015 at 5:31 AM, Srikanth Mad=
ugundi <span dir=3D"ltr">&lt;<a href=3D"mailto:srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
" target=3D"_blank">srikanth.madugundi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Hi,<br>
<br>
After upgrading to Hammer and moving from apache to civetweb. We<br>
started seeing high PUT latency in the order of 2 sec for every PUT<br>
request. The GET request lo<br>
<br>
Attaching the radosgw logs for a single request. The ceph.conf has the<br>
following configuration for civetweb.<br>
<br>
[client.radosgw.gateway]<br>
rgw frontends =3D civetweb port=3D5632<br>
<br>
<br>
Further investion reveled the call to get_data() at<br>
<a href=3D"https://github.com/ceph/ceph/blob/hammer/src/rgw/rgw_op.cc#L1786=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/ceph/ceph/blob/ha=
mmer/src/rgw/rgw_op.cc#L1786</a> is<br>
taking 2 sec to respond. The cluster is running Hammer 94.2 release<br>
<br>
Did any one face this issue before? Is there some configuration I am missin=
g?<br>
<br>
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888">Srikanth<br>
</font></span><br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
<br></blockquote></div><br></div>

--089e0160b770f56af00520527c34--

--===============0596189916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0596189916==--
