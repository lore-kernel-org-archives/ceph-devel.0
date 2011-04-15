From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Fri, 15 Apr 2011 17:16:54 +0200
Message-ID: <4DA86166.2000608@provocation.net>
References: <4DA85AA6.8050707@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:41101 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab1DOPQ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 11:16:56 -0400
In-Reply-To: <4DA85AA6.8050707@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


BTW, man cmds says "--journal_check" and cmds says

usage: cmds -i name [flags] [[--journal_check]|[--hot-standby][rank]]
<snip>
  --journal-check rank
        replay the journal for rank, then exit

with underscore in the summary and dash in the option details. Trying all
possibble combinations I found the right syntax:

cmds -i node01 --journal-check 0

The problem wasn't dash or underscore; both of them work. Omitting the rank
is what doesn't, so that's an error in the man page: [--journal_check [rank]]
should be [--journal_check rank].

Anyway, cmds --journal-check on both nodes didn't fix the problem. I also
tried --journal-reset. It returned

2011-04-15 17:07:44.494238 7f372f185720 -- 0.0.0.0:6804/11266 messenger.start BUG: there
are 1 child threads already started that will now die!  call messenger.start() sooner.

but didn't fix the suicide either.

Z

