From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Cehp - tip - build break ?
Date: Mon, 6 Apr 2015 11:10:48 -0700
Message-ID: <CAC6JEv935z0w=E16HQ22aVaYwriRBYE=y3a5NuOmt8s=Cc7L0w@mail.gmail.com>
References: <CAFkUHxdMwZDR7=Z1XeyF9zrNzV2e1U+OWcsRpVusi_GhzCPN1A@mail.gmail.com>
	<55210974.2010009@dachary.org>
	<CAFkUHxe_tHvkYM_As7A8x42UT5XTzGLB-mjROv=t9NVgd+EiEQ@mail.gmail.com>
	<alpine.DEB.2.00.1504060906550.4469@cobra.newdream.net>
	<CAFkUHxdOsYqyi6yuVpL8fCOpL95xTrsjhi_9=5HW4Xi903f6Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33471 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbbDFSKw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Apr 2015 14:10:52 -0400
Received: by ignm3 with SMTP id m3so23953889ign.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Apr 2015 11:10:51 -0700 (PDT)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by mx.google.com with ESMTPSA id f77sm3135367iof.7.2015.04.06.11.10.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 11:10:51 -0700 (PDT)
Received: by igbqf9 with SMTP id qf9so25776261igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Apr 2015 11:10:48 -0700 (PDT)
In-Reply-To: <CAFkUHxdOsYqyi6yuVpL8fCOpL95xTrsjhi_9=5HW4Xi903f6Uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Apr 6, 2015 at 9:09 AM, kernel neophyte
<neophyte.hacker001@gmail.com> wrote:
> On Mon, Apr 6, 2015 at 9:07 AM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 6 Apr 2015, kernel neophyte wrote:
>>> On Sun, Apr 5, 2015 at 3:07 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>> > Hi,
>>> >
>>> > My guess is that it's because the gmock directory has been replac=
ed by a gmock submodule and git pull won't be enough to do the right th=
ing.
>>> > The simplest workaround is to git clone a fresh copy. Or you can =
try ./autogen.sh which should also do what's necessary.
>>>
>>> Cloned a fresh copy, still the same.
>>
>> Make sure you run make in teh top-level directory, not inside src/, =
at
>> least once to get the gmock stuff built.
>
>
> Yep thats exactly what I am doing. In the top level directory:
>
> ./autogen.sh
> ./configure
> make -j12

You need to also run "git submodule update --init" first. The
"do_autogen.sh" script will handle that for you, as well as making a
bunch of other configuration decisions that you may or may not want.
;)
-Greg

>
>
> -Neo
>>
>> sage
>>
>>>
>>>
>>>
>>> -Neo
>>> >
>>> > Cheers
>>> >
>>> > On 05/04/2015 07:07, kernel neophyte wrote:
>>> >> Hi,
>>> >>
>>> >> I am seeing build break in ceph master.
>>> >>
>>> >> make[3]: *** No rule to make target
>>> >> `../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'=
=2E
>>> >> Stop.
>>> >>
>>> >> make[3]: *** Waiting for unfinished jobs....
>>> >>
>>> >>   CXX      test/erasure-code/ceph_erasure_code_non_regression.o
>>> >>
>>> >>
>>> >> Am I missing anything obvious ?
>>> >>
>>> >>
>>> >> -Neo
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>> >>
>>> >
>>> > --
>>> > Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>> >
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
