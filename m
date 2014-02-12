From: Ashish Chandra <mail.ashishchandra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Is it possible to have One Ceph-OSD-Daemon
 managing more than one OSD
Date: Wed, 12 Feb 2014 17:55:17 +0530
Message-ID: <CAP+3n31q75FmH6jBukTYzgS7ck2DN48rX6oo9HnpHz053XdYDg@mail.gmail.com>
References: <CAEvFgitj2DoJ=D-zCZghoRf2o910K1RokOOb=08TNyZ5ZUFvSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0787506147=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEvFgitj2DoJ=D-zCZghoRf2o910K1RokOOb=08TNyZ5ZUFvSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Vikrant Verma <vikrantverma99-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0787506147==
Content-Type: multipart/alternative; boundary=001a11c1f54069907404f234aae4

--001a11c1f54069907404f234aae4
Content-Type: text/plain; charset=ISO-8859-1

AFAIK, one ceph-osd daemon is tied to single OSD, identified by osd-num and
data path.


On Wed, Feb 12, 2014 at 4:58 PM, Vikrant Verma <vikrantverma99-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:

> Hi All,
>
> I have one quick question -
>
> Is it possible to have One Ceph-OSD-Daemon managing more than one Object
> Storage Device in a Ceph  Cluster?
>
> Regards,
> Vikrant
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--001a11c1f54069907404f234aae4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">AFAIK, one ceph-osd daemon is tied to single OSD, identifi=
ed by osd-num and data path.<br></div><div class=3D"gmail_extra"><br><br><d=
iv class=3D"gmail_quote">On Wed, Feb 12, 2014 at 4:58 PM, Vikrant Verma <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:vikrantverma99-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">vikrantverma99-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi All,<div><br></div><div>=
I have one quick question -=A0</div><div><br></div><div>Is it possible to h=
ave One Ceph-OSD-Daemon managing more than one Object Storage Device in a C=
eph =A0Cluster?<br>
</div><div><br>
</div><div>Regards,</div><div>Vikrant</div></div>
<br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br></div>

--001a11c1f54069907404f234aae4--

--===============0787506147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0787506147==--
