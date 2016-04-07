From: Owen Synge <osynge@suse.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 15:54:51 +0200
Message-ID: <570666AB.8090408@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
 <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41582 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbcDGNzI (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 7 Apr 2016 09:55:08 -0400
In-Reply-To: <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

Hi Sage,

On 04/07/2016 02:26 PM, Sage Weil wrote:
> Hi Owen,
> 
> I never really liked ceph-create-keys either, but it simplified the 
> deployment process.  

I would propose we do this in two stages.

(A) Remove calling the command from the init scripts as a side effect of
starting the mon.

This allows us to get most of the issues solved.

(B) Remove the command.

This is the long term goal, which is not as urgent in my opinion but
others may disagree.

> I have no problem with removing it as long as we make
> sure the deployment process doesn't too much harder for ceph-deploy users.

The documentation for the manual process without using ceph-deploy will
need to be changed if we remove calling ceph-create-keys from the boot
scripts.

For ceph-deploy users I think we should see if any changes to the
process are needed, the next question is will any be wanted?

While this change still depends on ceph-create-keys it can work without
this code being a side effect of mon booting.

This change here solves the issue for the new way but uses ceph-create-keys:

https://github.com/SUSE/ceph-deploy/commit/58b030dbe0a964b32f1fbc9a3762e64dd74bf50c

Thank you for mentioning the old manual way, I will see if this fix also
solves this, and make a PR to get us to be able to remove the command
ceph-create-keys from the boot scripts of the mon under both ways of
using ceph-deploy you mention below.

(I had forgotten about the old way)

> Right now, you have to do something like
> 
>  ceph-deploy create MON1 MON2 MON3
>  ceph-deploy install MON1 MON2 MON3
>
> then manually
> 
>  ceph-deploy create MON1 MON2 MON3
>  ceph-deploy gatherkeys MON1
> 
> or, using the simplified step that was added later,
> 
>  ceph-deploy mon create-initial
> 
> How about we change the manual process to do
> 
>  ceph-deploy create MON1 MON2 MON3
>  ceph-deploy createkeys MON1    # ceph-deploy bootstrap-keys create HOST ?
>  ceph-deploy gatherkeys MON1    # ceph-deploy bootstrap-keys gather HOST ?
> 
> and the create-initial one to run ceph-create-keys manually?

I think for ceph-deploy we should target no changes to use.

Manually installing ceph without ceph-deploy their will need to be
documentation changes.

> We'll need chef, ansible, puppet, and other recipes/playbooks/manifests to 
> be updated as well...

Yes this is why I had interstitially worried that this would never be
accepted.

Best regards

Owen
