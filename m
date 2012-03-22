From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Logging braindump
Date: Thu, 22 Mar 2012 15:32:11 -0700
Message-ID: <CA+qbEUPGMAM9CskZ5dKTatB8KoU83Hom3Te3=LnjvE1kgOG32A@mail.gmail.com>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
	<CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com>
	<4F6B6CB0.1000400@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62900 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab2CVWcM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 18:32:12 -0400
Received: by wgbdr13 with SMTP id dr13so1714021wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 15:32:11 -0700 (PDT)
In-Reply-To: <4F6B6CB0.1000400@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <Mark.Kampe@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 22, 2012 at 11:17 AM, Mark Kampe <Mark.Kampe@dreamhost.com>=
 wrote:
> On 03/22/12 09:38, Colin McCabe wrote:
>> An mmap'ed buffer, even a lockless one, is a simple beast. =A0Do you
>> really need a whole library just for that? =A0Maybe I'm just
>> old-fashioned.
>
>
> IMHO, surprisingly few things involving large numbers of performance
> critical threads turn out to be simple :-) =A0For example:
>
> =A0 =A0 =A0 =A0If we are logging a lot, buffer management has the pot=
ential
> =A0 =A0 =A0 =A0to become a bottle-neck ... so we need to be able to a=
llocate
> =A0 =A0 =A0 =A0a record of the required size from the circular buffer
> =A0 =A0 =A0 =A0with atomic instructions (at least in non-wrap situati=
ons).
>
> =A0 =A0 =A0 =A0But if records are allocated and then filled, we have =
to
> =A0 =A0 =A0 =A0consider how to handle the case where the filling is
> =A0 =A0 =A0 =A0delayed, and the reader catches up with an incomplete
> =A0 =A0 =A0 =A0log record (e.g. skip it, wait how long, ???).

The easiest solution is to store pointers in the circular buffer
rather than directly writing to it.   Another solution would be epoch
numbers that increment each time the log buffer wraps around.

C.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
