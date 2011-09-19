From: Sage Weil <sage@newdream.net>
Subject: Re: [Qemu-devel] [PATCH 2/4] rbd: allow escaping in config string
Date: Mon, 19 Sep 2011 13:33:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109191330190.7701@cobra.newdream.net>
References: <1316121071-7690-1-git-send-email-sage@newdream.net>
 <1316121071-7690-3-git-send-email-sage@newdream.net> <4E774C59.3070401@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60873 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab1ISU1t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2011 16:27:49 -0400
In-Reply-To: <4E774C59.3070401@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On Mon, 19 Sep 2011, Kevin Wolf wrote:
> If src ends with a backslash, you read beyond the end of the string.

Right, sending an updated patch.

> Wouldn't it make sense to have the unescape integrated in
> qemu_rbd_next_tok? Or are there any places where you would want to call
> it without doing a qemu_rbd_unescape() afterwards?

The conf string makes two passes through rbd_next_tok(), once to grab 
the whole conf string, and again to pull out each item.  We can't 
strip out escaping the first time through or else e.g. \: will turn into 
the : delimiter.

I thought about adding a flag to enable/disable the escaping, but 
explicitly doing the unescape seemed cleaner.

sage
> 
