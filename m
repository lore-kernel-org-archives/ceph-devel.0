From: Sage Weil <sage@newdream.net>
Subject: Re: projects
Date: Tue, 6 Sep 2011 21:01:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109062100120.7331@cobra.newdream.net>
References: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
 <Pine.LNX.4.64.1109031532190.12865@cobra.newdream.net>
 <CAB2gnbXvRv66OFH7TXtuqkv9P_+ZykekNZUHRwgDntPggwDQ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53218 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab1IGD4S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2011 23:56:18 -0400
In-Reply-To: <CAB2gnbXvRv66OFH7TXtuqkv9P_+ZykekNZUHRwgDntPggwDQ=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 4 Sep 2011, Noah Watkins wrote:
> > * Clean java libceph bindings. There are some basic libceph Java bindings
> > in src/client/hadoopclient that are used by the current hadoop shim. These
> > should be cleaned up a bit, moved, and packaged properly to provide
> > generic libceph java bindings (of which the hadoop shim would be just one
> > user). See http://tracker.newdream.net/issues/814.
> 
> Are you thinking that these should live in a new tree?

I suspect it'll be easier if it's all in the main ceph.git.  Right now the 
bindings are hidden in src/client/haddop, though...  They should be 
first-order components that you can build/install independently from 
hadoop.  

Not sure how the packaging works for java stuff, but whatever the 
convention is that should be done properly as well.

sage
