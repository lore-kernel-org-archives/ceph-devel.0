From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: A design for CephFS forward scrub with multiple MDS
Date: Wed, 21 Sep 2016 07:24:14 -0700
Message-ID: <CAJ4mKGaCZbU1aRNmUJsz8ZY++EKRrRFRyYigye9bdy7ztmw7Pg@mail.gmail.com>
References: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
 <CAJ4mKGYo+P3JHH4OyzdAtmfx5JaMCT+xCzPLA45=BK50KJLAhg@mail.gmail.com> <448CAE51-31E6-43FD-9BF0-CDEEA982493E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33054 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934219AbcIUOYW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 10:24:22 -0400
Received: by mail-yw0-f181.google.com with SMTP id i129so55555563ywb.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 07:24:15 -0700 (PDT)
In-Reply-To: <448CAE51-31E6-43FD-9BF0-CDEEA982493E@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

On Wed, Sep 21, 2016 at 3:58 AM, Douglas Fuller <dfuller@redhat.com> wrote:
>
>> On Sep 21, 2016, at 2:29 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>
>> On Tue, Sep 20, 2016 at 10:16 AM, Douglas Fuller <dfuller@redhat.com> wrote:
>>>
>>> When popping an inode from the scrub stack, it’s important to note that its authority may have been changed by some intervening export. The scrubbing MDS will drop any file inode for which it is no longer authoritative, assuming this would be handled by the correct MDS. For directory inodes, forward a request to the authoritative MDS to scrub the directory. This may result in attempts to scrub the same inodes more than once (though we track this and can avoid most of the work), it seems necessary in order to guarantee no directories are missed due to splits or exports (NB: this is correct, right?).
>>
>> I think we need to spell this out a little more. Some thoughts:
>> * right now, the ScrubStack is just a CInode*. This needs to turn into
>> a two-way reference.
>
> I wasn’t at the datatype level of detail here. I agree it can’t be a CInode* anymore, and figured it’d have to be something we could fetch if it is exported while on the stack.
>
>> * When we freeze a tree for export, we need a new step that removes it
>> from the ScrubStack and sets up the "remote scrub" state we'd have if
>> it were a freshly-encountered subtree boundary
>>  * this may involve some delayed execution of remote scrub requests,
>> or of bundling up the need for a scrub in the exported state
>
> Directories don’t know where their subtree roots are, so I’m not sure how we would remove subdirectories and their contained files from the stack if one of their parents were exported. I think the stack could be “dumb” in some sense and not care what happens to the items on it. If we pop a file inode for which we are not authoritative, we drop it on the floor, assuming its parent directory will cause it to be scrubbed elsewhere. If we pop a directory inode for which we are not authoritative, we send a request to the authoritative MDS to scrub it.

Well, we can't keep these inodes around the way the code currently
works: unless I'm much mistaken, nothing is keeping them updated so
they're just out-of-date copies of metadata. PIN_SCRUBQUEUE exists to
keep inodes in-memory once on the scrub queue but it was explicitly
never designed to interact with multi-mds systems and needs to be
cleaned up; the current behavior is just broken. Luckily, there are
some not-too-ridiculous solutions.
* We already freeze a subtree before exporting it. I don't remember if
that involves actually touching every in-memory CDentry/CInode
underneath, or marking a flag on the root?
* We obviously walk our way through the whole subtree when bundling it
up for export
So, in one of those passes (or in a new one tacked on to freezing), we
can detect that an inode is on the scrub queue and remove it.
-Greg
