From: David C <dcsysengineer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Deploying an Active/Active NFS Cluster over CephFS
Date: Wed, 12 Dec 2018 13:35:29 +0000
Message-ID: <CACo-D_Dew2bTznRTb_=2cjo6R705p+oy7N=sJ-uyw_E1230gqg@mail.gmail.com>
References: <e37575905d14e9342bcecb8445ad730d57b4d713.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7678804463148555400=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <e37575905d14e9342bcecb8445ad730d57b4d713.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, nfs-ganesha-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "support-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org" <support-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============7678804463148555400==
Content-Type: multipart/alternative; boundary="0000000000002297dd057cd34667"

--0000000000002297dd057cd34667
Content-Type: text/plain; charset="UTF-8"

Hi Jeff

Many thanks for this! Looking forward to testing it out.

Could you elaborate a bit on why Nautilus is recommended for this set-up
please. Would attempting this with a Luminous cluster be a non-starter?



On Wed, 12 Dec 2018, 12:16 Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:

> (Sorry for the duplicate email to ganesha lists, but I wanted to widen
> it to include the ceph lists)
>
> In response to some cries for help over IRC, I wrote up this blog post
> the other day, which discusses how to set up parallel serving over
> CephFS:
>
>
> https://jtlayton.wordpress.com/2018/12/10/deploying-an-active-active-nfs-cluster-over-cephfs/
>
> Feel free to comment if you have questions. We may be want to eventually
> turn this into a document in the ganesha or ceph trees as well.
>
> Cheers!
> --
> Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
>

--0000000000002297dd057cd34667
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Jeff<div dir=3D"auto"><br></div><div dir=3D"auto">Many=
 thanks for this! Looking forward to testing it out.=C2=A0</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Could you elaborate a bit on why Nautilu=
s is recommended for this set-up please. Would attempting this with a Lumin=
ous cluster be a non-starter?=C2=A0</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><br></div><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr">On Wed, 12 Dec 2018, 12:16 Jeff Layton &lt;<a href=3D"mailto:jlayt=
on-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">(Sorry for the duplicate email to ganesha lists, but I wanted to =
widen<br>
it to include the ceph lists)<br>
<br>
In response to some cries for help over IRC, I wrote up this blog post<br>
the other day, which discusses how to set up parallel serving over<br>
CephFS:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://jtlayton.wordpress.com/2018/12/10/deployin=
g-an-active-active-nfs-cluster-over-cephfs/" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://jtlayton.wordpress.com/2018/12/10/deploying-an-ac=
tive-active-nfs-cluster-over-cephfs/</a><br>
<br>
Feel free to comment if you have questions. We may be want to eventually<br=
>
turn this into a document in the ganesha or ceph trees as well.<br>
<br>
Cheers!<br>
-- <br>
Jeff Layton &lt;<a href=3D"mailto:jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank" rel=
=3D"noreferrer">jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
<br>
</blockquote></div></div>

--0000000000002297dd057cd34667--

--===============7678804463148555400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7678804463148555400==--
