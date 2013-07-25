From: Gregory Farnum <greg@inktank.com>
Subject: Re: a few rados blueprints
Date: Thu, 25 Jul 2013 16:38:07 -0700
Message-ID: <CAPYLRzgm_vObTgxu04iWi20bVsX5H6af7-=PLPALD2MwwQT_dg@mail.gmail.com>
References: <alpine.DEB.2.00.1307251556550.12830@cobra.newdream.net>
	<CAPYLRzgafkZ5-LXzNMoMAYwvyO+jo1RAiTNFNhEMXPE-Ues5DQ@mail.gmail.com>
	<alpine.DEB.2.00.1307251626550.32741@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:63091 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab3GYXiI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 19:38:08 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so193909wiw.13
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 16:38:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1307251626550.32741@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jul 25, 2013 at 4:28 PM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 25 Jul 2013, Gregory Farnum wrote:
>> On Thu, Jul 25, 2013 at 4:01 PM, Sage Weil <sage@inktank.com> wrote:
>> > I've added a blueprint for avoiding double-writes when using btrfs:
>> >
>> >         http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd:_clone_from_journal_on_btrfs
>> >
>> > This should improve throughput significantly when the journal is a file in
>> > btrfs.
>> >
>> > ---
>> >
>> > Also, there's one for improving the localized read behavior:
>> >
>> >         http://wiki.ceph.com/01Planning/02Blueprints/Emperor/librados%2F%2Fobjecter%3A_smarter_localized_reads
>> >
>> > For example, for read-only parents of rbd clones, we may as well read from
>> > the replica in the same host or rack or row--whatever crush can tell
>> > us--and not the primary.  This is good for locality and load distribution
>> > when certain object sets are hot.
>>
>> This blueprint includes work items to set locality information in
>> libcephfs and via the Hadoop bindings. However, there's still a read
>> hole issue with read-from-replicas [1] that makes this generally
>> unwise. Did you consider that when writing this blueprint?
>> In particular I think we want to discuss if we allow people to use a
>> more powerful read-from-replica unless we can guarantee their usage of
>> it is safe (ie, snapshots).
>
> Yeah, there's an open bug for that, but the solution doesn't seem
> interesting enough to warrant a CDS discussion...
>
>         http://tracker.ceph.com/issues/5388
>
> But if I'm wrong, by all means write one! :)

I didn't think we had a solution yet, since your last words there are
"the fix on the OSD is going to be a bit more involved". :p
That doesn't mean we shouldn't do this, I just thought it was a
problem that needed to be part of the blueprint when designing and
implementing this, whether it's the user's problem to handle properly,
or we want to lock it out in ways we can be reasonably sure are safe,
or if we expect the local read issue to be resolved before this is
completed.
-Greg
