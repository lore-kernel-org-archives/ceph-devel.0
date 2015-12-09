From: Sage Weil <sage@newdream.net>
Subject: Re: Filestore without journal
Date: Wed, 9 Dec 2015 05:37:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512090535360.25269@cobra.newdream.net>
References: <0dd001d1322a$6d3b19a0$47b14ce0$@com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38646 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbbLINhY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 08:37:24 -0500
In-Reply-To: <0dd001d1322a$6d3b19a0$47b14ce0$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: changtao381 <changtao381@163.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 9 Dec 2015, changtao381 wrote:
> Hi Cephers,
> 
> Why it is use journal with Filestore ?  From my understand, it is used to
> prevent partial write.
> 
> In my view ,it is needn't journal for Filestore as to the scenario for EC
> backend and for RGW object storage application. 
> 
> For EC backend, it just now only have write full and append write, truncate
> operations which already has rollback mechanism 
> 
> For RGW application, it only has append write. 
> 
> So, in my opinion, it should develop a type of filestore with no journal,
> and it writes data using aio which directly persisted data to disk.
> And the performance are also very good for large io.
> 
> Am I right? Thanks!

In theory, yes.  In reality, no--this isn't how the FileStore was 
implemented and it would take significant work to make it behave this way.  

Note that we are focusing our efforts instead on new implementations of 
the ObjectStore interface instead of investing time in rearchitecting 
FileStore (which, although slow, is known to be stable).

sage
