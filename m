From: Vaibhav Bhembre <vaibhav@digitalocean.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Thu, 8 Jun 2017 17:33:34 -0400
Message-ID: <CADJota-JLQXfky_FgLqUEypTRBByfgT2C4Dk2KXNDy7Jb13V2Q@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35831 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdFHVeF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jun 2017 17:34:05 -0400
Received: by mail-io0-f176.google.com with SMTP id k93so25891195ioi.2
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jun 2017 14:34:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

We have an internal management service that works at a higher layer
upstream on top of multiple Ceph clusters. It needs a way to
differentiate and connect separately to each of those clusters.
Presently making that distinction is relatively easy since we create
those connections based on /etc/conf/$cluster.conf, where each cluster
name is unique. I am not sure how this will work for us if we go away
from the way of uniquely identifying multiple clusters from a single client.

On Thu, Jun 8, 2017 at 3:37 PM, Sage Weil <sweil@redhat.com> wrote:
>
> At CDM yesterday we talked about removing the ability to name your ceph
> clusters.  There are a number of hurtles that make it difficult to fully
> get rid of this functionality, not the least of which is that some
> (many?) deployed clusters make use of it.  We decided that the most we can
> do at this point is remove support for it in ceph-deploy and ceph-ansible
> so that no new clusters or deployed nodes use it.
>
> The first PR in this effort:
>
>         https://github.com/ceph/ceph-deploy/pull/441
>
> Background:
>
> The cluster name concept was added to allow multiple clusters to have
> daemons coexist on the same host.  At the type it was a hypothetical
> requirement for a user that never actually made use of it, and the
> support is kludgey:
>
>  - default cluster name is 'ceph'
>  - default config is /etc/ceph/$cluster.conf, so that the normal
> 'ceph.conf' still works
>  - daemon data paths include the cluster name,
>      /var/lib/ceph/osd/$cluster-$id
>    which is weird (but mostly people are used to it?)
>  - any cli command you want to touch a non-ceph cluster name
> needs -C $name or --cluster $name passed to it.
>
> Also, as of jewel,
>
>  - systemd only supports a single cluster per host, as defined by $CLUSTER
> in /etc/{sysconfig,default}/ceph
>
> which you'll notice removes support for the original "requirement".
>
> Also note that you can get the same effect by specifying the config path
> explicitly (-c /etc/ceph/foo.conf) along with the various options that
> substitute $cluster in (e.g., osd_data=/var/lib/ceph/osd/$cluster-$id).
>
>
> Crap preventing us from removing this entirely:
>
>  - existing daemon directories for existing clusters
>  - various scripts parse the cluster name out of paths
>
>
> Converting an existing cluster "foo" back to "ceph":
>
>  - rename /etc/ceph/foo.conf -> ceph.conf
>  - rename /var/lib/ceph/*/foo-* -> /var/lib/ceph/*/ceph-*
>  - remove the CLUSTER=foo line in /etc/{default,sysconfig}/ceph
>  - reboot
>
>
> Questions:
>
>  - Does anybody on the list use a non-default cluster name?
>  - If so, do you have a reason not to switch back to 'ceph'?
>
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
