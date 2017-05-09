From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Question regarding struct ceph_timestamp
Date: Tue, 9 May 2017 09:42:49 -0700
Message-ID: <CAJ4mKGanWD5PSMnf+C4nJJ7-t04f7jYjJ4T0xH-q+srfQ5_o6w@mail.gmail.com>
References: <20170509142331.ntm3wuyk2ce6mnui@hermes.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38675 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbdEIQmv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 12:42:51 -0400
Received: by mail-it0-f43.google.com with SMTP id e65so5140199ita.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 09:42:50 -0700 (PDT)
In-Reply-To: <20170509142331.ntm3wuyk2ce6mnui@hermes.olymp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 9, 2017 at 7:23 AM, Luis Henriques <lhenriques@suse.com> wrote:
> Hi,
>
> While analysing an xfstest failure (generic/258) I had to look at the
> definition of struct ceph_timespec.  And I was surprised to verify that
> both its fields (tv_sec and tv_nsec) are 32-bits (__le32).  And I believe
> that this explains the test failure, as ceph_encode_timespec() would fail
> to convert the negative pre-epoch value (-315615540 => 3979351756).
>
> The failure can be easily reproduced by simply creating a test file in a
> cephfs mount with:
>
>  $ touch -t 196001010101 /mnt/testfile
>  $ ls -l /mnt/testfile
>  -rw-r--r-- 1 root 0 0 Jan  1  1960 testfile
>
> After remounting the filesystem:
>
>  $ ls -l /mnt/testfile
>  -rw-r--r-- 1 root 0 0 Feb  6  2096 testfile
>
> Am I missing something?  If I'm not (and I probably am!), this isn't just
> a client-side issue and fixing it will require touching several other
> parts of the code.

I haven't done any work with most of the kernel code, but I believe
this was discussed last year:
https://patchwork.kernel.org/patch/8308691/
-Greg
