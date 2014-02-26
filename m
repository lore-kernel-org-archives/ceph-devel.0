From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] PG folder hierarchy
Date: Tue, 25 Feb 2014 19:51:56 -0800
Message-ID: <CAPYLRzjd6uzdrP13Za5P6gViX_njXu=WzJLLmNq9xSYKswVn-Q@mail.gmail.com>
References: <21B7D175-AB24-45A8-B64F-AA7BA2E3A215@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:48770 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaBZDv5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 22:51:57 -0500
Received: by mail-qa0-f51.google.com with SMTP id j7so1435236qaq.38
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 19:51:56 -0800 (PST)
In-Reply-To: <21B7D175-AB24-45A8-B64F-AA7BA2E3A215@yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang <yguang11@yahoo.com>
Cc: Ceph-users <ceph-users@lists.ceph.com>, Ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Feb 25, 2014 at 7:13 PM, Guang <yguang11@yahoo.com> wrote:
> Hello,
> Most recently when looking at PG's folder splitting, I found that there was
> only one sub folder in the top 3 / 4 levels and start having 16 sub folders
> starting from level 6, what is the design consideration behind this?
>
> For example, if the PG root folder is '3.1905_head', in the first level, it
> only has one sub folder 'DIR_5' and then one sub folder 'DIR_0', and then
> 'DIR_9', under which there are two sub folders 'DIR_1' and 'DIR_9', starting
> from which, the next level has 16 sub folders.
>
> If we start splitting into 16 sub folders in the very first level, we may
> potential gain better performance with less dentry lookup (though most
> likely the root level been cached).

It's an implementation detail of the FileStore (the part of the OSD
that stores data in the filesystem). Each of those folders represents
an ever-smaller division of the hash space that objects live in. The
more PGs you have, the less hash space each one covers, so there's
that trail of folders.
It's a bit unfortunate, because as you mention it involves more
metadata memory caching, but fixing it would require some fairly
detailed code in a critical path. The cost of fixing it and the risk
of breaking things haven't been worth it yet.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
