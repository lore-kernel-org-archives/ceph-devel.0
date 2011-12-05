From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Cannot create an rbd image
Date: Mon, 05 Dec 2011 09:57:22 -0800
Message-ID: <4EDD0602.1070905@dreamhost.com>
References: <3559228.m2Jnrzo7Vd@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38146 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535Ab1LER5W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 12:57:22 -0500
In-Reply-To: <3559228.m2Jnrzo7Vd@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On 12/05/2011 08:57 AM, Guido Winkelmann wrote:
> Hi,
>
> I cannot create a new rbd image in a newly created ceph cluster. When I try
> it, I get these messages:
>
> # rbd create testimage1 --size 10000

<other output trimmed>

> 2011-12-05 17:41:00.994075 7ffe8b5c3760 librbd: failed to assign a block name
> for image
> create error: error 5: Input/output error

This usually happens because your osds can't find cls_rbd.so. They 
search for it in osd_class_dir, which may not be set correctly by 
default (bug #1722). Most likely it's looking in /usr/lib/rados-classes 
instead of /usr/lib64/rados-classes - change osd_class_dir in your 
ceph.conf and restart the osds to fix it.
