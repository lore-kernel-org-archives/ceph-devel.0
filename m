From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/3] rbd: allow client id to be specified in config string
Date: Thu, 08 Sep 2011 12:04:42 +0200
Message-ID: <4E68933A.2000907@redhat.com>
References: <1315412886-21092-1-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56837 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756359Ab1IHKBq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Sep 2011 06:01:46 -0400
In-Reply-To: <1315412886-21092-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Am 07.09.2011 18:28, schrieb Sage Weil:
> Allow the client id to be specified in the config string via 'id=' so that
> users can control who they authenticate as.  Currently they are stuck with
> the default ('admin').  This is necessary for anyone using authentication
> in their environment.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>

Thanks, applied all to the block branch.

Kevin
