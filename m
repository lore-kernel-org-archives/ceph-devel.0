From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Active vs. standby MDSes (Was: Re: Degraded PGs blocking open()?)
Date: Thu, 9 Jun 2011 09:16:38 -0700
Message-ID: <BANLkTimESfkKJbyFbzpZfK_W8dbshDeGmA@mail.gmail.com>
References: <201106070237.34854.szekelyi@niif.hu>
	<BANLkTimt0MKyd9ZOqxYm=z91HNS+5B=a1g@mail.gmail.com>
	<201106091223.08914.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42928 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab1FIQQl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2011 12:16:41 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 49E12C182
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 09:16:40 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id C8C63C178
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 09:16:39 -0700 (PDT)
Received: by ewy4 with SMTP id 4so599073ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jun 2011 09:16:38 -0700 (PDT)
In-Reply-To: <201106091223.08914.szekelyi@niif.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

So the Ceph MDS system is a little odd. Presumably you are aware that
file data is stored as chunks (default 4MB) in objects on RADOS (ie,
the OSD system). Metadata is also stored on RADOS, where each
directory is a single object that contains all the inodes underneath
it.
In principle you could construct a filesystem that simply accessed
this on-disk metadata every time it changed everything. However, that
would be slow for a number of reasons. To speed up metadata ops, we
have the MetaData Server. Essentially, it does 3 things:
1) Cache the metadata in-memory to speed up read accesses.
2) Handle client locking of data/metadata accesses (this is the
capabilities system)
3) Journal metadata write operations so that we can get streaming
write latencies instead of random lookup-and-write latencies on
changes.

When you have multiple active MDSes, they partition the namespace so
that any given directory has a single "authoritative" MDS which is
responsible for handling requests. This simplifies locking and
prevents the MDSes from duplicating inodes in-cache. You can add MDSes
by increasing the max_mds number. (Most of the machinery is there to
reduce the number of MDSes too, but it's not all tied together.)

So you can see that if one daemon dies you're going to lose access to
the metadata it's responsible for. :( HOWEVER, all the data it's
"responsible" for resides in RADOS so you haven't actually lost any
state or the ability to access it, just the authorization to do so. So
we introduce standby and standby-replay MDSes. If you have more MDS
daemons than max_mds, the first max_mds daemons will start up and
become active and the rest will sit around as standbys. The monitor
service knows they exist and are available, but they don't do anything
until an active MDS dies. If an active MDS does die, the monitor
assigns one of the standbys to take over for that MDS -- it becomes
the same logical MDS but on a different host (or not, if you're
running multiple daemons on the same host or whatever). It goes
through a set of replay stages and then operates normally.
If this makes you shudder in horror from previous experiences with the
HDFS standby or something, fear not. :) We haven't done comprehensive
tests but replay is generally pretty short -- our default timeout on
an MDS is in the region of 30 seconds and I don't think I've ever seen
replay take more than 45.
If you want to reduce the time it takes even further you can assign
certain daemons to be in standby-replay mode. In this mode they
actively replay the journal of an active MDS and maintain the same
cache, so if the active MDS fails they only need to go through the
client reconnect stage.
Also remember that during this time access to metadata which resides
on other non-failed MDSes goes on uninterrupted. :)

In principle we could do some whiz-bang coding so that if an MDS fails
another active MDS takes over responsibility for its data and then
repartitions it out to the rest of the cluster, but that's not
something we're likely to do for a while given the complexity and the
relatively small advantage over using standby daemons.

So going through your questions specifically:
2011/6/9 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> If I understand things correctly, Ceph tries to have max_mds number o=
f MDSes
> active at all times. I can have more MDSes than this number, but the =
excess
> ones will be standby MDSes, right?
Right.

> I can't really understand the difference between a standby and an act=
ive MDS.
> Now I have two active and no standby MDSes, and the filesystem stops =
working if
> I kill any of them. Does this mean that the system will stop working =
if it
> can't fill up the number of MDSes to max_mds from the standby pool?
Hopefully the above answered this for you a little more precisely, but
the short answer is yes.

> What is the reason for running standby MDSes and not setting max_mds =
to the
> number of all MDSes?
Again, hopefully you got this above. But it increases system
resiliency in the case of a failure.

>> 2) Create an extra MDS daemon, perhaps on your monitor node. When th=
e
>> system detects that one of your MDSes has died (a configurable
>> timeout, IIRC in the neighborhood of 30-60 seconds), this extra daem=
on
>> will take over.
>
> I will do this. Should this be a standby or an active MDS? Ie. should=
 I
> increase max_mds from 2 to 3 after creating the new MDS?
Standby -- don't increase max_mds.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
