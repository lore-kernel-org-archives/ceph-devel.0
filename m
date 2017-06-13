From: Dan van der Ster <dan@vanderster.com>
Subject: Re: ceph.dir.rbytes inconsistent on different hosts
Date: Tue, 13 Jun 2017 15:12:31 +0200
Message-ID: <CABZ+qqkCSjbk4kYVXO1CP3bbMJZU3mATc5s=o=Xc6=FKeKnC4Q@mail.gmail.com>
References: <CAGbvivJw+gEDijgq3eG41k78K2AGh+HknKwE7FKVUGo01Wd3SA@mail.gmail.com>
 <CABZ+qq=NUHM6v7v5kS5FD8DQsPiSNbBAgU+qY1=vcANNZ4+zHg@mail.gmail.com>
 <CAGbvivLGTLXDLb5JUr3481L-CE0tJo2eR9LZ2akBeh8gz29d-A@mail.gmail.com>
 <CABZ+qq=rqcNVYPbk57R8o2VkztJY9T4fjocmz7qXHByB7C6fiw@mail.gmail.com> <CAGbvivLCFEtTHCxf1t5zvV33jDGPAL3tYuda0ebsv8NDbuOusg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:34289 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdFMNNN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 09:13:13 -0400
Received: by mail-ot0-f173.google.com with SMTP id t31so87445446ota.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 06:13:13 -0700 (PDT)
Received: from mail-ot0-f176.google.com (mail-ot0-f176.google.com. [74.125.82.176])
        by smtp.gmail.com with ESMTPSA id q106sm956413ota.20.2017.06.13.06.13.12
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 06:13:12 -0700 (PDT)
Received: by mail-ot0-f176.google.com with SMTP id t31so87445022ota.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 06:13:12 -0700 (PDT)
In-Reply-To: <CAGbvivLCFEtTHCxf1t5zvV33jDGPAL3tYuda0ebsv8NDbuOusg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Our workaround is to touch the directory itself. That pokes the client
to refresh the rstats (which are otherwise cached forever).

-- dan

On Tue, Jun 13, 2017 at 3:10 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> I didnt try that, but I did touch the large file in the directory and
> that did not change anything.  Right now, I cannot recreate the
> problem because we re-mounted the filesystem and now it is correct.
> Obviously, remounting is not a good solution though.
>
> On Tue, Jun 13, 2017 at 9:06 AM, Dan van der Ster <dan@vanderster.com> wrote:
>> If you touch the dir, do the rstats synchronize?
>>
>> -- dan
>>
>>
>> On Tue, Jun 13, 2017 at 3:05 PM, Wyllys Ingersoll
>> <wyllys.ingersoll@keepertech.com> wrote:
>>>
>>> That sounds similar but Im not sure if its the same issue.  Our mounts
>>> were done using kernel mounting, not fuse.
>>>
>>> On Tue, Jun 13, 2017 at 6:02 AM, Dan van der Ster <dan@vanderster.com>
>>> wrote:
>>> > Sounds like this issue?
>>> >
>>> >    http://tracker.ceph.com/issues/17939
>>> >
>>> > Cheers, Dan
>>> >
>>> >
>>> >
>>> > On Mon, Jun 12, 2017 at 9:45 PM, Wyllys Ingersoll
>>> > <wyllys.ingersoll@keepertech.com> wrote:
>>> >> Ceph 10.2.7
>>> >> Ubuntu 16.04.2
>>> >>
>>> >> We have 2 hosts running identical versions of ceph with identical
>>> >> ceph.conf configuration files.
>>> >> Both mount /cephfs with the same options.
>>> >>
>>> >> We have a directory under /cephfs with a 4GB file in it.  The
>>> >> ceph.dir.rbytes xattr reported by ceph is different on the 2 hosts.
>>> >> One is correct, one is not.
>>> >>
>>> >> One host reports the 'ceph.dir.rbytes' correctly as 4129644548, the
>>> >> other reports it incorrectly as  2389190660
>>> >> Any ideas why this would be happening ?
>>> >>
>>> >> - Wyllys Ingersoll
>>> >>   Keeper Technology, LLC
>>> >>
>>> >>
>>> >> HOST A (correct values):
>>> >> $ ls -alF /cephfs/exports/smbtest
>>> >> total 4032857
>>> >> drwxrwxrwx 1 root    root    4129644548 May 31 11:28 ./
>>> >> drwxr-xr-x 1 root    root    4129644548 May 31 11:25 ../
>>> >> -rw-r--r-- 1 2000501 2000514       4096 May 31 11:26 ._.DS_Store
>>> >> -rw-r--r-- 1 2000501 2000514       6148 Jun  1 14:37 .DS_Store
>>> >> -rw-r--r-- 1 2000501 2000514 4129634304 Jun 12 15:25
>>> >> test-2017-05-30-m1.iso
>>> >>
>>> >> $ getfattr -d -m ceph.dir /cephfs/exports/smbtest
>>> >> getfattr: Removing leading '/' from absolute path names
>>> >> # file: cephfs/exports/smbtest
>>> >> ceph.dir.rbytes="4129644548"
>>> >>
>>> >> HOST B (incorrect values)
>>> >> $ ls -alF /cephfs/exports/smbtest
>>> >> total 4032857
>>> >> drwxrwxrwx 1 root          root         2389190660 May 31 11:28 ./
>>> >> drwxr-xr-x 1 root          root         4129644548 May 31 11:25 ../
>>> >> -rw-r--r-- 1 2000501 2000514       4096 May 31 11:26 ._.DS_Store
>>> >> -rw-r--r-- 1 2000501 2000514       6148 Jun  1 14:37 .DS_Store
>>> >> -rw-r--r-- 1 2000501 2000514 4129634304 Jun 12 15:25
>>> >> test-2017-05-30-m1.iso
>>> >>
>>> >> $ getfattr -d -m ceph.dir.rbytes /cephfs/exports/smbtest
>>> >> getfattr: Removing leading '/' from absolute path names
>>> >> # file: cephfs/exports/smbtest
>>> >> ceph.dir.rbytes="2389190660"
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> >> in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
