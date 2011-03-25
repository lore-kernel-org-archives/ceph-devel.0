From: Sage Weil <sage@newdream.net>
Subject: Re: handle flushing stray dentry
Date: Fri, 25 Mar 2011 13:10:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103251308010.21143@cobra.newdream.net>
References: <AANLkTik-hfQUzG7qoR=Zmo+2uzv=2XEmwAndrj8xarnF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59918 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab1CYUHN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2011 16:07:13 -0400
In-Reply-To: <AANLkTik-hfQUzG7qoR=Zmo+2uzv=2XEmwAndrj8xarnF@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi!

On Fri, 25 Mar 2011, huang jun wrote:
> after i remove the  local dentries ,metadata will store in stray
> dentry.and now metadata of removed dentries will not be removed,did
> the remove of stray depends on LRU ?if not ,on which circumstance
> should we remove stray dentry? how to judge LRU's expire info?

When a file is unlinked it goes into the stray directory.  It stays there 
until the last references goes away (last client drops its capability, 
peer MDSs drop their replicas).  There is code in the client and MDS to 
move the replica dentries to the tail of the LRU so that happens quickly.

On the primary, though, the cache LRU is unrelated.  eval_stray() is 
called and, if there are no references, it removes the file objects and 
then removes the entry from the stray dir.

Does that answer your question?
sage
