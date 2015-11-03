From: Sage Weil <sweil@redhat.com>
Subject: Re: civetweb upstream/downstream divergence
Date: Tue, 3 Nov 2015 03:22:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511030320340.32232@cobra.newdream.net>
References: <5631E4A5.9020003@suse.cz> <CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com> <20151029225738.51b8b2e5@lembas.zaitcev.lan> <CALqRxCwPNA0WFYu0oJ-70L3vgR0G8WLs4paU=K1xZCyf=a3Fjw@mail.gmail.com> <1446486438.12033.24.camel@millnert.se>
 <56387CDD.9070605@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbbKCLXA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Nov 2015 06:23:00 -0500
In-Reply-To: <56387CDD.9070605@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Martin Millnert <martin@millnert.se>, Ken Dreyer <kdreyer@redhat.com>, Pete Zaitcev <zaitcev@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 3 Nov 2015, Nathan Cutler wrote:
> IMHO the first step should be to get rid of the evil submodule. Arguably
> the most direct path leading to this goal is to simply package up the
> downstream civetweb (i.e. 1.6 plus all the downstream patches) for all
> the supported distros. The resulting package would be Ceph-specific,
> obviously, so it could be called "civetweb-ceph".
> 
> Like Ken says, the upstreaming effort can continue in parallel.

I'm not sure I agree.  As long as everything is not upstream and we are 
running a fork, what is the value of having it in a separate package?  
That just means all of the effort of managing the package dependency and 
making sure it is in all of the appropriate distros (and similar pain for 
those building manually) without any of the benefits (upstream bug fixes, 
etc.).

sage
