From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] ceph-mds crash - jewel 10.2.3
Date: Mon, 22 May 2017 18:34:38 +0100
Message-ID: <CALe9h7f3hFTvQQm8d2VAMX0wsGc9Ou5zuyQM548jr79QtMu19Q@mail.gmail.com>
References: <CADwtSqRA5TbTWYgX5_tjC2MT49h_vttiSm0Vev6M5taMkVbizA@mail.gmail.com>
 <CALe9h7fpTp-39VgLpr_Otv6sOUVWusmKJQqzzZMUEH3eV9jXWg@mail.gmail.com>
 <CADwtSqR8DMEb1nPCGFPj9kZCaZyoEn1HA8z=uiRy9CDsEgAcOQ@mail.gmail.com> <CADwtSqRJC49UqTqOcU-OLEA6vBtGcWLf+vVyqwvbXv6R88ruPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36572 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760654AbdEVRfA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 May 2017 13:35:00 -0400
Received: by mail-wm0-f49.google.com with SMTP id 7so2246542wmo.1
        for <ceph-devel@vger.kernel.org>; Mon, 22 May 2017 10:34:59 -0700 (PDT)
In-Reply-To: <CADwtSqRJC49UqTqOcU-OLEA6vBtGcWLf+vVyqwvbXv6R88ruPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simion Marius Rad <simarad@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 22, 2017 at 6:10 PM, Simion Marius Rad <simarad@gmail.com> wrote:
> What do represent (in the context of ceph rados) the x and i arguments in
> the MDS_INO_STRAY(x,i) macro from mdstypes.h file:
> #define MDS_INO_STRAY(x,i)
> (MDS_INO_STRAY_OFFSET+((((unsigned)(x))*NUM_STRAY)+((unsigned)(i))))

(copying list back in, in case anyone else is ever searching for this)

x is the MDS rank.

i is from 0 up to NUM_STRAY (10)

The purpose is to create 10 stray directories for each MDS rank.
There being 10 of them is kind of arbitrary, in preference to having
one super big one.  The value returned by the macro is the inode
number of a stray directory.

John
