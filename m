From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Suicide
Date: Fri, 15 Apr 2011 17:00:35 -0700
Message-ID: <25103BE141804650A169B6444F0D6D21@gmail.com>
References: <4DA85AA6.8050707@provocation.net>
 <3704E18884CB47E081E09984151ACC7B@gmail.com>
 <4DA8C8FB.5050106@provocation.net>
 <161F0A2E50F1465996C6A9075A508C85@gmail.com>
 <4DA8D4EF.8090006@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44511 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab1DPAAj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 20:00:39 -0400
Received: by pzk9 with SMTP id 9so1195063pzk.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 17:00:38 -0700 (PDT)
In-Reply-To: <4DA8D4EF.8090006@provocation.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Friday, April 15, 2011 at 4:29 PM, Zenon Panoussis wrote:

> On 04/16/2011 01:06 AM, Gregory Farnum wrote:
> 
> > Hmm, that timeline doesn't quite make sense -- node01 takes over the MDS 
> > duties at 4:33 and crashes, but then it starts up again at 4:50. But it's 
> > possible that node02 took over in the interval there and we just don't see 
> > it because the log disk was full (I had erroneously thought that a filled 
> > disk would hang the daemon but that turns out not to be the case). So I'd 
> > guess you shut everything down sometime after 5:08, and that would make 
> > sense.
> 
> Indeed, you're probably right.
> 
> > Unfortunately what we're really interested in is what caused the assert 
> > failure on node01 at 4:35 and the reasons for that aren't available in the 
> > logs we have. :(
> 
> > This is the second time we've seen that assert but we've not been able to 
> > reproduce it or figure out how the invariant that it's checking against got 
> > broken. If you like we can come up with a hacky fix that should let your 
> > cluster come back up, but it's possible that you'd lose some data and this 
> > is a very rare condition so if it's not a big deal I'd just re-create your 
> > cluster.
> 
> My data has been safe elsewhere all along and I have already re-created the
> cluster. In other words I don't need the hacky fix, but someone else might
> be desperate for it in the future, so creating it could be a good idea anyway.

Well, we'd like to develop a proper fix in the form of our fsck tools. That, however, will take some time and a hacky fix isn't really safe so we don't want to put it out there and have people use it while thinking it's safe. ;) 


> However, the cause of the corruption is still an open issue that ought to be
> understood and solved. The most likely place to be able to reproduce it at is
> right here, so if you think it's useful, I'm willing to try to crash it again.
> If you want me to, let's make a plan for it. These are just test boxes and
> I have no problem even giving you root on them, if that can help pinpoint
> the cause of the corruption.
We'd love to reproduce it and track it down! Unfortunately, the two times we've seen it so far (you're the second one) are on external users who have very sparse logging. :(

If you want to try to reproduce it for us in a useful fashion we'd love that. You'll need to add debug output to your MDS config. At a minimum we will need "debug journaler = 20". You should also add "debug ms = 1" and probably "debug mds = 10". Be warned that this will use a LOT of disk space, though. If you ran out before you're going to do so again and we will really need the logs that generated the journal and the logs that were replaying the journal to figure out what happened, so you'll need to come up with some way of handling them (writing to a big NFS disk -- though that'll impact networking, different disk, log rotation, etc). Then try and reproduce your previous conditions as exactly as possible and see if you run into that assert again.

Thanks!
-Greg



