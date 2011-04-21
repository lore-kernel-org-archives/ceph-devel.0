From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 12:32:40 -0700
Message-ID: <20110421193240.GA26545@dreamer>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
 <20110421185606.GC9431@dreamer>
 <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50029 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab1DUTcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 15:32:39 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thu, Apr 21, 2011 at 12:27:01PM -0700, Colin McCabe wrote:
> I like this idea a lot. It does involve extra expense, but only for
> long file names. It also avoids object name collisions completely.
> 
> One additional idea: can we make the chunking configurable?
> If we did a translation like this:
> abcdefg -> abc/def/g
> 123456789 -> 123/456/789
> 
> prefix search would become a *lot* more efficient for rgw.
> On the other hand, the filesystem layer doesn't care about prefix
> search, so it could just configure the chunking to be after 200
> characters or something (at which point it's basically a no-op.)

The one big downside is that with configurable chunking, you no longer
have an always correct 1:1 mapping between object and file.

You might argue for always (not configurably) chunking at some
smaller, fixed boundary, so on the average you'd need to readdir()
less to serve a prefix search. I think this is what your last sentence
refers to. But that means more overhead with the directories.

The only real answers are available via benchmarks.

-- 
:(){ :|:&};:
