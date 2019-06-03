From: Martin Verges <martin.verges-iZXOWb+A65A@public.gmane.org>
Subject: Re: bluestore block.db on SSD, where block.wal?
Date: Mon, 3 Jun 2019 08:13:31 +0200
Message-ID: <CAOf0rEtVbFergwJRpt5M5i2=9YMs_-qfOEyNLpvCnotnCkC4Kw@mail.gmail.com>
References: <CANA9Uk6nU4KZtipsZe=wXwck5ZP93rUmrvk8cvUmYjNoZwP8Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0037173649973572721=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk6nU4KZtipsZe=wXwck5ZP93rUmrvk8cvUmYjNoZwP8Wg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0037173649973572721==
Content-Type: multipart/alternative; boundary="0000000000001971c7058a654479"

--0000000000001971c7058a654479
Content-Type: text/plain; charset="UTF-8"

Hello,

please see
https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg54607.html and
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-October/030740.html
.

--
Martin Verges
Managing director

Mobile: +49 174 9335695
E-Mail: martin.verges-iZXOWb+A65A@public.gmane.org
Chat: https://t.me/MartinVerges

croit GmbH, Freseniusstr. 31h, 81247 Munich
CEO: Martin Verges - VAT-ID: DE310638492
Com. register: Amtsgericht Munich HRB 231263

Web: https://croit.io
YouTube: https://goo.gl/PGE1Bx


Am So., 2. Juni 2019 um 18:43 Uhr schrieb M Ranga Swami Reddy <
swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> Hello - I planned to use the bluestore's block.db on SSD (and data is on
> HDD) with 4% of HDD size. Here I have not mentioned the block.wal..in this
> case where block.wal place?
> is it in HDD (ie data) or in block.db of SSD?
>
> Thanks
> Swami
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--0000000000001971c7058a654479
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>please see=C2=A0<a href=3D"https=
://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg54607.html">https://ww=
w.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg54607.html</a>=C2=A0and=C2=
=A0<a href=3D"http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-Octo=
ber/030740.html">http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-O=
ctober/030740.html</a>.</div><div><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature">--<br>Martin Ve=
rges<br>Managing director<br><br>Mobile: +49 174 9335695<br>E-Mail: <a href=
=3D"mailto:martin.verges-iZXOWb+A65A@public.gmane.org" target=3D"_blank">martin.verges-iZXOWb+A65A@public.gmane.org=
</a><br>Chat: <a href=3D"https://t.me/MartinVerges" target=3D"_blank">https=
://t.me/MartinVerges</a><br><br>croit GmbH, Freseniusstr. 31h, 81247 Munich=
<br>CEO: Martin Verges - VAT-ID: DE310638492<br>Com. register: Amtsgericht =
Munich HRB 231263<br><br>Web: <a href=3D"https://croit.io" target=3D"_blank=
">https://croit.io</a><br>YouTube: <a href=3D"https://goo.gl/PGE1Bx" target=
=3D"_blank">https://goo.gl/PGE1Bx</a><br></div></div><br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am So., 2. J=
uni 2019 um 18:43=C2=A0Uhr schrieb M Ranga Swami Reddy &lt;<a href=3D"mailt=
o:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hello - I planned to=
 use the bluestore&#39;s block.db on SSD (and data is on HDD) with 4% of HD=
D size. Here I have not mentioned the block.wal..in this case where block.w=
al place?<div>is it in HDD (ie data) or in block.db of SSD?</div><div><br><=
/div><div>Thanks</div><div>Swami</div></div>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--0000000000001971c7058a654479--

--===============0037173649973572721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0037173649973572721==--
