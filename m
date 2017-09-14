From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: file in one file system is a directory in ceph
Date: Thu, 14 Sep 2017 14:41:04 -0700
Message-ID: <CAKRxpuuDb6QL6E9rrVS=91E-D6Og54OKExE1cFWENyuuT=7WnQ@mail.gmail.com>
References: <CAKRxpus4LRh_OyBJpy7KSn5n2L0HEVFzfpj5NywSS=zf8kbGWA@mail.gmail.com>
 <CA+2bHPZiwNGmnSfSr5rHJpbD_oShi5nYymoti3xevcCD49q-5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:54707 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdINVlG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 17:41:06 -0400
Received: by mail-it0-f45.google.com with SMTP id e134so1708754ite.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 14:41:05 -0700 (PDT)
In-Reply-To: <CA+2bHPZiwNGmnSfSr5rHJpbD_oShi5nYymoti3xevcCD49q-5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

can I just disable it?
I didn't see any variable, like client_snapavailable <true|false>.
feature request?


>> In unix, super fast snapshots can be made 'cp -lrp'
>That's not a snapshot. It's a terrible copy.
Thanks for the insight. I'll read up on this. hardlinks just worked
and I think lot of snapshot software used this. It is great for rsync
when renaming or moving data into different directories, since there
is already a copy in the hardlink, it doesn't have to recopy the file.
I use to tell people that hardlinks was just yet another reason why
windows s*ck. I hope I can keep saying that.

On Thu, Sep 14, 2017 at 2:15 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
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
>
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
