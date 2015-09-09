From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: bug with cache/tiering and snapshot reads
Date: Tue, 8 Sep 2015 20:55:02 -0400 (EDT)
Message-ID: <1807779066.25465139.1441760102338.JavaMail.zimbra@redhat.com>
References: <55EF6CBF.4090703@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:35410 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbbIIA4G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 20:56:06 -0400
In-Reply-To: <55EF6CBF.4090703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> Does "bug with cache/tiering and snapshot reads"
> http://tracker.ceph.com/issues/12748 sound familiar to you ? Although it
> looks like a tiering problem, it involves rbd and maybe it rings a bell ? If
> not, don't worry about it and I'll dig further: I can repeat it every time
> using the script from the description. I kind of remember something similar
> but it involved erasure coded pools and is probably different.

I believe it's related to this thread [1].  There is an cache tier / EC pool issue wrt proxied writes, but this is different.   

-- 

Jason Dillaman 

[1] http://article.gmane.org/gmane.comp.file-systems.ceph.user/22901
