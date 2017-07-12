From: Chris Jones <chris.jones-7eV6lPUPuyrnjl+F95n0ng@public.gmane.org>
Subject: Re: autoconfigured haproxy service?
Date: Wed, 12 Jul 2017 15:37:07 -0400
Message-ID: <CAO4wRRQ=4qMO7wU7KU=Sf2ByabYwsmbnLYJ-_uPwwKji+w+ndA@mail.gmail.com>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1270851870=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1707111458470.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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

--===============1270851870==
Content-Type: multipart/alternative; boundary="94eb2c0361a640de98055423f204"

--94eb2c0361a640de98055423f204
Content-Type: text/plain; charset="UTF-8"

Hi Sage,

The automated tool Cepheus https://github.com/cepheus-io/cepheus does this
with ceph-chef. It's based on json data for a given environment. It uses
Chef and Ansible. If someone wanted to break out the haproxy (ADC) portion
into a package then it has a good model for HAProxy they could look at.
Originally created due to the need for our own software LB solution over a
hardware LB. It also supports keep-alived and bird (BGP).

Thanks

On Tue, Jul 11, 2017 at 11:03 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi all,
>
> Luminous features a new 'service map' that lets rgw's (and rgw nfs
> gateways and iscsi gateways and rbd mirror daemons and ...) advertise
> themselves to the cluster along with some metadata (like the addresses
> they are binding to and the services the provide).
>
> It should be pretty straightforward to build a service that
> auto-configures haproxy based on this information so that you can deploy
> an rgw front-end that dynamically reconfigures itself when additional
> rgw's are deployed or removed.  haproxy has a facility to adjust its
> backend configuration at runtime[1].
>
> Anybody interested in tackling this?  Setting up the load balancer in
> front of rgw is one of the more annoying pieces of getting ceph up and
> running in production and until now has been mostly treated as out of
> scope.  It would be awesome if there was an autoconfigured service that
> did it out of the box (and had all the right haproxy options set).
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--94eb2c0361a640de98055423f204
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sage,<div><br></div><div>The automated tool Cepheus=C2=
=A0<a href=3D"https://github.com/cepheus-io/cepheus">https://github.com/cep=
heus-io/cepheus</a> does this with ceph-chef. It&#39;s based on json data f=
or a given environment. It uses Chef and Ansible. If someone wanted to brea=
k out the haproxy (ADC) portion into a package then it has a good model for=
 HAProxy they could look at. Originally created due to the need for our own=
 software LB solution over a hardware LB. It also supports keep-alived and =
bird (BGP).</div><div><br></div><div>Thanks</div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Tue, Jul 11, 2017 at 11:03 AM, Sag=
e Weil <span dir=3D"ltr">&lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"=
_blank">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Hi all,<br>
<br>
Luminous features a new &#39;service map&#39; that lets rgw&#39;s (and rgw =
nfs<br>
gateways and iscsi gateways and rbd mirror daemons and ...) advertise<br>
themselves to the cluster along with some metadata (like the addresses<br>
they are binding to and the services the provide).<br>
<br>
It should be pretty straightforward to build a service that<br>
auto-configures haproxy based on this information so that you can deploy<br=
>
an rgw front-end that dynamically reconfigures itself when additional<br>
rgw&#39;s are deployed or removed.=C2=A0 haproxy has a facility to adjust i=
ts<br>
backend configuration at runtime[1].<br>
<br>
Anybody interested in tackling this?=C2=A0 Setting up the load balancer in<=
br>
front of rgw is one of the more annoying pieces of getting ceph up and<br>
running in production and until now has been mostly treated as out of<br>
scope.=C2=A0 It would be awesome if there was an autoconfigured service tha=
t<br>
did it out of the box (and had all the right haproxy options set).<br>
<br>
sage<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</blockquote></div><br></div>

--94eb2c0361a640de98055423f204--

--===============1270851870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1270851870==--
