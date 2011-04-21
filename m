From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 13:03:57 -0700
Message-ID: <99672323C62444DFA181A0659E4D37FC@gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
 <20110421185606.GC9431@dreamer>
 <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
 <20110421193240.GA26545@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35486 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1DUUEK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 16:04:10 -0400
Received: by pzk9 with SMTP id 9so35710pzk.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 13:04:10 -0700 (PDT)
In-Reply-To: <20110421193240.GA26545@dreamer>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I really don't see how pushing the naming complexity into the local filesystem, where it adds lots of otherwise-useless inodes and dentries, is going to help us.

I like what Yehuda has here for its relative simplicity -- though I think we should just up the hash size enough that we don't need to handle collisions, and leave out the retry looping so as to make it simpler still -- but given the relative simplicity I think it might be nice to push all the name mangling into a flat space so that we can preserve the prefix- and post-fixing -- this would keep snapshots of one object more identifiable than hashing over the entire name like it's doing right now.
-Greg
On Thursday, April 21, 2011 at 12:32 PM, Tommi Virtanen wrote: 
> On Thu, Apr 21, 2011 at 12:27:01PM -0700, Colin McCabe wrote:
> > I like this idea a lot. It does involve extra expense, but only for
> > long file names. It also avoids object name collisions completely.
> > 
> > One additional idea: can we make the chunking configurable?
> > If we did a translation like this:
> > abcdefg -> abc/def/g
> > 123456789 -> 123/456/789
> > 
> > prefix search would become a *lot* more efficient for rgw.
> > On the other hand, the filesystem layer doesn't care about prefix
> > search, so it could just configure the chunking to be after 200
> > characters or something (at which point it's basically a no-op.)
> 
> The one big downside is that with configurable chunking, you no longer
> have an always correct 1:1 mapping between object and file.
> 
> You might argue for always (not configurably) chunking at some
> smaller, fixed boundary, so on the average you'd need to readdir()
> less to serve a prefix search. I think this is what your last sentence
> refers to. But that means more overhead with the directories.
> 
> The only real answers are available via benchmarks.
> 
> -- 
> :(){ :|:&};:
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

