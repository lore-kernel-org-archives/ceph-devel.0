From: Wido den Hollander <wido@42on.com>
Subject: Re: disabling updatedb
Date: Tue, 18 Feb 2014 19:25:32 +0100
Message-ID: <5303A59C.6030604@42on.com>
References: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:42797 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbaBRSZe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Feb 2014 13:25:34 -0500
In-Reply-To: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 02/18/2014 05:47 PM, Sage Weil wrote:
> Dan at CERN noticed that his performance was tanking because updatedb was
> running against /var/lib/ceph.  updatedb has a PRUNE line in
> /etc/updatedb.conf that we should presumably be adding ourselves to.  One
> user pointed out a package that uses sed to rewrite this line in the init
> script on start.
>
> I have two questions:
>
> - is there no better way than sed to add ourselves to this list?
> - should we do it in the init script, or postinst, or both?
>

Well, I don't have a clue. postinst seems very dirty to me. It's a 
bummer that updatedb doesn't support a .d directory for configuration.

> Presumably this is a problem others have solved with other packages.
>
> 	http://tracker.ceph.com/issues/7451
>

Not completely the same, but I filed something similar at Ubuntu 
yesterday: https://bugs.launchpad.net/ubuntu/+source/mlocate/+bug/1281074

It's to prevent Ceph clients from indexing CephFS or Ceph Fuse. 
Hopefully that makes it into 14.04.

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
