From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Questions about journals, performance and disk utilization.
Date: Tue, 22 Jan 2013 16:25:07 -0800
Message-ID: <50FF2DE3.7020404@inktank.com>
References: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk> <50FF0197.6020202@inktank.com> <50FF0410.3030308@gmail.com> <50FF098C.8050707@profihost.ag> <50FF0B2E.6010301@inktank.com> <50FF0B6A.6070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:57937 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab3AWAZL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 19:25:11 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so4322500pbb.29
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 16:25:10 -0800 (PST)
In-Reply-To: <50FF0B6A.6070408@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>, martin <martin@skytech.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/22/2013 01:58 PM, Jeff Mitchell wrote:
> I'd be interested in figuring out the right way to migrate an RBD from
> one pool to another regardless.

Each way involves copying data, since by definition a different pool
will use different placement groups.

You could export/import with the rbd tool, do a manual dd like you
mentioned, or clone and then flatten in the new pool. The simplest
is probably 'rbd cp pool1/image pool2/image'.

Josh
