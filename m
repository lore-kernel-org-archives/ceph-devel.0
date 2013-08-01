From: Samuel Just <sam.just@inktank.com>
Subject: Re: PG Backend Proposal
Date: Thu, 1 Aug 2013 10:14:09 -0700
Message-ID: <CA+4uBUZhO_HdWuJTX5qYOpHGozg6R7PnpZ4MATqzhDf_doi3uw@mail.gmail.com>
References: <51FA8FF7.7090004@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:46811 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab3HAROL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 13:14:11 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz11so2566125veb.8
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 10:14:10 -0700 (PDT)
In-Reply-To: <51FA8FF7.7090004@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

DELETE can always be rolled forward, but there may be other operations
in the log that can't be (like an append).  So we need to be able to
roll it back (I think)  perform_write, read, try_rollback probably
don't matter to backfill, scrubbing.  You are correct, we need to
include the chunk number in the object as well!
-Sam

On Thu, Aug 1, 2013 at 9:42 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> When the acting set changes order two chunks for the same object may =
co-exist in the same placement group. The key should therefore also con=
tain the chunk number.
>
> That's probably the most sensible comment I have so far. This documen=
t is immensely useful (even in its current state) because it shows me y=
our perspective on the implementation.
>
> I'm puzzled by:
>
> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete requires=
 that we retain the deleted object until all replicas have persisted th=
e deletion event. ErasureCoded backend will therefore need to store obj=
ects with the version at which they were created included in the key pr=
ovided to the filestore. Old versions of an object can be pruned when a=
ll replicas have committed up to the log event deleting the object.
>
> because I don't understand why the version would be necessary. I thou=
ght that deleting an erasure coded object could be even easier than era=
sing a replicated object because it cannot be resurrected if enough chu=
nks are lots, therefore you don't need to wait for ack from all OSDs in=
 the up set. I'm obviously missing something.
>
> I failed to understand how important the pg logs were to maintaining =
the consistency of the PG. For some reason I thought about them only in=
 terms of being a light weight version of the operation logs. Adding a =
payload to the pg_log_entry ( i.e. APPEND size or attribute ) is a new =
idea for me and I would have never thought or dared think the logs coul=
d be extended in such a way. Given the recent problems with logs writes=
 having a high impact on performances ( I'm referring to what forced yo=
u to introduce code to reduce the amount of logs being written to only =
those that have been changed instead of the complete logs ) I thought a=
bout the pg logs as something immutable.
>
> I'm still trying to figure out how PGBackend::perform_write / read / =
try_rollback would fit in the current backfilling / write / read / scru=
bbing ... code path.
>
> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb2=
26fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb2=
26fed8d9b7/src/osd/PGBackend.h
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
