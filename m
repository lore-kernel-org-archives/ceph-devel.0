From: Alex Elder <elder@inktank.com>
Subject: Re: Character limit for rbd block device
Date: Mon, 26 Nov 2012 21:00:55 -0600
Message-ID: <50B42CE7.3080506@inktank.com>
References: <50B404DA.50805@lamphost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:47123 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732Ab2K0DA6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 22:00:58 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so8633547iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 19:00:57 -0800 (PST)
In-Reply-To: <50B404DA.50805@lamphost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: brady <brady@lamphost.com>
Cc: ceph-devel@vger.kernel.org

On 11/26/2012 06:10 PM, brady wrote:
> Hello,
>     I have a general question. Is there a specific character limit for
> rbd block devices? In attempting to map a block device with a name that
> is 36 characters or more, I am getting the following error:
> 
> rbd map (36+ character name) --user admin --secret /etc/ceph/keyring.key
> add failed: (2) No such file or directory

We can set the maximum supported length almost arbitrarily high,
although we use the image name in a path component.  Linux limits
such file names to 255 bytes normally.

As Josh said, the limit is higher than what you mention.  Do
you have any thoughts on what constitutes a reasonable limit?
Are you using some sort of naming convention that produces
your 36+ byte image names?

Thanks.

					-Alex

>     When using the same command to map a device with 35 characters or
> less, the device is mapped as expected. Any insight into this issue
> would be greatly appreciated.
> 
> -Brady
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

