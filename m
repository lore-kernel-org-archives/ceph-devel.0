From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: hammer 0.94.10 QE status
Date: Tue, 14 Feb 2017 16:04:45 +0100
Message-ID: <22868a53-b99e-0686-e7e1-a288558aed27@suse.cz>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
 <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com>
 <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz>
 <CAMMFjmH-+w8H7V0WjDUPStT5+3=doBH2OsWD5DNE3ij=zS7wzA@mail.gmail.com>
 <CAMMFjmHd1kJfBfjE7b8jOcXUZp74hi5Gbh-bQmOStPJoZ397UQ@mail.gmail.com>
 <CAObvjwPb_PosEnGOXP2tV4aWjnTyed7-275svyK+vu4uxYdTzQ@mail.gmail.com>
 <alpine.DEB.2.11.1702131624230.7782@piezo.novalocal>
 <CABo9giShGk2sdYyoJmuF9J-4kqDHmfzTrWq8H02aCCEJAa7tFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46149 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbdBNPEs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 14 Feb 2017 10:04:48 -0500
In-Reply-To: <CABo9giShGk2sdYyoJmuF9J-4kqDHmfzTrWq8H02aCCEJAa7tFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Tamilarasi Muthamizhan <tmuthami@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

> They are all resulting of linking with tcmalloc in notcmalloc builds
> that valgrind doesn't like.
> There is an open tracker issue: http://tracker.ceph.com/issues/18744

Note that these failures would probably disappear on re-run, because Dan 
fixed the underlying build issue.

Nathan
