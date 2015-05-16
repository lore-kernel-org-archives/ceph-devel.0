From: Michal Jarzabek <stiopa@gmail.com>
Subject: Re: Problem running make check
Date: Sat, 16 May 2015 09:55:47 +0100
Message-ID: <CAEFDAA5b7DDzycDT0BY98en9wUiKjOVW1nJYL6drpuumkBJWGg@mail.gmail.com>
References: <CAEFDAA5BroNoMvR8Yyvf+nj_0RJa20gkCUhJo3zrbvYNYa5w1g@mail.gmail.com>
	<CAC6JEv9s1fSk7X5XSp8CtYN6Qr3SR5+XRD-Lu51YDJw0RGdRNA@mail.gmail.com>
	<55552C87.1080100@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37727 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbbEPIzt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 May 2015 04:55:49 -0400
Received: by wibt6 with SMTP id t6so16828671wib.0
        for <ceph-devel@vger.kernel.org>; Sat, 16 May 2015 01:55:48 -0700 (PDT)
In-Reply-To: <55552C87.1080100@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Loic: I've got 16GB ram, SSD and 3.3GHz 4 cores cpu

I have increased ulimit settings as Greg suggested to 16K and turned of=
f lttng.
Now it hangs in different place:

=2E..
PASS: unittest_ipaddr
PASS: unittest_texttable
PASS: unittest_on_exit
PASS: unittest_readahead
PASS: unittest_tableformatter
PASS: unittest_bit_vector
PASS: ceph-detect-init/run-tox.sh
=46AIL: test/erasure-code/test-erasure-code.sh
PASS: test/run-rbd-unit-tests.sh



On Fri, May 15, 2015 at 12:15 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 14/05/2015 22:55, Gregory Farnum wrote:
>> On Thu, May 14, 2015 at 1:24 PM, Michal Jarzabek <stiopa@gmail.com> =
wrote:
>>> Hi,
>>>
>>> After cloning ceph repo and then running:
>>> ./autogen.sh
>>> ./configure
>>> make -j 8
>>> make check
>>>
>>> make check always hangs after following lines:
>>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>> PASS: unittest_texttable
>>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>> PASS: unittest_on_exit
>>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>> PASS: unittest_readahead
>>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>> PASS: unittest_tableformatter
>>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>> PASS: unittest_bit_vector
>>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>> PASS: ceph-detect-init/run-tox.sh
>>> LD_PRELOAD=3Dliblttng-ust-fork.so
>>>
>>> Any idea what might be a problem?
>
> In addition to what Greg said:
>
> ./configure --without-lttng ...
>
> lttng is indeed the most probably cause for failure. How much RAM/CPU=
 does your machine have ? Is this running on SSD or spinner ? Not that =
a spinner would be a problem but mor than -j4 on a spinner is probably =
not a good idea because the disk will be the bottleneck.
>
>>
>> You can try building without lttng, which has helped some users, and
>> you can check if you have high enough ulimit settings. The defaults =
on
>> my box were not high enough; I bumped both files and processes up to
>> 16k and rebooted before I could get it working properly.
>
>> -Greg
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
