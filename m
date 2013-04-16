From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: other rbd stuff
Date: Tue, 16 Apr 2013 15:43:11 -0700
Message-ID: <516DD3FF.6020009@inktank.com>
References: <alpine.DEB.2.00.1304161446540.5978@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49959 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965476Ab3DPWnO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 18:43:14 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so532228pdd.3
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 15:43:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304161446540.5978@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/16/2013 03:02 PM, Sage Weil wrote:
> - wip-4531 looks good.  should i merge it?

Yes

> - figured out the DiffIterate failures (rbd caching), see wip-4683.
> flushing from diff_iterate should be fine right?

It should use _flush() so that it doesn't count as a flush coming from
an upper layer.

> - the qemu-iotests are failing because of the rbd progress on stderr.
> sent a patch to qemu list with a 2>/dev/null.  note that qemu-iotests is
> not part of qemu.git, so our test script should clone from there instead.
> or we can make our own copy of the old standalone repo and host it
> ourselves...

Until we have a qemu gitbuilder, we should copy the old qemu-iotests
repo. The tests depend heavily on the version of qemu used (output
differences plus using new features and fixes for old bugs).

Josh
