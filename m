From: Gregory Farnum <greg@inktank.com>
Subject: Re: Tracking hadoop-common for file system shim versioning
Date: Fri, 26 Oct 2012 16:00:36 -0700
Message-ID: <CAPYLRziOgDG0dPUs+fq903OxvNXOZT_-zfVgcYZi7_aKFv8+3g@mail.gmail.com>
References: <CAPrxi584NjBoo1qA-2YpqMt9p+6g+SooeR0Y1fKetGN55Fchdg@mail.gmail.com>
	<CAPYLRziSw8WVK8=X557+M8ZJ+T9Dv2v1kyp_FXkQM=8XBmhwPA@mail.gmail.com>
	<F94C248B-486F-4565-B712-1FAE21912B65@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40403 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab2JZXAi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 19:00:38 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1985945lbo.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 16:00:36 -0700 (PDT)
In-Reply-To: <F94C248B-486F-4565-B712-1FAE21912B65@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <jbbuck@gmail.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

If that's all we're interested in it seems like cloning their repo and
then checking out a specific version would be the right answer. ;)
I'm just a little concerned because we don't actually want to be
forking the Hadoop upstream and generally speaking a fork seems like
inviting accidental problems when all we want to do is look at a
single version of their upstream without actually importing it into
our tree. If there are other concerns I'm missing then they could
certainly be overriding, though!

On Fri, Oct 26, 2012 at 3:47 PM, Joe Buck <jbbuck@gmail.com> wrote:
> Noah and I talked about this a bit and the idea was not to push our code upstream, but rather to host a fork locally so that we could decide when to rev the version(s) we build against rather than just pulling trunk from Hadoop's repo. We'd still be building the one or two .jar files that users would have to configure Hadoop to find, but we'd have a full version of Hadoop in our repo for consistency and what not.
>
> -Joe Buck
>
> On Oct 26, 2012, at 3:42 PM, Gregory Farnum wrote:
>
>> On Fri, Oct 26, 2012 at 3:29 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>>> Development of the Hadoop shim layer is best done in the Apache Hadoop
>>> Git repository, so we can track up-stream and build for all the
>>> different versions that exist. Is keeping a clone in Inktank Github
>>> something that is possible / desired?
>>
>> Are we sure we want to maintain it in a fork of their repo? (I'm not
>> saying we don't, just curious.) QFS recently published support for
>> Hadoop and apparently they only need two JARs to support the things
>> that everybody is running now. Either way, see
>> http://mail-archives.apache.org/mod_mbox/hadoop-common-dev/201210.mbox/%3CCC946699.1C97B%25thilee@quantcast.com%3E
>> and https://issues.apache.org/jira/browse/HADOOP-8885 for the
>> discussion surrounding (not) sending that upstream and the
>> distribution strategy they ended up with.
>
