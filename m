From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Fri, 17 Feb 2017 15:21:32 -0800
Message-ID: <CAJ4mKGY=J8r0txTLwzVb5OWkmJ=rLV0uf5z45mUS49+y0RzjxA@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
 <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com>
 <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz> <CAMMFjmH-+w8H7V0WjDUPStT5+3=doBH2OsWD5DNE3ij=zS7wzA@mail.gmail.com>
 <CAMMFjmHd1kJfBfjE7b8jOcXUZp74hi5Gbh-bQmOStPJoZ397UQ@mail.gmail.com>
 <CAObvjwPb_PosEnGOXP2tV4aWjnTyed7-275svyK+vu4uxYdTzQ@mail.gmail.com>
 <alpine.DEB.2.11.1702131624230.7782@piezo.novalocal> <CABo9giShGk2sdYyoJmuF9J-4kqDHmfzTrWq8H02aCCEJAa7tFA@mail.gmail.com>
 <22868a53-b99e-0686-e7e1-a288558aed27@suse.cz> <CAMMFjmFtrwGMaVweDt9eefWta22UdjgmdVg0it1t0SwWma_FXg@mail.gmail.com>
 <473edf7d-c46a-be4c-bc8a-35be4c095b2b@suse.cz> <CAJ4mKGaM2cO7QjAcYgmnTKWE8Bq+WTKi_Pd5+h4gkpOKeN0kCg@mail.gmail.com>
 <9c713c1b-b01b-ed10-dc06-6ffc5e9f0aa6@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:33385 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964813AbdBQXWb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2017 18:22:31 -0500
Received: by mail-ot0-f169.google.com with SMTP id k4so20697693otc.0
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2017 15:21:33 -0800 (PST)
In-Reply-To: <9c713c1b-b01b-ed10-dc06-6ffc5e9f0aa6@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Yuri Weinstein <yweinste@redhat.com>, Orit Wasserman <owasserm@redhat.com>, Sage Weil <sweil@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 17, 2017 at 11:52 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> I've no idea what's broken there, so eg more valgrind failures are not
>> a big deal, but if the upgrade itself is failing in some way that's
>> going to be a problem. o_O
>
>
> Hi Greg,
>
> Let me try to clarify :-)
>
> If someone reports problems upgrading their firefly cluster to hammer, and
> the problem is in firefly, will we publish a new firefly release?
>
> If someone reports problems upgrading their dumpling cluster to firefly, and
> the problem is in dumpling, will we publish a new dumpling release?

Probably not. But, we do know that upgrades work now and so any new
failures must be a failure of the new version of Hammer. That, we
would hopefully avoid releasing, and would definitely issue a fix
release for. :) We can't strand users!

>
> I don't know the answer to those questions, but such a release -- if
> published -- would be "out-of-band" with regard to what is written in
> https://github.com/ceph/ceph/blob/master/doc/releases.rst#understanding-the-release-cycle
> - in particular this:
>
> "Every other stable releases is a LTS (Long Term Stable) and will receive
> updates until two LTS are published. For instance Dumpling is retired when
> Hammer is published, Firefly is retired when Jewel is published etc."
>
> Nathan
