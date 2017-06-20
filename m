From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Fwd: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Tue, 20 Jun 2017 17:38:08 -0400
Message-ID: <CAC-Np1wAh5mewdgKOosHc=b8WrRZW+zUuosoaB-FmmX1g4fLLA@mail.gmail.com>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com>
 <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com>
 <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com>
 <CALe9h7cxPioPHLw48Gj02bEkD-HC49yHT8kG62AyLm_V9KnOZQ@mail.gmail.com>
 <09d01c0c-b5f0-519e-0687-c8117e1fc2ce@suse.cz> <CAEPMp+41hTKanCsxJ7r-YA7k11QFQczGPXaiwmYptW9viFAEAQ@mail.gmail.com>
 <0d432012-9491-0ebd-edd0-06d68fb1801b@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33892 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdFTViK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 17:38:10 -0400
Received: by mail-wr0-f169.google.com with SMTP id 77so108702646wrb.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 14:38:10 -0700 (PDT)
In-Reply-To: <0d432012-9491-0ebd-edd0-06d68fb1801b@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 20, 2017 at 4:40 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> For upstream testing of ceph-volume (if it
>> existed outside ceph.git) you'd simply install it with pip.
>
>
> Like, e.g., setuptools? Always use the latest version, and you're fine?
>
> Seriously, this would be OK if the ceph-volume maintainers ensure that every
> new release is thoroughly regression-tested against all stable versions of
> Ceph that are in maintenance at the time and agree not to roll out any
> non-backward-compatible features (?).
>
> I recall that with ceph-deploy we did get into a situation where the latest
> version did not support hammer, so hammer users could not simply grab the
> latest version of ceph-deploy. (I guess that has been fixed in the
> meantime?) Users had to "know" which version played nice with hammer and
> grab that one specifically. Also, whatever bugs were in that version, they
> were stuck with because nothing is backported.

ceph-deploy always supported up until the EOL'd versions. Not sure
what specific issue you are referring to.

I wasn't implying that there were no bugs in ceph-deploy :)


>
> I suppose the Ceph project could do the same - just maintain a single
> codestream ("master") and cut releases from time to time. It would be a lot
> simpler! And if a distro wanted to backport fixes to a previous release,
> nothing to stop them, right? But for some reason the Ceph project goes
> through the trouble to maintain multiple codestreams. And doesn't the Linux
> kernel project maintains stable branches, too?
>

Bummer, again, I wasn't implying such a thing (sarcasm?)

> Maintaining stable branches is a lot of work, so there must be good reasons
> for it. One reason I can think of is that it becomes possible to implement
> non-backward-compatible features in mainline/master, yet folks who value
> stability (i.e. distros and the vast majority of users) can continue to use
> the older codestreams and benefit from bugfixes that get backported.
>

I agree with you, stable branches is a lot of work, and the ceph
backporting team does a lot of excellent
work here. None of my comments should be read otherwise.

My position is that a small, python-only, with no direct bindings to
Ceph other than the CLI, should probably have the
freedom of staying out of tree, and that it can keep up with older
versions, and release often when bugs come up (as you've mentioned
happened
with ceph-deploy)



> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
