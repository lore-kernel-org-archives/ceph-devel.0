From: Sage Weil <sweil@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was:
 mon daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 08:26:53 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
References: <5703A7FF.2090002@suse.com> <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com> <5704C76C.2050408@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51784 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472AbcDGM07 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 08:26:59 -0400
In-Reply-To: <5704C76C.2050408@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

Hi Owen,

I never really liked ceph-create-keys either, but it simplified the 
deployment process.  I have no problem with removing it as long as we make 
sure the deployment process doesn't too much harder for ceph-deploy users.

Right now, you have to do something like

 ceph-deploy create MON1 MON2 MON3
 ceph-deploy install MON1 MON2 MON3

then manually

 ceph-deploy create MON1 MON2 MON3
 ceph-deploy gatherkeys MON1

or, using the simplified step that was added later,

 ceph-deploy mon create-initial

How about we change the manual process to do

 ceph-deploy create MON1 MON2 MON3
 ceph-deploy createkeys MON1    # ceph-deploy bootstrap-keys create HOST ?
 ceph-deploy gatherkeys MON1    # ceph-deploy bootstrap-keys gather HOST ?

and the create-initial one to run ceph-create-keys manually?

We'll need chef, ansible, puppet, and other recipes/playbooks/manifests to 
be updated as well...

sage
