From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Manila] Ceph native driver for manila
Date: Fri, 27 Feb 2015 12:23:36 +0800
Message-ID: <CACJqLyZfTL9c38Eiuxr7JRsfTE4biHay1mVOEfVvDD8po54JYA@mail.gmail.com>
References: <alpine.DEB.2.00.1502261520050.23918@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37452 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbbB0EXh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 23:23:37 -0500
Received: by pabrd3 with SMTP id rd3so19536083pab.4
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 20:23:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502261520050.23918@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 27, 2015 at 8:01 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi everyone,
>
> The online Ceph Developer Summit is next week[1] and among other things
> we'll be talking about how to support CephFS in Manila.  At a high level,
> there are basically two paths:
>
> 1) Ganesha + the CephFS FSAL driver
>
>  - This will just use the existing ganesha driver without modifications.
> Ganesha will need to be configured with the CephFS FSAL instead of
> GlusterFS or whatever else you might use.
>  - All traffic will pass through the NFS VM, providing network isolation
>
> No real work needed here aside from testing and QA.
>
> 2) Native CephFS driver
>
> As I currently understand it,
>
>  - The driver will set up CephFS auth credentials so that the guest VM can
> mount CephFS directly
>  - The guest VM will need access to the Ceph network.  That makes this
> mainly interesting for private clouds and trusted environments.
>  - The guest is responsible for running 'mount -t ceph ...'.
>  - I'm not sure how we provide the auth credential to the user/guest...
>
> This would perform better than an NFS gateway, but there are several gaps
> on the security side that make this unusable currently in an untrusted
> environment:
>
>  - The CephFS MDS auth credentials currently are _very_ basic.  As in,
> binary: can this host mount or it cannot.  We have the auth cap string
> parsing in place to restrict to a subdirectory (e.g., this tenant can only
> mount /tenants/foo), but the MDS does not enforce this yet.  [medium
> project to add that]
>
>  - The same credential could be used directly via librados to access the
> data pool directly, regardless of what the MDS has to say about the
> namespace.  There are two ways around this:
>
>    1- Give each tenant a separate rados pool.  This works today.  You'd
> set a directory policy that puts all files created in that subdirectory in
> that tenant's pool, then only let the client access those rados pools.
>
>      1a- We currently lack an MDS auth capability that restricts which
> clients get to change that policy.  [small project]
>
>    2- Extend the MDS file layouts to use the rados namespaces so that
> users can be separated within the same rados pool.  [Medium project]
>
>    3- Something fancy with MDS-generated capabilities specifying which
> rados objects clients get to read.  This probably falls in the category of
> research, although there are some papers we've seen that look promising.
> [big project]
>
> Anyway, this leads to a few questions:
>
>  - Who is interested in using Manila to attach CephFS to guest VMs?

Yeah, actually we are doing this
(https://www.openstack.org/vote-vancouver/Presentation/best-practice-of-ceph-in-public-cloud-cinder-manila-and-trove-all-with-one-ceph-storage).

Hmm, the link seemed redirect and useless:-(

>  - What use cases are you interested?

We uses Manila + OpenStack for our NAS service

>  - How important is security in your environment?

Very important, we need to provide with qos, network isolation(private
network support).

Now we use default Manila driver, attach a rbd image to service vm and
this service vm export NFS endpoint.

Next as we showed in the presentation, we will use qemu driver to
directly passthrough filesystem command instead of block command. So
host can directly access cephfs safely and network isolation can be
ensured. It will make clearly for internal network(or storage network)
and virtual network.

>
> Thanks!
> sage
>
>
> [1] http://ceph.com/community/ceph-developer-summit-infernalis/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
