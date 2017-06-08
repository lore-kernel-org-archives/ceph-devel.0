From: Benjeman Meekhof <bmeekhof@umich.edu>
Subject: Re: [ceph-users] removing cluster name support
Date: Thu, 8 Jun 2017 16:41:44 -0400
Message-ID: <CAH-GEabva8CFqmJ36O-9TCnbPdryLcg-ojoOHv=5SvCnkHZfqg@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35770 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdFHUlq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jun 2017 16:41:46 -0400
Received: by mail-ot0-f173.google.com with SMTP id a2so29516657oth.2
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jun 2017 13:41:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users <ceph-users@ceph.com>

Hi Sage,

We did at one time run multiple clusters on our OSD nodes and RGW
nodes (with Jewel).  We accomplished this by putting code in our
puppet-ceph module that would create additional systemd units with
appropriate CLUSTER=name environment settings for clusters not named
ceph.  IE, if the module were asked to configure OSD for a cluster
named 'test' it would copy/edit the ceph-osd service to create a
'test-osd@.service' unit that would start instances with CLUSTER=test
so they would point to the right config file, etc   Eventually on the
RGW side I started doing instance-specific overrides like
'/etc/systemd/system/ceph-radosgw@client.name.d/override.conf' so as
to avoid replicating the stock systemd unit.

We gave up on multiple clusters on the OSD nodes because it wasn't
really that useful to maintain a separate 'test' cluster on the same
hardware.  We continue to need ability to reference multiple clusters
for RGW nodes and other clients. For the other example, users of our
project might have their own Ceph clusters in addition to wanting to
use ours.

If the daemon solution in the no-clustername future is to 'modify
systemd unit files to do something' we're already doing that so it's
not a big issue.  However the current modification of over-riding
CLUSTER in the environment section of systemd files does seem cleaner
than over-riding an exec command to specify a different config file
and keyring path.   Maybe systemd units could ship with those
arguments as variables for easily over-riding.

thanks,
Ben

On Thu, Jun 8, 2017 at 3:37 PM, Sage Weil <sweil@redhat.com> wrote:
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
