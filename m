From: Sage Weil <sage@newdream.net>
Subject: Re: Create/Quota/Mount pool
Date: Fri, 16 Mar 2012 08:32:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203160830320.31380@cobra.newdream.net>
References: <4F6327FB.4070104@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40050 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422646Ab2CPPcw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 11:32:52 -0400
In-Reply-To: <4F6327FB.4070104@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chu Duc Minh <chu.ducminh@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 16 Mar 2012, Chu Duc Minh wrote:
> Hi, i'm searching a way to create more data(s) pool and quota for each pool.
> Do you know how to select pool to mount when using ceph client. (i'm using
> kernel 3.0.x)

You can create pools with 

 ceph osd pool create <poolname>

make them usable by the fs with

 ceph mds add_data_pool <poolname>

and then set a subdirectory to use that pool for new files with cephfs 
(man cephfs).

If you run into problems, let us know; this isn't well documented yet!

sage
