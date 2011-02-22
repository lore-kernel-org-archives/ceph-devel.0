From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Questions about ceph mount dir subdirectory max size limit
Date: Tue, 22 Feb 2011 11:39:06 +0100
Message-ID: <1298371146.2423.63.camel@wido-laptop.pcextreme.nl>
References: <1298367457.1879.33.camel@cephhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51983 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934Ab1BVKjM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Feb 2011 05:39:12 -0500
In-Reply-To: <1298367457.1879.33.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Jeff,

On Tue, 2011-02-22 at 17:37 +0800, Jeff Wu wrote:
> Hi ,
> Resemble quota,
> is there a way to limit per subdirectory max size under ceph mount
> directory  ? 

I don't thin there currently is any way of having a quota per directory.
User/Group quota's are not supported either.

Wido

> 
> For instance :
> mount.ceph cephserver:6789:/ /mnt/ceph
> /mnt/ceph     max size    300G 
> /mnt/ceph/user1     max size limit   30G 
> /mnt/ceph/user2     max size limit   50G 
> /mnt/ceph/user3     max size limit   10G 
> ................
> ................
> 
> Thanks
> 
> Jeff C.P.Wu
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

