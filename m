From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Proposal for a Backport tracker
Date: Fri, 22 May 2015 10:32:09 +0200
Message-ID: <555EE989.5070009@suse.cz>
References: <555DC080.8050508@dachary.org> <555ED569.2090604@suse.cz> <555ED98F.8020402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47875 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757006AbbEVIcL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 May 2015 04:32:11 -0400
In-Reply-To: <555ED98F.8020402@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> We can probably keep the original ticket in the "Pending Backport" status until all backports are resolved, as we currently do.
>
>> So the question is, what will the original ticket's status be changed to? Resolved?
>
> When all backports are resolved, then we can also resolve the original ticket. Do you forsee a problem with that ?
>

Yes and no. It's a scripting problem, not a workflow problem. I'll try 
to describe the scenario I'm envisioning:

We have a simple script that loops over all tickets with status "Pending 
Backport". We run it once per week. The first week we run it, the script 
finds 3 such tickets. For each one it creates a ticket in the Backport 
tracker.

A week goes by, during which developers marked 4 more tickets "Pending 
Backport". It's time to run the script again. Since it is looping over 
all tickets marked "Pending Backport", it now finds 7 such tickets: 3 
from last week and the 4 new ones. For each one it dutifully creates a 
new ticket in the Backport tracker. Now we have duplicate Backport 
tickets for 3 bugfixes.

But I guess it will be trivial to make the script check if a Backport 
ticket is already open and refrain from opening a new one in this case.

The same script could also check further: if Backport tickets already 
exist for the bugfix and all of them are marked Resolved, then 
automatically mark the original ticket Resolved as well.

Nathan
