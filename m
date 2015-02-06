From: John Spray <john.spray@redhat.com>
Subject: Re: flock() on libcephfs ?
Date: Fri, 6 Feb 2015 14:44:50 +0100
Message-ID: <CAGd4Wr3Yu6OZ__QZAfrQH5zUrNoTgXfUfSyouJ6VX=Z4ma9HKg@mail.gmail.com>
References: <54D499D5.3060505@exalead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:40691 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbBFNow convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 08:44:52 -0500
Received: by labpv20 with SMTP id pv20so1188745lab.7
        for <ceph-devel@vger.kernel.org>; Fri, 06 Feb 2015 05:44:50 -0800 (PST)
In-Reply-To: <54D499D5.3060505@exalead.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xavier Roche <roche+kml2@exalead.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 6, 2015 at 11:39 AM, Xavier Roche <roche+kml2@exalead.com> wrote:
> I'm not sure this is the right place to post, so do not hesitate to redirect me to a more appropriate list if necessary!

You're in the right place!

> New to ceph, I naively attempted to add a flock (int ceph_flock(struct ceph_mount_info *cmount, int fd, int operation)) function in libcephfs, but I could not find the proper way to figure out what was the owner identifier used by Client::ll_flock() (an uint64_t integer) - this is not the pid, I presume ?

You should let the caller pass in the owner ID.  For example, if you
were using libcephfs to implement a filesystem interface, it would be
up to that interface to work out the unique ID from the calling layer
above it.  So you can pass it through libcephfs, no logic needed.

> Thanks in advance for any hints! By the way - would this new feature (flock()) make sense ?

Definitely, the flock support in the userspace client is new, and the
libcephfs bindings just didn't catch up yet: it was added in October:

commit a1b2c8ff955b30807ac53ce6bdc97cf61a7262ca
Author: Yan, Zheng <zyan@redhat.com>
Date:   Thu Oct 2 19:07:41 2014 +0800

    client: posix file lock support

    Signed-off-by: Yan, Zheng <zyan@redhat.com>


Cheers,
John
