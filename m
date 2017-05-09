From: Luis Henriques <lhenriques@suse.com>
Subject: Re: Question regarding struct ceph_timestamp
Date: Tue, 9 May 2017 19:25:42 +0100
Message-ID: <20170509182542.utphva2p2xl4kozp@hermes.olymp>
References: <20170509142331.ntm3wuyk2ce6mnui@hermes.olymp>
 <CAJ4mKGanWD5PSMnf+C4nJJ7-t04f7jYjJ4T0xH-q+srfQ5_o6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39293 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754223AbdEISZu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 9 May 2017 14:25:50 -0400
Content-Disposition: inline
In-Reply-To: <CAJ4mKGanWD5PSMnf+C4nJJ7-t04f7jYjJ4T0xH-q+srfQ5_o6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 09, 2017 at 09:42:49AM -0700, Gregory Farnum wrote:
> On Tue, May 9, 2017 at 7:23 AM, Luis Henriques <lhenriques@suse.com> wrote:
> > Hi,
> >
> > While analysing an xfstest failure (generic/258) I had to look at the
> > definition of struct ceph_timespec.  And I was surprised to verify that
> > both its fields (tv_sec and tv_nsec) are 32-bits (__le32).  And I believe
> > that this explains the test failure, as ceph_encode_timespec() would fail
> > to convert the negative pre-epoch value (-315615540 => 3979351756).
> >
> > The failure can be easily reproduced by simply creating a test file in a
> > cephfs mount with:
> >
> >  $ touch -t 196001010101 /mnt/testfile
> >  $ ls -l /mnt/testfile
> >  -rw-r--r-- 1 root 0 0 Jan  1  1960 testfile
> >
> > After remounting the filesystem:
> >
> >  $ ls -l /mnt/testfile
> >  -rw-r--r-- 1 root 0 0 Feb  6  2096 testfile
> >
> > Am I missing something?  If I'm not (and I probably am!), this isn't just
> > a client-side issue and fixing it will require touching several other
> > parts of the code.
> 
> I haven't done any work with most of the kernel code, but I believe
> this was discussed last year:
> https://patchwork.kernel.org/patch/8308691/

Ah, awesome!  Thanks for pointing me to this thread.  I did a quick search
before sending my email but failed to find it.  Anyway, that discussion
contains lots of interesting information around the issue and it looks
like it is being taken care of.  Again, thanks Greg!

Cheers,
--
Luís
