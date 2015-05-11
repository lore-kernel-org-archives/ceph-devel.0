From: John Spray <john.spray@redhat.com>
Subject: Re: [ceph-users] RFC: Deprecating ceph-tool commands
Date: Mon, 11 May 2015 11:33:03 +0100
Message-ID: <5550855F.2000807@redhat.com>
References: <554D4CD8.6020809@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48999 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbbEKKdF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 May 2015 06:33:05 -0400
In-Reply-To: <554D4CD8.6020809@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>



On 09/05/2015 00:55, Joao Eduardo Luis wrote:
> A command being DEPRECATED must be:
>
>   - clearly marked as DEPRECATED in usage;
>   - kept around for at least 2 major releases;
>   - kept compatible for the duration of the deprecation period.
>
> Once two major releases go by, the command will then enter the OBSOLETE
> period.  This would be one major release, during which the command would
> no longer work although still acknowledged.  A simple message down the
> lines of 'This command is now obsolete; please check the docs' would
> suffice to inform the user.
>
> The command would no longer exist in the next major release.
>
> This approach gives a lifespan of roughly 3 releases (at current rate,
> roughly 1.5 years) before being completely dropped.  This should give
> enough time to people to realize what has happened and adjust any
> scripts they may have.

+1, this seems like a reasonable timescale, but I think the important 
thing is that it's deprecated in at least one LTS release before it's 
actually removed.  So maybe we should just define it like that, and say 
"two stable releases or one LTS release, whichever is longer".  But I 
guess definition of LTS is a per-downstream-vendor thing, so maybe 
harder to define -- maybe the downstream part could be a guideline to 
downstream packagers, that will require no work from them as long as 
they are generating LTS releases on at least every other stable release.

An additional thought: it might be useful to have a "strict" flag for 
processes sending commands, so that e.g. management tools in QA can set 
that and fail out when they use something deprecated. Otherwise, 
automated things would tend not to notice messages about deprecation.

Cheers,
John
