From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Fri, 28 Jul 2017 11:42:39 -0700
Message-ID: <CAJ4mKGbqJpGKK6_1__sURxghxcVEt3S2-RihcU+oGs4yKWZE-w@mail.gmail.com>
References: <597962ffac427_273d7af32858674@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36340 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdG1Smk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 14:42:40 -0400
Received: by mail-it0-f50.google.com with SMTP id v205so84843729itf.1
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 11:42:40 -0700 (PDT)
In-Reply-To: <597962ffac427_273d7af32858674@ss1435.mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: scan-admin@coverity.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

________________________________________________________________________________________________________
> *** CID 1415755:  Memory - corruptions  (OVERRUN)
> /home/brad/working/src/ceph/src/mon/MonCommand.h: 39 in MonCommand::encode(ceph::buffer::list &) const()
> 33
> 34       bool has_flag(uint64_t flag) const { return (flags & flag) != 0; }
> 35       void set_flag(uint64_t flag) { flags |= flag; }
> 36       void unset_flag(uint64_t flag) { flags &= ~flag; }
> 37
> 38       void encode(bufferlist &bl) const {
>>>>     CID 1415755:  Memory - corruptions  (OVERRUN)
>>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
> 39         ENCODE_START(1, 1, bl);
> 40         encode_bare(bl);
> 41         ::encode(flags, bl);
> 42         ENCODE_FINISH(bl);
> 43       }
> 44

I looked at this one briefly and don't understand it at all. The only
ceph_le32 I can find related to it is the struct_v (defined in the
macro), and there's nothing referencing it oddly! Anybody have some
idea?
-Greg
