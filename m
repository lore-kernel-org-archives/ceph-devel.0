From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: would people mind a slow osd restart during
	luminous upgrade?
Date: Thu, 09 Feb 2017 04:19:05 +0000
Message-ID: <CAN-Gep+5wDxpab3b5AN_i1m2uNHVvhWkjMWjmd7Rmi6Xbnciuw@mail.gmail.com>
References: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0649860484=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1702090302470.7782-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0649860484==
Content-Type: multipart/alternative; boundary=001a114355a6c9755d05481148a0

--001a114355a6c9755d05481148a0
Content-Type: text/plain; charset=UTF-8

The only issue I can think of is if there isn't a version of the clients
fully tested to work with a partially upgraded cluster or a documented
incompatibility requiring downtime. We've had upgrades where we had to
upgrade clients first and others that we had to do the clients last due to
issues with how the clients interacted with an older cluster, partially
upgraded cluster, or newer cluster.

If the FileStore is changing this much, I can imagine a Jewel client having
a hard time locating the objects it needs from a Luminous cluster.
On Wed, Feb 8, 2017 at 8:09 PM Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hello, ceph operators...
>
> Several times in the past we've had to do some ondisk format conversion
> during upgrade which mean that the first time the ceph-osd daemon started
> after upgrade it had to spend a few minutes fixing up it's ondisk files.
> We haven't had to recently, though, and generally try to avoid such
> things.
>
> However, there's a change we'd like to make in FileStore for luminous (*)
> and it would save us a lot of time and complexity if it was a one-shot
> update during the upgrade.  I would probably take in the neighborhood of
> 1-5 minutes for a 4-6TB HDD.  That means that when restarting the daemon
> during the upgrade the OSD would stay down for that period (vs the usual
> <1 restart time).
>
> Does this concern anyone?  It probably means the upgrades will take longer
> if you're going host by host since the time per host will go up.
>
> sage
>
>
> * eliminate 'snapdir' objects, replacing them with a head object +
> whiteout.
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a114355a6c9755d05481148a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The only issue I can think of is if there isn&#39;t a version of the client=
s fully tested to work with a partially upgraded cluster or a documented in=
compatibility requiring downtime. We&#39;ve had upgrades where we had to up=
grade clients first and others that we had to do the clients last due to is=
sues with how the clients interacted with an older cluster, partially upgra=
ded cluster, or newer cluster.<br><br>If the FileStore is changing this muc=
h, I can imagine a Jewel client having a hard time locating the objects it =
needs from a Luminous cluster.<br><div class=3D"gmail_quote"><div dir=3D"lt=
r">On Wed, Feb 8, 2017 at 8:09 PM Sage Weil &lt;<a href=3D"mailto:sweil@red=
hat.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Hello, ceph operators...<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Several times in the past we&#39;ve had to do some ondisk format conversion=
<br class=3D"gmail_msg">
during upgrade which mean that the first time the ceph-osd daemon started<b=
r class=3D"gmail_msg">
after upgrade it had to spend a few minutes fixing up it&#39;s ondisk files=
.<br class=3D"gmail_msg">
We haven&#39;t had to recently, though, and generally try to avoid such<br =
class=3D"gmail_msg">
things.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
However, there&#39;s a change we&#39;d like to make in FileStore for lumino=
us (*)<br class=3D"gmail_msg">
and it would save us a lot of time and complexity if it was a one-shot<br c=
lass=3D"gmail_msg">
update during the upgrade.=C2=A0 I would probably take in the neighborhood =
of<br class=3D"gmail_msg">
1-5 minutes for a 4-6TB HDD.=C2=A0 That means that when restarting the daem=
on<br class=3D"gmail_msg">
during the upgrade the OSD would stay down for that period (vs the usual<br=
 class=3D"gmail_msg">
&lt;1 restart time).<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Does this concern anyone?=C2=A0 It probably means the upgrades will take lo=
nger<br class=3D"gmail_msg">
if you&#39;re going host by host since the time per host will go up.<br cla=
ss=3D"gmail_msg">
<br class=3D"gmail_msg">
sage<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
* eliminate &#39;snapdir&#39; objects, replacing them with a head object +<=
br class=3D"gmail_msg">
whiteout.<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
ceph-users mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" class=3D"gmail_msg" target=3D"=
_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">http://lists.ceph.com/list=
info.cgi/ceph-users-ceph.com</a><br class=3D"gmail_msg">
</blockquote></div>

--001a114355a6c9755d05481148a0--

--===============0649860484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0649860484==--
