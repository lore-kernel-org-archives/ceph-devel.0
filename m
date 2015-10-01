From: John Spray <jspray@redhat.com>
Subject: Re: advice on indexing sequential data?
Date: Thu, 1 Oct 2015 13:42:36 +0100
Message-ID: <CALe9h7c59qb_3_RTUnu9PFZ1Vxx+=QWCJH4zVvg9H7afYof5tg@mail.gmail.com>
References: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34137 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbbJAMm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Oct 2015 08:42:57 -0400
Received: by obbda8 with SMTP id da8so56454552obb.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Oct 2015 05:42:56 -0700 (PDT)
In-Reply-To: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Nakamura <tnakamura@eml.cc>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 1, 2015 at 11:44 AM, Tom Nakamura <tnakamura@eml.cc> wrote:
> Hello ceph-devel,
>
> My lab is concerned with developing data mining application for
> detecting and 'deanonymizing' spamming botnets from high-volume spam
> feeds.
>
> Currently, we just store everything in large mbox files in directories
> separated by day (think: /data/feed1/2015/09/13.mbox) on a single NFS
> server. We have ad-hoc scripts to extract features from these mboxes and
> pass them to our analysis pipelines (written in a mixture of
> R/matlab/python/etc). This system is reaching its limit point.
>
> We already have a small Ceph installation with which we've had good luck
> for storing other data,and would like to see how we can use it to solve
> our mail problem. Our basic requirements are that:
>
> - We need to be able to access each message by its extracted features.
> These features include simple information found in its header (for
> example From: and To:) as well as more complex information like
> signatures from attachments and network information (for example,
> presence in blacklists).
> - We will frequently add/remove features.
> - Faster access to recent data is more important than to older data.
> - Maintaining strict ordering of incoming messages is not necessary. In
> other words, if we received two spam messages on our feeds, it doesn't
> matter too much if they are stored in that order, as long as we can have
> coarse-grained temporal accuracy (say, 5 minutes). So we don't need
> anything as sophisticated as Zlog.
> - We need to be able to remove messages older than some specific age,
> due to storage constraints.
>
> Any advice on how to use Ceph and librados to accomplish this?  Here are
> my initial thoughts:
>
> - Each message is an object with some unique ID. Use omap to store all
> its features in the same object.
> - For each time period (which will have to be pre-specified to, say, an
> hour), we have an object which contains a list of ID's, as a bytestring
> of contatenated ID's. This should make expiring old messages trivial.
> - For each feature, we have a timestamped index (like
> 20150930-from-foo@bar.com or
> 20150813-has-attachment-with-hash-123abddeadbeef) the which contains a
> list of ID's.
> - Hopefully use Rados classes to index/feature-extract on the OSD's.
>
> How does this sound? One glaring omission is that I do not know how to
> create indices which would support querying by inequality/ranges ('find
> all messages between 1000 and 2000 bytes').

I would suggest some sort of hybrid approach, where you store your
messages and your time index in ceph (so that you can insert data and
expire data all within ceph), then use an external database for the
queries your application layer is interested in.  That way the
external database becomes somewhat disposable (you can always rebuild
efficiently for any given time period by consulting your time index in
ceph), but you don't have to implement any multi-axis querying inside
ceph.

With that kind of approach, you don't have to worry about implementing
indices (let the existing database do it), but you do still have to
worry about recovery from failure, i.e. keeping the ceph store and the
database index up to date.  You might need a "regenerate data for this
time period" call that re-inserted all the last 5 minutes emails to
the database after a failure of whatever is injecting the data.

John
