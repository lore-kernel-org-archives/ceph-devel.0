From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH] include: ceph: Fix encode and decode type conversions
Date: Fri, 19 Feb 2016 17:30:37 +0100
Message-ID: <2888792.FMmWd8y8pW@wuerfel>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com> <3047619.1giXQfFTZa@wuerfel> <CAOi1vP8fnBXw3pOspN7KeAVUk3wEEbMLhdbW2qQ4xryrGpoyTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:56678 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947010AbcBSQap (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Feb 2016 11:30:45 -0500
In-Reply-To: <CAOi1vP8fnBXw3pOspN7KeAVUk3wEEbMLhdbW2qQ4xryrGpoyTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: y2038@lists.linaro.org
Cc: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Sage Weil <sage@redhat.com>

On Friday 19 February 2016 12:42:02 Ilya Dryomov wrote:
> On Fri, Feb 19, 2016 at 11:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 18 February 2016 18:22:55 Ilya Dryomov wrote:
> >> On Thu, Feb 18, 2016 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Thursday 18 February 2016 17:02:25 Ilya Dryomov wrote:
> >> >>
> >> >> If we are going to touch this function at all, let's drop all casts and
> >> >> just add a comment along the lines of "the lack of cast/sign-extension
> >> >> here is intentional, this function has a counterpart on the server side
> >> >> which also lacks cast/sign-extension, etc".  To someone who is not up
> >> >> on these subtleties, the __u64 cast is going to be more confusing than
> >> >> explicit...
> >> >
> >> > We certainly a comment, I was just suggesting to add the cast as well.
> >> >
> >> > Again, it's not the lack of the cast on the server that is important
> >> > here, it's whether it gets interpreted as signed or unsigned at the
> >> > point where the timestamp is actually used for comparison or
> >> > printing. Let me suggest a comment here:
> >>
> >> I'd argue it's important to have encode/decode code look the same.
> >>
> >> I mentioned before that at least in some places it's interpreted as
> >> signed and that the interpretation is not totally up to the client.
> >> The printing (at least some of it) is right there in the same file
> >> (src/include/utime.h) and you can see ... + 1900.
> >
> > I see this code:
> >
> > class utime_t {
> >   struct {
> >     __u32 tv_sec, tv_nsec;
> >   } tv;
> >
> >   time_t        sec()  const { return tv.tv_sec; }
> >
> >   ostream& gmtime(ostream& out) const {
> >     out.setf(std::ios::right);
> >     char oldfill = out.fill();
> >     out.fill('0');
> >     if (sec() < ((time_t)(60*60*24*365*10))) {
> >       // raw seconds.  this looks like a relative time.
> >       out << (long)sec() << "." << std::setw(6) << usec();
> >     } else {
> >       // localtime.  this looks like an absolute time.
> >       //  aim for http://en.wikipedia.org/wiki/ISO_8601
> >       struct tm bdt;
> >       time_t tt = sec();
> >       gmtime_r(&tt, &bdt);
> >       out << std::setw(4) << (bdt.tm_year+1900)  // 2007 -> '07'
> >           << '-' << std::setw(2) << (bdt.tm_mon+1)
> >           << '-' << std::setw(2) << bdt.tm_mday
> >           << ' '
> >           << std::setw(2) << bdt.tm_hour
> >           << ':' << std::setw(2) << bdt.tm_min
> >           << ':' << std::setw(2) << bdt.tm_sec;
> >       out << "." << std::setw(6) << usec();
> >       out << "Z";
> >     }
> >     out.fill(oldfill);
> >     out.unsetf(std::ios::right);
> >     return out;
> >   }
> >
> > which interprets the time roughly in the way I explained:
> >
> > * On 64-bit architectures, the time is interpreted as an unsigned
> >   number in the range from 1980-2106, while any times between 1970
> >   and 1980 are interpreted as a relative time and printed as
> >   a positive seconds number.
> >
> > * On 32-bit architectures, times in the range 1980-2038 are printed
> >   as a date like 64-bit does, times from 1970-1980 are also printed
> >   as a positive seconds number, and anything with the top bit set
> >   is printed as a negative seconds number.
> >
> > It this the intended behavior? I guess we could change the kernel
> > to reject any timestamps before 1980 and after 2038 in
> > ceph_decode_timespec and just set the Linux timestamp to (time_t)0
> > (Jan 1 1970) in that case, and document that there is no valid
> > interpretation for those.
> 
> At least conceptually, this isn't a bad idea, as only 1970(1980)..2038
> works on both architectures; everything else is likely to break
> something in ceph either on 32-bit or on both, I think.  But, I'm not
> sure if rejecting by setting to 0 is going to work all around and we
> can't change just the kernel client.

Setting to 0 is a bit fishy, but I couldn't think of anything better
either. Right now, we just overflow 32-bit timestamps all the time
and get unpredictable results. I think we will end up implementing
some form of truncation, so times earlier than the start of the 
file system specific epoch (1902, 1970, 1980, ... depending on the
implementation) get set to the earliest supported time, while
times after the last supported timestamp (2037, 2038, 2106, ...)
get set to the maximum.

The problem here is that we don't even know whether an underflow
or an overflow happened.

> I want the kernel client to be bug compatible with servers and other
> clients in ceph.git.
> 
> >
> > a) Remain consistent with current 64-bit servers and clients,
> >    interpreting the number as an unsigned 32-bit integer where
> >    possible, and remain broken on existing 32-bit machines
> >    until they start using 64-bit time_t.
> >
> > b) Change 64-bit clients to behave the same way that that 32-bit
> >    clients and servers do today, and actually use the times as
> >    a signed number that you claimed they already did.
> >
> > c) Interpret all times before 1980 or after 2038 as buggy servers
> >    and only accept times that are always handled consistently.
> >    Also fix the server to reject those times coming from broken
> >    clients.
> >
> > d) Leave 64-bit clients unchanged (using unsigned timestamps) and
> >    document that 32-bit clients should keep interpreting them as
> >    signed even when we fix VFS, to preserve the existing behavior.
> >
> > I think a), b) and c) are all reasonable, and I can send a patch
> > as soon as you know what you want. If you want d), please leave
> > me out of that and do it yourself.
> 
> My preference would be a), possibly with some comments along the lines
> of c), to make the ..2038 range more explicit, as I doubt we've ever
> assumed ..2106 on 64-bit.  This is all really old code and goes back to
> the dawn of ceph and beyond the kernel client, so let's wait for Sage
> to chime in.

Ok, thanks!

I think the same problem appeared in a lot of places when code was
originally written with the assumption that time_t is 32-bit,
and then it kept working in practice when ported to 64-bit systems
for the first time but the underlying assumptions changed.

/*
 * ceph timestamp handling is traditionally inconsistent between
 * 32-bit clients and servers using them as a signed 32-bit time_t
 * ranging from 1902 to 2038, and 64-bit clients and servers
 * interpreting the same numbers as unsigned 32-bit integers
 * with negative numbers turning into dates between 2038 and 2106.
 *
 * Most clients and servers these days are 64-bit, so let's pretend
 * that interpreting the times as "__u32" is intended, and use
 * that on 32-bit systems as well once using a 64-bit time_t.
 */

	Arnd
