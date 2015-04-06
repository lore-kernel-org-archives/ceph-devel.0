From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: Cehp - tip - build break ?
Date: Mon, 6 Apr 2015 09:09:58 -0700
Message-ID: <CAFkUHxdOsYqyi6yuVpL8fCOpL95xTrsjhi_9=5HW4Xi903f6Uw@mail.gmail.com>
References: <CAFkUHxdMwZDR7=Z1XeyF9zrNzV2e1U+OWcsRpVusi_GhzCPN1A@mail.gmail.com>
	<55210974.2010009@dachary.org>
	<CAFkUHxe_tHvkYM_As7A8x42UT5XTzGLB-mjROv=t9NVgd+EiEQ@mail.gmail.com>
	<alpine.DEB.2.00.1504060906550.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35256 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbbDFQJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Apr 2015 12:09:59 -0400
Received: by pddn5 with SMTP id n5so48681290pdd.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Apr 2015 09:09:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1504060906550.4469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Apr 6, 2015 at 9:07 AM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 6 Apr 2015, kernel neophyte wrote:
>> On Sun, Apr 5, 2015 at 3:07 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>> > Hi,
>> >
>> > My guess is that it's because the gmock directory has been replace=
d by a gmock submodule and git pull won't be enough to do the right thi=
ng.
>> > The simplest workaround is to git clone a fresh copy. Or you can t=
ry ./autogen.sh which should also do what's necessary.
>>
>> Cloned a fresh copy, still the same.
>
> Make sure you run make in teh top-level directory, not inside src/, a=
t
> least once to get the gmock stuff built.


Yep thats exactly what I am doing. In the top level directory:

=2E/autogen.sh
=2E/configure
make -j12


-Neo
>
> sage
>
>>
>>
>>
>> -Neo
>> >
>> > Cheers
>> >
>> > On 05/04/2015 07:07, kernel neophyte wrote:
>> >> Hi,
>> >>
>> >> I am seeing build break in ceph master.
>> >>
>> >> make[3]: *** No rule to make target
>> >> `../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'.
>> >> Stop.
>> >>
>> >> make[3]: *** Waiting for unfinished jobs....
>> >>
>> >>   CXX      test/erasure-code/ceph_erasure_code_non_regression.o
>> >>
>> >>
>> >> Am I missing anything obvious ?
>> >>
>> >>
>> >> -Neo
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>> >>
>> >
>> > --
>> > Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
