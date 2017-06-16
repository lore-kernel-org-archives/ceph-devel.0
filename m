From: John Spray <jspray@redhat.com>
Subject: Re: Cluster log: hiding cluster map prints, decreasing audit log messages
Date: Thu, 15 Jun 2017 20:30:42 -0400
Message-ID: <CALe9h7cwaZ8F16YakRFwG=h-YJrASd70XsTDTFKm+3ANJW0U6A@mail.gmail.com>
References: <CALe9h7cVUB-H8aeXGRFPFOeTe+nFyMZ=Obmqr4P527gmR7268A@mail.gmail.com>
 <alpine.DEB.2.11.1706151924590.32272@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33183 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdFPAbE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 20:31:04 -0400
Received: by mail-wr0-f174.google.com with SMTP id r103so30389207wrb.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 17:31:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706151924590.32272@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 15, 2017 at 3:27 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 15 Jun 2017, John Spray wrote:
>> Some musings from me about the cluster log, interested in others' thoughts.
>>
>> Audit log
>> =======
>>
>> The audit logging is nice, but it has a couple of noticeable annoyances:
>>  - it crowds out real health messages, e.g. when using the new "log
>> last" command you may see mostly see audit log messages, especially if
>> a monitoring tool is polling some commands.
>>  - the messages themselves are ugly JSON dumps
>>
>> We already have a separate channel for these, so it's easy for UIs to
>> split out the audit stuff (I just did this in the dashboad module),
>> but I think they're still consuming some number of the lines when we
>> fetch a set number of lines using "log last".
>>
>> Maybe things like log last (and the internal buffering in the mon)
>> should keep N lines for each channel, rather than channels competing
>> for the space?  It might already be like that on some level, haven't
>> dug into the mon internals yet.
>
> - last N for each channel makes sense to me.  The way LogMonitor
> implements this needs a bit of cleanup at the same time.
> - I think it makes sense to only show the 'default' channel by default and
> ignore all others (including audit log) unless asked for?  I guess this
> would add a channel option to 'last' that takes either the channel name
> (audit or default) or '*' or 'all' for all.

Yep.  The mildly annoying part would be having to do the time-sorted
interleave of the messages from various channels, but we can do it
simply all at once as long as the max possible number of lines we're
dealing with is reasonably small.

>> Cluster maps
>> ===========
>>
>> It is very nice for debugging that we can see updates to osdmap/fsmap
>> ticking by as the mon updates the state of the system.  However, it
>> kind of disrupts our ability to output clearly readable log messages
>> for ordinary users when things changed.
>>
>> Maybe the cluster maps should be on a separate channel, like the audit logs are?
>>
>> Of course, when we're hiding the low level cluster map prints away, we
>> need to at the same time make sure we're adding in the right high
>> level "OSD 123 went down" messages to replace where the "osdmap e456
>> ..." lines currently give you the hint that something happened.
>
> We could also just put these at the DBG level so that they are hidden by
> default...

True, but then they would still be competing with the higher level
messages for the buffer space in the normal channel, unless we also
changed things to have separate buffers for different prios (not
necessarily a crazy idea but makes all reads/follows more complex)

John

(P.S. apologies if anyone is getting this twice, the first send
bounced because I was on my phone and it send HTML)

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
