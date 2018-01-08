From: kefu chai <tchaikov@gmail.com>
Subject: Re: Read a single shard in EC
Date: Mon, 8 Jan 2018 14:48:19 +0800
Message-ID: <CAJE9aOO0z_jRUP4bJ0vEw38VJNrUYLbKNpuYTNt6f8ks2vBanA@mail.gmail.com>
References: <CAODUPsHZhyafs6E8n31nBcLVjLEjiMUTEju2XbCjdWLDwsOwog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:39925 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755760AbeAHGsU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 01:48:20 -0500
Received: by mail-qt0-f176.google.com with SMTP id k19so12486989qtj.6
        for <ceph-devel@vger.kernel.org>; Sun, 07 Jan 2018 22:48:20 -0800 (PST)
In-Reply-To: <CAODUPsHZhyafs6E8n31nBcLVjLEjiMUTEju2XbCjdWLDwsOwog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Sun, Jan 7, 2018 at 3:03 AM, Oleg Kolosov <olekol@gmail.com> wrote:
> Hi
> I was wondering if it's possible to read a single shard in an erasure code?
>
> I saw this was implemented in Luminous:
>
> core: osd/ECTransaction: only read partial stripes when below
> *original* object size (issue#19882, pr#15712, Sage Weil)
>
> If yes, how can it be done?

no, i don't think so. stripe and shard are different concepts in Ceph.
please see http://docs.ceph.com/docs/master/dev/osd_internals/erasure_coding/#glossary
. here i assume that what you want to read is strips from a certain
shard. but what the change tried to accomplish is to avoid reading
beyond original size if a write request touches the area out of the
original end of file. it has nothing to do with shard, IMO.


-- 
Regards
Kefu Chai
