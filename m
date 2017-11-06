From: kefu chai <tchaikov@gmail.com>
Subject: Re: 12.2.2 status
Date: Mon, 6 Nov 2017 16:52:08 +0800
Message-ID: <CAJE9aOP+11MR+kKDKiCQx4FQPjofBkQcecEFOJjubZX30br-Og@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com> <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
 <874lqbcl5p.fsf@suse.com> <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal>
 <871slfckae.fsf@suse.com> <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
 <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz> <CAEw75dMUFUQ5JAd4LRX=ycjo0d0C7RmvqMq6d+=5qkKcaGf8ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:52732 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdKFIwK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 03:52:10 -0500
Received: by mail-ot0-f180.google.com with SMTP id v105so7792511ota.9
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 00:52:09 -0800 (PST)
In-Reply-To: <CAEw75dMUFUQ5JAd4LRX=ycjo0d0C7RmvqMq6d+=5qkKcaGf8ow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Kefu Chai <kchai@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, vumrao@redhat.com, Sage Weil <sweil@redhat.com>, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Karol Mroz <KMroz@suse.com>

On Sun, Nov 5, 2017 at 8:17 PM, Abhishek L
<abhishek.lekshmanan@gmail.com> wrote:
> On Sat, Nov 4, 2017 at 8:51 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> all or nothing. if we want to backport the fix of
>>> http://tracker.ceph.com/issues/21762, we will have to backport the
>>> "debian: fix package relationships after" fixes. so i think pull/18589
>>> is self-contained. and no additional step is needed.
>>>
>>> and per http://tracker.ceph.com/issues/21762, we need to have it in
>>> luminous. but i have no strong opinion on including it in 12.2.2 or
>>> post 12.2.2. Vikhyat and Nathan, what do you think?
>>
>>
>> Yes, I tried to make 18589 self-contained by pulling in Kefu's and
>> Abhishek's follow-on fixes. I think it would be nice to have it in 12.2.2.
>
> Rebuilt the integration branch with the newer PR and it still fails
> with the same reason
> http://pulpito.ceph.com/abhi-2017-11-05_11:53:02-ceph-disk-wip-abhi-testing-2017-11-05-0933-distro-basic-vps/
> for eg.
>
> Kefu, are there any more commits we need to solve the dependency issue?

well, yes and no.

we need to "dch" the changelog, to bump up the version number to
12.2.2 to address this issue. but i thought this was a step of our
release process: see
https://github.com/ceph/ceph-build/blob/2cb4f4069c7a0fac1abecd76e6014272f22cf139/ansible/roles/ceph-release/tasks/release/stable.yml#L3.

that's why i believed that PR#18589 was self-contained. anyway, we can
"fix" this issue in two ways:

1. "dch" the changelog in a commit only for testing, and it will not
be merged into luminous. run that the upgrade suites using dch'ed
version, and wait until the jenkins builder to tag and dch
automatically for the official release of 12.2.2
2. just drop the PR#18589. so and include it in post 12.2.2. so the
problem will be resolved w/o any efforts by then.


-- 
Regards
Kefu Chai
