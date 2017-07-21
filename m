From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: cephfs performance
Date: Fri, 21 Jul 2017 11:55:27 -0700
Message-ID: <CA+2bHPZC2eQ=dS4v1ECQUEu+WWv7eRrAeCFbf4smbBD+nbmeDA@mail.gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
 <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com>
 <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com>
 <CA+2bHPbbFttvv2Ci6W59g-raZqVCDaZgrQ-BPpYQvs_0XTcdNA@mail.gmail.com>
 <CAB7xdin_PNRCCqf1nO0LVb4P8fUXMJqwBqXHavrQU_VVi6SuNg@mail.gmail.com>
 <CA+2bHPbSeg0t4M41XL+rdjuT2fmz8WnU1N_G0N5a2zhNNqOSng@mail.gmail.com> <CAB7xdikWd6nuUJy96BQJogTohWzZBotsy+OF7jrgVip7AqEMpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33531 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbdGUSz7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jul 2017 14:55:59 -0400
Received: by mail-qt0-f173.google.com with SMTP id n42so45351810qtn.0
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jul 2017 11:55:58 -0700 (PDT)
In-Reply-To: <CAB7xdikWd6nuUJy96BQJogTohWzZBotsy+OF7jrgVip7AqEMpw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sheng,

Sorry I misspoke in my previous email. The clients may all have the
capability to read and write but none of them will be able to
**cache** reads/writes or **buffer** writes. They rely on synchronous
read/write with the OSDs for consistency/atomicity.

On Fri, Jul 21, 2017 at 9:19 AM, sheng qiu <herbert1984106@gmail.com> wrote:
> so when multiple write clients or a mix of read and write clients
> accessing same file, the previous cached data of this file on all
> clients will be revoked.

Yes.

> And the following multi-clients' write or mixed read and write
> accessing to that file will become synchronous.

Writes/reads are become synchronous, yes.

> On Tue, Jul 18, 2017 at 9:41 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>> On Tue, Jul 18, 2017 at 9:17 AM, sheng qiu <herbert1984106@gmail.com> wrote:
>>> Hi Patrick,
>>>
>>> thanks for your quick response.
>>> just one concern, if disable direct I/O, multiple clients access same
>>> file via different mount point on different machines, will it cause
>>> data inconsistency?
>>
>> No, but you'll still effectively have synchronous I/O because only one
>> writer will have write capabilities from the MDS.
>>
>> --
>> Patrick Donnelly



-- 
Patrick Donnelly
