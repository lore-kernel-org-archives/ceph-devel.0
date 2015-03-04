From: Deepak Shetty <dpkshetty-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Manila] Ceph native driver for manila
Date: Wed, 4 Mar 2015 09:49:26 +0530
Message-ID: <CAOXiiMmBLRMdin7=O6x2dAG_eTHV3C=d0a09hi_--U6B3kxfhw@mail.gmail.com>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net>
 <54F31D28.9050103@bisect.de>
 <835936292.21191270.1425324075471.JavaMail.zimbra@redhat.com>
 <CAOXiiM=n6K7LjkB0pkDBj11ND7=UhAgioBZ2wgJOY90u79ZNkA@mail.gmail.com>
 <54F6467F.2000708@bisect.de>
Reply-To: "OpenStack Development Mailing List \(not for usage questions\)"
 <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2617242251100601612=="
Return-path: <openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <54F6467F.2000708-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.openstack.org/cgi-bin/mailman/options/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openstack.org/pipermail/openstack-dev>
List-Post: <mailto:openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Errors-To: openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
To: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Cc: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2617242251100601612==
Content-Type: multipart/alternative; boundary=001a114159b8c651c405106ec119

--001a114159b8c651c405106ec119
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 4, 2015 at 5:10 AM, Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
wrote:

> Am 03.03.2015 um 19:31 schrieb Deepak Shetty:
> [...]
> >> For us security is very critical, as the performance is too. The
> >> first solution via ganesha is not what we prefer (to use CephFS
> >> via p9 and NFS would not perform that well I guess). The second
> >> solution, to use CephFS directly to the VM would be a bad
> >> solution from the security point of view since we can't expose
> >> the Ceph public network directly to the VMs to prevent all the
> >> security issues we discussed already.
> >>
> >
> > Is there any place the security issues are captured for the case
> > where VMs access CephFS directly ?
>
> No there isn't any place and this is the issue for us.
>
> > I was curious to understand. IIUC Neutron provides private and
> > public networks and for VMs to access external CephFS network, the
> > tenant private network needs to be bridged/routed to the external
> > provider network and there are ways neturon achives it.
> >
> > Are you saying that this approach of neutron is insecure ?
>
> I don't say neutron itself is insecure.
>
> The problem is: we don't want any VM to get access to the ceph public
> network at all since this would mean access to all MON, OSDs and MDS
> daemons.
>
> If a tenant VM has access to the ceph public net, which is needed to
> use/mount native cephfs in this VM, one critical issue would be: the
> client can attack any ceph component via this network. Maybe I misses
> something, but routing doesn't change this fact.
>

Agree, but there are ways you can restrict the tenant VMs to specific
network ports
only using neutron security groups and limit what tenant VM can do. On the
CephFS side one can use selinux labels to provide addnl level of security
for
Ceph daemons, where in only certain process can access/modify them, I am
just thinking aloud here, i m not sure how well cephfs works with selinux
combined.

Thinking more, it seems like then you need a solution that goes via the
serviceVM
approach but provide native CephFS mounts instead of NFS ?

thanx,
deepak


>
> Danny
>
>
>
>

--001a114159b8c651c405106ec119
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Mar 4, 2015 at 5:10 AM, Danny Al-Gaaf <span dir=3D"ltr">&lt;<a =
href=3D"mailto:danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org" target=3D"_blank">danny.al-gaaf@bis=
ect.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Am 03.03.201=
5 um 19:31 schrieb Deepak Shetty:<br>
[...]<br>
<span class=3D"">&gt;&gt; For us security is very critical, as the performa=
nce is too. The<br>
&gt;&gt; first solution via ganesha is not what we prefer (to use CephFS<br=
>
&gt;&gt; via p9 and NFS would not perform that well I guess). The second<br=
>
&gt;&gt; solution, to use CephFS directly to the VM would be a bad<br>
&gt;&gt; solution from the security point of view since we can&#39;t expose=
<br>
&gt;&gt; the Ceph public network directly to the VMs to prevent all the<br>
&gt;&gt; security issues we discussed already.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Is there any place the security issues are captured for the case<br>
&gt; where VMs access CephFS directly ?<br>
<br>
</span>No there isn&#39;t any place and this is the issue for us.<br>
<span class=3D""><br>
&gt; I was curious to understand. IIUC Neutron provides private and<br>
&gt; public networks and for VMs to access external CephFS network, the<br>
&gt; tenant private network needs to be bridged/routed to the external<br>
&gt; provider network and there are ways neturon achives it.<br>
&gt;<br>
&gt; Are you saying that this approach of neutron is insecure ?<br>
<br>
</span>I don&#39;t say neutron itself is insecure.<br>
<br>
The problem is: we don&#39;t want any VM to get access to the ceph public<b=
r>
network at all since this would mean access to all MON, OSDs and MDS<br>
daemons.<br>
<br>
If a tenant VM has access to the ceph public net, which is needed to<br>
use/mount native cephfs in this VM, one critical issue would be: the<br>
client can attack any ceph component via this network. Maybe I misses<br>
something, but routing doesn&#39;t change this fact.<br></blockquote><div><=
br></div><div>Agree, but there are ways you can restrict the tenant VMs to =
specific network ports<br></div><div>only using neutron security groups and=
 limit what tenant VM can do. On the <br></div><div>CephFS side one can use=
 selinux labels to provide addnl level of security for<br></div><div>Ceph d=
aemons, where in only certain process can access/modify them, I am <br></di=
v><div>just thinking aloud here, i m not sure how well cephfs works with se=
linux combined.<br><br></div><div>Thinking more, it seems like then you nee=
d a solution that goes via the serviceVM<br></div><div>approach but provide=
 native CephFS mounts instead of NFS ?<br><br></div><div>thanx,<br></div><d=
iv>deepak<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Danny<br>
<br>
<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a114159b8c651c405106ec119--


--===============2617242251100601612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

__________________________________________________________________________
OpenStack Development Mailing List (not for usage questions)
Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev

--===============2617242251100601612==--
