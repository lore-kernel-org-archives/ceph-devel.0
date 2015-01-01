From: Joao Eduardo Luis <joao@redhat.com>
Subject: Re: full osdmaps in mon txns
Date: Thu, 01 Jan 2015 15:50:09 +0000
Message-ID: <54A56CB1.4010207@redhat.com>
References: <alpine.DEB.2.00.1412231306170.28630@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:51451 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbAAPuF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jan 2015 10:50:05 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so23224772wgh.20
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jan 2015 07:50:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412231306170.28630@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, gfarnum@redhat.com
Cc: ceph-devel@vger.kernel.org

On 12/23/2014 09:10 PM, Sage Weil wrote:
> This fun issue came up again in the form of 10422:
>
> 	http://tracker.ceph.com/issues/10422
>
> I think we have 3 main options:
>
> 1. Ask users to do a mon scrub prior to upgrade to
> ensure it is safe.  If a mon is out of sync, manually kick it out, blow it
> away, and resync.
>
> 2. Do a one-time broadcast of the full osdmap across mons to ensure they
> are consistent after upgrade.  Bleh.
>
> 3. Include full encoded OSDMap in txns on updates going forward.
>
> I like 3 because it solves this and all related problems going forward.
> The local encoding of full osdmaps has proven to be a huge headache.
> And, the patch to do it is remarkably simple
>
> 	https://github.com/ceph/ceph/pull/3247/files
>
> and dovetails well with the new CRC.

I prefer 3 as well.  Below is my reply on the pull request, which I 
wrote before addressing this email, and I shall leave it here for posterity!

(Also, I think the approach in the pull request is correct)

As far as I can tell, the whole idea about relying solely on incremental 
to locally build full osdmaps goes as back as a5e2dcb. This has me 
believe that while the idea may have seemed good at the time it may not 
have been based on a real issue.

Anyway, relaying a few MB's worth of osdmap (if it gets to that) over 
the wire doesn't concern me particularly -- the one thing that may be 
annoying is writing them to leveldb.

I fear that writing a just-big enough map to leveldb may cause a hang; 
while we do now have the async mechanism to handle this, I fear that we 
may end up waiting for a big transaction to be applied to leveldb before 
accepting the value (e.g., in Paxos::handle_begin() we will wait for the 
value to be applied to the store before we send out 
MMonPaxos::OP_ACCEPT). Then again, this can easily be something 
surmountable by adjusting timeouts if we ever hit it.


   -Joao

>
> What do you think?
> sage
>


-- 
Joao Eduardo Luis
Software Engineer | http://ceph.com
