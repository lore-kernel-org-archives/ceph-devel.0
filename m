From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Berserker toolkit for (semi-)automated fs fuzz testing
Date: Sat, 5 May 2012 13:36:03 -0700
Message-ID: <CA+qbEUP_bcSohhixqUGH+44gFeEBSaeJTAzRbkcym+AxjNvRgQ@mail.gmail.com>
References: <CA+qbEUN3DZzCCJm=mLT+QczXs0nN2xE_86RJPcwCLYEKMVtcSQ@mail.gmail.com>
	<CAORUGqBbL6WSt83jqoTJ5kXhbQc_SErYJUK=+yZ6nB2Mg=b=SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48532 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab2EEUgF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 May 2012 16:36:05 -0400
Received: by werb10 with SMTP id b10so557626wer.19
        for <ceph-devel@vger.kernel.org>; Sat, 05 May 2012 13:36:04 -0700 (PDT)
In-Reply-To: <CAORUGqBbL6WSt83jqoTJ5kXhbQc_SErYJUK=+yZ6nB2Mg=b=SQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 30, 2012 at 10:13 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Sat, Apr 28, 2012 at 17:29, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
>> This could be useful for testing the in-kernel Ceph client:
>>
>> http://www.spinics.net/lists/linux-ext4/msg31856.html
>
> Well, that post is all about non-networked file systems.
>
> zzuf has a network mode (-n) where it hijacks the socket calls and ca=
n
> randomly mutate the bytes transferred. However, I feel like most of
> the benefits of that wrapper are lost, as the Ceph network behavior
> just isn't very cleanly deterministic.. even if we included the
> cluster serving the client inside the System Under Test for the
> fuzzing, I feel like the crashes wouldn't be very reproducible, so
> fancy features of that wrapper, like the the git bisect integration,
> will not be useful.
>
> What we might want to do is run zzuf to mess with the osds etc while
> exercising the usual QA suite, similar to thrashing. Not
> deterministically reproducible, but would probably expose some bugs
> now and then.

Even ext{2,3,4} and btrfs use threads.  That means that the behavior
under test is never going to be deterministic.  The real question is
how many bugs would be exposed, and whether those bugs would be
fixable with the information provided.  Performance testing is the
area where nondeterminism really starts to hurt the most.

Colin

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
