From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 09/10] fs: ceph: Replace CURRENT_TIME by ktime_get_real_ts()
Date: Thu, 4 Feb 2016 10:01:31 +0100
Message-ID: <CAOi1vP8EpxFdi_6Twad7wzCQnBLks0d6mbsrX=AVp64_AxR=OQ@mail.gmail.com>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
	<3267742.ulDeDOimis@wuerfel>
	<A70D88EB-6B14-4553-9C9D-88D54F7BA689@redhat.com>
	<4400939.hfiB5KsmnG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4400939.hfiB5KsmnG@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Yan, Zheng" <zyan@redhat.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Zheng Yan <ukernel@gmail.com>, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, linux-kernel <linux-kernel@vger.kernel.org>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Feb 4, 2016 at 9:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 February 2016 10:00:19 Yan, Zheng wrote:
>> > On Feb 4, 2016, at 05:27, Arnd Bergmann <arnd@arndb.de> wrote:
>> {
>>           struct ceph_timespec ts;
>>           ceph_encode_timespec(&ts, &req->r_stamp);
>>           ceph_encode_copy(&p, &ts, sizeof(ts));
>> }
>
> Ok, that does make the behavior consistent on all architectures, but
> leads to a different question:
>
> struct ceph_timespec {
>         __le32 tv_sec;
>         __le32 tv_nsec;
> } __attribute__ ((packed));
>
> How do you define ceph_timespec, is tv_sec supposed to be signed or unsigned?
>
> It seems that you treat it as signed, meaning you interpret times
> from the server as being in the [1902..2038] range, rather than the
> [1970..2106] range:
>
> static inline void ceph_decode_timespec(struct timespec *ts,
>                                         const struct ceph_timespec *tv)
> {
>         ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
>         ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
> }
>
> Is that intentional and documented? If yes, what is your plan to deal
> with y2038 support?

tv_sec is used as a time_t, so signed.  The problem is that ceph_timespec is
not only passed over the wire, but is also stored on disk, part of quite a few
other data structures.  The plan is to eventually switch to a 64-bit tv_sec and
tv_nsec, bump the version on all the structures that contain it and add
a cluster-wide feature bit to deal with older clients.  We've recently had
a discussion about this, so it may even happen in a not so distant future, but
no promises ;)

Thanks,

                Ilya
