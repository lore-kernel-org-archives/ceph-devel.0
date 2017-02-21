From: Ramana Raja <rraja@redhat.com>
Subject: Re: quota change restriction
Date: Tue, 21 Feb 2017 07:57:35 -0500 (EST)
Message-ID: <1094111600.109553860.1487681855536.JavaMail.zimbra@redhat.com>
References: <461205975.109214419.1487599948474.JavaMail.zimbra@redhat.com> <1228164616.109276923.1487608022780.JavaMail.zimbra@redhat.com> <CALe9h7dmU3c10rSnD-Ux4dB3bFXYko6uvcw1f8-RrJ=7f5NKWg@mail.gmail.com> <CAJ4mKGbeZapFaygONBmMyguz-Q0h8Wj3=0xkn55UYV4WJ4Tm2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:51296 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbdBUM5f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2017 07:57:35 -0500
In-Reply-To: <CAJ4mKGbeZapFaygONBmMyguz-Q0h8Wj3=0xkn55UYV4WJ4Tm2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Feb 20, 2017 at 10:43 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Feb 20, 2017 at 8:43 AM, John Spray <jspray@redhat.com> wrote:
> > (taking to ceph-devel)
> >
> > On Mon, Feb 20, 2017 at 4:27 PM, Ramana Raja <rraja@redhat.com> wrote:
> >> Would it be possible or make sense to disallow clients having
> >> path restricted caps (OpenStack clients) from modifying quota
> >> (change share size) of the root of the exported subtree (manila share)?
> >>
> >> Currently, an OpenStack client can mount a share and modify
> >> its size, by modifying the quota xattr value at the mount point,
> >> without Manila service knowing about the size change.
> >
> > Right, I think this came up before at some point.  I think I didn't
> > think hard about it because it wouldn't be an issue so much with NFS
> > clients, but we should at least decide what direction we want to go
> > in.
> >
> > We had kind of the same issue with layouts, which is why the 'p' part
> > of 'allow rwp' MDS auth caps was introduced.  A few options spring to
> > mind:
> >  A) Apply the 'p' flag rules quotas as well as layouts: generalise it
> > into a "this is a client that isn't allowed to modify the special
> > ceph.* attrs".  Is this too Manila-specific?  Not sure.
> >  B) Special case the client's mount root, and never let it modify the
> > quotas on its own root.  This is probably reasonable in practice as I
> > would expect someone to only be mounting a subpath at the point they
> > had configured their quotas elsewhere, but it seems like quite a
> > quirky move.
> >  C) Introduce another flag to the mds auth caps that controls ability
> > to set quota.  Downside: additional complexity in the auth caps.
> >  D) Do nothing
> >
> > Anyone have other thoughts on this, and/or a preference from those
> > options?  I'm leaning towards A but just because I can't readily
> > imagine use cases where you want to permit layout changes but ban
> > quotas, doesn't mean they don't exist.
> 
> I like A but it does restrict the ability of tenants to have a "tenant
> admin" restricting the size of certain of their clients. Not sure if
> we care about that use case or not.

I don't think this is an issue in the OpenStack world. What Manila
operation, e.g., shrink/extend share, an OpenStack user can perform is
controlled by OpenStack's authorization mechanism, role based access
control [1]. It should be possible to enable only certain OpenStack
users to modify share sizes. So such users can change the share size
anytime through Manila client APIs.

I was referring to the issue of native CephFS clients with path
restricted MDS caps in OpenStack user's compute instances, nova VMs,
being able to modify quota xattrs and thereby override the share size set
by the OpenStack user using Manila with cephfs_native driver backend.
As John pointed out, this wouldn't be an issue once Manila's CephFS driver
can also serve NFS shares using NFS-Ganesha servers. NFS clients can't
change xattr values and hence wouldn't be able to modify the quota/share size.

-Ramana

[1] https://docs.openstack.org/admin-guide/identity-service-api-protection.html
I understand the mechanism as follows:
An OpenStack user is assigned a 'role' and what a 'role' can
do is determined by 'rules' in a per-OpenStack service
'policy.json'file such as,
https://github.com/openstack/manila/blob/master/etc/manila/policy.json

> -Greg
