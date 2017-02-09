From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: would people mind a slow osd restart during
	luminous upgrade?
Date: Thu, 09 Feb 2017 17:12:09 +0000
Message-ID: <CAN-GepLfgY-D6UaN+ZLt9Kdo20F4gOUnFPSOpjuNZzy=9bbKQw@mail.gmail.com>
References: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal>
	<CAN-Gep+5wDxpab3b5AN_i1m2uNHVvhWkjMWjmd7Rmi6Xbnciuw@mail.gmail.com>
	<alpine.DEB.2.11.1702091426500.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0304297001=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1702091426500.7782-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0304297001==
Content-Type: multipart/alternative; boundary=001a114697b07ca0fc05481c1522

--001a114697b07ca0fc05481c1522
Content-Type: text/plain; charset=UTF-8

When we upgraded to Jewel 10.2.3 from Hammer 0.94.7 in our QA cluster we
had issues with client incompatibility.  We first tried upgrading our
clients before upgrading the cluster.  This broke creating RBDs, cloning
RBDs, and probably many other things.  We quickly called that test a wash
and redeployed the cluster back to 0.94.7 and redid the upgrade by
partially upgrading the cluster, testing, fully upgrading the cluster,
testing, and finally upgraded the clients to Jewel.  This worked with no
issues creating RBDs, cloning, snapshots, deleting, etc.

I'm not sure if there was a previous reason that we decided to always
upgrade the clients first.  It might have had to do with the upgrade from
Firefly to Hammer.  It's just something we always test now, especially with
full version upgrades.  That being said, making sure that there is a client
that was regression tested throughout the cluster upgrade would be great to
have in the release notes.

On Thu, Feb 9, 2017 at 7:29 AM Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Thu, 9 Feb 2017, David Turner wrote:
> > The only issue I can think of is if there isn't a version of the clients
> > fully tested to work with a partially upgraded cluster or a documented
> > incompatibility requiring downtime. We've had upgrades where we had to
> > upgrade clients first and others that we had to do the clients last due
> to
> > issues with how the clients interacted with an older cluster, partially
> > upgraded cluster, or newer cluster.
>
> We maintain client compatibiltity across *many* releases and several
> years.  In general this under the control of the administrator via their
> choice of CRUSH tunables, which effectively let you choose the oldest
> client you'd like to support.
>
> I'm curious which upgrade you had problems with?  Generally speaking the
> only "client" upgrade ordering issue is with the radosgw clients, which
> need to be upgraded after the OSDs.
>
> > If the FileStore is changing this much, I can imagine a Jewel client
> having
> > a hard time locating the objects it needs from a Luminous cluster.
>
> In this case the change would be internal to a single OSD and have no
> effect on the client/osd interaction or placement of objects.
>
> sage
>

--001a114697b07ca0fc05481c1522
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font size=3D"2" face=3D"Calibri"><span style=3D"font-size=
:10pt">When we upgraded to Jewel 10.2.3 from Hammer 0.94.7 in our QA cluste=
r we had issues with client incompatibility.=C2=A0 We first=20
tried upgrading our clients before upgrading the cluster.=C2=A0 This broke =
creating RBDs, cloning RBDs, and probably many other=20
things.=C2=A0 We quickly called that test a wash and redeployed the cluster=
 back to 0.94.7 and redid the upgrade
by partially upgrading the cluster, testing, fully upgrading the cluster, t=
esting, and finally upgraded the clients to Jewel.=C2=A0 This=20
worked with no issues creating RBDs, cloning,=20
snapshots, deleting, etc.</span></font><br><div><font size=3D"2" face=3D"Ca=
libri"><span style=3D"font-size:10pt"><br></span></font></div><div><font si=
ze=3D"2" face=3D"Calibri"><span style=3D"font-size:10pt">I&#39;m not sure i=
f there was a previous reason that we decided to always upgrade the clients=
 first.=C2=A0 It might have had to do with the upgrade from Firefly to Hamm=
er.=C2=A0 It&#39;s just something we always test now, especially with full =
version upgrades.=C2=A0 That being said, making sure that there is a client=
 that was regression tested throughout the cluster upgrade would be great t=
o have in the release notes.</span></font></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr">On Thu, Feb 9, 2017 at 7:29 AM Sage Weil &lt;<a =
href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Thu, 9 Feb 2017, David Turner wrote:<br cl=
ass=3D"gmail_msg">
&gt; The only issue I can think of is if there isn&#39;t a version of the c=
lients<br class=3D"gmail_msg">
&gt; fully tested to work with a partially upgraded cluster or a documented=
<br class=3D"gmail_msg">
&gt; incompatibility requiring downtime. We&#39;ve had upgrades where we ha=
d to<br class=3D"gmail_msg">
&gt; upgrade clients first and others that we had to do the clients last du=
e to<br class=3D"gmail_msg">
&gt; issues with how the clients interacted with an older cluster, partiall=
y<br class=3D"gmail_msg">
&gt; upgraded cluster, or newer cluster.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
We maintain client compatibiltity across *many* releases and several<br cla=
ss=3D"gmail_msg">
years.=C2=A0 In general this under the control of the administrator via the=
ir<br class=3D"gmail_msg">
choice of CRUSH tunables, which effectively let you choose the oldest<br cl=
ass=3D"gmail_msg">
client you&#39;d like to support.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
I&#39;m curious which upgrade you had problems with?=C2=A0 Generally speaki=
ng the<br class=3D"gmail_msg">
only &quot;client&quot; upgrade ordering issue is with the radosgw clients,=
 which<br class=3D"gmail_msg">
need to be upgraded after the OSDs.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; If the FileStore is changing this much, I can imagine a Jewel client h=
aving<br class=3D"gmail_msg">
&gt; a hard time locating the objects it needs from a Luminous cluster.<br =
class=3D"gmail_msg">
<br class=3D"gmail_msg">
In this case the change would be internal to a single OSD and have no<br cl=
ass=3D"gmail_msg">
effect on the client/osd interaction or placement of objects.<br class=3D"g=
mail_msg">
<br class=3D"gmail_msg">
sage<br class=3D"gmail_msg">
</blockquote></div>

--001a114697b07ca0fc05481c1522--

--===============0304297001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0304297001==--
