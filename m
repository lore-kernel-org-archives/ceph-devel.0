From: Tommi Virtanen <tv@inktank.com>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Wed, 30 May 2012 10:02:07 -0700
Message-ID: <CADvuQRF0nGLty9XYxLT_1KzbEMkjdeCj07==qzONg5CbRR7VZg@mail.gmail.com>
References: <201205290944.33983.a.ott@m-privacy.de> <CADvuQRF5zC78hySCf3gYeJkRWGa+KjMKcY==0hqBxJrLhFv9dw@mail.gmail.com>
 <201205300859.27181.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51233 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab2E3RC1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 13:02:27 -0400
Received: by dady13 with SMTP id y13so40352dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 10:02:27 -0700 (PDT)
In-Reply-To: <201205300859.27181.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Tue, May 29, 2012 at 11:59 PM, Amon Ott <a.ott@m-privacy.de> wrote:
> AFAIR, when the deadlocks came, there were some GB of the 12 GB RAM still
> unused, not even for caching. But it might be a problem with low memory,
> because we are running with 32 Bit.
>
> Would it be possible to preallocate a significant amount of RAM for the
> purpose of syncing? I would not mind reserving a few 100 MB for that, but
> deadlocks must not happen in any case. Can the size of the journal give a
> hint on how much is needed?

The code & complexity overhead of managing that reserved buffer has so
far prevented that approach from being really adopted, anywhere in the
Linux kernel community, as far as I know.
