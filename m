From: Wesley Peng <wesley.peng1-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: v14.2.3 Nautilus released
Date: Wed, 4 Sep 2019 21:52:18 +0800
Message-ID: <CAKyZhjt_yTX6JpCALyG4wApAtJ=Ff0JY2-zgPgbLVDrLk8dH0g@mail.gmail.com>
References: <87v9u8dvjh.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1826308987961894806=="
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <87v9u8dvjh.fsf-IBi9RG/b67k@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Cc: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, dev-a8pt6IJUokc@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1826308987961894806==
Content-Type: multipart/alternative; boundary="000000000000a31f2a0591ba8583"

--000000000000a31f2a0591ba8583
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your work. We are using Ceph happily.

Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>=E4=BA=8E2019=E5=B9=B49=E6=9C=884=E6=
=97=A5 =E5=91=A8=E4=B8=89=E4=B8=8B=E5=8D=889:48=E5=86=99=E9=81=93=EF=BC=9A

>
> This is the third bug fix release of Ceph Nautilus release series. This
> release fixes a security issue. We recommend all Nautilus users upgrade
> to this release. For upgrading from older releases of ceph, general
> guidelines for upgrade to nautilus must be followed
>
> Notable Changes
> ---------------
> * CVE-2019-10222 - Fixed a denial of service vulnerability where an
>   unauthenticated client of Ceph Object Gateway could trigger a crash fro=
m
> an
>   uncaught exception
> * Nautilus-based librbd clients can now open images on Jewel clusters.
> * The RGW `num_rados_handles` has been removed. If you were using a value
> of
>   `num_rados_handles` greater than 1, multiply your current
>   `objecter_inflight_ops` and `objecter_inflight_op_bytes` parameters by
> the
>   old `num_rados_handles` to get the same throttle behavior.
> * The secure mode of Messenger v2 protocol is no longer experimental with
> this
>   release. This mode is now the preferred mode of connection for monitors=
.
> * "osd_deep_scrub_large_omap_object_key_threshold" has been lowered to
> detect an
>   object with large number of omap keys more easily.
>
> For a detailed changelog please refer to the official release notes
> entry at the ceph blog:
> https://ceph.io/releases/v14-2-3-nautilus-released/
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-14.2.3.tar.gz
> * For packages, see http://docs.ceph.com/docs/master/install/get-packages=
/
> * Release git sha1: 0f776cf838a1ae3130b2b73dc26be9c95c6ccc39
>
> --
> Abhishek Lekshmanan
> SUSE Software Solutions Germany GmbH
> _______________________________________________
> ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
> To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
>

--000000000000a31f2a0591ba8583
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Thanks for your work. We are using Ceph happily.</di=
v></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">Abhishek Lekshmanan &lt;<a href=3D"mailto:abhishek-IBi9RG/b67k@public.gmane.org">abhishe=
k@suse.com</a>&gt;=E4=BA=8E2019=E5=B9=B49=E6=9C=884=E6=97=A5 =E5=91=A8=E4=
=B8=89=E4=B8=8B=E5=8D=889:48=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><br>
This is the third bug fix release of Ceph Nautilus release series. This<br>
release fixes a security issue. We recommend all Nautilus users upgrade<br>
to this release. For upgrading from older releases of ceph, general<br>
guidelines for upgrade to nautilus must be followed<br>
<br>
Notable Changes<br>
---------------<br>
* CVE-2019-10222 - Fixed a denial of service vulnerability where an<br>
=C2=A0 unauthenticated client of Ceph Object Gateway could trigger a crash =
from an<br>
=C2=A0 uncaught exception<br>
* Nautilus-based librbd clients can now open images on Jewel clusters.<br>
* The RGW `num_rados_handles` has been removed. If you were using a value o=
f<br>
=C2=A0 `num_rados_handles` greater than 1, multiply your current<br>
=C2=A0 `objecter_inflight_ops` and `objecter_inflight_op_bytes` parameters =
by the<br>
=C2=A0 old `num_rados_handles` to get the same throttle behavior.<br>
* The secure mode of Messenger v2 protocol is no longer experimental with t=
his<br>
=C2=A0 release. This mode is now the preferred mode of connection for monit=
ors.<br>
* &quot;osd_deep_scrub_large_omap_object_key_threshold&quot; has been lower=
ed to detect an<br>
=C2=A0 object with large number of omap keys more easily.<br>
<br>
For a detailed changelog please refer to the official release notes <br>
entry at the ceph blog: <a href=3D"https://ceph.io/releases/v14-2-3-nautilu=
s-released/" rel=3D"noreferrer" target=3D"_blank">https://ceph.io/releases/=
v14-2-3-nautilus-released/</a><br>
<br>
Getting Ceph<br>
------------<br>
<br>
* Git at git://<a href=3D"http://github.com/ceph/ceph.git" rel=3D"noreferre=
r" target=3D"_blank">github.com/ceph/ceph.git</a><br>
* Tarball at <a href=3D"http://download.ceph.com/tarballs/ceph-14.2.3.tar.g=
z" rel=3D"noreferrer" target=3D"_blank">http://download.ceph.com/tarballs/c=
eph-14.2.3.tar.gz</a><br>
* For packages, see <a href=3D"http://docs.ceph.com/docs/master/install/get=
-packages/" rel=3D"noreferrer" target=3D"_blank">http://docs.ceph.com/docs/=
master/install/get-packages/</a><br>
* Release git sha1: 0f776cf838a1ae3130b2b73dc26be9c95c6ccc39<br>
<br>
-- <br>
Abhishek Lekshmanan<br>
SUSE Software Solutions Germany GmbH<br>
_______________________________________________<br>
ceph-users mailing list -- <a href=3D"mailto:ceph-users-a8pt6IJUokc@public.gmane.org" target=3D"=
_blank">ceph-users-a8pt6IJUokc@public.gmane.org</a><br>
To unsubscribe send an email to <a href=3D"mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org"=
 target=3D"_blank">ceph-users-leave-a8pt6IJUokc@public.gmane.org</a><br>
</blockquote></div></div>

--000000000000a31f2a0591ba8583--

--===============1826308987961894806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org

--===============1826308987961894806==--
