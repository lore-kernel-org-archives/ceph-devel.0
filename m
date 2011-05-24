From: Sage Weil <sage@newdream.net>
Subject: Re: dnl status in mds rejoin operation
Date: Tue, 24 May 2011 16:53:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105241651140.9499@cobra.newdream.net>
References: <BANLkTikG1C1WDEvSmpA+QEaxvY-o5ruf1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38978 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541Ab1EXXwf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 19:52:35 -0400
In-Reply-To: <BANLkTikG1C1WDEvSmpA+QEaxvY-o5ruf1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 24 May 2011, huang jun wrote:
> hi,all
>    There is an assert(dnl->is_primary()) in function "rejoin_walk()".
> why should the dnl must be primary if we want to  continue rejoin
> operation? or the assert() crashed.

The rejoin_walk() method traverse subtrees for which we are _not_ auth, 
and the only dentries and inodes we should have in those subtrees after 
recovery are ancestors of subtrees that we are auth for, which implies 
they are primary.  If it encounters a non-primary dentry here, there is 
a bug earlier in recovery.. probably in trim_non_auth()?

>    I want to know whether the status of the replica subtree root
> directory's dentry should be primary?

Directory inode parent dentries will always be primary; multiple hard 
links to a directory are not allowed.

>    And  we assume one dentry in directory is a remote link ,then place
> this dentry in a fragment, can we create the replicas of this fragment
> in other MDSs?

Any dentry can be replicated (primary, remote, or null) once the MDS is 
active.

Does that answer your question?
sage
