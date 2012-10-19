From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd map error with new rbd format
Date: Fri, 19 Oct 2012 16:52:42 -0700
Message-ID: <5081E7CA.2080801@inktank.com>
References: <60E83269D669544E8069A09CB69135EA02DF21@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:62067 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab2JSXwq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 19:52:46 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so451358dak.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Oct 2012 16:52:45 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA02DF21@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

On 10/18/2012 01:01 AM, Eric_YH_Chen@wiwynn.com wrote:
> Hi, Josh:
>
>> Yeah, format 2 and layering support is in progress for kernel rbd,
>> but not ready yet. The userspace side is all ready in the master
>> branch, but it takes more time to implement in the kernel.
>> Btw, instead of --new-format you should use --format 2. It's in
>> the man page in the master branch.
>
> As you mentioned before, http://www.spinics.net/lists/ceph-devel/msg08857.html
> The kernel rbd is not ready at September, so we cannot map rbd to a device.
> Would you mind to estimate when will be available? And which version of kernel? (3.5 or 3.6?)
> Thanks!

At this point format 2 is understood by the kernel, and the
infrastructure for opening parent images and the I/O path
for clones is in progress. We estimate about 4-8 weeks for this,
but you should check back then.

Kernel 3.6 was already released, so this would probably go into 3.8 or
3.9.

Josh
