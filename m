From: Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Discuss: New default recovery config settings
Date: Fri, 29 May 2015 22:16:58 +0000
Message-ID: <CAOnYue-zF1driSi1oxGCQ8Vh1UcG=viT5P8AeHA3R1NCca1o6w@mail.gmail.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1767545456=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1394947829.9758745.1432936033017.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org' (ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1767545456==
Content-Type: multipart/alternative; boundary=f46d041827e6476fb705173fd605

--f46d041827e6476fb705173fd605
Content-Type: text/plain; charset=UTF-8

Hi,

We did it the other way around instead, defining a period where the load is
lighter and turn off/on backfill/recover. Then you want the backfill values
to be the what is default right now.

Also, someone said that (think it was Greg?) If you have problems with
backfill, your cluster backing store is not fast enough/too much load.
If 10 osds goes down at the same time you want those values to be high to
minimize the downtime.

/Josef

fre 29 maj 2015 23:47 Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> skrev:

> Many people have reported that they need to lower the osd recovery config
> options to minimize the impact of recovery on client io.  We are talking
> about changing the defaults as follows:
>
> osd_max_backfills to 1 (from 10)
> osd_recovery_max_active to 3 (from 15)
> osd_recovery_op_priority to 1 (from 10)
> osd_recovery_max_single_start to 1 (from 5)
>
> We'd like a bit of feedback first though.  Is anyone happy with the
> current configs?  Is anyone using something between these values and the
> current defaults?  What kind of workload?  I'd guess that lowering
> osd_max_backfills to 1 is probably a good idea, but I wonder whether
> lowering osd_recovery_max_active and osd_recovery_max_single_start will
> cause small objects to recover unacceptably slowly.
>
> Thoughts?
> -Sam
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--f46d041827e6476fb705173fd605
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
Hi,</p>
<p dir=3D"ltr">We did it the other way around instead, defining a period wh=
ere the load is lighter and turn off/on backfill/recover. Then you want the=
 backfill values to be the what is default right now. </p>
<p dir=3D"ltr">Also, someone said that (think it was Greg?) If you have pro=
blems with backfill, your cluster backing store is not fast enough/too much=
 load.<br>
If 10 osds goes down at the same time you want those values to be high to m=
inimize the downtime.</p>
<p dir=3D"ltr">/Josef</p>
<br><div class=3D"gmail_quote">fre 29 maj 2015 23:47=C2=A0Samuel Just &lt;<=
a href=3D"mailto:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; skrev:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Many people have reported that they need to lower=
 the osd recovery config options to minimize the impact of recovery on clie=
nt io.=C2=A0 We are talking about changing the defaults as follows:<br>
<br>
osd_max_backfills to 1 (from 10)<br>
osd_recovery_max_active to 3 (from 15)<br>
osd_recovery_op_priority to 1 (from 10)<br>
osd_recovery_max_single_start to 1 (from 5)<br>
<br>
We&#39;d like a bit of feedback first though.=C2=A0 Is anyone happy with th=
e current configs?=C2=A0 Is anyone using something between these values and=
 the current defaults?=C2=A0 What kind of workload?=C2=A0 I&#39;d guess tha=
t lowering osd_max_backfills to 1 is probably a good idea, but I wonder whe=
ther lowering osd_recovery_max_active and osd_recovery_max_single_start wil=
l cause small objects to recover unacceptably slowly.<br>
<br>
Thoughts?<br>
-Sam<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div>

--f46d041827e6476fb705173fd605--

--===============1767545456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1767545456==--
