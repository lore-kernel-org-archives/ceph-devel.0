From: Sage Weil <sage@newdream.net>
Subject: Re: libaio parallel
Date: Fri, 1 Jul 2016 14:20:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1607011419000.31398@piezo.us.to>
References: <7BD28126D6935A4498AE6DE60B5D4CAB23D89B91@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52829 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbcGAOUQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2016 10:20:16 -0400
In-Reply-To: <7BD28126D6935A4498AE6DE60B5D4CAB23D89B91@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhangzengran <zhangzengran@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 1 Jul 2016, Zhangzengran wrote:
> Hi, all:
>          Recently we found that, when running fio with ioengine=libaio on one cluster node , some ops will become slow quest if the iodepth is large enough.
> We track the log ,found that the slow quest blocked too long when the journal entry writen with io_submit.
>          Is it a problem of libaio parallel? Thank you!

How deep is the queue depth?  And where are you seeing the slow requests?  
At some point you will just saturate the OSDs and latency will go up, but 
it should take a lot of requests for that to happen.

sage
