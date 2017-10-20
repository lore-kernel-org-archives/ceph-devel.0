From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: "debug ms = 0/5" logging ...
Date: Thu, 19 Oct 2017 17:08:09 -0700
Message-ID: <CAJ4mKGYLmtqMvQeyrtXg6b=kTu26DEgaU9iXxGo1+rMhfzZubA@mail.gmail.com>
References: <1508413648.27011.5.camel@redhat.com> <CALe9h7ey7ADZ6jSk29qqy-yBMVJAD1codOuaBGgn03ursadExg@mail.gmail.com>
 <CACJqLybJXS84ijrCH6gAptPp3reiQezwvn8dq5hxno54==a7tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:55572 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdJTAIK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 20:08:10 -0400
Received: by mail-it0-f45.google.com with SMTP id l196so11712817itl.4
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 17:08:10 -0700 (PDT)
In-Reply-To: <CACJqLybJXS84ijrCH6gAptPp3reiQezwvn8dq5hxno54==a7tw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, "Dillaman, Jason" <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 19, 2017 at 6:24 AM, Haomai Wang <haomai@xsky.com> wrote:
> On Thu, Oct 19, 2017 at 8:06 PM, John Spray <jspray@redhat.com> wrote:
>> On Thu, Oct 19, 2017 at 12:47 PM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> While the default messenger logging setting has always been an
>>> impediment to high queue-depth, high IOPS workloads, in Luminous it
>>> appears to have slowed down librbd small block IOPS by an additional 10-
>>> 15%. When compared against cases where the messenger logs are disabled,
>>> it's more than a 40% IOPS degradation to have the messenger logs
>>> enabled.
>
> As I remembered, luminous will add extra line for each message
> compared to jewel.
>
>>>
>>> From some quick "perf" runs, the Luminous delta seems to be from from a
>>> few places: (1) hobject_t is now used in the OSD messages, and it's more
>>> expensive to construct[2] and print; (2) log messages are longer in
>>> length; and (3) async messenger is more verbose per message at log level
>>> 1 compared to simple messenger.
>
> it's new added.

Which extra log messages are we printing out in AsyncMessenger that
aren't in SimpleMessenger? Is it just the log line printing out the
message on _send_message? Is there any reason we can't turn that down
to a lower level like in SimpleMessenger?
-Greg
