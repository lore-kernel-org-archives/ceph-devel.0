From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: Cehp - tip - build break ?
Date: Mon, 6 Apr 2015 09:04:20 -0700
Message-ID: <CAFkUHxe_tHvkYM_As7A8x42UT5XTzGLB-mjROv=t9NVgd+EiEQ@mail.gmail.com>
References: <CAFkUHxdMwZDR7=Z1XeyF9zrNzV2e1U+OWcsRpVusi_GhzCPN1A@mail.gmail.com>
	<55210974.2010009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33888 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbbDFQEV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Apr 2015 12:04:21 -0400
Received: by pdbni2 with SMTP id ni2so48578657pdb.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Apr 2015 09:04:20 -0700 (PDT)
In-Reply-To: <55210974.2010009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Apr 5, 2015 at 3:07 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> My guess is that it's because the gmock directory has been replaced b=
y a gmock submodule and git pull won't be enough to do the right thing.
> The simplest workaround is to git clone a fresh copy. Or you can try =
=2E/autogen.sh which should also do what's necessary.

Cloned a fresh copy, still the same.



-Neo
>
> Cheers
>
> On 05/04/2015 07:07, kernel neophyte wrote:
>> Hi,
>>
>> I am seeing build break in ceph master.
>>
>> make[3]: *** No rule to make target
>> `../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'.
>> Stop.
>>
>> make[3]: *** Waiting for unfinished jobs....
>>
>>   CXX      test/erasure-code/ceph_erasure_code_non_regression.o
>>
>>
>> Am I missing anything obvious ?
>>
>>
>> -Neo
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
