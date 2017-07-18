From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: cephfs performance
Date: Tue, 18 Jul 2017 09:17:35 -0700
Message-ID: <CAB7xdin_PNRCCqf1nO0LVb4P8fUXMJqwBqXHavrQU_VVi6SuNg@mail.gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
 <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com>
 <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com> <CA+2bHPbbFttvv2Ci6W59g-raZqVCDaZgrQ-BPpYQvs_0XTcdNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35759 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdGRQRh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 12:17:37 -0400
Received: by mail-lf0-f47.google.com with SMTP id w198so18268496lff.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 09:17:36 -0700 (PDT)
In-Reply-To: <CA+2bHPbbFttvv2Ci6W59g-raZqVCDaZgrQ-BPpYQvs_0XTcdNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Patrick,

thanks for your quick response.
just one concern, if disable direct I/O, multiple clients access same
file via different mount point on different machines, will it cause
data inconsistency?
for example, some client modify one file which has old data buffered
on the other client.

Thanks,
Sheng

On Tue, Jul 18, 2017 at 9:11 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> On Tue, Jul 18, 2017 at 9:07 AM, sheng qiu <herbert1984106@gmail.com> wrote:
>> ceph version is v11.2, no special config changes, just some regular
>> configurations for filestore backend.
>>
>> Fio is using libaio, with direct=1, running 4KB block size.
>
> Don't use direct I/O unless you want to benchmark synchronous I/O:
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-July/019478.html
>
> --
> Patrick Donnelly
