From: Milosz Tanski <milosz@adfin.com>
Subject: Re: New(ish) LMDBstore KeyValuedB backend and testing
Date: Tue, 11 Jul 2017 15:23:18 -0400
Message-ID: <CANP1eJFpCMM8Do9wBcLZjfqP_1xLyLTBra7GrpUFwJmOgx-Abg@mail.gmail.com>
References: <e81ae2ee-8e6e-3276-d373-fe26f58f23e9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37245 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933570AbdGKTXT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 15:23:19 -0400
Received: by mail-it0-f52.google.com with SMTP id m84so1069400ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 12:23:19 -0700 (PDT)
In-Reply-To: <e81ae2ee-8e6e-3276-d373-fe26f58f23e9@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.a.nelson@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 11, 2017 at 10:23 AM, Mark Nelson <mark.a.nelson@gmail.com> wrote:
> Hi guys,
>
> A month or so ago I started rewriting Xinxin Shu's old LMDB kvdb PR to work
> with master.  I've now got it to the point where it no longer segfaults
> during performance tests as the kvstore for bluestore.
>
> The new PR is here:
>
> https://github.com/ceph/ceph/pull/16257
>
> The original version needed some work to get into a functional state. Some
> of this was just general things like adding cmake support and adding
> functionality to conform to the current KeyValueDB interface. Beyond that,
> the biggest issue was reworking it to not keep multiple concurrent write
> transactions open.  Other minor issues include removing various temporary
> string conversions and memory copies where possible.
>
> One remaining issue is that Bluestore's BitmapFreelistManager keeps a read
> iterator open indefinitely.  This translates to keeping a read-only lmdb txn
> open, which makes new writes to the database grow the database rather than
> reusing free-pages (ie the db grows without bound with new writes).
>
> A (buggy) fix for this is being attempted in another PR (currently probably
> breaks freelist management, segfaults for large min_alloc sizes), but fixes
> the db growth issue:
>
> https://github.com/ceph/ceph/pull/16243
>
> Write performance is fairly low (as expected) vs rocksdb, though it's
> possible we may be able to improve some of that via a WAL or similar
> mechanism.  Most of the time is spent doing fdatasync via mdb_env_sync. It
> might be possible to make the bluestore write workload more favorable to
> lmdb (bigger key/value pairs) but that's potentially a lot of work.
>
> Space-amp so far seems like it might be lower than rocksdb in our current
> configuration though which could be good for large HDD configurations where
> the DB is on flash and raw write performance is less of an issue.
>
> I think it would be good to try to get some other key/value stores like
> forestdb or even the aging zetascale into a functional state and do some
> more comparison testing.
>
> Mark

Mark, I've actually looked into making LMDB group commit work for
another project. In the we ended up going a different direction, but
not before at least we figure out how to do it conceptually. At the
end of the day the hardest part of making it work comes down how to do
it in a portable way within the existing code base. LMDB is very well
written in terms of quality of the implementation (stability / crash
performance) but the code can be difficult to read/change and in our
case the issue various cross platform.

Here's a mind dump of what I remember.

Current LMDB transaction design works very similar to a RW lock with
the additional relaxation of the rules that writes never block reads
(you just read a potentially older copy). The writes end up being
bound by fsync() performance. On workload that have lots of small
database updates in each transaction (like filesystem metadata) this
lead to somewhat poor write txn rate.

The fsync() bottle neck is especially true on spinning disk but is
still apparent on everything but nvdimm. The solution to that is being
able to commit multiple changes in one go, in traditional database
this is often referred to group commit. You can implement it either in
the higher level software that's consuming it (CEPH) or in the lower
layer (LMDB). I've only though through the second one.

The way that works out is:

1. You have a previous txn commit that's happening. What I'll refer to
as "previous turn"
2. Instead of blocking like we do today in another thread, it's
possible to rework LMDB code in such a way that the next write
transaction can proceed using the results from the ongoing write
assuming it's going to succeed. This is possible since LMDB is COW so
you're never overwriting existing data. I refer to this "current turn"
3. Once the "current turn" completes but "previous turn" is not
complete, we can expend on "current turn" to include the next pending
transaction. Thus we can end up with a whole group of transaction in
the "current turn".
4. When "previous turn" completes, it can check if there's any
transactions in the "current turn" and wake up one of the threads to
complete the commit.
5. If there's an write error in the "previous turn" you obviously need
to fail "current turn" since it's using results that have not been
committed. This should hopefully be the corner case.

So, conceptually it's simple. You get you make progress on then next
write transaction while the current one is waiting on fsync and you
opportunistically get to group transactions together. But a I said
it's easier said then done....

The difficulties I have identified:
1. The LMDB code is designed for and makes a lot of assumptions about
one writer.
2. The on-disk format have a root page double buffering scheme (one
for previous and next transaction) that would need to change (need at
least 3).
3. A prototype I experiment with required some point-to-point
synchronization. "previous turn" commiter thread needs to wake up the
threads in the current group, then need to wake up one thread in the
next group to be it's commit leader. There's lots of corner cases of
what if there's no next group, etc...
4. I've implemented this the prototype using futex and atomics. A lot
of complexity came from dealing lock-free queue problems... the double
buffer root page scheme is essentially replaced by a "queue" and you
need to worry about pre-allocating it but also making sure you don't
overrun it (waiting on possibly slow notifications to others in your
group that have not advanced).
5. LMDB supports both in single process (threads) and multi-process
model for accessing the same database. The second case made it
somewhat harder to implement this.
6. I'm not sure with what you end up is compatible with LMDB... and
that might be a burden.

There's other things I'm missing. As I said, we've abandoned our
changes here because we went in a different direction with the whole
projects (using LMDB as on-disk cache for remote resources) partially
due to the complexity. But with the right implementation, you can
ended up with a btree database with a really solid base (LMDB) but
also with much faster write txn (thanks to implementing group commit).

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
