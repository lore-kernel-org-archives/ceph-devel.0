From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [NewStore]About PGLog Workload With RocksDB
Date: Tue, 8 Sep 2015 16:47:46 +0100
Message-ID: <CAJ4mKGbA4ZbPr9bS+EKiagTBcZoyOB5OJsbALkhf2mde56rwfw@mail.gmail.com>
References: <CACJqLybUOPaj3kFrn6b3-1O7fEd0zom2KR5ETC+DiPpid4HQew@mail.gmail.com>
	<CACJqLyanf82a60YrLmYio80ff+-xkdWUiSqhiiu3v8TqSa0K_w@mail.gmail.com>
	<CAJ4mKGZFoScqE3t-fawrkCEPZe2t_BmbbV+tpUF3HBkMUF+8=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37449 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbIHPrr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 11:47:47 -0400
Received: by wicfx3 with SMTP id fx3so120151235wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 08 Sep 2015 08:47:46 -0700 (PDT)
In-Reply-To: <CAJ4mKGZFoScqE3t-fawrkCEPZe2t_BmbbV+tpUF3HBkMUF+8=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 8, 2015 at 3:12 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Sep 8, 2015 at 3:06 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Hit "Send" by accident for previous mail. :-(
>>
>> some points about pglog:
>> 1. short-alive but frequency(HIGH)
>
> Is this really true? The default length of the log is 1000 entries,
> and most OSDs have ~100 PGs, so on a hard drive running at 80
> writes/second that's about 100000 seconds (~27 hours) before we delete
> an entry. In reality most deployments aren't writing that
> quickly....and if something goes wrong with the PG we increase to
> 10000 log entries!
> -Greg

Er, whoops, as Ilya points out I've left out a step here. 100000
entries at 80 entries/sec is only 1250 seconds, or about 20 minutes.
That's quite a different number and you should perhaps just ignore me.
:)
