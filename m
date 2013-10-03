From: Darren Birkett <darren.birkett-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: OpenStack Grizzly Authentication (Keystone PKI)
 with RADOS Gateway
Date: Thu, 3 Oct 2013 12:45:57 +0100
Message-ID: <CAHX4EnNCUXU=PtXWGJZVgaBTKFup56bWCySGX9m6jkRDAotxRg@mail.gmail.com>
References: <CADgBPFDkw7aoVwXumn+O6ZgfEKsnDtPsYx7zONzMQ6m4Rk++Yg@mail.gmail.com>
Reply-To: darren.birkett-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0094032853=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADgBPFDkw7aoVwXumn+O6ZgfEKsnDtPsYx7zONzMQ6m4Rk++Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Amit Vijairania <amit.vijairania-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0094032853==
Content-Type: multipart/alternative; boundary=001a11c380b0a5137a04e7d4badc

--001a11c380b0a5137a04e7d4badc
Content-Type: text/plain; charset=ISO-8859-1

Hi Amit,

It can, but at the moment there is some issue with keystone token caching
(in Dumpling), so every auth call hits keystone and does not cache the
token.

See here:

http://www.spinics.net/lists/ceph-users/msg04531.html

and here:

http://tracker.ceph.com/issues/6360


Thanks

Darren



On 28 September 2013 03:24, Amit Vijairania <amit.vijairania-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:

> Hello!
>
> Does RADOS Gateway supports or integrates with OpenStack (Grizzly)
> Authentication (Keystone PKI)?
>
> Can RADOS Gateway use PKI tokens to conduct user token verification
> without explicit calls to Keystone.
>
> Thanks!
> Amit
>
> Amit Vijairania  |  978.319.3684
> --*--
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--001a11c380b0a5137a04e7d4badc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"arial, helvetica, sans-serif">Hi Amit,</font=
><div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><fo=
nt face=3D"arial, helvetica, sans-serif">It can, but at the moment there is=
 some issue with keystone token caching (in Dumpling), so every auth call h=
its keystone and does not cache the token.</font></div>
<div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><fon=
t face=3D"arial, helvetica, sans-serif">See here:</font></div><div><font fa=
ce=3D"arial, helvetica, sans-serif"><br></font></div><div><font face=3D"ari=
al, helvetica, sans-serif"><a href=3D"http://www.spinics.net/lists/ceph-use=
rs/msg04531.html">http://www.spinics.net/lists/ceph-users/msg04531.html</a>=
<br>
</font></div><div><font face=3D"arial, helvetica, sans-serif"><br></font></=
div><div><font face=3D"arial, helvetica, sans-serif">and here:</font></div>=
<div><pre><font color=3D"#000000" face=3D"arial, helvetica, sans-serif"><a =
href=3D"http://tracker.ceph.com/issues/6360">http://tracker.ceph.com/issues=
/6360</a></font></pre>
<pre><font color=3D"#000000" face=3D"arial, helvetica, sans-serif"><br></fo=
nt></pre><pre><font color=3D"#000000" face=3D"arial, helvetica, sans-serif"=
>Thanks</font></pre><pre><font color=3D"#000000" face=3D"arial, helvetica, =
sans-serif">Darren</font></pre>
</div><div class=3D"gmail_extra"><font face=3D"arial, helvetica, sans-serif=
"><br><br></font><div class=3D"gmail_quote"><font face=3D"arial, helvetica,=
 sans-serif">On 28 September 2013 03:24, Amit Vijairania <span dir=3D"ltr">=
&lt;<a href=3D"mailto:amit.vijairania-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">amit.vij=
airania-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
</font><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><font face=3D"arial,=
 helvetica, sans-serif">Hello!</font><div><font face=3D"arial, helvetica, s=
ans-serif"><br>
</font></div><div><font face=3D"arial, helvetica, sans-serif">Does RADOS Ga=
teway supports or integrates with OpenStack (Grizzly) Authentication (Keyst=
one PKI)?</font></div>
<div><font color=3D"#000000" face=3D"arial, helvetica, sans-serif"><br></fo=
nt></div><div><font face=3D"arial, helvetica, sans-serif"><font color=3D"#0=
00000">Can RADOS Gateway=A0use PKI tokens to conduct user token verificatio=
n without explicit calls to Keystone.</font></font></div>

<div><font face=3D"arial, helvetica, sans-serif"><font color=3D"#000000"><b=
r></font></font></div><div><font face=3D"arial, helvetica, sans-serif"><fon=
t color=3D"#000000">Thanks!</font></font></div><div><font face=3D"arial, he=
lvetica, sans-serif"><font color=3D"#000000">Amit<span class=3D"HOEnZb"><fo=
nt color=3D"#888888"><br clear=3D"all">

</font></span></font><span class=3D"HOEnZb"><font color=3D"#888888"><div><d=
iv dir=3D"ltr"><br>Amit Vijairania =A0| =A0<a href=3D"tel:978.319.3684" val=
ue=3D"+19783193684" target=3D"_blank">978.319.3684</a><br>--*--</div></div>
</font></span></font></div></div>
<font face=3D"arial, helvetica, sans-serif"><br>___________________________=
____________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></font></blockquote></div><br></div></div>

--001a11c380b0a5137a04e7d4badc--

--===============0094032853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0094032853==--
