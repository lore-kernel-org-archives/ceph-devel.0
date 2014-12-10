From: Sage Weil <sage@newdream.net>
Subject: Re: force pushes disabled for master in ceph.git and
 ceph-deploy.git
Date: Wed, 10 Dec 2014 14:43:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412101442240.22847@cobra.newdream.net>
References: <5488C747.2000003@redhat.com> <5488C861.1080005@dachary.org> <5488CA35.1040908@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35694 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623AbaLJWnH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 17:43:07 -0500
In-Reply-To: <5488CA35.1040908@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

On Wed, 10 Dec 2014, Ken Dreyer wrote:
> On 12/10/2014 03:25 PM, Loic Dachary wrote:
> > On 10/12/2014 23:20, Ken Dreyer wrote:
> >> Thanks to GitHub Support, force-pushes are now disabled for master in
> >> ceph.git and ceph-deploy.git. This should save us from accidentally
> >> deleting history with a bad force-push to the wrong branch. (Not that
> >> any of us were going to do that, of course! :)
> > 
> > Thanks ! I did that last year and that makes me appreciate the precaution ;-)
> 
> Whoops, so I duplicated your work apparently!
> 
> I was thinking that we should do this for the release branches as well?
> So "argonaut", "bobtail", "cuttlefish" "dumpling", "emperor", "firefly",
> "giant"... any other branches?
> 
> And should we open a new support request each time we create a new
> release branch in the future?

The backport branches are occasionally reset; I'd rather not remove that 
flexibility.  They're generally not something people should be developing 
against so I don't think it's an issue.

sage

