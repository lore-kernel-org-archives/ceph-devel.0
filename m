From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Mon, 19 Jun 2017 13:41:35 -0500
Message-ID: <CAEPMp+7Ki_cCbXJNWnhUejqbGA+HSypcZ9KmjaWaSjHo28-NLA@mail.gmail.com>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com>
 <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com> <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36675 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbdFSSmR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jun 2017 14:42:17 -0400
Received: by mail-qt0-f170.google.com with SMTP id u19so117370556qta.3
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 11:42:16 -0700 (PDT)
In-Reply-To: <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: John Spray <jspray@redhat.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>
>> I think having one part of Ceph on a different release cycle to the
>> rest of Ceph is an even more dramatic thing than having it in a
>> separate git repository.
>>
>> It seems like there is some dissatisfaction with how the Ceph project
>> as whole is doing things that is driving you to try and do work
>> outside of the repo where the rest of the project lives -- if the
>> release cycles or test infrastructure within Ceph are not adequate for
>> the tool that formats drives for OSDs, what can we do to fix them?
>
> It isn't Ceph the project :)

I think there needs to be a distinction between things that *are* ceph
(CephFS, RBD, RGW, MON, OSD) and things that might leverage ceph or
help with it's installation / usage (ceph-ansible, ceph-deploy,
ceph-installer, ceph-volume). I don't think the later group needs to
be in ceph.git.


>>
>> I guess my argument isn't so much an argument as it is an assertion
>> that if you want to go your own way then you need to have a really
>> strong clear reason.
>
> Many! Like I mentioned: easier testing, faster release cycle, can
> publish in any package index, doesn't need anything in ceph.git to
> operate, etc..

I agree with all these points. I would add that having ceph-volume in
a separate git repo greatly simplifies the CI interaction with the
project. When I submit a PR to ceph-volume.git I'd want all our unit
tests run and any new docs automatically published. If this lived in
ceph.git it's very clumsy (maybe not possible) to have a jenkins react
and start jobs that only pertain to the code being changed. If I
submit new ceph-volume code why would I need make check ran or ceph
packages built?

Having ceph-disk tied to ceph.git (and it's release cycle) has caused
problems with ceph-docker in the past. We've had a race condition (in
ceph-disk) that exposes itself in our CI present for quite some time
even though the patch was merged to master upstream. I think the fixed
missed the 2.3 downstream release as well because it wasn't back
ported quickly enough. Keeping tools like ceph-disk or ceph-volume
outside of ceph.git would allow us to merge those fixes back into
ceph-docker more efficiently.

Maybe I don't understand the strong reasons for keeping ceph-volume in
ceph.git? If it's only for parity in branches, I never thought of
ceph-volume having a branch per version of ceph supported anyway. I'd
expect it to have numbered releases that support a documented number
of ceph releases, ceph-ansible works similarly here and I believe
ceph-deploy did as well.

- Andrew
