From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] rbd: allow escaping in config string
Date: Tue, 20 Sep 2011 09:44:55 +0200
Message-ID: <4E784477.2030000@redhat.com>
References: <Pine.LNX.4.64.1109191334080.7703@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51663 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab1ITHmA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Sep 2011 03:42:00 -0400
In-Reply-To: <Pine.LNX.4.64.1109191334080.7703@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Am 19.09.2011 22:35, schrieb Sage Weil:
> The config string is variously delimited by =, @, and /, depending on the
> field.  Allow these characters to be escaped by preceeding them with \.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>

Thanks, applied to the block branch.

Kevin
