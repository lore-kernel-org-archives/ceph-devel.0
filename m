From: Sage Weil <sage@newdream.net>
Subject: Re: Several patches for CEPH
Date: Wed, 22 Sep 2010 10:06:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009220953390.6962@cobra.newdream.net>
References: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57851 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab0IVRFG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 13:05:06 -0400
In-Reply-To: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Henry,

> 3. http://github.com/tcloud/ceph/commit/01e3bd78fe7ae26b394f5acda5c0ea875726a387
> 
> We found that every execution of 'ceph -s' causes a thread leaking on
> the monitor.
> This patch sort of fixed the problem: the thread will be terminated
> when the subscription
> expires. However, I wonder if we should provide an "unsubscribe" mechanism to
> allow the client to explicitly unsubscribe it.

There is an ms_handle_reset callback that triggers when the socket 
closes--that's where the cleanup should happen.  Looking into this, 
though, it turns out the problem was somewhat unrelated.  The monitor has 
a "lossy server" policy for non-monitor peers, which means that things 
connect to it, but it shouldn't initiate any outgoing connections.  That 
piece of logic was missing from SimpleMessenger::submit_message().  
Should be fixed by

http://ceph.newdream.net/git/?p=ceph.git;a=commitdiff;h=01b58f38cc94ae7f209c215b782b1c7dec2c1b65

It will need a bit of testing.  (I caught this was setting debug ms = 10 
for [mon], and noticing that there were two different Pipe instances for 
the same peer address.)

We're looking at the other two issues now.  Thanks!
sage
