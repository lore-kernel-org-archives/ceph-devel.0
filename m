From: Alex Gorbachev <ag@iss-integration.com>
Subject: Re: [ceph-users] Ceph + VMWare
Date: Thu, 6 Oct 2016 10:01:39 -0400
Message-ID: <CADb9453mfXcgxMuOMvbz12XDB02bbzuaV-Jtoiqd04n7XuSzJg@mail.gmail.com>
References: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33388 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbcJFOBl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 10:01:41 -0400
Received: by mail-ua0-f179.google.com with SMTP id p102so18357933uap.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 07:01:40 -0700 (PDT)
In-Reply-To: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <pmcgarry@redhat.com>
Cc: Ceph-User <ceph-users@ceph.com>, Ceph Devel <ceph-devel@vger.kernel.org>

On Wed, Oct 5, 2016 at 2:32 PM, Patrick McGarry <pmcgarry@redhat.com> wrote:
> Hey guys,
>
> Starting to buckle down a bit in looking at how we can better set up
> Ceph for VMWare integration, but I need a little info/help from you
> folks.
>
> If you currently are using Ceph+VMWare, or are exploring the option,
> I'd like some simple info from you:
>
> 1) Company
> 2) Current deployment size
> 3) Expected deployment growth
> 4) Integration method (or desired method) ex: iscsi, native, etc
>
> Just casting the net so we know who is interested and might want to
> help us shape and/or test things in the future if we can make it
> better. Thanks.
>

Hi Patrick,

We have Storcium certified with VMWare, and we use it ourselves:

Ceph Hammer latest

SCST redundant Pacemaker based delivery front ends - our agents are
published on github

EnhanceIO for read caching at delivery layer

NFS v3, and iSCSI and FC delivery

Our deployment size we use ourselves is 700 TB raw.

Challenges are as others described, but HA and multi host access works
fine courtesy of SCST.  Write amplification is a challenge on spinning
disks.

Happy to share more.

Alex

>
> --
>
> Best Regards,
>
> Patrick McGarry
> Director Ceph Community || Red Hat
> http://ceph.com  ||  http://community.redhat.com
> @scuttlemonkey || @ceph
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
