From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph-mgr is in master
Date: Mon, 3 Oct 2016 22:49:57 -0700
Message-ID: <CAJ4mKGYJptXbrL54FZp=YLsH51STk=F9Fw5ztq32xboX-jvaAQ@mail.gmail.com>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
 <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com> <b9e30685-d37d-f019-79cc-dbe5c77b71b8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35962 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcJDFt6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Oct 2016 01:49:58 -0400
Received: by mail-io0-f175.google.com with SMTP id j37so49060877ioo.3
        for <ceph-devel@vger.kernel.org>; Mon, 03 Oct 2016 22:49:58 -0700 (PDT)
In-Reply-To: <b9e30685-d37d-f019-79cc-dbe5c77b71b8@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 3, 2016 at 8:16 PM, Dan Mick <dmick@redhat.com> wrote:
> On 10/03/2016 10:45 AM, Gregory Farnum wrote:
>
>> 3) It uses "ceph tell" syntax. I thought we were moving away from
>> top-level "tell" commands and towards making them part of the
>> sub-command (eg "ceph osd tell", "ceph mgr tell"); is this a
>> deliberate new lease on life for that? Unintended? Something I just
>> made up?
>
> Actually it's the other way around; 'osd tell', for example, says:
>
> "osd tell" is deprecated; try "tell osd.<id> <command> [options...]"
> instead (id can be "*")

o_0. Thanks Dan.

In other news we've also acquired some valgrind errors in the
MgrMonitor; not sure how serious they are but it's getting flagged in
the tests. http://tracker.ceph.com/issues/17492
