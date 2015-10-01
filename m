From: Tom Nakamura <tnakamura@eml.cc>
Subject: advice on indexing sequential data?
Date: Thu, 01 Oct 2015 03:44:37 -0700
Message-ID: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45686 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140AbbJAKoi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Oct 2015 06:44:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 774B9204E1
	for <ceph-devel@vger.kernel.org>; Thu,  1 Oct 2015 06:44:37 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello ceph-devel,

My lab is concerned with developing data mining application for
detecting and 'deanonymizing' spamming botnets from high-volume spam
feeds.

Currently, we just store everything in large mbox files in directories
separated by day (think: /data/feed1/2015/09/13.mbox) on a single NFS
server. We have ad-hoc scripts to extract features from these mboxes and
pass them to our analysis pipelines (written in a mixture of
R/matlab/python/etc). This system is reaching its limit point.  

We already have a small Ceph installation with which we've had good luck
for storing other data,and would like to see how we can use it to solve
our mail problem. Our basic requirements are that:

- We need to be able to access each message by its extracted features.
These features include simple information found in its header (for
example From: and To:) as well as more complex information like
signatures from attachments and network information (for example,
presence in blacklists).
- We will frequently add/remove features.
- Faster access to recent data is more important than to older data. 
- Maintaining strict ordering of incoming messages is not necessary. In
other words, if we received two spam messages on our feeds, it doesn't
matter too much if they are stored in that order, as long as we can have
coarse-grained temporal accuracy (say, 5 minutes). So we don't need
anything as sophisticated as Zlog. 
- We need to be able to remove messages older than some specific age,
due to storage constraints.

Any advice on how to use Ceph and librados to accomplish this?  Here are
my initial thoughts:

- Each message is an object with some unique ID. Use omap to store all
its features in the same object.
- For each time period (which will have to be pre-specified to, say, an
hour), we have an object which contains a list of ID's, as a bytestring
of contatenated ID's. This should make expiring old messages trivial.
- For each feature, we have a timestamped index (like
20150930-from-foo@bar.com or
20150813-has-attachment-with-hash-123abddeadbeef) the which contains a
list of ID's. 
- Hopefully use Rados classes to index/feature-extract on the OSD's. 

How does this sound? One glaring omission is that I do not know how to
create indices which would support querying by inequality/ranges ('find
all messages between 1000 and 2000 bytes').

Thank you,
Tom N.
