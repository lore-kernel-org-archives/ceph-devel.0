From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: qemu-rbd : savevm monitor command don't save vmstate, is it
 normal ?
Date: Wed, 29 Aug 2012 09:25:54 -0700
Message-ID: <CAC-hyiHURKbxNcW+MNMi2onw9iar7d7RD=y3pw_EoHQB711-iA@mail.gmail.com>
References: <3aa58a4b-8f7f-48ac-8ab7-510924be9e2a@mailpro>
	<503E4015.7050707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59927 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab2H2QZ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 12:25:56 -0400
Received: by bkwj10 with SMTP id j10so389391bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 09:25:54 -0700 (PDT)
In-Reply-To: <503E4015.7050707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Wed, Aug 29, 2012 at 9:15 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 08/29/2012 06:40 AM, Alexandre DERUMIER wrote:
>>
>> Hi,
>>
>> I'm trying to take a full vm state snapshot with savevm monitor command
>> (qemu 0.12rc1 + rbd 0.48.1)
>>
>> it seem that vmstate is not saved in the snapshot. (I also don't notice
>> any vm hang during snapshot)
>> Snapshot of disk is correctly made.
>
>
> AFAIK the only block backend that supports saving the vmstate is qcow2.
> For rbd, the savevm/loadvm monitor commands are equivalent to
> 'rbd snap create' and 'rbd snap rollback'. They just save/rollback the
> disk.
>
>
>> using loadvm monitor command, rollback correctly to disk snapshot but vm
>> hang.
>
>
> If you don't quiesce i/o i.e. via xfsfreeze (it works on the vfs level
> now, so it's not xfs-specific anymore) before snapshotting a running
> vm, the fs might require a fsck to be usable. This is only rolling back
> the disk, and not the memory state, so doing it while the vm is running
> is likely to cause problems.
>
>
>> starting qemu with -loadvm snapshotname give
>> kvm: Error -22 while loading VM state
>>
>>
>> Is it normal ? Not implemented ?
>
>
> bdrv_{save|load}_vmstate are not implemented.
>
How complicated would it be to implement it? Looking at the api it
seems trivial. We can add a new block with a .vmstate prefix and keeps
the raw data on it. We should probably add some librbd functionality
that stores and retrieves alternative data payloads and use it for
that.

Yehuda
