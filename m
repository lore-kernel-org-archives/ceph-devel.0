From: Sage Weil <sage@newdream.net>
Subject: Re: Ideas on NSS vs fork?
Date: Fri, 29 Apr 2011 08:49:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104290846590.31308@cobra.newdream.net>
References: <20110428212902.GA3932@dreamer> <BANLkTimF1sLvLuw3tztW8Ee6eLV6vP1-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51213 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab1D2Psu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 11:48:50 -0400
In-Reply-To: <BANLkTimF1sLvLuw3tztW8Ee6eLV6vP1-8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, 28 Apr 2011, Colin Patrick McCabe wrote:
> > The "remove this" comment on libceph_initialized cannot be blindly
> > acted on; similar logic could be pushed down into ceph::crypto::init,
> > though.
> >
> > This is ugly, but it's the best I could do. Please go through the code
> > and let me know if you have any ideas on how to make it less painful.
> 
> Daemonization should be done in common_init. Obviously, only daemons 
> will do it!

Well, probably after that.  There is a lot of initialization that 
intentionally runs before daemonization (so that you get feedback on 
errors, etc.).

> Daemonization has nothing to do with the messenger logically, so it
> will be good to get that stuff out of there.

Yeah.  SimpleMessenger::start() basically does some checks, forks, and 
then starts a thread.  The forking bit can be moved out, and I think most 
of the checks are obsolete anyway.

sage
