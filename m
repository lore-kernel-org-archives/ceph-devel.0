From: Sage Weil <sage@newdream.net>
Subject: Re: Proposal for a Backport tracker
Date: Thu, 21 May 2015 08:46:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505210844580.23818@cobra.newdream.net>
References: <555DC080.8050508@dachary.org> <555DD285.3050204@suse.cz> <555DF7E7.9000501@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56402 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbbEUPqS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 11:46:18 -0400
In-Reply-To: <555DF7E7.9000501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 21 May 2015, Loic Dachary wrote:
> 
> On 21/05/2015 14:41, Nathan Cutler wrote:
> >> * a backport issue is created in the "Backport" tracker and is 
> >> "Related" to the original issue
> > 
> > Hi Loic:
> > 
> > I like the idea of having backport tickets in a separate Redmine
> > subproject/issue tracker. 
> 
> It would just be in a separate tracker, in the same project. 
> 
> > In fact, I would go even a step further and
> > have separate subprojects for each target version (hammer backports,
> > firefly backports).
> 
> Separating them in a different project / subproject would create 
> problems because redmine has ways to partition the subprojects that make 
> some things difficult. For instance not all issues can be "Related" to 
> issues in other projects which is kind of annoying. My general 
> impression with redmine subprojects is that they tend to complexify and 
> obscure the process rather than help. Or maybe it's just that my redmine 
> skills are not what they should be. Do you have a different experience ?

I agree.  Adding subprojects clutters up the project list, and a separate 
tracker captures this perfectly.  It also means you can rank by priority 
issues and see both bugs and backprots together (if you like).  And I 
think (?) the related issue only works within the same project (that is 
at least true with the 'duplicate' relationship).

Loic, I think this is a great idea (provided the bot does all the issue 
creation).  +1!

sage
