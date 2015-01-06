From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] What to do when a parent RBD clone becomes corrupted
Date: Tue, 6 Jan 2015 11:12:34 -0700
Message-ID: <CAANLjFodmg9qivzCgg40RjDo2WiAYvky9wZN2U9-NM1O1yjhvQ@mail.gmail.com>
References: <CAANLjFqeEqQWimV-A8rzFgAkBrtxRXu3_OUF6waPT7N6J7GL4g@mail.gmail.com>
	<CAC6JEv9WPxAKBdjKzjYwQYEHfRr-RsmMWBd=nJBfsbknWJO97w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34368 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbAFSMg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 13:12:36 -0500
Received: by mail-wg0-f48.google.com with SMTP id l2so4486366wgh.21
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 10:12:35 -0800 (PST)
In-Reply-To: <CAC6JEv9WPxAKBdjKzjYwQYEHfRr-RsmMWBd=nJBfsbknWJO97w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 6:01 PM, Gregory Farnum <greg@gregs42.com> wrote:
> On Thu, Dec 18, 2014 at 1:21 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> Before we base thousands of VM image clones off of one or more snapshots, I
>> want to test what happens when the snapshot becomes corrupted. I don't
>> believe the snapshot will become corrupted through client access to the
>> snapshot, but some weird issue with PGs being lost or forced to be lost,
>> solar flares or alien invasions.
>>
>> My initial thought was to export a snapshot image and import it over the top
>> of the existing snapshot so that children would be preserved. No such luck.
>> I was hoping there would be a "i-really-really-want-to-do-this" option that
>> would let me restore the snapshot.
>
> I don't get it. This is to try and corrupt the snapshot? To repair it
> in the failure case?

Yes, the idea is to backup/export the snapshot and if it becomes
corrupted to re-import it back in.

>> Am I going about this the wrong way? I can see having to restore a number of
>> VM because of corrupted clone, but I'd hate to lose all the clones because
>> of corruption in the snapshot. I would be happy if the restored snapshot
>> would be flattened if it was a clone of another image previously.
>
> I don't remember exactly what metadata is stored how, that's related
> to this. I believe all the RBD images references are via a GUID that's
> distinct from the image name, which would make this non-trivial. It
> might be easier to upload the snapshot into a new rbd image and then
> change the headers on the children to point at the new image as the
> parent, but I don't think there's any easy tooling to allow that. The
> RBD guys would know better.

If the image could be overwritten, it could preserve the GUID as it
would just overwrite the blocks. If the snapshot is removed, then
either specifying the GUID or repointing the children would be
necessary, but I don't think this would be possible if there are
children (at least without a i-really-really-want-to-do-this option).
Honestly, I only really see restoring the snapshot in place as the
only recovery option that makes sense.

Thanks for the discussion.
