From: Roger Brown <rogerpbrown-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RGW: removal of support for fastcgi
Date: Fri, 05 May 2017 20:06:04 +0000
Message-ID: <CAFS+ELhCJ1usUSjPTwRPOzFtnR6HAcu4ic4EL=19aJVVY-OYsA@mail.gmail.com>
References: <CADRKj5SSio-vpfSBgJbEWTZC2HDqnWQsYd6K0auy-=F7PpBVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0036471090=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADRKj5SSio-vpfSBgJbEWTZC2HDqnWQsYd6K0auy-=F7PpBVeA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0036471090==
Content-Type: multipart/alternative; boundary=001a11491f24e97e42054ecc6bac

--001a11491f24e97e42054ecc6bac
Content-Type: text/plain; charset=UTF-8

I'm using fastcgi/apache2 instead of civetweb (centos7) because i couldn't
get civetweb to work with SSL on port 443 and in a subdomain of my main
website.
So I have domain.com, www.domain.com, s3.domain.com (RGW), and *.
s3.domain.com for the RGW buckets. As long as you can do the same with
civitweb for RGW, then maybe I don't care.

Roger


On Fri, May 5, 2017 at 1:51 PM Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
wrote:

> RGW has supported since forever. Originally it was the only supported
> frontend, and nowadays it is the least preferred one.
>
> Rgw was first developed over fastcgi + lighttpd, but there were some
> issues with this setup, so we switched to fastcgi + apache as our main
> supported configuration. This was also sub-optimal, as there wasn't a
> good, supported, and mainained fastcgi module for apache that we could
> find. At the time there were two modules: mod_fcgid, and mod_fastcgi.
> The former had a major flaw, which it buffered all PUTs before sending
> them to the backend (rgw). It also didn't really support 100-continue.
> The latter was mostly unmaintained, and didn't quite support
> 100-continue either. We ended up maintaining a fork of mod_fastcgi for
> quite a while, which was a pain. Later came mod-proxy-fcgi, which also
> didn't fully support 100-continue (iirc), but it was maintained, and
> was good enough to use out of the box, so we settled on it. At that
> time we already had civetweb as a frontend, so we didn't really worry
> about it.
> Now, I'd like to know whether anyone actually uses and needs fastcgi.
> I get an occasional request to remove it altogether, and I'd like to
> have some more info before we go and do it. The requests for removal
> usually cite security reasons, but I can also add 'we don't really
> want to maintain it anymore'.
> A valid replacement for fastcgi could be using civetweb directly, or
> using mod-proxy (in apache, I'd expect similar solution in other
> webservers) with civetweb as the rgw frontend.
>
> TL;DR: Does anyone care if we remove support for fastcgi in rgw?
>
> Yehuda
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11491f24e97e42054ecc6bac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m using fastcgi/apache2 instead of civetweb (ce=
ntos7) because i couldn&#39;t get civetweb to work with SSL on port 443 and=
 in a subdomain of my main website.</div><div>So I have <a href=3D"http://d=
omain.com">domain.com</a>, <a href=3D"http://www.domain.com">www.domain.com=
</a>, <a href=3D"http://s3.domain.com">s3.domain.com</a> (RGW), and *.<a hr=
ef=3D"http://s3.domain.com">s3.domain.com</a> for the RGW buckets. As long =
as you can do the same with civitweb for RGW, then maybe I don&#39;t care.=
=C2=A0</div><div><br></div><div>Roger</div><div><br></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr">On Fri, May 5, 2017 at 1:51 PM Yehuda Sadeh-=
Weinraub &lt;<a href=3D"mailto:yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">RGW has supported since for=
ever. Originally it was the only supported<br>
frontend, and nowadays it is the least preferred one.<br>
<br>
Rgw was first developed over fastcgi + lighttpd, but there were some<br>
issues with this setup, so we switched to fastcgi + apache as our main<br>
supported configuration. This was also sub-optimal, as there wasn&#39;t a<b=
r>
good, supported, and mainained fastcgi module for apache that we could<br>
find. At the time there were two modules: mod_fcgid, and mod_fastcgi.<br>
The former had a major flaw, which it buffered all PUTs before sending<br>
them to the backend (rgw). It also didn&#39;t really support 100-continue.<=
br>
The latter was mostly unmaintained, and didn&#39;t quite support<br>
100-continue either. We ended up maintaining a fork of mod_fastcgi for<br>
quite a while, which was a pain. Later came mod-proxy-fcgi, which also<br>
didn&#39;t fully support 100-continue (iirc), but it was maintained, and<br=
>
was good enough to use out of the box, so we settled on it. At that<br>
time we already had civetweb as a frontend, so we didn&#39;t really worry<b=
r>
about it.<br>
Now, I&#39;d like to know whether anyone actually uses and needs fastcgi.<b=
r>
I get an occasional request to remove it altogether, and I&#39;d like to<br=
>
have some more info before we go and do it. The requests for removal<br>
usually cite security reasons, but I can also add &#39;we don&#39;t really<=
br>
want to maintain it anymore&#39;.<br>
A valid replacement for fastcgi could be using civetweb directly, or<br>
using mod-proxy (in apache, I&#39;d expect similar solution in other<br>
webservers) with civetweb as the rgw frontend.<br>
<br>
TL;DR: Does anyone care if we remove support for fastcgi in rgw?<br>
<br>
Yehuda<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div>

--001a11491f24e97e42054ecc6bac--

--===============0036471090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0036471090==--
