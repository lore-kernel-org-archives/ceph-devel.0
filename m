From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Ceph fs stability
Date: Thu, 02 Aug 2012 10:24:38 -0700
Message-ID: <501AB7D6.3020508@inktank.com>
References: <501AB499.1080706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46996 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab2HBRYn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 13:24:43 -0400
Received: by qadb17 with SMTP id b17so3577677qad.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 10:24:42 -0700 (PDT)
In-Reply-To: <501AB499.1080706@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Niko! <nicola.ranaldo@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/02/2012 10:10 AM, Niko! wrote:
> Hi!
>
> we are using ceph 0.48 on three nodes to provide rbd images for further
> four kvm nodes (not kernel mapped) with no big issues and would mount
> the ceph fs on the kvm nodes just to store xml virtual machine
> definitions in order to have them immediately in the case an host
> crashes (we are in multimds configuration). As ceph fs is not production
> ready what are the possible problems? May the fs corrupt the rbd pool or
> damages will be limited only to the data/metadata pools (acceptable for
> us)? may the fs hang the entire cluster or kvm client nodes?
>
> Regards.
>
>      Niko

The fs won't corrupt other pools or make them inaccessible, but if you
use the kernel client it could potentially lock up the node. If you
really want the fs interface, you can limit the failure further by
mounting with fuse instead of the kernel ceph module.

Since you're just storing some some vm definitions, why not use rados
objects directly, e.g. with rados get/put to retrieve and store them?

Josh

