From: Deepak Shetty <dpkshetty-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Manila] Ceph native driver for manila
Date: Wed, 4 Mar 2015 00:01:11 +0530
Message-ID: <CAOXiiM=n6K7LjkB0pkDBj11ND7=UhAgioBZ2wgJOY90u79ZNkA@mail.gmail.com>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net>
 <54F31D28.9050103@bisect.de>
 <835936292.21191270.1425324075471.JavaMail.zimbra@redhat.com>
Reply-To: "OpenStack Development Mailing List \(not for usage questions\)"
 <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1838322692540153028=="
Return-path: <openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <835936292.21191270.1425324075471.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.openstack.org/cgi-bin/mailman/options/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openstack.org/pipermail/openstack-dev>
List-Post: <mailto:openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Errors-To: openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
To: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1838322692540153028==
Content-Type: multipart/alternative; boundary=047d7bd75b34fe7139051066894c

--047d7bd75b34fe7139051066894c
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 3, 2015 at 12:51 AM, Luis Pabon <lpabon-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> What is the status on virtfs?  I am not sure if it is being maintained.
> Does anyone know?
>

The last i knew its not maintained.
Also for what its worth, p9 won't work for windows guest (unless there is a
p9 driver for windows ?) if that is part of your usecase/scenario ?

Last but not the least, p9/virtfs would expose a p9 mount , not a ceph
mount to VMs, which means if there are cephfs specific mount options they
may not work



>
> - Luis
>
> ----- Original Message -----
> From: "Danny Al-Gaaf" <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
> To: "OpenStack Development Mailing List (not for usage questions)" <
> openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Sent: Sunday, March 1, 2015 9:07:36 AM
> Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
>
> Am 27.02.2015 um 01:04 schrieb Sage Weil:
> > [sorry for ceph-devel double-post, forgot to include
> > openstack-dev]
> >
> > Hi everyone,
> >
> > The online Ceph Developer Summit is next week[1] and among other
> > things we'll be talking about how to support CephFS in Manila.  At
> > a high level, there are basically two paths:
>
> We discussed the CephFS Manila topic also on the last Manila Midcycle
> Meetup (Kilo) [1][2]
>
> > 2) Native CephFS driver
> >
> > As I currently understand it,
> >
> > - The driver will set up CephFS auth credentials so that the guest
> > VM can mount CephFS directly - The guest VM will need access to the
> > Ceph network.  That makes this mainly interesting for private
> > clouds and trusted environments. - The guest is responsible for
> > running 'mount -t ceph ...'. - I'm not sure how we provide the auth
> > credential to the user/guest...
>
> The auth credentials need to be handled currently by a application
> orchestration solution I guess. I see currently no solution on the
> Manila layer level atm.
>

There were some discussion in the past in Manila community on guest auto
mount
but i guess nothing was conclusive there.

Appln orchestration can be achived by having tenant specific VM images with
creds
pre-loaded or have the creds injected via cloud-init too should work ?


>
> If Ceph would provide OpenStack Keystone authentication for
> rados/cephfs instead of CephX, it could be handled via app orch easily.
>
> > This would perform better than an NFS gateway, but there are
> > several gaps on the security side that make this unusable currently
> > in an untrusted environment:
> >
> > - The CephFS MDS auth credentials currently are _very_ basic.  As
> > in, binary: can this host mount or it cannot.  We have the auth cap
> > string parsing in place to restrict to a subdirectory (e.g., this
> > tenant can only mount /tenants/foo), but the MDS does not enforce
> > this yet.  [medium project to add that]
> >
> > - The same credential could be used directly via librados to access
> > the data pool directly, regardless of what the MDS has to say about
> > the namespace.  There are two ways around this:
> >
> > 1- Give each tenant a separate rados pool.  This works today.
> > You'd set a directory policy that puts all files created in that
> > subdirectory in that tenant's pool, then only let the client access
> > those rados pools.
> >
> > 1a- We currently lack an MDS auth capability that restricts which
> > clients get to change that policy.  [small project]
> >
> > 2- Extend the MDS file layouts to use the rados namespaces so that
> >  users can be separated within the same rados pool.  [Medium
> > project]
> >
> > 3- Something fancy with MDS-generated capabilities specifying which
> >  rados objects clients get to read.  This probably falls in the
> > category of research, although there are some papers we've seen
> > that look promising. [big project]
> >
> > Anyway, this leads to a few questions:
> >
> > - Who is interested in using Manila to attach CephFS to guest VMs?
>

I didn't get this question... Goal of manila is to provision shared FS to
VMs
so everyone interested in using CephFS would be interested to attach (
'guess you meant mount?)
CephFS to VMs, no ?



> > - What use cases are you interested? - How important is security in
> > your environment?
>

NFS-Ganesha based service VM approach (for network isolation) in Manila is
still
 under works, afaik.


>
> As you know we (Deutsche Telekom) are may interested to provide shared
> filesystems via CephFS to VMs instead of e.g. via NFS. We can
> provide/discuss use cases at CDS.
>
> For us security is very critical, as the performance is too. The first
> solution via ganesha is not what we prefer (to use CephFS via p9 and
> NFS would not perform that well I guess). The second solution, to use
> CephFS directly to the VM would be a bad solution from the security
> point of view since we can't expose the Ceph public network directly
> to the VMs to prevent all the security issues we discussed already.
>

Is there any place the security issues are captured for the case where VMs
access
CephFS directly ? I was curious to understand. IIUC Neutron provides
private and public
networks and for VMs to access external CephFS network, the tenant private
network needs
to be bridged/routed to the external provider network and there are ways
neturon achives it.

Are you saying that this approach of neutron is insecure ?

thanx,
deepak


>
> We discussed during the Midcycle a third option:
>
> Mount CephFS directly on the host system and provide the filesystem to
> the VMs via p9/virtfs. This need nova integration (I will work on a
> POC patch for this) to setup libvirt config correctly for virtfs. This
> solve the security issue and the auth key distribution for the VMs,
> but it may introduces performance issues due to virtfs usage. We have
> to check what the specific performance impact will be. Currently this
> is the preferred solution for our use cases.
>
> What's still missing in this solution is user/tenant/subtree
> separation as in the 2th option. But this is needed anyway for CephFS
> in general.
>
> Danny
>
> [1] https://etherpad.openstack.org/p/manila-kilo-midcycle-meetup
> [2] https://etherpad.openstack.org/p/manila-meetup-winter-2015
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> __________________________________________________________________________
> OpenStack Development Mailing List (not for usage questions)
> Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
> http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev
>

--047d7bd75b34fe7139051066894c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Mar 3, 2015 at 12:51 AM, Luis Pabon <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:lpabon-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">lpabon-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">What is the status on virt=
fs?=C2=A0 I am not sure if it is being maintained.=C2=A0 Does anyone know?<=
br></blockquote><div><br></div><div>The last i knew its not maintained.<br>=
</div><div>Also for what its worth, p9 won&#39;t work for windows guest (un=
less there is a p9 driver for windows ?) if that is part of your usecase/sc=
enario ?<br></div><div><br>Last but not the least, p9/virtfs would expose a=
 p9 mount , not a ceph mount to VMs, which means if there are cephfs specif=
ic mount options they may not work<br><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
- Luis<br>
<div><div class=3D"h5"><br>
----- Original Message -----<br>
From: &quot;Danny Al-Gaaf&quot; &lt;<a href=3D"mailto:danny.al-gaaf@bisect.=
de">danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org</a>&gt;<br>
To: &quot;OpenStack Development Mailing List (not for usage questions)&quot=
; &lt;<a href=3D"mailto:openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org">openstack-dev@li=
sts.openstack.org</a>&gt;, <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ce=
ph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
Sent: Sunday, March 1, 2015 9:07:36 AM<br>
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila<br>
<br>
Am 27.02.2015 um 01:04 schrieb Sage Weil:<br>
&gt; [sorry for ceph-devel double-post, forgot to include<br>
&gt; openstack-dev]<br>
&gt;<br>
&gt; Hi everyone,<br>
&gt;<br>
&gt; The online Ceph Developer Summit is next week[1] and among other<br>
&gt; things we&#39;ll be talking about how to support CephFS in Manila.=C2=
=A0 At<br>
&gt; a high level, there are basically two paths:<br>
<br>
We discussed the CephFS Manila topic also on the last Manila Midcycle<br>
Meetup (Kilo) [1][2]<br>
<br>
&gt; 2) Native CephFS driver<br>
&gt;<br>
&gt; As I currently understand it,<br>
&gt;<br>
&gt; - The driver will set up CephFS auth credentials so that the guest<br>
&gt; VM can mount CephFS directly - The guest VM will need access to the<br=
>
&gt; Ceph network.=C2=A0 That makes this mainly interesting for private<br>
&gt; clouds and trusted environments. - The guest is responsible for<br>
&gt; running &#39;mount -t ceph ...&#39;. - I&#39;m not sure how we provide=
 the auth<br>
&gt; credential to the user/guest...<br>
<br>
The auth credentials need to be handled currently by a application<br>
orchestration solution I guess. I see currently no solution on the<br>
Manila layer level atm.<br></div></div></blockquote><div><br></div><div>The=
re were some discussion in the past in Manila community on guest auto mount=
<br></div><div>but i guess nothing was conclusive there.<br><br></div><div>=
Appln orchestration can be achived by having tenant specific VM images with=
 creds <br></div><div>pre-loaded or have the creds injected via cloud-init =
too should work ?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div><div class=3D"h5">
<br>
If Ceph would provide OpenStack Keystone authentication for<br>
rados/cephfs instead of CephX, it could be handled via app orch easily.<br>
<br>
&gt; This would perform better than an NFS gateway, but there are<br>
&gt; several gaps on the security side that make this unusable currently<br=
>
&gt; in an untrusted environment:<br>
&gt;<br>
&gt; - The CephFS MDS auth credentials currently are _very_ basic.=C2=A0 As=
<br>
&gt; in, binary: can this host mount or it cannot.=C2=A0 We have the auth c=
ap<br>
&gt; string parsing in place to restrict to a subdirectory (e.g., this<br>
&gt; tenant can only mount /tenants/foo), but the MDS does not enforce<br>
&gt; this yet.=C2=A0 [medium project to add that]<br>
&gt;<br>
&gt; - The same credential could be used directly via librados to access<br=
>
&gt; the data pool directly, regardless of what the MDS has to say about<br=
>
&gt; the namespace.=C2=A0 There are two ways around this:<br>
&gt;<br>
&gt; 1- Give each tenant a separate rados pool.=C2=A0 This works today.<br>
&gt; You&#39;d set a directory policy that puts all files created in that<b=
r>
&gt; subdirectory in that tenant&#39;s pool, then only let the client acces=
s<br>
&gt; those rados pools.<br>
&gt;<br>
&gt; 1a- We currently lack an MDS auth capability that restricts which<br>
&gt; clients get to change that policy.=C2=A0 [small project]<br>
&gt;<br>
&gt; 2- Extend the MDS file layouts to use the rados namespaces so that<br>
&gt;=C2=A0 users can be separated within the same rados pool.=C2=A0 [Medium=
<br>
&gt; project]<br>
&gt;<br>
&gt; 3- Something fancy with MDS-generated capabilities specifying which<br=
>
&gt;=C2=A0 rados objects clients get to read.=C2=A0 This probably falls in =
the<br>
&gt; category of research, although there are some papers we&#39;ve seen<br=
>
&gt; that look promising. [big project]<br>
&gt;<br>
&gt; Anyway, this leads to a few questions:<br>
&gt;<br>
&gt; - Who is interested in using Manila to attach CephFS to guest VMs?<br>=
</div></div></blockquote><div><br></div><div>I didn&#39;t get this question=
... Goal of manila is to provision shared FS to VMs<br></div><div>so everyo=
ne interested in using CephFS would be interested to attach ( &#39;guess yo=
u meant mount?)<br></div><div>CephFS to VMs, no ?<br><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5">
&gt; - What use cases are you interested? - How important is security in<br=
>
&gt; your environment?<br></div></div></blockquote><div><br></div><div>NFS-=
Ganesha based service VM approach (for network isolation) in Manila is stil=
l<br>=C2=A0under works, afaik.<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div><div class=3D"h5">
<br>
As you know we (Deutsche Telekom) are may interested to provide shared<br>
filesystems via CephFS to VMs instead of e.g. via NFS. We can<br>
provide/discuss use cases at CDS.<br>
<br>
For us security is very critical, as the performance is too. The first<br>
solution via ganesha is not what we prefer (to use CephFS via p9 and<br>
NFS would not perform that well I guess). The second solution, to use<br>
CephFS directly to the VM would be a bad solution from the security<br>
point of view since we can&#39;t expose the Ceph public network directly<br=
>
to the VMs to prevent all the security issues we discussed already.<br></di=
v></div></blockquote><div><br></div><div>Is there any place the security is=
sues are captured for the case where VMs access<br></div><div>CephFS direct=
ly ? I was curious to understand. IIUC Neutron provides private and public<=
br></div><div>networks and for VMs to access external CephFS network, the t=
enant private network needs <br></div><div>to be bridged/routed to the exte=
rnal provider network and there are ways neturon achives it.<br><br></div><=
div>Are you saying that this approach of neutron is insecure ?<br><br></div=
><div>thanx,<br></div><div>deepak<br>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div><div class=3D"h5">
<br>
We discussed during the Midcycle a third option:<br>
<br>
Mount CephFS directly on the host system and provide the filesystem to<br>
the VMs via p9/virtfs. This need nova integration (I will work on a<br>
POC patch for this) to setup libvirt config correctly for virtfs. This<br>
solve the security issue and the auth key distribution for the VMs,<br>
but it may introduces performance issues due to virtfs usage. We have<br>
to check what the specific performance impact will be. Currently this<br>
is the preferred solution for our use cases.<br>
<br>
What&#39;s still missing in this solution is user/tenant/subtree<br>
separation as in the 2th option. But this is needed anyway for CephFS<br>
in general.<br>
<br>
Danny<br>
<br>
[1] <a href=3D"https://etherpad.openstack.org/p/manila-kilo-midcycle-meetup=
" target=3D"_blank">https://etherpad.openstack.org/p/manila-kilo-midcycle-m=
eetup</a><br>
[2] <a href=3D"https://etherpad.openstack.org/p/manila-meetup-winter-2015" =
target=3D"_blank">https://etherpad.openstack.org/p/manila-meetup-winter-201=
5</a><br>
<br>
</div></div>--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
__________________________________________________________________________<=
br>
OpenStack Development Mailing List (not for usage questions)<br>
Unsubscribe: <a href=3D"http://OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?su=
bject:unsubscribe" target=3D"_blank">OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhA@public.gmane.org=
org?subject:unsubscribe</a><br>
<a href=3D"http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-de=
v" target=3D"_blank">http://lists.openstack.org/cgi-bin/mailman/listinfo/op=
enstack-dev</a><br>
</div></div></blockquote></div><br></div></div>

--047d7bd75b34fe7139051066894c--


--===============1838322692540153028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

__________________________________________________________________________
OpenStack Development Mailing List (not for usage questions)
Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev

--===============1838322692540153028==--
