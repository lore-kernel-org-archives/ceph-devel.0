From: Luis Pabon <lpabon@redhat.com>
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila
Date: Mon, 2 Mar 2015 14:21:15 -0500 (EST)
Message-ID: <835936292.21191270.1425324075471.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net> <54F31D28.9050103@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:44647 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbbCBTVW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 14:21:22 -0500
In-Reply-To: <54F31D28.9050103@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>, ceph-devel@vger.kernel.org

What is the status on virtfs?  I am not sure if it is being maintained.  Does anyone know?

- Luis

----- Original Message -----
From: "Danny Al-Gaaf" <danny.al-gaaf@bisect.de>
To: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev@lists.openstack.org>, ceph-devel@vger.kernel.org
Sent: Sunday, March 1, 2015 9:07:36 AM
Subject: Re: [openstack-dev] [Manila] Ceph native driver for manila

Am 27.02.2015 um 01:04 schrieb Sage Weil:
> [sorry for ceph-devel double-post, forgot to include
> openstack-dev]
> 
> Hi everyone,
> 
> The online Ceph Developer Summit is next week[1] and among other
> things we'll be talking about how to support CephFS in Manila.  At
> a high level, there are basically two paths:

We discussed the CephFS Manila topic also on the last Manila Midcycle
Meetup (Kilo) [1][2]

> 2) Native CephFS driver
> 
> As I currently understand it,
> 
> - The driver will set up CephFS auth credentials so that the guest
> VM can mount CephFS directly - The guest VM will need access to the
> Ceph network.  That makes this mainly interesting for private
> clouds and trusted environments. - The guest is responsible for
> running 'mount -t ceph ...'. - I'm not sure how we provide the auth
> credential to the user/guest...

The auth credentials need to be handled currently by a application
orchestration solution I guess. I see currently no solution on the
Manila layer level atm.

If Ceph would provide OpenStack Keystone authentication for
rados/cephfs instead of CephX, it could be handled via app orch easily.

> This would perform better than an NFS gateway, but there are
> several gaps on the security side that make this unusable currently
> in an untrusted environment:
> 
> - The CephFS MDS auth credentials currently are _very_ basic.  As
> in, binary: can this host mount or it cannot.  We have the auth cap
> string parsing in place to restrict to a subdirectory (e.g., this
> tenant can only mount /tenants/foo), but the MDS does not enforce
> this yet.  [medium project to add that]
> 
> - The same credential could be used directly via librados to access
> the data pool directly, regardless of what the MDS has to say about
> the namespace.  There are two ways around this:
> 
> 1- Give each tenant a separate rados pool.  This works today.
> You'd set a directory policy that puts all files created in that
> subdirectory in that tenant's pool, then only let the client access
> those rados pools.
> 
> 1a- We currently lack an MDS auth capability that restricts which 
> clients get to change that policy.  [small project]
> 
> 2- Extend the MDS file layouts to use the rados namespaces so that
>  users can be separated within the same rados pool.  [Medium
> project]
> 
> 3- Something fancy with MDS-generated capabilities specifying which
>  rados objects clients get to read.  This probably falls in the
> category of research, although there are some papers we've seen
> that look promising. [big project]
> 
> Anyway, this leads to a few questions:
> 
> - Who is interested in using Manila to attach CephFS to guest VMs? 
> - What use cases are you interested? - How important is security in
> your environment?

As you know we (Deutsche Telekom) are may interested to provide shared
filesystems via CephFS to VMs instead of e.g. via NFS. We can
provide/discuss use cases at CDS.

For us security is very critical, as the performance is too. The first
solution via ganesha is not what we prefer (to use CephFS via p9 and
NFS would not perform that well I guess). The second solution, to use
CephFS directly to the VM would be a bad solution from the security
point of view since we can't expose the Ceph public network directly
to the VMs to prevent all the security issues we discussed already.

We discussed during the Midcycle a third option:

Mount CephFS directly on the host system and provide the filesystem to
the VMs via p9/virtfs. This need nova integration (I will work on a
POC patch for this) to setup libvirt config correctly for virtfs. This
solve the security issue and the auth key distribution for the VMs,
but it may introduces performance issues due to virtfs usage. We have
to check what the specific performance impact will be. Currently this
is the preferred solution for our use cases.

What's still missing in this solution is user/tenant/subtree
separation as in the 2th option. But this is needed anyway for CephFS
in general.

Danny

[1] https://etherpad.openstack.org/p/manila-kilo-midcycle-meetup
[2] https://etherpad.openstack.org/p/manila-meetup-winter-2015

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
