From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 09:41:01 -0700
Message-ID: <CAJ4mKGbsJBk_8N8tkmqhYOipXXQC-LdiV=XOZ8S22HCCXh8_OA@mail.gmail.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
	<5727A3DC.7070102@symas.com>
	<bee8107b-0d3e-3ebc-d029-ed27e0165137@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36372 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933972AbcECQlD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 12:41:03 -0400
Received: by mail-yw0-f179.google.com with SMTP id o66so28125664ywc.3
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 09:41:02 -0700 (PDT)
In-Reply-To: <bee8107b-0d3e-3ebc-d029-ed27e0165137@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Howard Chu <hyc@symas.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 3, 2016 at 6:34 AM, Mark Nelson <mnelson@redhat.com> wrote:
> On 05/02/2016 02:00 PM, Howard Chu wrote:
>>
>> Sage Weil wrote:
>>>
>>> 1) Thoughts on moving to rocksdb in general?
>>
>>
>> Are you actually prepared to undertake all of the measurement and tu=
ning
>> required to make RocksDB actually work well? You're switching from a=
n
>> (abandoned/unsupported) engine with only a handful of config paramet=
ers
>> to one with ~40-50 params, all of which have critical but unpredicta=
ble
>> impact on resource consumption and performance.
>>
>
> You are absolutely correct, and there are definitely pitfalls we need=
 to
> watch out for with the number of tunables in rocksdb.  At least on th=
e
> performance side two of the big issues we've hit with leveldb compact=
ion
> related.  In some scenarios compaction happens slower than the number=
 of
> writes coming in resulting in ever-growing db sizes.  The other issue=
 is
> that compaction is single threaded and this can cause stalls and gene=
ral
> mayhem when things get really heavily loaded.  My hope is that if we =
do go
> with rocksdb, even in a sub-optimally tuned state, we'll be better of=
f than
> we were with leveldb.
>
> We did some very preliminary benchmarks a couple of years ago (admitt=
edly a
> too-small dataset size) basically comparing the (at the time) stock c=
eph
> leveldb settings vs rocksdb.  On this set size, leveldb looked much b=
etter
> for reads, but much worse for writes.

That's actually a bit troubling =E2=80=94 many of our monitor problems =
have
arisen from slow reads, rather than slow writes. I suspect we want to
eliminate this before switching, if it's a concern.

=2E..Although I think I did see a monitor caching layer go by, so maybe
it's a moot point now?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
