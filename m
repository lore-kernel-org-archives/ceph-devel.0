From: Goncalo Borges <goncalofilipeborges-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CRUSH puzzle: step weighted-take
Date: Fri, 28 Sep 2018 08:50:57 +1000
Message-ID: <CAL8KHarp1AyOCx5ymHUT4h9d7oJvWVFGh8UY87LXhfF7-heF2g@mail.gmail.com>
References: <CABZ+qqmMiGSF3g-WR9TLTUAxwdK3aCt0wq+ku5XWzukp0tJ04w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4463633920048933288=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqmMiGSF3g-WR9TLTUAxwdK3aCt0wq+ku5XWzukp0tJ04w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4463633920048933288==
Content-Type: multipart/alternative; boundary="000000000000b363010576e22cb5"

--000000000000b363010576e22cb5
Content-Type: text/plain; charset="UTF-8"

Hi Dan

Hope to find you ok.

Here goes a suggestion from someone who has been sitting in the side line
for the last 2 years but following stuff as much as possible

Will weight set per pool help?

This is only possible in luminous but according to the docs there is the
possibility to adjust positional weights for devices hosting replicas of
objects for a given bucket.

Cheers
Goncalo

--000000000000b363010576e22cb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Hi Dan</div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Hope to find you ok.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Here goes a suggestion from someone who has been sitting in the s=
ide line for the last 2 years but following stuff as much as possible=C2=A0=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Will weight set per poo=
l help?</div><div dir=3D"auto"><br></div><div dir=3D"auto">This is only pos=
sible in luminous but according to the docs there is the possibility to adj=
ust positional weights for devices hosting replicas of objects for a given =
bucket.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Cheers=C2=A0</di=
v><div dir=3D"auto">Goncalo=C2=A0</div><div dir=3D"auto"><div class=3D"sect=
ion" id=3D"creating-per-pool-weight-sets" style=3D"color:rgb(62,67,73);font=
-family:Helvetica,Arial,sans-serif;font-size:14px" dir=3D"auto"><p style=3D=
"line-height:1.5em"></p><table class=3D"docutils field-list" frame=3D"void"=
 rules=3D"none" style=3D"border:0px;border-collapse:collapse;margin:1.5em">=
<colgroup><col class=3D"field-name" style=3D"-webkit-hyphens: manual;"><col=
 class=3D"field-body"></colgroup><tbody valign=3D"top"><tr class=3D"field-o=
dd field"><th class=3D"field-name" style=3D"padding:1px 8px 1px 5px;border:=
0px!important"></th><td class=3D"field-body" style=3D"padding:1px 8px 1px 5=
px;border:0px!important"><br></td></tr></tbody></table></div></div>

--000000000000b363010576e22cb5--

--===============4463633920048933288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4463633920048933288==--
