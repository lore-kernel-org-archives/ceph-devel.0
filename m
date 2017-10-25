From: Sage Weil <sweil@redhat.com>
Subject: announcing ceph-helm (ceph on kubernetes orchestration)
Date: Wed, 25 Oct 2017 19:09:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710251848140.22592@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932162AbdJYTJV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 15:09:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@ceph.com

There is a new repo under the ceph org, ceph-helm, which includes helm 
charts for deploying ceph on kubernetes.  The code is based on the ceph 
charts from openstack-helm, but we've moved them into their own upstream 
repo here so that they can be developed more quickly and independently 
from the openstack-helm work.  The code has already evolved a fair bit, 
mostly to support luminous and fix a range of issues:

	https://github.com/ceph/ceph-helm/tree/master/ceph/ceph

The repo is a fork of the upstream kubernetes/charts.git repo with an eye 
toward eventually merging the chart upstream into that repo.  How useful 
that would be in practice is not entirely clear to me since the version in 
the ceph-helm repo will presumably always be more up to date and users 
have to point to *some* source for the chart either way.  Also the current 
structure of the files in the repo is carried over from openstack-helm, 
which uses the helm-toolkit stuff and isn't in the correct form for the 
upstream charts.git.  Suggestions/input here on what direction makes more 
sense would be welcome!

There are also some docs on getting a ceph cluster up in kubernetes using 
these charts at

	https://github.com/ceph/ceph/pull/18520
	http://docs.ceph.com/ceph-prs/18520/start/kube-helm/

that should be merged shortly.  Not terribly detailed and we're not 
covering much on the operations side yet, but that all is coming.

A very rough sketch of the direction currently being considered from 
running ceph in kubernetes is here:

	http://pad.ceph.com/p/containers

and there is a trello board here

	https://trello.com/b/kcXOllJp/kubehelm

All of this builds on the container image that Sebastien has been working 
on for some time, that has recently been renamed from ceph-docker -> 
ceph-container

	https://github.com/ceph/ceph-container

Dan is working on getting an image registry up at registry.ceph.com so 
that we can publish test build images, releases, or both.

We also have a daily sync up call for the folks who are actively working 
on this.

That's all for now!  :)
sage

