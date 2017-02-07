From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Tue, 7 Feb 2017 13:47:31 -0800
Message-ID: <CAMMFjmH-+w8H7V0WjDUPStT5+3=doBH2OsWD5DNE3ij=zS7wzA@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
 <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com> <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35498 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbdBGVrn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 16:47:43 -0500
Received: by mail-wm0-f42.google.com with SMTP id v186so29512601wmd.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2017 13:47:37 -0800 (PST)
In-Reply-To: <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

See updated status with approvals http://tracker.ceph.com/issues/17151#note-61

Outstanding suites requiring approval:

rgw
samba
upgrade/firefly-x (hammer)
upgrade/hammer-x (jewel)

Thx
YuriW

On Thu, Feb 2, 2017 at 3:17 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Turned out to be a buggy test -- hammer is missing an infernalis
>> commit f217865cf7c4 ("test_librbd_fsx: invalidate before discard in
>> krbd mode").
>
>
> I gave it a try; please take a look:
>
> * https://github.com/ceph/ceph/pull/13230
>
> Nathan
