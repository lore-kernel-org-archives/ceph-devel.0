From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd map fail when the crushmap algorithm changed to tree
Date: Mon, 09 Jul 2012 11:23:27 -0700
Message-ID: <4FFB219F.6020809@inktank.com>
References: <8512670932FB654F81AF0FEF1BE6D49D019C0EA7@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50912 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab2GISXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 14:23:30 -0400
Received: by pbbrp8 with SMTP id rp8so19605997pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 11:23:30 -0700 (PDT)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D019C0EA7@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

On 07/06/2012 12:27 AM, Eric_YH_Chen@wiwynn.com wrote:
> Hi all:
>
> Here is the original crushmap, I change the algorithm of host to "tree"
> and
> set back to ceph cluster. However, when I try to map one imge to
> rados block device (RBD), it would hang and no response until I press
> ctrl-c.
> ( rbd map xxxx  =>  then hang)
>
> Is there any wrong in the crushmap? Thanks for help.

It looks like the kernel client is not able to parse the tree algorithm
in the OSDMap. I filed http://tracker.newdream.net/issues/2759 to
track this.

Josh
