From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: cephfs performance
Date: Tue, 18 Jul 2017 09:07:16 -0700
Message-ID: <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
 <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34624 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbdGRQHR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 12:07:17 -0400
Received: by mail-qt0-f171.google.com with SMTP id 32so19770716qtv.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 09:07:17 -0700 (PDT)
In-Reply-To: <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

ceph version is v11.2, no special config changes, just some regular
configurations for filestore backend.

Fio is using libaio, with direct=1, running 4KB block size.

I will try kernel client to see if there's any improvement.

Thanks,
Sheng

On Tue, Jul 18, 2017 at 8:58 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> On Mon, Jul 17, 2017 at 10:27 PM, sheng qiu <herbert1984106@gmail.com> wrote:
>> hi,
>>
>> I am evaluating the cephfs performance and see unreasonable
>> performance when multiple threads accessing same mount point.
>>
>> there are 10k files (300MB each) in the fuse mount point, when
>> increase multiple fio threads accessing those 10k files, the
>> performance is not scaled and bounded to ~40MB/s.
>>
>> the ceph cluster has 36 OSDs on three high end servers, each OSD
>> backed by a NVMe drive. Theres's another servers running one MDS
>> process and monitors.
>>
>> if pushing IO via fio rbd engine to the cluster directly, it has
>> pretty reasonable performance. Is there any special configuration i
>> should pay attention when setup cephfs or fuse client is the problem?
>> or i should use more MDS?
>>
>> any suggestions would be appreciated.
>
> What version are you running? Any special config option changes?
>
> What I/O engines are you testing with fio? We need more details about
> the testing to give you better feedback.
>
> --
> Patrick Donnelly
