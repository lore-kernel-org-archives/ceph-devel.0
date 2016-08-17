From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about Accepter::stop()
Date: Wed, 17 Aug 2016 12:36:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608171234490.17762@piezo.us.to>
References: <3492e51f-021b-2c6e-2242-2237add24784@digiware.nl> <alpine.DEB.2.11.1608122056380.17762@piezo.us.to> <b6ef2b22-e693-afcc-1772-73ab2d6869cc@digiware.nl> <67687e3b-f514-b727-ca3a-173c82fc3860@digiware.nl> <8bfc92da-efd2-6783-b74a-9ed3612a6f8a@digiware.nl>
 <alpine.DEB.2.11.1608131357080.17762@piezo.us.to> <fb18be0c-ad7e-b5ba-c841-5e361b9e5a93@digiware.nl> <alpine.DEB.2.11.1608151947010.14754@piezo.us.to> <d7c48e3c-00e2-eec6-4d56-5b35ec05f9cc@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58655 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbcHQMgL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2016 08:36:11 -0400
In-Reply-To: <d7c48e3c-00e2-eec6-4d56-5b35ec05f9cc@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 15 Aug 2016, Willem Jan Withagen wrote:
> > A workaround might be to set a modest timeout (say, 1s) on the poll.  
> > Worst case, you wait up to 1s to shut down, which isn't to bad, and in the 
> > normal case you only wake up needlessly once per second (also not *too* 
> > bad).
> > 
> >> The other solution would be to include a watch pipe in the poll fds.
> >> And then write that pipe if you want to trigger the poll. Instead of
> >> doing the shutdown. I think there is example code for this on the web,
> >> it is called the self-pipe trick.
> > 
> > That's probably the most elegant/correct solution... I'm not sure that teh 
> > current behavior where we call shutdown(2) on an unconnected socket and it 
> > wakes up poll(2) is well-defined behavior.
> 
> I actually found more cases of the selfpipe solution, and it is a
> portable ways of tackling the challenge.
> But there are also more cases that use ::shutdown().
> Which I will have to review and see of they cause the same type of
> errors. But perhaps should we just rewrite all the shutdown cases, just
> to use the same code in all code.

That would be my preference.  Then we're not potentially abusing the API 
and FreeBSD isn't using a different path that isn't as well tested.

Thanks!
sage
