From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to know the Rados pools path.
Date: Thu, 16 Aug 2012 15:18:10 +0200
Message-ID: <502CF312.7030008@widodh.nl>
References: <loom.20120816T141547-773@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45553 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab2HPNSM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 09:18:12 -0400
In-Reply-To: <loom.20120816T141547-773@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/16/2012 02:20 PM, ramu wrote:
> Hi,
>
>        Iam creating rados pools from java-rados,it's creating the pool fine.
> I don't know this pool location on disks,please help me to know the location
> of rados pool(means path).It is showing the list of pools from the command
> "rados lspools".But there is not showing the path.
>

Why do you want to know the pool location?

First, there is no such hardcoded location. On the disk of an OSD you'll 
find directories for each PG with their files in them, but I wouldn't 
recommended digging in there.

There is no need for it. You know the pool name and you can interact 
with your objects.

Wido

> Thanks,
> Ramu.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

