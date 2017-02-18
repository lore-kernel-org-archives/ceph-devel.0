From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: hammer 0.94.10 QE status
Date: Sat, 18 Feb 2017 09:39:16 +0100
Message-ID: <5d25394f-b9e6-177c-548c-6714467c2760@suse.cz>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
 <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com>
 <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz>
 <CAMMFjmH-+w8H7V0WjDUPStT5+3=doBH2OsWD5DNE3ij=zS7wzA@mail.gmail.com>
 <CAMMFjmHd1kJfBfjE7b8jOcXUZp74hi5Gbh-bQmOStPJoZ397UQ@mail.gmail.com>
 <CAObvjwPb_PosEnGOXP2tV4aWjnTyed7-275svyK+vu4uxYdTzQ@mail.gmail.com>
 <alpine.DEB.2.11.1702131624230.7782@piezo.novalocal>
 <CABo9giShGk2sdYyoJmuF9J-4kqDHmfzTrWq8H02aCCEJAa7tFA@mail.gmail.com>
 <22868a53-b99e-0686-e7e1-a288558aed27@suse.cz>
 <CAMMFjmFtrwGMaVweDt9eefWta22UdjgmdVg0it1t0SwWma_FXg@mail.gmail.com>
 <473edf7d-c46a-be4c-bc8a-35be4c095b2b@suse.cz>
 <CAJ4mKGaM2cO7QjAcYgmnTKWE8Bq+WTKi_Pd5+h4gkpOKeN0kCg@mail.gmail.com>
 <9c713c1b-b01b-ed10-dc06-6ffc5e9f0aa6@suse.cz>
 <CAJ4mKGY=J8r0txTLwzVb5OWkmJ=rLV0uf5z45mUS49+y0RzjxA@mail.gmail.com>
 <23126e7c-8064-9fa4-961d-faec8c513166@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbdBRIjW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 18 Feb 2017 03:39:22 -0500
In-Reply-To: <23126e7c-8064-9fa4-961d-faec8c513166@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, Orit Wasserman <owasserm@redhat.com>, Sage Weil <sweil@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Several people have looked at the upgrade/firefly-x (hammer) failures
> and nobody has found anything that wasn't an issue with the tests
> themselves. Maybe you could take a look, too?
>
> http://pulpito.ceph.com/teuthology-2017-01-30_20:52:09-upgrade:firefly-x-hammer-distro-basic-vps/

There are two failed and three dead jobs. The two failures are

ceph-objectstore-tool apply-layout-settings failed with 1

My totally untested theory: the client is not getting upgraded from 
firefly to hammer, and as of 
https://github.com/ceph/ceph/commit/e4038a0c ceph_manager.py has the 
client running the "apply-layout-settings" subcommand of 
ceph-objectstore-tool which is missing in firefly.

PR with fix for review: https://github.com/ceph/ceph/pull/13513 (against 
hammer for now, but the same code is jewel, kraken, and master as well)
