From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Sat, 29 Jul 2017 08:22:15 +1000
Message-ID: <CAF-wwdFcPpoXNeS86X9hrpqRj-eUNv3LkWs4x5z3fj3JrVvG4w@mail.gmail.com>
References: <597962ffac427_273d7af32858674@ss1435.mail>
 <CAJ4mKGbqJpGKK6_1__sURxghxcVEt3S2-RihcU+oGs4yKWZE-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35345 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbdG1WWW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 18:22:22 -0400
Received: by mail-pg0-f46.google.com with SMTP id v190so116031873pgv.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 15:22:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbqJpGKK6_1__sURxghxcVEt3S2-RihcU+oGs4yKWZE-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: scan-admin@coverity.com, ceph-devel <ceph-devel@vger.kernel.org>



On Sat, Jul 29, 2017 at 4:42 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> ________________________________________________________________________________________________________
>> *** CID 1415755:  Memory - corruptions  (OVERRUN)
>> /home/brad/working/src/ceph/src/mon/MonCommand.h: 39 in MonCommand::encode(ceph::buffer::list &) const()
>> 33
>> 34       bool has_flag(uint64_t flag) const { return (flags & flag) != 0; }
>> 35       void set_flag(uint64_t flag) { flags |= flag; }
>> 36       void unset_flag(uint64_t flag) { flags &= ~flag; }
>> 37
>> 38       void encode(bufferlist &bl) const {
>>>>>     CID 1415755:  Memory - corruptions  (OVERRUN)
>>>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
>> 39         ENCODE_START(1, 1, bl);
>> 40         encode_bare(bl);
>> 41         ::encode(flags, bl);
>> 42         ENCODE_FINISH(bl);
>> 43       }
>> 44
>
> I looked at this one briefly and don't understand it at all. The only
> ceph_le32 I can find related to it is the struct_v (defined in the
> macro), and there's nothing referencing it oddly! Anybody have some
> idea?

We could try compiling with "-fsanitize=address" and exercise this code then try
it under valgrind (I imagine this is already done since this code is well used).
If neither of those show up the problem we could probably flag it as a false
positive?

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Cheers,
Brad
