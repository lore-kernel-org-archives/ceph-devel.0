From: =?UTF-8?Q?=C3=96zhan_R=C3=BCzgar_Karaman?= <oruzgarkaraman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and
	lumninous?
Date: Mon, 14 Nov 2016 13:59:34 +0300
Message-ID: <CAHazn6swvOZTrj2bXFKmtn_YRN5r7ytfpCde1-7SmHjJZoL33g@mail.gmail.com>
References: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
	<CA+z5DszZp-j450Q1HyfQQtEx9tqeazJ=PqnUkmwFND_kMrvk-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1692186069=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5DszZp-j450Q1HyfQQtEx9tqeazJ=PqnUkmwFND_kMrvk-g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1692186069==
Content-Type: multipart/alternative; boundary=001a1148e9263291a2054140bcbd

--001a1148e9263291a2054140bcbd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi;
There are still lots of people who are using 14.04 and its also supported
till 2019 so +1 for option 1.

Thanks
=C3=96zhan

On Fri, Nov 11, 2016 at 11:22 PM, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8@public.gmane.org=
m
> wrote:

> Worth considering OpenStack and Ubuntu cloudarchive release cycles
> here. Mitaka is the release where all Ubuntu OpenStack users need to
> upgrade from Trusty to Xenial - so far Mitaka and now Newton
> deployments are still in the minority (see the OpenStack
> user/deployment survey for the data) and I expect they will remain so
> until at least Ocata. So if you pick #2 or #3 it'd be best to still
> keep building and testing the client packages for Trusty.
>
> Cheers,
> Blair
>
> On 11 Nov 2016 10:45 AM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> Currently the distros we use for upstream testing are
>
>  centos 7.x
>  ubuntu 16.04 (xenial)
>  ubuntu 14.04 (trusty)
>
> We also do some basic testing for Debian 8 and Fedora (some old version).
>
> Jewel was the first release that had native systemd and full xenial
> support, so it's helpful to have both 14.04 and 16.04 supported to provid=
e
> an upgrade path.  But I think we can safely drop 14.04 now for kraken and
> luminous.  Our options are
>
> 1) keep testing on xenial and trusty, and keep building packages for both
>
> 2) stop testing trusty, but still build packages
>
> 3) stop testing or building for trusty
>
> Preferences?
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a1148e9263291a2054140bcbd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi;<div>There are still lots of people who are using 14.04=
 and its also supported till 2019 so +1 for option 1.</div><div><br></div><=
div>Thanks</div><div>=C3=96zhan</div></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Fri, Nov 11, 2016 at 11:22 PM, Blair Bethwaite=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">Worth considering OpenStack and Ubuntu cloudarchive rele=
ase cycles<br>
here. Mitaka is the release where all Ubuntu OpenStack users need to<br>
upgrade from Trusty to Xenial - so far Mitaka and now Newton<br>
deployments are still in the minority (see the OpenStack<br>
user/deployment survey for the data) and I expect they will remain so<br>
until at least Ocata. So if you pick #2 or #3 it&#39;d be best to still<br>
keep building and testing the client packages for Trusty.<br>
<br>
Cheers,<br>
Blair<br>
<span class=3D""><br>
On 11 Nov 2016 10:45 AM, &quot;Sage Weil&quot; &lt;<a href=3D"mailto:sweil@=
redhat.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
<br>
Currently the distros we use for upstream testing are<br>
<br>
=C2=A0centos 7.x<br>
=C2=A0ubuntu 16.04 (xenial)<br>
=C2=A0ubuntu 14.04 (trusty)<br>
<br>
We also do some basic testing for Debian 8 and Fedora (some old version).<b=
r>
<br>
Jewel was the first release that had native systemd and full xenial<br>
support, so it&#39;s helpful to have both 14.04 and 16.04 supported to prov=
ide<br>
an upgrade path.=C2=A0 But I think we can safely drop 14.04 now for kraken =
and<br>
luminous.=C2=A0 Our options are<br>
<br>
1) keep testing on xenial and trusty, and keep building packages for both<b=
r>
<br>
2) stop testing trusty, but still build packages<br>
<br>
3) stop testing or building for trusty<br>
<br>
Preferences?<br>
sage<br>
<br>
</span>--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
<div class=3D"HOEnZb"><div class=3D"h5">______________________________<wbr>=
_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</div></div></blockquote></div><br></div>

--001a1148e9263291a2054140bcbd--

--===============1692186069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1692186069==--
