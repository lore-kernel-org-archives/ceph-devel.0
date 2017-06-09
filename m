From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: removing cluster name support
Date: Fri, 9 Jun 2017 19:10:53 +0300
Message-ID: <20170609161052.GA13741@gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34881 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdFIQK5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 12:10:57 -0400
Received: by mail-lf0-f43.google.com with SMTP id p189so31618788lfe.2
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jun 2017 09:10:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com, Jason Dillaman <jdillama@redhat.com>

RBD mirror uses cluster name when configuring its peer [1,2]

[1] http://docs.ceph.com/docs/master/rbd/rbd-mirroring/#add-cluster-peer
[2] https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/2/html/block_device_guide/block_device_mirroring#configuring_one_way_mirroring

On Thu, Jun 08, 2017 at 07:37:23PM +0000, Sage Weil wrote:
> At CDM yesterday we talked about removing the ability to name your ceph 
> clusters.  There are a number of hurtles that make it difficult to fully 
> get rid of this functionality, not the least of which is that some 
> (many?) deployed clusters make use of it.  We decided that the most we can 
> do at this point is remove support for it in ceph-deploy and ceph-ansible 
> so that no new clusters or deployed nodes use it.
> 
> The first PR in this effort:
> 
> 	https://github.com/ceph/ceph-deploy/pull/441
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
