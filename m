From: Samuel Just <sjust@redhat.com>
Subject: Re: rados and the next hammer release v0.94.3
Date: Tue, 4 Aug 2015 09:40:27 -0700
Message-ID: <CAN=+7FUUt6y4TjaY9L3ruw9At_pTWLwvJ-r8ANjg6M9w=3W6cA@mail.gmail.com>
References: <55BF8BD7.7020003@redhat.com>
	<55C092AA.9050402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34700 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbHDQk2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:40:28 -0400
Received: by ioea135 with SMTP id a135so22707328ioe.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 09:40:27 -0700 (PDT)
In-Reply-To: <55C092AA.9050402@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Looks good!
-Sam

On Tue, Aug 4, 2015 at 3:23 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> The backport for http://tracker.ceph.com/issues/12465 has been merged=
 (https://github.com/ceph/ceph/pull/5405). Since http://tracker.ceph.co=
m/issues/12410 and http://tracker.ceph.com/issues/12536 are not ready, =
they will wait for v0.94.4.
>
> The next hammer release as found at https://github.com/ceph/ceph/tree=
/hammer passed the rados suite. Do you think it is ready for QE to star=
t their own round of testing ?
>
> Cheers
>
> On 03/08/2015 17:42, Loic Dachary wrote:> Hi Sam,
>>
>> We need http://tracker.ceph.com/issues/12465 in hammer v0.94.3. Is t=
here anything else we want before publishing this release ? Should we w=
ait for http://tracker.ceph.com/issues/12410 maybe ? And http://tracker=
=2Eceph.com/issues/12536 ?
>>
>> The next hammer release as found at https://github.com/ceph/ceph/tre=
e/hammer passed the rados suite. Provided it also contains the fixes fo=
r the above three issues, do you think it is ready for QE to start thei=
r own round of testing ?
>>
>> Cheers
>>
>> P.S. http://tracker.ceph.com/issues/11990#Release-information has di=
rect links to the pull requests merged into hammer since v0.94.2 in cas=
e you need more context about one of them.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
