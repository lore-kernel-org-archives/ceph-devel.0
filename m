From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [PATCH 09/10] fs: ceph: Replace CURRENT_TIME by ktime_get_real_ts()
Date: Thu, 4 Feb 2016 07:26:51 -0800
Message-ID: <CAJ4mKGa0NDGNOPTg_MyE_B7BpPQLQ7JfiiBFuZ5t-t57VNihRQ@mail.gmail.com>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
	<4400939.hfiB5KsmnG@wuerfel>
	<CAOi1vP8EpxFdi_6Twad7wzCQnBLks0d6mbsrX=AVp64_AxR=OQ@mail.gmail.com>
	<3114558.FPEUoEgqxL@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <3114558.FPEUoEgqxL@wuerfel>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Elder <elder@linaro.org>, "Yan, Zheng" <zyan@redhat.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Zheng Yan <ukernel@gmail.com>, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, linux-kernel <linux-kernel@vger.kernel.org>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Feb 4, 2016 at 5:31 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 February 2016 10:01:31 Ilya Dryomov wrote:
>> On Thu, Feb 4, 2016 at 9:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 04 February 2016 10:00:19 Yan, Zheng wrote:
>> >> > On Feb 4, 2016, at 05:27, Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > static inline void ceph_decode_timespec(struct timespec *ts,
>> >                                         const struct ceph_timespec *tv)
>> > {
>> >         ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
>> >         ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
>> > }
>> >
>> > Is that intentional and documented? If yes, what is your plan to deal
>> > with y2038 support?
>>
>> tv_sec is used as a time_t, so signed.  The problem is that ceph_timespec is
>> not only passed over the wire, but is also stored on disk, part of quite a few
>> other data structures.
>
> That is only part of the issue though:
>
> Most file systems that store a timespec on disk define the function
> differently:
>
> static inline void ceph_decode_timespec(struct timespec *ts,
>                                         const struct ceph_timespec *tv)
> {
>         ts->tv_sec = (time_t)(u32)le32_to_cpu(tv->tv_sec);
>         ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
> }
>
> On systems that have a 64-bit time_t, the 1902..1970 interval
> (0xffffffff80000000..0xffffffffffffffff) and the 2038..2106
> interval (0x0000000080000000..0x00000000ffffffff) are written
> as the same 32-bit numbers, so when reading back you have to
> decide which interpretation you want, and your cast to
> __kernel_time_t means that you get the first representation on
> both 32-bit and 64-bit systems.
>
> On systems with a 32-bit time_t, this is the only option you
> have anyway, and some other file systems (ext2/3/4, xfs, ...)
> made the same decision in order to behave in a consistent way
> independent of what kernel (32-bit or 64-bit) you use. This
> is generally a reasonable goal, but it means that you get the
> overflow in 2038 rather than 2106.
>
> Alex Elder changed the cephs behavior in 2013 to be the same
> way, but from the changelog c3f56102f28d ("libceph: validate
> timespec conversions"), I guess this was not intentional, as
> he was also adding a comparison against U32_MAX, which should
> have been S32_MAX.
>
> A lot of other file systems (jfs, jffs2, hpfs, minix) apparently
> prefer the 1970..2106 interpretation of time values.
>
>> The plan is to eventually switch to a 64-bit tv_sec and
>> tv_nsec, bump the version on all the structures that contain it and add
>> a cluster-wide feature bit to deal with older clients.  We've recently had
>> a discussion about this, so it may even happen in a not so distant future, but
>> no promises
>
> Ok. We have a (rough) plan to deal with file systems that don't support
> extended time stamps in the meantime, so depending on user preferences
> we would either allow them to be used as before with times clamped
> to the 2038 overflow date, or only mounted readonly for users that want
> to ensure their systems can survive without regressions in 2038.

I dug up the email conversation, about it, although I think Adam has
done more work than it indicates:
http://www.spinics.net/lists/ceph-devel/msg27900.html. I can't speak
to any kernel-specific issues but this kind of transition while
maintaining wire compatibility with older code is something we've done
a lot; it shouldn't be a big deal even in the kernel where we're
slightly less prolific with such things. :)
-Greg
