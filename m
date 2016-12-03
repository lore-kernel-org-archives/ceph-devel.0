From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: raw rados listing with seek to marker
Date: Sat, 3 Dec 2016 09:29:35 -0800
Message-ID: <CADRKj5Tv-NN8gCJgR-X2kCVtYzNJnS9r78FtaGZm6GrX3s2EuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:32831 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbcLCR3h (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Dec 2016 12:29:37 -0500
Received: by mail-ua0-f176.google.com with SMTP id 20so311715540uak.0
        for <ceph-devel@vger.kernel.org>; Sat, 03 Dec 2016 09:29:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Weil, Sage" <sweil@redhat.com>, "Just, Samuel" <sjust@redhat.com>, David Zafman <dzafman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

rgw uses raw rados listing when doing certain operations. For example
when listing metadata entries (these aren't being indexed). When doing
a full metadata sync the rgw at the secondary zone sends a request to
the master to get a list of all the metadata entries (of a specific
section), so that it can build an internal index for these entries so
that it can fetch them.
One of the main issues here is that since the metadata listing relies
on raw rados objects listing, the operation cannot be paged.
I've looked at the nobjects listing code, and this is what I
understand happening:
 - we iterate through all the pgs in the pool, one by one and in order
 - for each pg we're at we read a chunk of the next X (where X 1024)
entries via rados pgls operation
 - for each chunk rados returns a cookie, which is some kind of a
descriptor that points at either the current, or the next chunk that
can be used to fetch the next chunk

rados itself with the nobjects api provides some seek mechanism, but
it's pretty rudimentary and only seeks by rounding down to the current
pg. I was looking at introducing a marker for nobjects listing (see:
https://github.com/yehudasa/ceph/commits/wip-18079), but there are a
few points I'm not completely sure about:
 - I was using cookie and current_pg as the marker, but that only
points to the current chunk that was just read (but not necessarily
consumed completely). Is there a way to generate a cookie that would
point at any entry within the current chunk?
 - Is entries order guaranteed within the chunk? E.g., if I know that
the last cookie was C, and the last object we saw was O, can we
request C again, and skip to object O and not miss any entries created
before original operation started? (it is ok to miss on entries
created after original operation started, as we're going to get these
via separate log)
 - is there any other field that we need to keep for the marker other
than these two?
 - what to do with the old object listing api? the code internally
defaults to using it, so if implementing seek only for nobjects it
won't work by default. I'm not sure we want to implement it for the
legacy listing infrastructure.

Yehuda
