From: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Initial performance cluster SimpleMessenger vs
 AsyncMessenger results
Date: Tue, 13 Oct 2015 10:56:31 +0800
Message-ID: <CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
References: <561BE4E3.7050404@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1753942434=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <561BE4E3.7050404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1753942434==
Content-Type: multipart/alternative; boundary=001a1143f84ed344a10521f39733

--001a1143f84ed344a10521f39733
Content-Type: text/plain; charset=UTF-8

COOL

Interesting that async messenger will consume more memory than simple, in
my mind I always think async should use less memory. I will give a look at
this

On Tue, Oct 13, 2015 at 12:50 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi Guy,
>
> Given all of the recent data on how different memory allocator
> configurations improve SimpleMessenger performance (and the effect of
> memory allocators and transparent hugepages on RSS memory usage), I thought
> I'd run some tests looking how AsyncMessenger does in comparison.  We spoke
> about these a bit at the last performance meeting but here's the full write
> up.  The rough conclusion as of right now appears to be:
>
> 1) AsyncMessenger performance is not dependent on the memory allocator
> like with SimpleMessenger.
>
> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB (ie
> default) thread cache.
>
> 3) AsyncMessenger is consistently faster than SimpleMessenger for 128K
> random reads.
>
> 4) AsyncMessenger is sometimes slower than SimpleMessenger when memory
> allocator optimizations are used.
>
> 5) AsyncMessenger currently uses far more RSS memory than SimpleMessenger.
>
> Here's a link to the paper:
>
> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view
>
> Mark
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 

Best Regards,

Wheat

--001a1143f84ed344a10521f39733
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">COOL<div><br></div><div>Interesting that async messenger w=
ill consume more memory than simple, in my mind I always think async should=
 use less memory. I will give a look at this</div></div><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Tue, Oct 13, 2015 at 12:50 AM, Ma=
rk Nelson <span dir=3D"ltr">&lt;<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" targe=
t=3D"_blank">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi Guy,<br>
<br>
Given all of the recent data on how different memory allocator configuratio=
ns improve SimpleMessenger performance (and the effect of memory allocators=
 and transparent hugepages on RSS memory usage), I thought I&#39;d run some=
 tests looking how AsyncMessenger does in comparison.=C2=A0 We spoke about =
these a bit at the last performance meeting but here&#39;s the full write u=
p.=C2=A0 The rough conclusion as of right now appears to be:<br>
<br>
1) AsyncMessenger performance is not dependent on the memory allocator like=
 with SimpleMessenger.<br>
<br>
2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB (ie d=
efault) thread cache.<br>
<br>
3) AsyncMessenger is consistently faster than SimpleMessenger for 128K rand=
om reads.<br>
<br>
4) AsyncMessenger is sometimes slower than SimpleMessenger when memory allo=
cator optimizations are used.<br>
<br>
5) AsyncMessenger currently uses far more RSS memory than SimpleMessenger.<=
br>
<br>
Here&#39;s a link to the paper:<br>
<br>
<a href=3D"https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/vie=
w" rel=3D"noreferrer" target=3D"_blank">https://drive.google.com/file/d/0B2=
gTBZrkrnpZS1Q4VktjZkhrNHc/view</a><br>
<br>
Mark<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">







<p>Best Regards,</p><p>Wheat</p></div>
</div>

--001a1143f84ed344a10521f39733--

--===============1753942434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1753942434==--
