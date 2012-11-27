From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Character limit for rbd block device
Date: Mon, 26 Nov 2012 16:52:37 -0800
Message-ID: <50B40ED5.7050307@inktank.com>
References: <50B404DA.50805@lamphost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57259 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670Ab2K0AxZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 19:53:25 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so8445097pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 16:53:25 -0800 (PST)
In-Reply-To: <50B404DA.50805@lamphost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: brady <brady@lamphost.com>
Cc: ceph-devel@vger.kernel.org

On 11/26/2012 04:10 PM, brady wrote:
> Hello,
>      I have a general question. Is there a specific character limit for
> rbd block devices? In attempting to map a block device with a name that
> is 36 characters or more, I am getting the following error:
>
> rbd map (36+ character name) --user admin --secret /etc/ceph/keyring.key
> add failed: (2) No such file or directory
>
>      When using the same command to map a device with 35 characters or
> less, the device is mapped as expected. Any insight into this issue
> would be greatly appreciated.
>
> -Brady

Which kernel version are you using?

A year ago there was a 40-char limit on objects names in the kernel's
libceph module, hence the failure at 36 char rbd image names (36 char
name + ".rbd" is the format 1 header object name).

This was extended to a 96-char limit in linux 3.2. There's no real limit
in userspace still (http://tracker.newdream.net/issues/1701).

Josh

