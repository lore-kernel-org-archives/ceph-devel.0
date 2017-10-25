From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] announcing ceph-helm (ceph on kubernetes
 orchestration)
Date: Wed, 25 Oct 2017 19:40:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710251928080.22592@piezo.us.to>
References: <alpine.DEB.2.11.1710251848140.22592@piezo.us.to> <CAOugy1vGkPDf7w_+ZMKpA7R2r-MV71=3KnaQ2V6WTaLg5fmTyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1640728472-1508960333=:22592"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdJYTkY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 15:40:24 -0400
In-Reply-To: <CAOugy1vGkPDf7w_+ZMKpA7R2r-MV71=3KnaQ2V6WTaLg5fmTyA@mail.gmail.com>
Content-ID: <alpine.DEB.2.11.1710251938570.22592@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hans van den Bogert <hansbogert@gmail.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1640728472-1508960333=:22592
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1710251938571.22592@piezo.us.to>

On Wed, 25 Oct 2017, Hans van den Bogert wrote:
> Very interesting.I've been toying around with Rook.io [1]. Did you know of this project, and if so can you tell if ceph-helm
> and Rook.io have similar goals?

Similar but a bit different.

Probably the main difference is that ceph-helm aims to run Ceph as part of 
the container infrastructure.  The containers are privileged so they can 
interact with hardware where needed (e.g., lvm for dm-crypt) and the 
cluster runs on the host network.  We use kubernetes some orchestration: 
kube is a bit of a headache for mons and osds but will be very helpful for 
scheduling everything else: mgrs, rgw, rgw-nfs, iscsi, mds, ganesha, 
samba, rbd-mirror, etc.

Rook, as I understand it at least (the rook folks on the list can speak up 
here), aims to run Ceph more as a tenant of kubernetes.  The cluster runs 
in the container network space, and the aim is to be able to deploy ceph 
more like an unprivileged application on e.g., a public cloud providing 
kubernetes as the cloud api.

The other difference is around rook-operator, which is the thing that lets 
you declare what you want (ceph clusters, pools, etc) via kubectl and goes 
off and creates the cluster(s) and tells it/them what to do.  It makes the 
storage look like it is tightly integrated with and part of kubernetes but 
means that kubectl becomes the interface for ceph cluster management.  

Some of that seems useful to me (still developing opinions here!) and 
perhaps isn't so different than the declarations in your chart's 
values.yaml but I'm unsure about the wisdom of going too far down the road 
of administering ceph via yaml.

Anyway, I'm still pretty new to kubernetes-land and very interested in 
hearing what people are interested in or looking for here!

sage


> Regards,
> 
> Hans
> 
> [1] https://rook.io/
> 
> On 25 Oct 2017 21:09, "Sage Weil" <sweil@redhat.com> wrote:
>       There is a new repo under the ceph org, ceph-helm, which includes helm
>       charts for deploying ceph on kubernetes.  The code is based on the ceph
>       charts from openstack-helm, but we've moved them into their own upstream
>       repo here so that they can be developed more quickly and independently
>       from the openstack-helm work.  The code has already evolved a fair bit,
>       mostly to support luminous and fix a range of issues:
> 
>               https://github.com/ceph/ceph-helm/tree/master/ceph/ceph
> 
>       The repo is a fork of the upstream kubernetes/charts.git repo with an eye
>       toward eventually merging the chart upstream into that repo.  How useful
>       that would be in practice is not entirely clear to me since the version in
>       the ceph-helm repo will presumably always be more up to date and users
>       have to point to *some* source for the chart either way.  Also the current
>       structure of the files in the repo is carried over from openstack-helm,
>       which uses the helm-toolkit stuff and isn't in the correct form for the
>       upstream charts.git.  Suggestions/input here on what direction makes more
>       sense would be welcome!
> 
>       There are also some docs on getting a ceph cluster up in kubernetes using
>       these charts at
> 
>               https://github.com/ceph/ceph/pull/18520
>               http://docs.ceph.com/ceph-prs/18520/start/kube-helm/
> 
>       that should be merged shortly.  Not terribly detailed and we're not
>       covering much on the operations side yet, but that all is coming.
> 
>       A very rough sketch of the direction currently being considered from
>       running ceph in kubernetes is here:
> 
>               http://pad.ceph.com/p/containers
> 
>       and there is a trello board here
> 
>               https://trello.com/b/kcXOllJp/kubehelm
> 
>       All of this builds on the container image that Sebastien has been working
>       on for some time, that has recently been renamed from ceph-docker ->
>       ceph-container
> 
>               https://github.com/ceph/ceph-container
> 
>       Dan is working on getting an image registry up at registry.ceph.com so
>       that we can publish test build images, releases, or both.
> 
>       We also have a daily sync up call for the folks who are actively working
>       on this.
> 
>       That's all for now!  :)
>       sage
> 
>       _______________________________________________
>       ceph-users mailing list
>       ceph-users@lists.ceph.com
>       http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
> 
--8323329-1640728472-1508960333=:22592--
