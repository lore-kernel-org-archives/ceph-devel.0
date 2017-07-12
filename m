From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: autoconfigured haproxy service?
Date: Wed, 12 Jul 2017 01:58:14 +0000
Message-ID: <CAN-GepKGb1c0Hvgy0HHg0ZOhcErV=apKV=-9YSSEMgmL8HKqLQ@mail.gmail.com>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
	<1718355157.3684.1499801810149@ox.pcextreme.nl>
	<alpine.DEB.2.11.1707112031580.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0042660064=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1707112031580.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0042660064==
Content-Type: multipart/alternative; boundary="94eb2c195a52cb69690554152687"

--94eb2c195a52cb69690554152687
Content-Type: text/plain; charset="UTF-8"

Would this be able to be modular for other front ends as well? We really
like using nginx for load balancing and it is capable of reloading the
config after modifications as well.

On Tue, Jul 11, 2017, 4:36 PM Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, 11 Jul 2017, Wido den Hollander wrote:
> > > Op 11 juli 2017 om 17:03 schreef Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> > >
> > >
> > > Hi all,
> > >
> > > Luminous features a new 'service map' that lets rgw's (and rgw nfs
> > > gateways and iscsi gateways and rbd mirror daemons and ...) advertise
> > > themselves to the cluster along with some metadata (like the addresses
> > > they are binding to and the services the provide).
> > >
> > > It should be pretty straightforward to build a service that
> > > auto-configures haproxy based on this information so that you can
> deploy
> > > an rgw front-end that dynamically reconfigures itself when additional
> > > rgw's are deployed or removed.  haproxy has a facility to adjust its
> > > backend configuration at runtime[1].
> > >
> > > Anybody interested in tackling this?  Setting up the load balancer in
> > > front of rgw is one of the more annoying pieces of getting ceph up and
> > > running in production and until now has been mostly treated as out of
> > > scope.  It would be awesome if there was an autoconfigured service that
> > > did it out of the box (and had all the right haproxy options set).
> > >
> >
> > Are there easy Python bindings for this? I mean querying the service map.
>
> Yes and no.  There are no special librados hooks (or python wrappers) to
> get the map, but you can issue a mon_command for 'service dump' and get it
> in JSON, which works just as well for python users.
>
> > I'm personally a fan of running Varnish (with Hitch for SSL) in front of
> > RGW. Some people might also prefer Traefik [0] since that also supports
> > dynamic configs.
>
> How would you go about autoconfiguring varnish via the rgw service map in
> this case?
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--94eb2c195a52cb69690554152687
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Would this be able to be modular for other front ends as well? We really li=
ke using nginx for load balancing and it is capable of reloading the config=
 after modifications as well.<br><br><div class=3D"gmail_quote"><div dir=3D=
"ltr">On Tue, Jul 11, 2017, 4:36 PM Sage Weil &lt;<a href=3D"mailto:sweil@r=
edhat.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On Tue, 11 Jul 2017, Wido den Hollander wrote:<br>
&gt; &gt; Op 11 juli 2017 om 17:03 schreef Sage Weil &lt;<a href=3D"mailto:=
sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi all,<br>
&gt; &gt;<br>
&gt; &gt; Luminous features a new &#39;service map&#39; that lets rgw&#39;s=
 (and rgw nfs<br>
&gt; &gt; gateways and iscsi gateways and rbd mirror daemons and ...) adver=
tise<br>
&gt; &gt; themselves to the cluster along with some metadata (like the addr=
esses<br>
&gt; &gt; they are binding to and the services the provide).<br>
&gt; &gt;<br>
&gt; &gt; It should be pretty straightforward to build a service that<br>
&gt; &gt; auto-configures haproxy based on this information so that you can=
 deploy<br>
&gt; &gt; an rgw front-end that dynamically reconfigures itself when additi=
onal<br>
&gt; &gt; rgw&#39;s are deployed or removed.=C2=A0 haproxy has a facility t=
o adjust its<br>
&gt; &gt; backend configuration at runtime[1].<br>
&gt; &gt;<br>
&gt; &gt; Anybody interested in tackling this?=C2=A0 Setting up the load ba=
lancer in<br>
&gt; &gt; front of rgw is one of the more annoying pieces of getting ceph u=
p and<br>
&gt; &gt; running in production and until now has been mostly treated as ou=
t of<br>
&gt; &gt; scope.=C2=A0 It would be awesome if there was an autoconfigured s=
ervice that<br>
&gt; &gt; did it out of the box (and had all the right haproxy options set)=
.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Are there easy Python bindings for this? I mean querying the service m=
ap.<br>
<br>
Yes and no.=C2=A0 There are no special librados hooks (or python wrappers) =
to<br>
get the map, but you can issue a mon_command for &#39;service dump&#39; and=
 get it<br>
in JSON, which works just as well for python users.<br>
<br>
&gt; I&#39;m personally a fan of running Varnish (with Hitch for SSL) in fr=
ont of<br>
&gt; RGW. Some people might also prefer Traefik [0] since that also support=
s<br>
&gt; dynamic configs.<br>
<br>
How would you go about autoconfiguring varnish via the rgw service map in<b=
r>
this case?<br>
<br>
sage<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--94eb2c195a52cb69690554152687--

--===============0042660064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0042660064==--
