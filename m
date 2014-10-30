From: Kapil Sharma <ksharma@suse.com>
Subject: Re: teuthology
Date: Thu, 30 Oct 2014 12:44:39 +0100
Message-ID: <1414669479.8790.110.camel@linux-cb82>
References: <20141024230302.GI6445@thinkpad.thebehrens.net>
		 <1414397595.8790.11.camel@linux-cb82>
		 <20141027104707.GU6445@thinkpad.thebehrens.net>
		 <544E6A2E.5090809@dachary.org> <1414429260.8790.41.camel@linux-cb82>
	 <544FAFD9.1070804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53498 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758889AbaJ3MEl (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 30 Oct 2014 08:04:41 -0400
In-Reply-To: <544FAFD9.1070804@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic, 

On Tue, 2014-10-28 at 16:01 +0100, Loic Dachary wrote:

> I also started to not use the lock server, a year ago. I recently experimented with paddles + teuthology-worker and it's fairly easy to get it to work. The advantage is that you can schedule jobs that will wait for others to complete. My work in progress is at
> 
> https://github.com/dachary/teuthology/compare/wip-container
> https://github.com/dachary/paddles/compare/wip-container
> 
> (note that it is mixed with my attempt to make it work with docker instead of virtual machines or bare metal)
Thanks for sharing your work. Yes, I am also using paddles +
teuthology-worker now.


>  
> > 2. The word "ubuntu" is hard coded in some places in the code :-)
> > 
> > 3. The bootstrap script is for ubuntu machines only. Anyway, it's
> > not a big task to run those commands manually or create a script of
> > your own. 
> 
> Is your script available somewhere ? I plan to set it up on fedora20 and it would be most useful.
Not yet, but I will share it with you soon. 



> 
> Yes. I'm often happy to read tests as if they were the documention of the code. But it would be useful to have documentation for the test themselves in additon ;-)
Yes, At some point I need to start this effort :-)



> Are you running pulpito ? I create a split of workunit that may be of interest to you. My motivation was not to have them show separately in pulpito. Rather to run them in // 
> 
> I first modified the script so that it could be called to group tests:
> 
> https://github.com/dachary/ceph/commit/ec0ba1a9994e4eb24955442895c6b8dd2561ba20
> 
> and then created scripts to run each group independantly
> 
> https://github.com/dachary/ceph/commit/bafd35478e310e887a808784f02c7f0041548d1e
> 
> which could also be an "exec" teuthology tasks.
Yes, I am running pulpito. Maybe a similar logic could be built to also
report the tests separately. Shall give it a try. 

> 
> 
> > 6. I have not tried this of-late but I think teuthology can not run it's
> > tests against an already deployed ceph-cluster. I need to check it again
> > though.
> 
> It may be possible to convince it to do that since the install task is not mandatory.
I found this old ticket which was closed. Need to check the latest
status - http://tracker.ceph.com/issues/6641



> > 7. Would be great if teuthology can cover Calamari testing too :-)
> If I'm not mistaken Waren is working on making this happen. But I've not looked at it closely.
Okay. Will follow up on this.



Regards,
Kapil.




> > On Mon, 2014-10-27 at 16:52 +0100, Loic Dachary wrote:
> >> It was great meeting your and your family :-) Back in Paris and massively jetlagged.
> >>
> >> Nice to meet you Kapil ! Are there any pain points you'd like to address regarding the teuthology installation ?
> >>
> >> Cheers
> >>
> >> On 27/10/2014 11:47, Thorsten Behrens wrote:
> >>> Hi Loic,
> >>>
> >>> was great to meet you and Patrick at the google summit!
> >>>
> >>> Loic, meet Kapil, who's doing lots of great stuff with QA automation
> >>> and deployment on our side. And I think he and Zack were already in
> >>> close contact. ;)
> >>>
> >>> As promised the update on what we run from teuthology:
> >>>
> >>> Kapil Sharma wrote:
> >>>> As of now I have cnfigured, rbd, krbd and rados test suites which
> >>>> are located here
> >>>> [snip]
> >>>>
> >>>
> >>> All the very best, and a safe trip home,
> >>>
> >>
> > 
> > 
> 


