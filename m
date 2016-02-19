From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] include: ceph: Fix encode and decode type conversions
Date: Fri, 19 Feb 2016 12:42:02 +0100
Message-ID: <CAOi1vP8fnBXw3pOspN7KeAVUk3wEEbMLhdbW2qQ4xryrGpoyTg@mail.gmail.com>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
	<12201396.FPdHi0skie@wuerfel>
	<CAOi1vP9n2UiYPj+EC6FsofG5kdCwpNv1CVK=AuKuOSUXqmMRcg@mail.gmail.com>
	<3047619.1giXQfFTZa@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36507 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427688AbcBSLmD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Feb 2016 06:42:03 -0500
Received: by mail-wm0-f48.google.com with SMTP id g62so71959797wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 19 Feb 2016 03:42:02 -0800 (PST)
In-Reply-To: <3047619.1giXQfFTZa@wuerfel>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>

On Fri, Feb 19, 2016 at 11:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 February 2016 18:22:55 Ilya Dryomov wrote:
>> On Thu, Feb 18, 2016 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 18 February 2016 17:02:25 Ilya Dryomov wrote:
>> >>
>> >> If we are going to touch this function at all, let's drop all casts and
>> >> just add a comment along the lines of "the lack of cast/sign-extension
>> >> here is intentional, this function has a counterpart on the server side
>> >> which also lacks cast/sign-extension, etc".  To someone who is not up
>> >> on these subtleties, the __u64 cast is going to be more confusing than
>> >> explicit...
>> >
>> > We certainly a comment, I was just suggesting to add the cast as well.
>> >
>> > Again, it's not the lack of the cast on the server that is important
>> > here, it's whether it gets interpreted as signed or unsigned at the
>> > point where the timestamp is actually used for comparison or
>> > printing. Let me suggest a comment here:
>>
>> I'd argue it's important to have encode/decode code look the same.
>>
>> I mentioned before that at least in some places it's interpreted as
>> signed and that the interpretation is not totally up to the client.
>> The printing (at least some of it) is right there in the same file
>> (src/include/utime.h) and you can see ... + 1900.
>
> I see this code:
>
> class utime_t {
>   struct {
>     __u32 tv_sec, tv_nsec;
>   } tv;
>
>   time_t        sec()  const { return tv.tv_sec; }
>
>   ostream& gmtime(ostream& out) const {
>     out.setf(std::ios::right);
>     char oldfill = out.fill();
>     out.fill('0');
>     if (sec() < ((time_t)(60*60*24*365*10))) {
>       // raw seconds.  this looks like a relative time.
>       out << (long)sec() << "." << std::setw(6) << usec();
>     } else {
>       // localtime.  this looks like an absolute time.
>       //  aim for http://en.wikipedia.org/wiki/ISO_8601
>       struct tm bdt;
>       time_t tt = sec();
>       gmtime_r(&tt, &bdt);
>       out << std::setw(4) << (bdt.tm_year+1900)  // 2007 -> '07'
>           << '-' << std::setw(2) << (bdt.tm_mon+1)
>           << '-' << std::setw(2) << bdt.tm_mday
>           << ' '
>           << std::setw(2) << bdt.tm_hour
>           << ':' << std::setw(2) << bdt.tm_min
>           << ':' << std::setw(2) << bdt.tm_sec;
>       out << "." << std::setw(6) << usec();
>       out << "Z";
>     }
>     out.fill(oldfill);
>     out.unsetf(std::ios::right);
>     return out;
>   }
>
> which interprets the time roughly in the way I explained:
>
> * On 64-bit architectures, the time is interpreted as an unsigned
>   number in the range from 1980-2106, while any times between 1970
>   and 1980 are interpreted as a relative time and printed as
>   a positive seconds number.
>
> * On 32-bit architectures, times in the range 1980-2038 are printed
>   as a date like 64-bit does, times from 1970-1980 are also printed
>   as a positive seconds number, and anything with the top bit set
>   is printed as a negative seconds number.
>
> It this the intended behavior? I guess we could change the kernel
> to reject any timestamps before 1980 and after 2038 in
> ceph_decode_timespec and just set the Linux timestamp to (time_t)0
> (Jan 1 1970) in that case, and document that there is no valid
> interpretation for those.

At least conceptually, this isn't a bad idea, as only 1970(1980)..2038
works on both architectures; everything else is likely to break
something in ceph either on 32-bit or on both, I think.  But, I'm not
sure if rejecting by setting to 0 is going to work all around and we
can't change just the kernel client.

>
>> >  * ceph timestamps are unsigned 32-bit starting at 1970, which is
>> >  * different from a signed 32-bit or 64-bit time_t. On 64-bit
>> >  * architectures, this gets interpreted as a subset of time_t
>> >  * in the range from 1970 to 2106.
>> >  * Machines with a 32-bit time_t will incorrectly interpret the
>> >  * timestamps with years 2038-2106 as negative numbers in the
>> >  * 1902-1969 range, until both kernel and glibc are change to
>> >  * using 64-bit time_t.
>> >  */
>>
>> I think a more accurate description would be "ceph timestamps are
>> signed 32-bit, with the caveat that something somewhere is likely to
>> break on a negative timestamp".
>
> This is the opposite of what you said previously, citing:
>
> | There aren't any casts on the server side: __u32 is simply assigned to
> | time_t, meaning no sign-extension is happening
>
> which I read as meaning you are using it as an unsigned number,
> because of the way the assignment operator works when you assign
> an unsigned 32-bit number to a signed 64-bit number.

All I was trying to convey throughout this thread is: we can't change
just the kernel client.  We can't add sign-extending casts without
either adding the same casts in ceph.git (which is both servers and
other clients) or explaining why it is OK to change just the kernel
client in the commit message.

>
>> We are not looking at trying to reuse that extra bit for 1970..2106.
>> As I said earlier, utime_t is used in quite a lot of places throughout
>> the code base and is part of both in-core and on-disk data structures.
>> Auditing all those sites for that is probably never going to happen.
>> I think the plan is to live with what we've got until a proper 64-bit
>> sec/nsec conversion is done in a way that was described earlier
>> (message versions, ceph feature bit, etc).  Any vfs timespec-handling
>> changes should simply preserve the existing behavior, for now.
>
> And that is a third option: preserve the existing behavior (different
> between 32-bit and 64-bit) even when we extend the 32-bit client to
> have 64-bit timestamps. I can't believe that is what you actually meant
> here but if you did, that would probably be the worst solution.
>
> Please just make up your mind and say which behavior you want the
> kernel client to have when dealing with servers that communicate
> using 32-bit timestamps:

I want the kernel client to be bug compatible with servers and other
clients in ceph.git.

>
> a) Remain consistent with current 64-bit servers and clients,
>    interpreting the number as an unsigned 32-bit integer where
>    possible, and remain broken on existing 32-bit machines
>    until they start using 64-bit time_t.
>
> b) Change 64-bit clients to behave the same way that that 32-bit
>    clients and servers do today, and actually use the times as
>    a signed number that you claimed they already did.
>
> c) Interpret all times before 1980 or after 2038 as buggy servers
>    and only accept times that are always handled consistently.
>    Also fix the server to reject those times coming from broken
>    clients.
>
> d) Leave 64-bit clients unchanged (using unsigned timestamps) and
>    document that 32-bit clients should keep interpreting them as
>    signed even when we fix VFS, to preserve the existing behavior.
>
> I think a), b) and c) are all reasonable, and I can send a patch
> as soon as you know what you want. If you want d), please leave
> me out of that and do it yourself.

My preference would be a), possibly with some comments along the lines
of c), to make the ..2038 range more explicit, as I doubt we've ever
assumed ..2106 on 64-bit.  This is all really old code and goes back to
the dawn of ceph and beyond the kernel client, so let's wait for Sage
to chime in.

Thanks,

                Ilya
