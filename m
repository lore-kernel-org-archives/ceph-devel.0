From: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ceph s3 allowed characters
Date: Fri, 30 Aug 2013 09:59:29 -0400
Message-ID: <CANtztVysF7AbZiMimU1zhyBPu35+xQhSvUU+PNRDb42ro2uhng@mail.gmail.com>
References: <CAMNMNTxn3DCbVAnvY1K7PE7Z1oWy-4nM_XKT92+xYEBxKzd=Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1446056108=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTxn3DCbVAnvY1K7PE7Z1oWy-4nM_XKT92+xYEBxKzd=Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1446056108==
Content-Type: multipart/alternative; boundary=001a11c309e89ebaba04e52aa125

--001a11c309e89ebaba04e52aa125
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Aug 30, 2013 at 9:52 AM, Dominik Mostowiec <
dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
> I got err (400) from radosgw on request:
> 2013-08-30 08:09:19.396812 7f3b307c0700  2 req 3070:0.000150::POST
> /dysk/files/test.test%
> 40op.pl/DOMIWENT%202013/DW%202013_03_27/PROJEKTY%202012/ZB%20KROL/Szko%C5%82a%20%C5%81aziska%20ZB%20KROL/sala-%A3aziska_Dolne_PB-0_went_15_11_06%20Layout1%20%283%29.pdf::http
> status=400
> 2013-08-30 08:09:34.851892 7f3b55ffb700 10
> s->object=files/test.test-FWhLrETftxM@public.gmane.org/DOMIWENT 2013/Damian
> DW/dw/Specyfikacja istotnych warunk<F3>w zam<F3>wienia.doc
> s->bucket=dysk
>
> What is allowed range of chars in url in radosgw?
>

Can you post the full HTTP headers for the response?

The output you are pasting is not entirely clear to me, is that a single
log line for the whole request? Maybe it is just the formatting that
is throwing me off.

>
> --
> Regards
> Dominik
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11c309e89ebaba04e52aa125
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, Aug 30, 2013 at 9:52 AM, Dominik Mostowiec <span dir=3D"ltr=
">&lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">domin=
ikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
I got err (400) from radosgw on request:<br>
2013-08-30 08:09:19.396812 7f3b307c0700 =A02 req 3070:0.000150::POST<br>
/dysk/files/test.test%<a href=3D"http://40op.pl/DOMIWENT%202013/DW%202013_0=
3_27/PROJEKTY%202012/ZB%20KROL/Szko%C5%82a%20%C5%81aziska%20ZB%20KROL/sala-=
%A3aziska_Dolne_PB-0_went_15_11_06%20Layout1%20%283%29.pdf::http
status=3D400" target=3D"_blank">40op.pl/DOMIWENT%202013/DW%202013_03_27/PRO=
JEKTY%202012/ZB%20KROL/Szko%C5%82a%20%C5%81aziska%20ZB%20KROL/sala-%A3azisk=
a_Dolne_PB-0_went_15_11_06%20Layout1%20%283%29.pdf::http<br>
status=3D400</a><br>
2013-08-30 08:09:34.851892 7f3b55ffb700 10<br>
s-&gt;object=3Dfiles/<a href=3D"http://test.test-FWhLrETftxM@public.gmane.org/DOMIWENT" target=3D"=
_blank">test.test-FWhLrETftxM@public.gmane.org/DOMIWENT</a> 2013/Damian<br>
DW/dw/Specyfikacja istotnych warunk&lt;F3&gt;w zam&lt;F3&gt;wienia.doc<br>
s-&gt;bucket=3Ddysk<br>
<br>
What is allowed range of chars in url in radosgw?<br></blockquote><div><br>=
</div><div>Can you post the full HTTP headers for the response? <br><br></d=
iv><div>The output you are pasting is not entirely clear to me, is that a s=
ingle log line for the whole request? Maybe it is just the formatting that<=
br>
</div><div>is throwing me off. <br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Regards<br>
Dominik<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</font></span></blockquote></div><br></div></div>

--001a11c309e89ebaba04e52aa125--

--===============1446056108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1446056108==--
