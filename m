From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: When to use "filestore xattr use omap = true"
Date: Thu, 03 Jan 2013 15:20:57 -0600
Message-ID: <50E5F639.2020001@inktank.com>
References: <CAJTroNqG7OA-WWL+5VxMZ-ggOuR-WKcFa4PH8UQ+tVda1jXN-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:50584 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab3ACVUs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 16:20:48 -0500
Received: by mail-oa0-f53.google.com with SMTP id j6so14158238oag.40
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 13:20:48 -0800 (PST)
In-Reply-To: <CAJTroNqG7OA-WWL+5VxMZ-ggOuR-WKcFa4PH8UQ+tVda1jXN-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roberto Aguilar <roberto.c.aguilar@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/03/2013 03:16 PM, Roberto Aguilar wrote:
> Hello,
>
> I read the "Filesystems" section in the "Hard disk and file system
> recommendations" [1] documentation and was confused on whether or not
> I should be using the setting:
>
>    filestore xattr use omap = true
>
> The section reads:
>
> "[...] but the ext4 is too small to be usable. To use these file
> systems, you should add the following like to the [osd] section of
> your ceph.conf file.:"
>
> Does that mean I the setting applies to systems that are using ext4,
> or does it apply to _any_ filesystem that was mentioned, i.e. btrfs,
> xfs, and ext4.
>
> Thanks!
> -Roberto.
>
> [1] http://ceph.com/docs/master/rados/configuration/filesystem-recommendations/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi Roberto,

You should always use "filestore xattr use omap = true" with EXT4.  You 
can optionally use it for BTRFS and XFS.  I've done a bit of testing and 
haven't yet been able to determine if there is any significant advantage 
or disadvantage to using it on BTRFS and XFS from a performance 
perspective.  So far the performance differences haven't been consistent 
or significant enough to be conclusive.

Mark

