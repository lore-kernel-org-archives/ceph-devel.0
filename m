From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: cephfs performance
Date: Tue, 18 Jul 2017 09:11:17 -0700
Message-ID: <CA+2bHPbbFttvv2Ci6W59g-raZqVCDaZgrQ-BPpYQvs_0XTcdNA@mail.gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
 <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com> <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34349 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdGRQLt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 12:11:49 -0400
Received: by mail-qk0-f174.google.com with SMTP id t2so17711255qkc.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 09:11:48 -0700 (PDT)
In-Reply-To: <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 18, 2017 at 9:07 AM, sheng qiu <herbert1984106@gmail.com> wrote:
> ceph version is v11.2, no special config changes, just some regular
> configurations for filestore backend.
>
> Fio is using libaio, with direct=1, running 4KB block size.

Don't use direct I/O unless you want to benchmark synchronous I/O:
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-July/019478.html

-- 
Patrick Donnelly
