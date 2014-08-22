From: Gregory Farnum <greg@inktank.com>
Subject: Re: watch/notify changes
Date: Fri, 22 Aug 2014 13:24:25 -0700
Message-ID: <CAPYLRzitTEEA3gyfDO-ac12KdRjf+f1bc9_aPEc-5yNg2e3Dgw@mail.gmail.com>
References: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
	<CAPYLRziFYx7bW5T3mnrSpGuAjxQ2oxqMomp0ffL1UyqBLDD_7g@mail.gmail.com>
	<alpine.DEB.2.00.1408221118290.31169@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:61266 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbaHVUY0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 16:24:26 -0400
Received: by mail-qg0-f50.google.com with SMTP id z107so7484257qgd.9
        for <ceph-devel@vger.kernel.org>; Fri, 22 Aug 2014 13:24:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408221118290.31169@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 22, 2014 at 11:22 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 22 Aug 2014, Gregory Farnum wrote:
>> On Thu, Aug 21, 2014 at 3:34 PM, Sage Weil <sweil@redhat.com> wrote:
>> > Sam and Josh and I discussed the state of watch/notify a couple weeks
>> > back.  Here are our notes:
>> >
>> >         http://pad.ceph.com/p/watch-notify
>> >
>> > I've mapped most of these to tickets or bugs and noted them in the pad.
>> >
>> > Ignore the fact that these are in the v0.86 sprint currently; it's just
>> > easier to enter them that way.
>> >
>> > If there are other issues we're missing here, let's address them now.  The
>> > API changes so far can be seen at
>> >
>> >         https://github.com/ceph/ceph/commit/7ba30230505c6eede06cb2e2cb64210fdd4025a8
>> >         https://github.com/ceph/ceph/commit/d179dd970e52db8b0c07b20f69c9e3be6bc43f09
>>
>> I'm not entirely up on how watch-notify is implemented right now
>> because it's been a bit of a mess, but this set of patches is a lot
>> smaller than I was expecting when I started hearing about reworking
>> it. The specific problem I remember remaining is:
>> 1) Notifiers can specify a timeout after which point the notify gets
>> completed regardless of the status of the watchers
>
> This is the error code patches.  The notifier now gets -ETIMEDOUT.
>
>> 2) Watchers have a separate timeout (which is often larger)
>
> This is by design.  I remember there was some suggestion that this was a
> problem, but when we talked a couple weeks back we couldn't figure out
> what it might be.  The watch timeout is about client reconnects and
> failures.  The notify timeout could be message or application dependent...
> it's just how long the notifier is willing to wait.

Okay, let's talk about that from the perspective of a watch-notify
user. Say RBD, with multiple readers on a single image. You want to
implement cooperative snapshotting, recording the snapid in the
header. How do we get every client accessing the image to coordinate
those changes?
The obvious way is to do something like make a write of the new snapid
to the header image and execute a notify to everybody. (This being in
fact what we do.)
But before we can consider the snapshot completed, we need affirmative
confirmation that no clients are continuing to write with the old
snapid.
With current master branch, we don't actually get that affirmation,
because the notify timeout could end and the notifier gets their
callback before all the other clients have seen the new info. If
there's a communications issue between the OSD and a client (so that
the notify is never received, but other communications continue to
run), that's a problem...
With this branch, we can get an ETIMEDOUT error instead of a positive
return, but what can we do with that information? Just try again in a
loop and trust that we'll eventually succeed? That's not great: maybe
one of the clients is high-latency enough that they can't satisfy the
notify threshold, but they can keep their watch active.

Whereas if the notify timeout is the same time length as a watch
timeout, we can affirmatively know on a notify reply (with or without
error return codes) that every client has either:
1) seen the notify, or
2) seen the watch connection's timeout period elapse on their side.
So no matter what happens in the network, after a notify cycle has
elapsed, every client has either seen the new data or knows that they
have failed and needs to re-read everything. My recollection is that
this sequence of timeouts and notification events (or one very much
like it) is the theoretical lower bound if you're going to do reliable
information delivery, but I can't find the proof at the moment (it's
associated in my head with ZooKeeper's watch mechanism, but neither of
the papers I have on hand discuss it in any detail). If you don't have
reliable information delivery, what good does watch-notify do?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
