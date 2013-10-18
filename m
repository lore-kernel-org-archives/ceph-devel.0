From: Gregory Farnum <greg@inktank.com>
Subject: Re: issues when bucket index deep-scrubbing
Date: Fri, 18 Oct 2013 12:00:38 -0700
Message-ID: <CAPYLRzjFRn=SHOs5JiEqGow0hgnbOEMkqrqwTi9W0cX4EAe=KA@mail.gmail.com>
References: <CAMNMNTyRDoQX=ytzF-jporD3uTpaUiJqTXEzqYGetqUerJ5=-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:43272 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597Ab3JRTAk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Oct 2013 15:00:40 -0400
Received: by mail-wg0-f45.google.com with SMTP id z12so4290966wgg.24
        for <ceph-devel@vger.kernel.org>; Fri, 18 Oct 2013 12:00:38 -0700 (PDT)
In-Reply-To: <CAMNMNTyRDoQX=ytzF-jporD3uTpaUiJqTXEzqYGetqUerJ5=-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dominik Mostowiec <dominikmostowiec@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Oct 18, 2013 at 4:01 AM, Dominik Mostowiec
<dominikmostowiec@gmail.com> wrote:
> Hi,
> I plan to shard my largest bucket because of issues of deep-scrubbing
> (when PG which index for this bucket is stored on is deep-scrubbed, it
> appears many slow requests and OSD grows in memory - after latest
> scrub it grows up to 9G).
>
> I trying to found why large bucket index make issues when it is scrubbed.
> On test cluster:
> radosgw-admin bucket stats --bucket=test1-XX
> { "bucket": "test1-XX",
>   "pool": ".rgw.buckets",
>   "index_pool": ".rgw.buckets",
>   "id": "default.4211.2",
> ...
>
> I guess index is in object .dir.default.4211.2. (pool: .rgw.buckets)
>
> rados -p .rgw.buckets get .dir.default.4211.2 -
> <empty>
>
> But:
> rados -p .rgw.buckets listomapkeys .dir.default.4211.2
> test_file_2.txt
> test_file_2_11.txt
> test_file_3.txt
> test_file_4.txt
> test_file_5.txt
>
> I guess that list of files are stored in leveldb not in one large file.
> 'omap' files are stored in {osd_dir}/current/omap/, the largest file
> that i found in this directory (on production) have 8.8M.
>
> I'm a little confused.
>
> How list of files (for bucket) is stored?

The index is stored as a bunch of omap entries in a single object.

> If list of objects in bucket is splitted on many small files in
> leveldb that large bucket (with many files) should not cause larger
> latency in PUT new object.

That's not quite how it works. Leveldb has a custom storage format in
which it stores sets of keys based on both time of update and the
value of the key, so the size of the individual files in its directory
has no correlation to the number or size of any given set of entries.

> Scrubbing also should not be a problem i think ...

The problem you're running into is that scrubbing is done on an
object-by-object basis, and so the OSD is reading all of the keys
associated with that object out of leveldb, and processing them, at
once. This number can be very much larger than the 8MB file you've
found in the leveldb directory, as discussed above.

> What you think about using a sharding to split big buckets into the
> smalest one to avoid the problems with big indexes?

That is definitely the obvious next step, but it's a non-trivial
amount of work and hasn't yet been started on by anybody. This is
probably a good subject for a CDS blueprint!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
