From: shylesh kumar <shylesh.mohan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Is lttng enable by default in debian hammer-0.94.5?
Date: Fri, 30 Oct 2015 12:44:30 +0530
Message-ID: <CAMxOGo16ezMhPX_apkrB6RkVrL9_5=0UBoocfNArcmHnSaCetA@mail.gmail.com>
References: <5632E7E7.1030901@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0596390089=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5632E7E7.1030901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: hzwulibin <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0596390089==
Content-Type: multipart/alternative; boundary=089e010d8b24bc3b5d05234d2d70

--089e010d8b24bc3b5d05234d2d70
Content-Type: text/plain; charset=UTF-8

Hi,

Have you disabled apparmor?

Please check apparmor_status if libvirtd is in enforcing mode then lttng
traces will not be generated.

Thanks,
Shylesh

On Fri, Oct 30, 2015 at 9:15 AM, hzwulibin <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi, everyone
>
> After install hammer-0.94.5 in debian, i want to trace the librbd by
> lttng, but after done follow steps, i got nothing:
>  2036  mkdir -p traces
>  2037  lttng create -o traces librbd
>  2038  lttng enable-event -u 'librbd:*'
>  2039  lttng add-context -u -t pthread_id
>  2040  lttng start
>  2041  lttng stop
>
> So, is the lttng enabled in this version on debian?
>
> Thanks!
>
> --------------
> hzwulibin
> 2015-10-30
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Thanks & Regards
Shylesh Kumar M

--089e010d8b24bc3b5d05234d2d70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Have you disabled apparmor?</div><d=
iv><br></div><div>Please check apparmor_status if libvirtd is in enforcing =
mode then lttng traces will not be generated.</div><div><br></div><div>Than=
ks,</div><div>Shylesh</div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, Oct 30, 2015 at 9:15 AM, hzwulibin <span dir=3D"lt=
r">&lt;<a href=3D"mailto:hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">hzwulibin@g=
mail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi, ever=
yone<br>
<br>
After install hammer-0.94.5 in debian, i want to trace the librbd by lttng,=
 but after done follow steps, i got nothing:<br>
=C2=A02036=C2=A0 mkdir -p traces<br>
=C2=A02037=C2=A0 lttng create -o traces librbd<br>
=C2=A02038=C2=A0 lttng enable-event -u &#39;librbd:*&#39;<br>
=C2=A02039=C2=A0 lttng add-context -u -t pthread_id<br>
=C2=A02040=C2=A0 lttng start<br>
=C2=A02041=C2=A0 lttng stop<br>
<br>
So, is the lttng enabled in this version on debian?<br>
<br>
Thanks!<br>
<br>
--------------<br>
hzwulibin<br>
2015-10-30<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Thanks &amp; Regards<br>Shylesh Kumar M<br>=C2=A0</div=
>
</div>

--089e010d8b24bc3b5d05234d2d70--

--===============0596390089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0596390089==--
