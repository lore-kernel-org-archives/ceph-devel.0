From: Sage Weil <sweil@redhat.com>
Subject: [Manila] Ceph native driver for manila
Date: Thu, 26 Feb 2015 16:04:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502261602390.23918@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643AbbB0AEI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 19:04:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, openstack-dev@lists.openstack.org

[sorry for ceph-devel double-post, forgot to include openstack-dev]

Hi everyone,

The online Ceph Developer Summit is next week[1] and among other things 
we'll be talking about how to support CephFS in Manila.  At a high level, 
there are basically two paths:

1) Ganesha + the CephFS FSAL driver

 - This will just use the existing ganesha driver without modifications.  
Ganesha will need to be configured with the CephFS FSAL instead of 
GlusterFS or whatever else you might use.
 - All traffic will pass through the NFS VM, providing network isolation

No real work needed here aside from testing and QA.

2) Native CephFS driver

As I currently understand it,

 - The driver will set up CephFS auth credentials so that the guest VM can 
mount CephFS directly
 - The guest VM will need access to the Ceph network.  That makes this 
mainly interesting for private clouds and trusted environments.
 - The guest is responsible for running 'mount -t ceph ...'.
 - I'm not sure how we provide the auth credential to the user/guest...

This would perform better than an NFS gateway, but there are several gaps 
on the security side that make this unusable currently in an untrusted 
environment:

 - The CephFS MDS auth credentials currently are _very_ basic.  As in, 
binary: can this host mount or it cannot.  We have the auth cap string 
parsing in place to restrict to a subdirectory (e.g., this tenant can only 
mount /tenants/foo), but the MDS does not enforce this yet.  [medium 
project to add that]

 - The same credential could be used directly via librados to access the 
data pool directly, regardless of what the MDS has to say about the 
namespace.  There are two ways around this:

   1- Give each tenant a separate rados pool.  This works today.  You'd 
set a directory policy that puts all files created in that subdirectory in 
that tenant's pool, then only let the client access those rados pools.

     1a- We currently lack an MDS auth capability that restricts which 
clients get to change that policy.  [small project]

   2- Extend the MDS file layouts to use the rados namespaces so that 
users can be separated within the same rados pool.  [Medium project]

   3- Something fancy with MDS-generated capabilities specifying which 
rados objects clients get to read.  This probably falls in the category of 
research, although there are some papers we've seen that look promising. 
[big project]

Anyway, this leads to a few questions:

 - Who is interested in using Manila to attach CephFS to guest VMs?
 - What use cases are you interested?
 - How important is security in your environment?

Thanks!
sage


[1] http://ceph.com/community/ceph-developer-summit-infernalis/


