From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: 'zombie snapshot' problem
Date: Wed, 21 Nov 2012 14:05:03 -0800
Message-ID: <50AD500F.5040800@inktank.com>
References: <CABYiri-cnNmP_Y0bdhvp8O8v-9kJyAWK9vcHgb_zwPP7ZAAuXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51509 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab2KVT0N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:26:13 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6047320pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 11:26:12 -0800 (PST)
In-Reply-To: <CABYiri-cnNmP_Y0bdhvp8O8v-9kJyAWK9vcHgb_zwPP7ZAAuXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/21/2012 04:50 AM, Andrey Korolyov wrote:
> Hi,
>
> Somehow I have managed to produce unkillable snapshot, which does not
> allow to remove itself or parent image:
>
> $ rbd snap purge dev-rack0/vm2
> Removing all snapshots: 100% complete...done.

I see one bug with 'snap purge' ignoring the return code when removing
snaps. I just fixed this in the next branch. It's probably getting the
same error as 'rbd snap rm' below.

Could you post the output of:

     rbd snap purge dev-rack0/vm2 --debug-ms 1 --debug-rbd 20

> $ rbd rm dev-rack0/vm2
> 2012-11-21 16:31:24.184626 7f7e0d172780 -1 librbd: image has snapshots
> - not removing
> Removing image: 0% complete...failed.
> rbd: image has snapshots - these must be deleted with 'rbd snap purge'
> before the image can be removed.
> $ rbd snap ls dev-rack0/vm2
> SNAPID NAME                               SIZE
>     188 vm2.snap-yxf 16384 MB
> $ rbd info dev-rack0/vm2
> rbd image 'vm2':
>          size 16384 MB in 4096 objects
>          order 22 (4096 KB objects)
>          block_name_prefix: rbd_data.1fa164c960874
>          format: 2
>          features: layering
> $ rbd snap rm --snap vm2.snap-yxf dev-rack0/vm2
> rbd: failed to remove snapshot: (2) No such file or directory
> $ rbd snap create --snap vm2.snap-yxf dev-rack0/vm2
> rbd: failed to create snapshot: (17) File exists
> $ rbd snap rollback --snap vm2.snap-yxf dev-rack0/vm2
> Rolling back to snapshot: 100% complete...done.
> $ rbd snap protect --snap vm2.snap-yxf dev-rack0/vm2
> $ rbd snap unprotect --snap vm2.snap-yxf dev-rack0/vm2
>
>
> Meanwhile, ``rbd ls -l dev-rack0''  segfaulting with an attached log.
> Is there any reliable way to kill problematic snap?

 From this log it looks like vm2 used to be a clone, and the snapshot
vm2.snap-yxf was taken before it was flattened. Later, the parent of
vm2.snap-yxf was deleted. Is this correct?

It was a bug in 0.53 that protected snapshots could be deleted.

Josh
