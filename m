From: Sage Weil <sage@newdream.net>
Subject: Re: Consistency vs efficiency
Date: Thu, 21 Jul 2011 09:49:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107210944550.5868@cobra.newdream.net>
References: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52020 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1GUQpy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 12:45:54 -0400
In-Reply-To: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 21 Jul 2011, Jojy Varghese wrote:
> Hi
>   I just started looking at the ceph code in kernel and had a question
> about performance considerations for lookup operations. I noticed that
> for every operation (say copying a directory), the root dentry is
> "looked" up multiple times and since they all go to MDS for the actual
> lookup operation, it effects the performance. I am sure consistency is
> the winner here. Is there any plan to improve this, maybe by having
> MDS push the capability down to the clients when the dentry is
> updated. So say from CAP_EXCL to CAP_SHARED when the dentry is
> modified. This was the client node can cache the lookup operation and
> does not have to make a round trip to the MDS.

In general, the MDS has two ways of keeping a client's cached dentry 
consistent:

 - it can issue the FILE_SHARED capability bit on the parent directory, 
which means the entire directory is static and the client can cache 
dentry.
 - if it can't do that, it will issue a per-dentry lease

There is an additional 'complete' bit that is used to indicate on the 
client that it has the _entire_ directory in cache.  If set, it can do 
negative lookups and readdir without hitting the MDS.  That's currently 
broken, pending the addition of a d_prune dentry_operation (see 
linux-fsdevel email from July 8).

Anyway, long story short, if you're seeing repeated lookups on a dentry 
that isn't changing, something is broken.  Can you describe the workload 
in more detail?  Which versions of the client and mds are you running?

sage

