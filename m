From: Sage Weil <sage@newdream.net>
Subject: Re: New ceph/ceph-helm repo?
Date: Tue, 29 Aug 2017 14:13:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708291410300.20435@piezo.novalocal>
References: <CALe9h7fhkejMOHd6+C9krFpijPpWe_NaVZvsp4dOJuWEU-110A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39832 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdH2ONo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 10:13:44 -0400
In-Reply-To: <CALe9h7fhkejMOHd6+C9krFpijPpWe_NaVZvsp4dOJuWEU-110A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, hchen@redhat.com

On Tue, 29 Aug 2017, John Spray wrote:
> According to a github notification, we now have a new "ceph-helm" repo
> in the ceph github project, which is a fork of kubernetes/charts.  I
> don't know how to get github to tell me who created it, so asking the
> list -- what's the story?

That's me!  There's a new Containers team with people with commit access.

This is where the upstream helm chart for ceph will live. It's a fork of 
kubernetes/charts so that we can eventually submit the latest upstream to 
the "official" kubernetes upstream charts repository.

The current latest-and-greatest ceph helm chart lives in 
openstack/openstack-helm[/ceph], but (1) it's nonintuitive that the ceph 
charts live there, and (2) it has been very slow getting changes submitted 
upstream (lack of attention from the openstack folks plus the joys of 
dealing with gerrit and the surrounding openstack process).

sage
