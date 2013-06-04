From: Samuel Just <sam.just@inktank.com>
Subject: Re: PGLog::merge_log clarification
Date: Tue, 4 Jun 2013 14:22:41 -0700
Message-ID: <CA+4uBUZdALGvWzWvrH5H2YJk67st9RchxXOndRfMOCTCHOv2TQ@mail.gmail.com>
References: <51AE4B84.7060609@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:64093 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3FDVWn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 17:22:43 -0400
Received: by mail-ea0-f178.google.com with SMTP id q15so602464ead.23
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jun 2013 14:22:41 -0700 (PDT)
In-Reply-To: <51AE4B84.7060609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Within a single log, the version must be always increasing.  The
reason for the epoch is that you might have two logs:

   a       b
(1, 1) (1, 1)
(1, 2) (1, 2)
(1, 3)
        (2, 3)
        (2, 4)

If a dies after persisting (1, 3) but before sending it to b, b might
become primary and go on accepting writes (2, 3) and (2, 4).  Later, a
comes back and we determine that (1, 3) is divergent using the epoch
numbers.
-Sam

On Tue, Jun 4, 2013 at 1:18 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> When calling merge_log on the following : http://pastealacon.com/3244=
9 ( where the first column are the versions of the log entries and the =
second column are the versions of the olog entries ) I expect 5,2 and 6=
,1 from log to be added to divergent
> https://github.com/ceph/ceph/blob/master/src/osd/PGLog.cc#L493
> however, because the 1 from 6,1 compares lower than the 2 of 3,2 ( lo=
wer_bound ), the loop stops
> https://github.com/ceph/ceph/blob/master/src/osd/PGLog.cc#L490
> and divergent is empty.
>
> I am missing something and a hint would be much appreciated :-)
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
