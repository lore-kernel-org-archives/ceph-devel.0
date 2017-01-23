From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Standalone libcrush: call for participation
Date: Mon, 23 Jan 2017 19:43:38 +0100
Message-ID: <CAOi1vP8U_YFZ18qr0PT1afcRRNT5-5P3Ei3TCQ8udWjtAQ5Ckw@mail.gmail.com>
References: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
 <20170123162905.GA8639@ultraspiritum.eng.arb.redhat.com> <cdb4c456-d15b-5630-2453-af94d1de0ba7@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38637 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAWSnk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 13:43:40 -0500
Received: by mail-wm0-f47.google.com with SMTP id r144so170460357wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 10:43:39 -0800 (PST)
In-Reply-To: <cdb4c456-d15b-5630-2453-af94d1de0ba7@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 6:00 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Adam,
>
> On 01/23/2017 05:29 PM, Adam C. Emerson wrote:
>> On 21/01/2017, Loic Dachary wrote:
>> [snip]
>>> The beginning of the next ceph release cycle seems like a good time
>>> to initiate that effort. If someone is willing to help with the
>>> bootstrap, now is a good time. The library will be hosted under the
>>> libcrush.org domain name. But that's about the only thing that
>>> happened so far :-)
>>
>> Would the Ceph git repository continue to have its own version of
>> CRUSH included, or would we pull in libcrush as a submodule?
>
> If all goes well and libcrush becomes actively and reliably maintained ou=
tside of the Ceph tree, it could either be a submodule or even a packaged d=
ependency. Before that happens things can stay the way they are. I voluntee=
r to manually monitor and cherry-pick whatever changes in the Ceph tree ont=
o the standalone repository ( http://libcrush.org/main/libcrush/ ) so that =
it does not drift away.
>
>> Also, does this affect the relationship between userspace CRUSH and
>> Linux kernel CRUSH?
>
> I don't know :-) Unless I'm mistaken the code in the linux kernel is an u=
nmodified copy of the code from src/crush/*.[ch].

Correct.  libcrush won't impact the kernel in any way, as long as the
C core <-> C++ wrappers boundary stays intact, which it should ;)

Some documentation will probably need to be added to cover things like
basic kernel compatibility (no floating point, stubs for asserts, etc)
and coding style for the C bits.  The core algorithm is far from where
libcrush initial activities would be centered though, I imagine.

> I however have no clue how it is tested to work as it should in both cont=
exts. Other than running integration tests with teuthology.
>
> How do you suggest we go about it ?

I don't think we need anything special here.

Thanks,

                Ilya
