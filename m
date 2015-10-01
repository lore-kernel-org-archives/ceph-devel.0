From: Sage Weil <sage@newdream.net>
Subject: Re: advice on indexing sequential data?
Date: Thu, 1 Oct 2015 05:33:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510010530120.5233@cobra.newdream.net>
References: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33721 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbbJAMd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Oct 2015 08:33:59 -0400
In-Reply-To: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Nakamura <tnakamura@eml.cc>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Tom,

On Thu, 1 Oct 2015, Tom Nakamura wrote:
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

This seems reasonable.  There's a rados append operation so you can fire 
off 2 IOs to write the message and do the append.  You may want to batch 
the appends on the inject process to reduce load... or it might not 
matter, depends on the data rate.

You could also use omap for this if you wan to query by time range (within 
the per-day or per-hour object).

> - For each feature, we have a timestamped index (like
> 20150930-from-foo@bar.com or
> 20150813-has-attachment-with-hash-123abddeadbeef) the which contains a
> list of ID's. 
> - Hopefully use Rados classes to index/feature-extract on the OSD's. 
>
> How does this sound? One glaring omission is that I do not know how to
> create indices which would support querying by inequality/ranges ('find
> all messages between 1000 and 2000 bytes').

This I'm less sure about.  You could use a rados class to do teh feature 
extraction and store in omap in the same object, but rados doesn't 
give you a cross-object index.  If you are going to do any queries I 
would put it in a database of some sort (maybe something like 
cassandra or hbase?).

sage
