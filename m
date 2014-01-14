From: ZHOU Yuan <dunk007-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: crush choose firstn vs. indep
Date: Tue, 14 Jan 2014 14:49:06 +0800
Message-ID: <CADTt812pZoObC+LWRGPSDFudpFSW4KR9B+z5=cMFsJLQoXCGWw@mail.gmail.com>
References: <24E144B8C0207547AD09C467A8259F75592E55C0@lisa.maurer-it.com>
	<52D32729.40400@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1386063274=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <52D32729.40400-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1386063274==
Content-Type: multipart/alternative; boundary=089e0160bd3ae16ac404efe89759

--089e0160bd3ae16ac404efe89759
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Loic, thanks for the education!

I=92m also trying to understand the new =91indep=92 mode. Is this new mode
designed for Ceph-EC only? It seems that all of the data in 3-copy system
are equivalent and this new algorithm should also work?


Sincerely, Yuan


On Mon, Jan 13, 2014 at 7:37 AM, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org> wrote:

>
>
> On 12/01/2014 15:55, Dietmar Maurer wrote:
> > From the docs:
> >
> >
> >
> > step [choose|chooseleaf] [firstn|indep] <N> <bucket-type>
> >
> >
> >
> > What exactly is the difference between =91firstn=92 and =91indep=92?
> >
> Hi,
>
> For Ceph releases up to Emperor[1], firstn is used and I'm not aware of a
> use case requiring indep. As part of the effort to implement erasure code=
d
> pools, firstn[2] and indep[3] were separated in two functions. The firstn
> method is best suited for replicated pools. The indep method tries to
> minimize the position changes in case an OSD becomes unavailable. For
> instance, if indep finds
>
>   [1,2,3,4]
>
> and after a while 3 become unavailable, it is very likely to replace it
> with
>
>   [1,2,5,4]
>
> It matters to erasure coded pools because
>
>   [4,5,2,1]
>
> (i.e. the same OSDs but in different positions), implies more I/O. Anothe=
r
> difference is that in the case of a mapping failure (i.e. unable to find
> the required number of OSDs), firstn will return a short list ( for
> instance [1,2,3] when 4 are required ) and indep will return a list with =
a
> placeholder at the missing position ( for instance [1,2,CRUSH_ITEM_NONE,4=
]
> ).
>
> Cheers
>
> [1] implementation in releases up to Emperor
> https://github.com/ceph/ceph/blob/v0.72/src/crush/mapper.c#L295
> [2] firstn https://github.com/ceph/ceph/blob/v0.74/src/crush/mapper.c#L29=
5
> [3] indep https://github.com/ceph/ceph/blob/v0.74/src/crush/mapper.c#L459
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--089e0160bd3ae16ac404efe89759
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Loic, thanks for the education!<br><br>I=92m also tryin=
g to understand the new =91indep=92 mode. Is this new mode designed for Cep=
h-EC only? It seems that all of the data in 3-copy system are equivalent an=
d this new algorithm should also work?<br>

<br clear=3D"all"><div class=3D"gmail_extra"><div><br>Sincerely, Yuan <br><=
/div>
<br><br><div class=3D"gmail_quote">On Mon, Jan 13, 2014 at 7:37 AM, Loic Da=
chary <span dir=3D"ltr">&lt;<a href=3D"mailto:loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org" target=3D"_=
blank">loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">

<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 12/01/2014 15:55, Dietmar Maurer wrote:<br>
&gt; From the docs:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; step [choose|chooseleaf] [firstn|indep] &lt;N&gt; &lt;bucket-type&gt;<=
br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; What exactly is the difference between =91firstn=92 and =91indep=92?<b=
r>
&gt;<br>
</div></div>Hi,<br>
<br>
For Ceph releases up to Emperor[1], firstn is used and I&#39;m not aware of=
 a use case requiring indep. As part of the effort to implement erasure cod=
ed pools, firstn[2] and indep[3] were separated in two functions. The first=
n method is best suited for replicated pools. The indep method tries to min=
imize the position changes in case an OSD becomes unavailable. For instance=
, if indep finds<br>


<br>
=A0 [1,2,3,4]<br>
<br>
and after a while 3 become unavailable, it is very likely to replace it wit=
h<br>
<br>
=A0 [1,2,5,4]<br>
<br>
It matters to erasure coded pools because<br>
<br>
=A0 [4,5,2,1]<br>
<br>
(i.e. the same OSDs but in different positions), implies more I/O. Another =
difference is that in the case of a mapping failure (i.e. unable to find th=
e required number of OSDs), firstn will return a short list ( for instance =
[1,2,3] when 4 are required ) and indep will return a list with a placehold=
er at the missing position ( for instance [1,2,CRUSH_ITEM_NONE,4] ).<br>


<br>
Cheers<br>
<br>
[1] implementation in releases up to Emperor <a href=3D"https://github.com/=
ceph/ceph/blob/v0.72/src/crush/mapper.c#L295" target=3D"_blank">https://git=
hub.com/ceph/ceph/blob/v0.72/src/crush/mapper.c#L295</a><br>
[2] firstn <a href=3D"https://github.com/ceph/ceph/blob/v0.74/src/crush/map=
per.c#L295" target=3D"_blank">https://github.com/ceph/ceph/blob/v0.74/src/c=
rush/mapper.c#L295</a><br>
[3] indep <a href=3D"https://github.com/ceph/ceph/blob/v0.74/src/crush/mapp=
er.c#L459" target=3D"_blank">https://github.com/ceph/ceph/blob/v0.74/src/cr=
ush/mapper.c#L459</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Lo=EFc Dachary, Artisan Logiciel Libre<br>
<br>
</font></span><br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br></div></div>

--089e0160bd3ae16ac404efe89759--

--===============1386063274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1386063274==--
