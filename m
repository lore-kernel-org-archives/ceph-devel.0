From: Gregory Farnum <greg@inktank.com>
Subject: Re: Tracking hadoop-common for file system shim versioning
Date: Fri, 26 Oct 2012 15:42:55 -0700
Message-ID: <CAPYLRziSw8WVK8=X557+M8ZJ+T9Dv2v1kyp_FXkQM=8XBmhwPA@mail.gmail.com>
References: <CAPrxi584NjBoo1qA-2YpqMt9p+6g+SooeR0Y1fKetGN55Fchdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:59000 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab2JZWm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:42:57 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2698898lag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:42:56 -0700 (PDT)
In-Reply-To: <CAPrxi584NjBoo1qA-2YpqMt9p+6g+SooeR0Y1fKetGN55Fchdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Joe Buck <buck@soe.ucsc.edu>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Oct 26, 2012 at 3:29 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Development of the Hadoop shim layer is best done in the Apache Hadoop
> Git repository, so we can track up-stream and build for all the
> different versions that exist. Is keeping a clone in Inktank Github
> something that is possible / desired?

Are we sure we want to maintain it in a fork of their repo? (I'm not
saying we don't, just curious.) QFS recently published support for
Hadoop and apparently they only need two JARs to support the things
that everybody is running now. Either way, see
http://mail-archives.apache.org/mod_mbox/hadoop-common-dev/201210.mbox/%3CCC946699.1C97B%25thilee@quantcast.com%3E
and https://issues.apache.org/jira/browse/HADOOP-8885 for the
discussion surrounding (not) sending that upstream and the
distribution strategy they ended up with.
