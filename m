From: Joe Buck <jbbuck@gmail.com>
Subject: Re: Tracking hadoop-common for file system shim versioning
Date: Fri, 26 Oct 2012 15:47:42 -0700
Message-ID: <F94C248B-486F-4565-B712-1FAE21912B65@gmail.com>
References: <CAPrxi584NjBoo1qA-2YpqMt9p+6g+SooeR0Y1fKetGN55Fchdg@mail.gmail.com> <CAPYLRziSw8WVK8=X557+M8ZJ+T9Dv2v1kyp_FXkQM=8XBmhwPA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48411 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966821Ab2JZWrr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:47:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3062768pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:47:46 -0700 (PDT)
In-Reply-To: <CAPYLRziSw8WVK8=X557+M8ZJ+T9Dv2v1kyp_FXkQM=8XBmhwPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Noah and I talked about this a bit and the idea was not to push our code upstream, but rather to host a fork locally so that we could decide when to rev the version(s) we build against rather than just pulling trunk from Hadoop's repo. We'd still be building the one or two .jar files that users would have to configure Hadoop to find, but we'd have a full version of Hadoop in our repo for consistency and what not. 

-Joe Buck

On Oct 26, 2012, at 3:42 PM, Gregory Farnum wrote:

> On Fri, Oct 26, 2012 at 3:29 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> Development of the Hadoop shim layer is best done in the Apache Hadoop
>> Git repository, so we can track up-stream and build for all the
>> different versions that exist. Is keeping a clone in Inktank Github
>> something that is possible / desired?
> 
> Are we sure we want to maintain it in a fork of their repo? (I'm not
> saying we don't, just curious.) QFS recently published support for
> Hadoop and apparently they only need two JARs to support the things
> that everybody is running now. Either way, see
> http://mail-archives.apache.org/mod_mbox/hadoop-common-dev/201210.mbox/%3CCC946699.1C97B%25thilee@quantcast.com%3E
> and https://issues.apache.org/jira/browse/HADOOP-8885 for the
> discussion surrounding (not) sending that upstream and the
> distribution strategy they ended up with.

