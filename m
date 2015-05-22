From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Proposal for a Backport tracker
Date: Fri, 22 May 2015 09:06:17 +0200
Message-ID: <555ED569.2090604@suse.cz>
References: <555DC080.8050508@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43063 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbbEVHGT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 May 2015 03:06:19 -0400
In-Reply-To: <555DC080.8050508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic:

As I understand the new backport workflow, the process of creating 
tickets in the Backport tracker will be automated. This raises a question:

As the automation script loops over each Pending Backport ticket, it 
will first create a corresponding ticket (or tickets) in the Backport 
tracker. After that, I'm thinking it will need to change the status of 
the original ticket from Pending Backport to something else (so it 
doesn't pick up the same ticket again the next time the script is run).

So the question is, what will the original ticket's status be changed 
to? Resolved?

Nathan
