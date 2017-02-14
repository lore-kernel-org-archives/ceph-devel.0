From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Tue, 14 Feb 2017 16:30:28 +0200
Message-ID: <CABo9giShGk2sdYyoJmuF9J-4kqDHmfzTrWq8H02aCCEJAa7tFA@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
 <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com>
 <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz> <CAMMFjmH-+w8H7V0WjDUPStT5+3=doBH2OsWD5DNE3ij=zS7wzA@mail.gmail.com>
 <CAMMFjmHd1kJfBfjE7b8jOcXUZp74hi5Gbh-bQmOStPJoZ397UQ@mail.gmail.com>
 <CAObvjwPb_PosEnGOXP2tV4aWjnTyed7-275svyK+vu4uxYdTzQ@mail.gmail.com> <alpine.DEB.2.11.1702131624230.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36357 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbdBNOab (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 09:30:31 -0500
Received: by mail-lf0-f52.google.com with SMTP id z134so67135321lff.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 06:30:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702131624230.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Tamilarasi Muthamizhan <tmuthami@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

On Mon, Feb 13, 2017 at 6:24 PM, Sage Weil <sweil@redhat.com> wrote:
> Let's ignore samba here too.
>
> The rgw failures are all valgrind... can Matt or Yehuda take a look and
> make sure they're not new/problematic?
>

They are all resulting of linking with tcmalloc in notcmalloc builds
that valgrind doesn't like.
There is an open tracker issue: http://tracker.ceph.com/issues/18744

Orit
> Thanks!
> sage
>
> On Thu, 9 Feb 2017, Tamilarasi Muthamizhan wrote:
>
>> Yuri, lets skip firefly-x upgrade issue.
>>
>> On Wed, Feb 8, 2017 at 1:14 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>       upgrade/hammer-x (jewel) PASSED now!
>>
>>       Outstanding suites requiring approval:
>>
>>       rgw
>>       samba
>>       upgrade/firefly-x (hammer)
>>
>>       Sage?
>>
>>       Thx
>>       YuriW
>>
>>       On Tue, Feb 7, 2017 at 1:47 PM, Yuri Weinstein
>>       <yweinste@redhat.com> wrote:
>>       > See updated status with approvals
>>       http://tracker.ceph.com/issues/17151#note-61
>>       >
>>       > Outstanding suites requiring approval:
>>       >
>>       > rgw
>>       > samba
>>       > upgrade/firefly-x (hammer)
>>       > upgrade/hammer-x (jewel)
>>       >
>>       > Thx
>>       > YuriW
>>       >
>>       > On Thu, Feb 2, 2017 at 3:17 AM, Nathan Cutler
>>       <ncutler@suse.cz> wrote:
>>       >>> Turned out to be a buggy test -- hammer is missing an
>>       infernalis
>>       >>> commit f217865cf7c4 ("test_librbd_fsx: invalidate before
>>       discard in
>>       >>> krbd mode").
>>       >>
>>       >>
>>       >> I gave it a try; please take a look:
>>       >>
>>       >> * https://github.com/ceph/ceph/pull/13230
>>       >>
>>       >> Nathan
>>       --
>>       To unsubscribe from this list: send the line "unsubscribe
>>       ceph-devel" in
>>       the body of a message to majordomo@vger.kernel.org
>>       More majordomo info at
>>       http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
