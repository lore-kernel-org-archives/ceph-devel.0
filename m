From: Ugis <ugis22@gmail.com>
Subject: Re: When ceph synchronizes journal to disk?
Date: Tue, 5 Mar 2013 16:27:11 +0200
Message-ID: <CAE63xUNUsCJ=c78HoGq2T-Bb3+gt+iLnMMQ1o_+4WG=rNc2ECw@mail.gmail.com>
References: <513343D8.8050402@cs.utah.edu>
	<CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
	<51357589.6080202@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36495 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3CEO1M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 09:27:12 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so7675813ieb.39
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 06:27:12 -0800 (PST)
In-Reply-To: <51357589.6080202@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> I do not think I understand this well. When the writeahead journal mode is
> in use, would you please explain what happens to a single 4M write request?
> I assume that an entry in the journal will be created for this write request
> and after this entry is flushed to the journal disk, Ceph returns
> successful. There should be no IO to the osd's disk. All IOs are supposed to
> go to the journal disk. At a later time, Ceph will start to apply these
> changes to the normal filesystem by reading from the first entry at which
> its previous synchronization stops. Finally, it will read this entry and
> apply this write change to the normal file system. Could you please point
> out where is wrong in my understanding? Thanks,
>

Probably you are expecting journal to behave like cache if I
understood correctly. Journals are for integrity, caches are for io
speed.
For block device caching you could see more on flashcache or bcache.

BR,
Ugis
