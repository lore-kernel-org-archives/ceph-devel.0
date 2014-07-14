From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: consequences of XFS_IOC_FSSETXATTR on non-empty file?
Date: Mon, 14 Jul 2014 11:24:05 +0400
Message-ID: <CALFYKtBVLLTjXnxS3qc7sCYbc+MfFFrGsbM1D_8jK4oiUd267w@mail.gmail.com>
References: <CA+4uBUYg+81G2=sj3qXO4GGgA7pyjgVrGDCN+UQ32jnWgSbG5w@mail.gmail.com>
	<20140713012624.GS4453@dastard>
	<CA+4uBUZwuh5t28jU5jfQb3ApdUKx8t88hg6m8CXS+0ztpi6OTw@mail.gmail.com>
	<CALFYKtC7J1ZvW40wsSWmVpNS5T3tmAOmY9CP=nsh4r=iUjeznA@mail.gmail.com>
	<20140713225532.GD22339@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:57092 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbaGNHYG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jul 2014 03:24:06 -0400
Received: by mail-qc0-f175.google.com with SMTP id i8so3128933qcq.6
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jul 2014 00:24:05 -0700 (PDT)
In-Reply-To: <20140713225532.GD22339@dastard>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Samuel Just <sam.just@inktank.com>, xfs@oss.sgi.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Mon, Jul 14, 2014 at 2:55 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Sun, Jul 13, 2014 at 09:01:13PM +0400, Ilya Dryomov wrote:
>> On Sun, Jul 13, 2014 at 5:48 AM, Samuel Just <sam.just@inktank.com> wrote:
>> > Actually, on this ubuntu kernel (3.13.0-24-generic), it doesn't seem
>> > to give an error.  I'll attach my test case for that.  We don't yet
>> > have a way of reproducing the corruption -- the ext_size change in the
>> > osd simply seemed like a promising lead.
>> > -Sam
>> >
>> > On Sat, Jul 12, 2014 at 6:26 PM, Dave Chinner <david@fromorbit.com> wrote:
>> >> On Sat, Jul 12, 2014 at 06:16:54PM -0700, Samuel Just wrote:
>> >>> Hi,
>> >>>
>> >>> We are seeing reports of ceph-osd stores on xfs of files with some
>> >>> garbage data (possibly misplaced from data elsewhere in the
>> >>> filesystem).  There was a bug for a while where the ceph-osd process
>> >>> would set a value for fsx_extsize on a non-empty (possibly sparse)
>> >>> file using XFS_IOC_FSSETXATTR.  Could that plausibly result in a file
>> >>> with garbage data?
>> >>
>> >> No, setting an extent size on a non-empty file will simply fail
>> >> with EINVAL.
>>
>> AFAIR it checks whether or not any extents are actually allocated, not
>> whether the file is empty or not.
>
> FWIW, that's an implementation detail, not the definition of the
> intended behaviour of the ioctl.  Indeed, the man page says:
>
> "The fsx_xflags realtime file bit and the file's extent size may be
> changed only when the file is empty, ..."
>
> For most people, "[non-]empty file" is much more easily understood
> than "a file without real extents, but might have been written to
> and so have dirty, in-memory delayed allocation data whose
> asynchronous flushing may or may not affect the behaviour of a call
> to XFS_IOC_FSSETXATTR".
>
> i.e. the intended application behaviour is that they should only be
> able to change the extent size hint *before* any data is written to
> the file.
>
>> I think if you call fsync() or even
>> fdatasync() before close(fd), it will fail as expected.
>
> Only if you are trying to change the extent size immediately after
> the first write you do to an empty file. Which is, as per the above,
> not the recommended or intended use of the ioctl.

That's understood, but that is exactly what Sam's test program happens
to try to do, so I had to point the "file w/o real extents" thing out.

Thanks,

                Ilya
