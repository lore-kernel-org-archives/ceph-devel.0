From: John Spray <jspray@redhat.com>
Subject: Re: ceph-mgr is in master
Date: Tue, 4 Oct 2016 07:07:13 +0100
Message-ID: <CALe9h7eZO2XCWqmMhM+hiJqSgmLPLqs5yBgyOD-6sRCYDD3jDQ@mail.gmail.com>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
 <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34721 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbcJDGNs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Oct 2016 02:13:48 -0400
Received: by mail-qt0-f172.google.com with SMTP id 38so89762135qte.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Oct 2016 23:13:48 -0700 (PDT)
In-Reply-To: <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 3, 2016 at 6:45 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Fri, Sep 30, 2016 at 4:24 AM, John Spray <jspray@redhat.com> wrote:
>> Hi all,
>>
>> A big thank you to everyone who helped with the reviews, packaging and
>> design discussions.  This will be included in forthcoming Kraken
>> (11.2.x) release.
>>
>> There is a new section in the documentation:
>> http://docs.ceph.com/docs/master/mgr/
>>
>> There is a new sub-project on tracker.ceph.com, populated with some
>> issues by me:
>> http://tracker.ceph.com/projects/mgr/issues
>>
>> Pull requests are of course welcome.
>>
>> At some point before Kraken I'll try to remember to send out a message
>> to ceph-users to give people a heads up about this mysterious new
>> daemon that's appearing on their systems.
>
> Awesome, this is going to be great. :) A few questions just from going
> over the admin guide:
>
> 1) It says to run a ceph-mgr on each monitor host. Does this mean
> admins need to do this manually when setting up a cluster?

The systemd units will automatically set up a mgr instance in Kraken.
I haven't personally tested that though.

> 2) I gather that the way HA works is that traffic just gets directed
> to whichever one the monitors pick. It seems like we'd want that to
> migrate to the same host as the leader monitor when possible; is that
> possible? Is it planned? Is it actually undesirable because it
> increases CPU usage and network savings isn't worth that?

The obvious advantage would be to avoid a network hop by running on
the same host as the leader.  However, unless it's always going to be
the case, that extra efficiency could give a false sense of security
if things are fast enough in that case, but become too slow when the
service runs somewhere else.  It would be interesting to try.

> 3) It uses "ceph tell" syntax. I thought we were moving away from
> top-level "tell" commands and towards making them part of the
> sub-command (eg "ceph osd tell", "ceph mgr tell"); is this a
> deliberate new lease on life for that? Unintended? Something I just
> made up?

As Dan says, `ceph tell` is the new one, the one that sends commands
directly from the CLI to the named service (not via the mon).
However, this is a bit of a placeholder, as we'll eventually be
switching to some commands (especially PG stats ones) to silently go
to the mgr instead of the mon.  There are various ways of
accomplishing that, the simplest one is to have the CLI fetch both mgr
and mon command descriptions, and preferentially send commands to
matching entries from the mgr.

John

>
> -Greg
