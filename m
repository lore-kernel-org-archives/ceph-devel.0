From: Kyle Bader <kyle.bader-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CephFS & Project Manila (OpenStack)
Date: Wed, 23 Oct 2013 14:53:47 -0700
Message-ID: <CAFMfnwpemFVV65tqoZqU_4QRqsZ=SE=-81tgbHyxOSkYq1TdeA@mail.gmail.com>
References: <CAPYLRzg09EhsztuTLBUzVzEpxtA54cEJsO95fj3f=jV+eD_ZBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1580124115=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzg09EhsztuTLBUzVzEpxtA54cEJsO95fj3f=jV+eD_ZBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1580124115==
Content-Type: multipart/alternative; boundary=001a11c3c9d849aabc04e96f8d49

--001a11c3c9d849aabc04e96f8d49
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Option 1) The service plugs your filesystem's IP into the VM's network
> and provides direct IP access. For a shared box (like an NFS server)
> this is fairly straightforward and works well (*everything* has a
> working NFS client). It's more troublesome for CephFS, since we'd need
> to include access to many hosts, lots of operating systems don't
> include good CephFS clients by default, and the client is capable of
> forcing some service disruptions if they misbehave or disappear (most
> likely via lease timeouts), but it may not be impossible.
>

This is going to get horribly ugly when you add neutron into the mix, so
much so I'd consider this option a non-starter. If someone is using
openvswitch to create network overlays to isolate each tenant I can't
imagine this ever working.


> Option 2) The hypervisor mediates access to the FS via some
> pass-through filesystem (presumably P9 =E2=80=94 Plan 9 FS, which QEMU/KV=
M is
> already prepared to work with). This works better for us; the
> hypervisor host can have a single CephFS mount that it shares
> selectively to client VMs or something.
>

This seems like the only sane way to do it IMO.


> Option 3) An agent communicates with the client via a well-understood
> protocol (probably NFS) on their VLAN, and to the the backing
> filesystem on a different VLAN in the native protocol. This would also
> work for CephFS, but of course having to use a gateway agent (either
> on a per-tenant or per-many-tenants basis) is a bit of a bummer in
> terms of latency, etc.
>

Again, this still tricky with neutron and network overlays. You would need
one agent per tenant network and encapsulate the agents traffic using with
openvswitch (STT/VxLAN/etc) or a physical switch (only VxLAN is supported
in silicon).

--=20

Kyle

--001a11c3c9d849aabc04e96f8d49
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">

Option 1) The service plugs your filesystem&#39;s IP into the VM&#39;s netw=
ork<br>
and provides direct IP access. For a shared box (like an NFS server)<br>
this is fairly straightforward and works well (*everything* has a<br>
working NFS client). It&#39;s more troublesome for CephFS, since we&#39;d n=
eed<br>
to include access to many hosts, lots of operating systems don&#39;t<br>
include good CephFS clients by default, and the client is capable of<br>
forcing some service disruptions if they misbehave or disappear (most<br>
likely via lease timeouts), but it may not be impossible.<br></blockquote><=
div><br></div><div>This is going to get horribly ugly when you add neutron =
into the mix, so much so I&#39;d consider this option a non-starter. If som=
eone is using openvswitch to create network overlays to isolate each tenant=
 I can&#39;t imagine this ever working.<br>
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex">
Option 2) The hypervisor mediates access to the FS via some<br>
pass-through filesystem (presumably P9 =E2=80=94 Plan 9 FS, which QEMU/KVM =
is<br>
already prepared to work with). This works better for us; the<br>
hypervisor host can have a single CephFS mount that it shares<br>
selectively to client VMs or something.<br></blockquote><div><br></div><div=
>This seems like the only sane way to do it IMO.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex">

Option 3) An agent communicates with the client via a well-understood<br>
protocol (probably NFS) on their VLAN, and to the the backing<br>
filesystem on a different VLAN in the native protocol. This would also<br>
work for CephFS, but of course having to use a gateway agent (either<br>
on a per-tenant or per-many-tenants basis) is a bit of a bummer in<br>
terms of latency, etc.<br></blockquote><div><br></div><div>Again, this stil=
l tricky with neutron and network overlays. You would need one agent per te=
nant network and encapsulate the agents traffic using with openvswitch (STT=
/VxLAN/etc) or a physical switch (only VxLAN is supported in silicon).</div=
>
</div><div><br></div>-- <br><br>Kyle
</div></div>

--001a11c3c9d849aabc04e96f8d49--

--===============1580124115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1580124115==--
