From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: max useful journal size
Date: Fri, 18 Jan 2013 23:16:58 -0500
Message-ID: <CACkq2mrKccAP+w2OUwTtDBU0GKrFFV=7aXKwbewmZaooEWRS4Q@mail.gmail.com>
References: <CACkq2mokPwwgue_OjsZngzGLLt5XODZiJdD5YwCDJ1um5TQ9eA@mail.gmail.com>
 <CAPYLRzjkw92FU-q7tDWJSCuOjOE5OBaYZfPE0NT67cK532Gdwg@mail.gmail.com>
 <CACkq2mpwzsAtTRh7Cg0-c3GXTf8-V3OnrO6ojxE5gDnks9MMDQ@mail.gmail.com> <alpine.DEB.2.00.1301181454460.8622@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:34884 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab3ASERT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 23:17:19 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so1699469eab.34
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 20:17:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301181454460.8622@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for the clarifcation, Sage. That makes sense. Especially when I
think about it in the sense that if I have an SSD capable of
400MB/sec, and the journal doesn't flush for 5 seconds, there is 2GB
of data sync. The disk only does 100-150MB/sec, so this could take up
to twenty seconds to write out. And all the while more data is coming
in. Now I see the purpose of having the bigger journal.

Of course it only goes so far, and when its full, its full. I get that too.

I submitted a pull request to change the docs to specify filestore max
sync instead of min.

On Fri, Jan 18, 2013 at 5:56 PM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 18 Jan 2013, Travis Rhoden wrote:
>> On Fri, Jan 18, 2013 at 5:43 PM, Gregory Farnum <greg@inktank.com> wrote:
>> > On Fri, Jan 18, 2013 at 2:20 PM, Travis Rhoden <trhoden@gmail.com> wrote:
>> >> Hey folks,
>> >>
>> >> The Ceph docs give the following recommendation on sizing your journal:
>> >>
>> >> osd journal size = {2 * (expected throughput * filestore min sync interval)}
>> >>
>> >> The default value of min sync interval is .01.  If you use throughput
>> >> of a mediocre 7200RPM drive of 100MB/sec, this comes to 2 MB.  That
>> >> seems like the lower bound to have the journal do anything at all.
>> >
>> > Ah. This should refer to the max sync interval, not the min!
>>
>> I wondered about that.  But wasn't confident enough to ask about it.
>> >
>> >> My question is what is the upper bound?  There's clearly a limit to
>> >> how big make, such that it just becomes wasted space.  The reason I
>> >> want to know is that since I will be journals on SSDs, with each
>> >> journal being a dedicated partition, there is a benefit to not making
>> >> the partition bigger than it needs to be.  All that unpartitioned
>> >> space can be used by the SSD firmware for wear-leveling and other
>> >> things (so long as it remains unpartitioned).
>> >>
>> >> Would the following calc be appopriate?
>> >>
>> >> Assume an SSD write speed of 400MB/sec.  Default max sync interval is 5.
>> >>
>> >> 2 * (400 MB/sec * 5sec) = 4 GB.
>> >>
>> >> So is it appropriate to assume that if I can't write to an SSD faster
>> >> than 400 MB/sec, and I keep the default sync interval values, a
>> >> journal greater than 4GB is just a waste?
>> >>
>> >> I had been using 10GB journals...  seems like overkill.
>> >>
>> >> Or put another way, if I want to use 10GB journals, I should bump the
>> >> max sync interval to 12.5.
>> >
>> > It can of course grow as large as you let it, and I would leave some
>> > extra room as a margin. The main consideration is that the journal
>> > doesn't like getting too far ahead of the filestore, and that's what
>> > the above calculation uses to set size.
>>
>> Is "max sync interval" a hard stop, though?  I mean, once 5 seconds
>> pass, it's going to flush/sync no matter what, right? So there is no
>> point in making it much bigger than what can be written to the journal
>> in those 5 seconds.  I feel like I must be missing something, though,
>> otherwise the recommendation wouldn't to make the journal 2x that
>> size.
>
> The sync itself can take time, and we *initiate* the sync at that time.
> Hence the 2x.  When the journal fills up there is a hefty performance
> hit, too.  When you adjust this down, check back at some ponit and make
> sure you don't see JOURNAL FULL messages in your log that point to a
> problem (with the code or the tuning logic).
>
> Thanks!
> sage
>
>
