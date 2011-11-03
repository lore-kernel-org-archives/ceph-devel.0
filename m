From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH] FileJournal: stop using sync_file_range
Date: Thu, 3 Nov 2011 15:48:15 -0700
Message-ID: <CAORUGqCLXcL0L_8_M+RLAXsmB5x5Wnwj7hNsF-wvSix8C=OGaA@mail.gmail.com>
References: <20111103214508.GA19234@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60018 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab1KCWsh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 18:48:37 -0400
Received: by wyh15 with SMTP id 15so1733706wyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 15:48:36 -0700 (PDT)
In-Reply-To: <20111103214508.GA19234@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 3, 2011 at 14:45, Christoph Hellwig <hch@infradead.org> wro=
te:
> Using sync_file_range means that neither any required metadata gets c=
ommited,
> nor the disk cache gets flushed. =C2=A0Stop using it for the journal,=
 and add
> a comment on why a fsync_range system call would be helpful here.

One clarification here that came up in a conversation: the code quoted
was explicitly inside if (is_bdev), that is, it is only used when the
journal was on a raw block device. That should make a lot of the
metadata & block allocation irrelevant.

We're still very interested in hearing what are the real world barrier
/ write cache flush guarantees from all the syscalls; the
documentation doesn't guarantee much, even for fsync.. from fsync(2):

       If the underlying hard disk has write caching enabled, then the
data may not really be on
       permanent storage when fsync() / fdatasync() return.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
