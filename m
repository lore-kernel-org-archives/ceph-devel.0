From: John Spray <jspray@redhat.com>
Subject: Re: Cluster log: hiding cluster map prints, decreasing audit log messages
Date: Thu, 15 Jun 2017 20:28:26 -0400
Message-ID: <CALe9h7dyfNWQ17G4zEAUkaeLKyFxkNNkOpWvLbyAL7L-AAYDtQ@mail.gmail.com>
References: <CALe9h7cVUB-H8aeXGRFPFOeTe+nFyMZ=Obmqr4P527gmR7268A@mail.gmail.com>
 <alpine.DEB.2.11.1706151924590.32272@piezo.novalocal> <CAF-wwdGYTBhc7n+DmuVUwhHHQo6W54JtJ5JHv2_ruQJXEQgf0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33956 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdFPA2s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 20:28:48 -0400
Received: by mail-wr0-f175.google.com with SMTP id 77so30253597wrb.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 17:28:47 -0700 (PDT)
In-Reply-To: <CAF-wwdGYTBhc7n+DmuVUwhHHQo6W54JtJ5JHv2_ruQJXEQgf0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 15, 2017 at 7:55 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>
>
> On Fri, Jun 16, 2017 at 5:27 AM, Sage Weil <sage@newdream.net> wrote:
>> On Thu, 15 Jun 2017, John Spray wrote:
>>> Some musings from me about the cluster log, interested in others' thoughts.
>
> OK, you asked :)
>
> When we attempt to clean up logging we walk a fine line between making the logs
> "readable" for admins and removing useful information that can be crucial in the
> event of an issue. Both requirements hold great merit of course and are kind of
> diametrically opposed to each other making this tricky. The more times we can
> avoid the scenario where we need to ask for logs at a higher debug level the
> better the experience for the user as it is not always possible to reproduce
> these things on demand.
>
> So... I was wondering if we could produce two logs, an expurgated log for
> system administrator consumption containing only information considered relevant
> for that level of consumption, and a debugging log containing the level of
> detail support/devel would prefer to see if trying to debug a problem. The debug
> log could even be compressed on the fly if we are concerned about space. That
> might give us the "best of both worlds" approach?

Yes, I'm completely up for keeping (but hiding by default) the more
low level stuff that exists at the moment -- currently it's mostly
just the summary prints that we get every time a cluster map changes.
The subtle bit is how we actually implement it, so that we're getting
the right outcome in terms of efficiently fetching the latest stuff at
the "normal" detail level, and making sure we aren't throwing away
high-level content too soon if there is a lot of low-level content at
the same time.

John

>
> As I said, you asked :) (seriously though, I'm not overly attached to this idea
> so please feel free to shoot it down in flames however, I think it is worthy of
> consideration).
>
>>>
>>> Audit log
>>> =======
>>>
>>> The audit logging is nice, but it has a couple of noticeable annoyances:
>>>  - it crowds out real health messages, e.g. when using the new "log
>>> last" command you may see mostly see audit log messages, especially if
>>> a monitoring tool is polling some commands.
>>>  - the messages themselves are ugly JSON dumps
>>>
>>> We already have a separate channel for these, so it's easy for UIs to
>>> split out the audit stuff (I just did this in the dashboad module),
>>> but I think they're still consuming some number of the lines when we
>>> fetch a set number of lines using "log last".
>>>
>>> Maybe things like log last (and the internal buffering in the mon)
>>> should keep N lines for each channel, rather than channels competing
>>> for the space?  It might already be like that on some level, haven't
>>> dug into the mon internals yet.
>>
>> - last N for each channel makes sense to me.  The way LogMonitor
>> implements this needs a bit of cleanup at the same time.
>> - I think it makes sense to only show the 'default' channel by default and
>> ignore all others (including audit log) unless asked for?  I guess this
>> would add a channel option to 'last' that takes either the channel name
>> (audit or default) or '*' or 'all' for all.
>>
>>> Cluster maps
>>> ===========
>>>
>>> It is very nice for debugging that we can see updates to osdmap/fsmap
>>> ticking by as the mon updates the state of the system.  However, it
>>> kind of disrupts our ability to output clearly readable log messages
>>> for ordinary users when things changed.
>>>
>>> Maybe the cluster maps should be on a separate channel, like the audit logs are?
>>>
>>> Of course, when we're hiding the low level cluster map prints away, we
>>> need to at the same time make sure we're adding in the right high
>>> level "OSD 123 went down" messages to replace where the "osdmap e456
>>> ..." lines currently give you the hint that something happened.
>>
>> We could also just put these at the DBG level so that they are hidden by
>> default...
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> Brad
