From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Is using the 'discard' mount option safe on an rbd?
Date: Thu, 06 Sep 2012 15:14:48 -0700
Message-ID: <50492058.2030608@inktank.com>
References: <CAPud5_62LcGbmdQEdOP+KgdO4y6t=A6OvW3f9s8hxg5ULD-inA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60602 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab2IFWOv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 18:14:51 -0400
Received: by dady13 with SMTP id y13so1368642dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 15:14:51 -0700 (PDT)
In-Reply-To: <CAPud5_62LcGbmdQEdOP+KgdO4y6t=A6OvW3f9s8hxg5ULD-inA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 09/06/2012 02:57 PM, Nick Bartos wrote:
> Is it safe to use the discard mount option when mounting a xfs
> filesystem on an rbd (using the kernel driver)?  We're currently using
> kernel 3.5.3 and Ceph 0.48.1.

The kernel rbd driver doesn't support discard yet 
(http://tracker.newdream.net/issues/190).

> Also, are there any stability issues doing it from a qemu VM?  It
> looks like support for rbd discard was added in qemu 1.1, but I wasn't
> sure how stable it was.

There was one bug (http://tracker.newdream.net/issues/2958) whose fix
will be in the next release. Note that you need an extra qemu option
(http://tracker.newdream.net/issues/2777) for the guest to detect
discard support.

Josh
