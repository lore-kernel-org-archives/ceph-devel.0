From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Tue, 14 Feb 2017 09:05:55 -0800
Message-ID: <CAMMFjmFoAZYC22zbsKKsqT2xmG4hQh=Df=Y_TpmOBjnyQcRjBA@mail.gmail.com>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com>
 <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com>
 <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com> <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35386 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755120AbdBNRF6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 12:05:58 -0500
Received: by mail-wr0-f174.google.com with SMTP id c4so16604155wrd.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 09:05:57 -0800 (PST)
In-Reply-To: <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>

Let's retest !

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
