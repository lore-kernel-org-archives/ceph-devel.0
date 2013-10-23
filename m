From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: CephFS & Project Manila (OpenStack)
Date: Tue, 22 Oct 2013 20:41:10 -0700
Message-ID: <CAPYLRzg09EhsztuTLBUzVzEpxtA54cEJsO95fj3f=jV+eD_ZBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hey all,
The OpenStack community has spawned a newish "Project Manila", an
effort spearheaded by NetApp to provide a file-sharing service
analogous to Cinder, but for filesystems instead of block devices. The
elevator pitch:
Isn't it great how OpenStack lets you manage block devices for your
hosts? Wouldn't you like OpenStack to manage your fileshare so that
all your VMs can access your <x>? Project Manila lets you do that!

There's a scattering of docs, mostly rooted at
https://wiki.openstack.org/wiki/Shares_Service. Inktank and the
community have expended a fair bit of effort on being good OpenStack
citizens with rbd and rgw, so we're naturally interested in making
CephFS work here. There are two different things we need for that to
happen:
1) Manila needs to support CephFS.
2) CephFS needs to support multi-tenancy to some degree (probably more
than it does right now).

The multi-tenancy requirements in CephFS have been discussed to
varying degrees in the past (eg,
http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Client_Security_for_C=
ephFS)
and will require some work, but that's likely to come about as the
filesystem improves without any special effort for Manila. More
interesting at the moment is making sure that the Manila model works
to use CephFS. There are a couple different possibilities which Manila
developers have already envisioned for how filesystems might integrate
(https://wiki.openstack.org/wiki/Manila/Manila_Storage_Integration_Patterns)
:

Option 1) The service plugs your filesystem's IP into the VM's network
and provides direct IP access. For a shared box (like an NFS server)
this is fairly straightforward and works well (*everything* has a
working NFS client). It's more troublesome for CephFS, since we'd need
to include access to many hosts, lots of operating systems don't
include good CephFS clients by default, and the client is capable of
forcing some service disruptions if they misbehave or disappear (most
likely via lease timeouts), but it may not be impossible.

Option 2) The hypervisor mediates access to the FS via some
pass-through filesystem (presumably P9 =97 Plan 9 FS, which QEMU/KVM is
already prepared to work with). This works better for us; the
hypervisor host can have a single CephFS mount that it shares
selectively to client VMs or something.

Option 3) An agent communicates with the client via a well-understood
protocol (probably NFS) on their VLAN, and to the the backing
filesystem on a different VLAN in the native protocol. This would also
work for CephFS, but of course having to use a gateway agent (either
on a per-tenant or per-many-tenants basis) is a bit of a bummer in
terms of latency, etc.

Right now, unsurprisingly, the focus of the existing Manila developers
is on Option 1: it's less work than the others and supports the most
common storage protocols very well. But as mentioned, it would be a
pretty poor fit for CephFS, which means if anybody wants to use Manila
with CephFS anytime soon they need to come up with some development
support. The project is getting moving now, so if you want to
contribute to an OpenStack project this is a great time to get
involved (they've already expressed enthusiasm for supporting
alternative architectures from extra contributors), both with your own
effort and to help keep alternative connection models in mind during
planning. If you as a user would like to use both Manila and CephFS,
you should tell both communities so that the developers know their
efforts will be appreciated.

Anybody interested? :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
