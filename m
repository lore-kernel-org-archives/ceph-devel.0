From: Samuel Just <sjust@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 15:23:43 -0800
Message-ID: <CAN=+7FX3goZteU+niLf5gXpVBq0yFxi6Gkqux5FZbvJNpQieJw@mail.gmail.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com>
	<20151203191233.GA17144@ultraspiritum.redhat.com>
	<CAN=+7FVC5QU7Gz6qq9PPeVv3Nvkq0c0cbVNNcC+Rz-j7OcnHxQ@mail.gmail.com>
	<1928144476.28418457.1449170995351.JavaMail.zimbra@redhat.com>
	<CAN=+7FV1aFxmT8E_-=G4+OuOG=VotWV7PQv45zL3v3+mjDYbrQ@mail.gmail.com>
	<291788535.28463587.1449173661550.JavaMail.zimbra@redhat.com>
	<alpine.DEB.2.00.1512031303010.19170@cobra.newdream.net>
	<1814262106.28521757.1449177794388.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36744 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbbLCXXo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 18:23:44 -0500
Received: by igcph11 with SMTP id ph11so21973561igc.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 15:23:44 -0800 (PST)
In-Reply-To: <1814262106.28521757.1449177794388.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

From a simplicity point of view, I'd rather just move a Transaction
object than use a unique_ptr.   Maybe the overhead doesn't end up
being significant?
-Sam

On Thu, Dec 3, 2015 at 1:23 PM, Casey Bodley <cbodley@redhat.com> wrote:
>
> ----- Original Message -----
>> On Thu, 3 Dec 2015, Casey Bodley wrote:
>> > > Well, yeah we are, it's just the actual Transaction structure which
>> > > wouldn't be dynamic -- the buffers and many other fields would still
>> > > hit the allocator.
>> > > -Sam
>> >
>> > Sure. I was looking specifically at the tradeoffs between allocating
>> > and moving the Transaction object itself.
>> >
>> > As it currently stands, the caller of ObjectStore can choose whether to
>> > allocate its Transactions on the heap, embed them in other objects, or
>> > put them on the stack for use with apply_transactions(). Switching to an
>> > interface built around unique_ptr forces all callers to use the heap. I'm
>> > advocating for an interface that doesn't.
>>
>> That leaves us with either std::move or.. the raw Transaction* we have
>> now.  Right?
>
> Right. The thing I really like about the unique_ptr approach is that the
> caller no longer has to care about the Transaction's lifetime, so doesn't
> have to allocate the extra ObjectStore::C_DeleteTransaction for cleanup.
> Movable Transactions accomplish this as well.
>
> Casey
>
>>
>> > > > It's true that the move ctor has to do work. I counted 18 fields, half
>> > > > of
>> > > > which are integers, and the rest have move ctors themselves. But the
>> > > > cpu
>> > > > is good at integers. The win here is that you're not hitting the
>> > > > allocator
>> > > > in the fast path.
>>
>> To be fair, many of these are also legacy that we can remove... possibly
>> even now.  IIRC the only exposure to legacy encoded transactions (that use
>> the tbl hackery) are journal items from an upgrade pre-hammer OSD that
>> aren't flushed on upgrade.  We should have made the osd flush the journal
>> before recording the 0_94_4 ondisk feature.  We could add another one to
>> enforce that and rip all that code out now instead of waiting until
>> after jewel... that would be satisfying (and I think an ondisk ceph-osd
>> feature is enough here, then document that users should upgrade to
>> hammer 0.94.6 or infernalis 9.2.1 before moving to jewel).
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
