From: John Spray <jspray@redhat.com>
Subject: Re: file in one file system is a directory in ceph
Date: Thu, 14 Sep 2017 22:37:38 +0100
Message-ID: <CALe9h7dfyOQWVP-wcYVwH3+2oOsDyj0-swFzpOzA99mdvstkeg@mail.gmail.com>
References: <CAKRxpus4LRh_OyBJpy7KSn5n2L0HEVFzfpj5NywSS=zf8kbGWA@mail.gmail.com>
 <CA+2bHPZiwNGmnSfSr5rHJpbD_oShi5nYymoti3xevcCD49q-5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:45702 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdINViA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 17:38:00 -0400
Received: by mail-wm0-f41.google.com with SMTP id g206so3934618wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 14:37:59 -0700 (PDT)
In-Reply-To: <CA+2bHPZiwNGmnSfSr5rHJpbD_oShi5nYymoti3xevcCD49q-5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 14, 2017 at 10:15 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> On Thu, Sep 14, 2017 at 2:00 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>> I was trying to track down a file that keeps showing up as a directory in ceph.
>>
>> The user literally has a files called ".snap", and it tried to copy
>> into cephfs, and it kept complaining and kept reappearing as a
>> directory. delete the directory and recopy the .snap file. I found out
>> .snap is a special hidden ceph directory. the user is actually on a
>> project called "SNAP".
>>
>> Is there anything that can be done about this? My priority is to the
>> user being able to name their files anything except certain well
>> understood special characters. There is already a little contention
>> between unix and windows filesystems eg ':', but nobody will know that
>> their underlying file system will be changed to ceph or if used for
>> backups systems and that the backup system can't properly copy their
>> file due to the name..nobody is expecting this limitation.
>>
>> I, not know what the .snap was for, force deleted it, not realizing I
>> was removing possible user snapshots.
>>
>> Feels wrong to tell a user they can't name their file .snap.
>
> Change the name using "client_snap_dir" in
> docs.ceph.com/docs/master/cephfs/client-config-ref/

I've sometimes wondered if we should have a different default, perhaps
one with ceph in the name like ".ceph_snapshot" or something?

Anyone with a home directory workload is liable to see the ".snap"
issue because you get files with that name in eclipse projects.

John

>> Just food for thought. Is this moveable out of band. I've used
>> snapshot software before -- even whole drive snapshots, and the
>> snapshots for the most part were hidden or explicitly visible from
>> mount.
>
> It's not simple to expose advanced non-POSIX file system interfaces
> outside the file system without losing convenience/usability.
>
>> In unix, super fast snapshots can be made 'cp -lrp'
>
> That's not a snapshot. It's a terrible copy.
>
> --
> Patrick Donnelly
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
