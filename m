From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Tue, 14 Feb 2017 09:46:42 -0800
Message-ID: <CAMMFjmFtrwGMaVweDt9eefWta22UdjgmdVg0it1t0SwWma_FXg@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
 <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com>
 <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz> <CAMMFjmH-+w8H7V0WjDUPStT5+3=doBH2OsWD5DNE3ij=zS7wzA@mail.gmail.com>
 <CAMMFjmHd1kJfBfjE7b8jOcXUZp74hi5Gbh-bQmOStPJoZ397UQ@mail.gmail.com>
 <CAObvjwPb_PosEnGOXP2tV4aWjnTyed7-275svyK+vu4uxYdTzQ@mail.gmail.com>
 <alpine.DEB.2.11.1702131624230.7782@piezo.novalocal> <CABo9giShGk2sdYyoJmuF9J-4kqDHmfzTrWq8H02aCCEJAa7tFA@mail.gmail.com>
 <22868a53-b99e-0686-e7e1-a288558aed27@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35613 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbdBNRqq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 12:46:46 -0500
Received: by mail-wm0-f46.google.com with SMTP id v186so23999515wmd.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 09:46:44 -0800 (PST)
In-Reply-To: <22868a53-b99e-0686-e7e1-a288558aed27@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Orit Wasserman <owasserm@redhat.com>, Sage Weil <sweil@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

I am running tests and so far they are still showing the same rgw issues

http://pulpito.ceph.com/teuthology-2017-02-14_16:21:46-rgw-hammer-distro-basic-smithi/


On Tue, Feb 14, 2017 at 7:04 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> They are all resulting of linking with tcmalloc in notcmalloc builds
>> that valgrind doesn't like.
>> There is an open tracker issue: http://tracker.ceph.com/issues/18744
>
>
> Note that these failures would probably disappear on re-run, because Dan
> fixed the underlying build issue.
>
> Nathan
