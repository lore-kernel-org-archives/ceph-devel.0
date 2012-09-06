From: Tommi Virtanen <tv@inktank.com>
Subject: Re: issues with adjusting the crushmap in 0.51
Date: Thu, 6 Sep 2012 13:31:15 -0700
Message-ID: <CADvuQRFz9oZr3BGRdzUhG4xhdYUu69v7UxKDuS4d0-kTisrr6Q@mail.gmail.com>
References: <20120906175821.GA32205@tchpc.tcd.ie> <sfid-H20120906-191917-+051.46-1@marduk.tchpc.tcd.ie>
 <CAPYLRzggLqcgvMJWFDYOsHvQNK2oOvHmmTEnufK60R4=mdEQNw@mail.gmail.com> <20120906185104.GA6518@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57951 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759770Ab2IFUbh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 16:31:37 -0400
Received: by vbbff1 with SMTP id ff1so1975998vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 13:31:36 -0700 (PDT)
In-Reply-To: <20120906185104.GA6518@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Sep 6, 2012 at 11:51 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> Also, the "ceph osd setcrushmap..." command doesn't up when a ceph
> --help is run in the 0.51 release, however it is documented on the
> wiki as far as I recall. It'd be real nice if the applications emitted
> all the available commands, it would make experimenting much nicer and
> fun.

"ceph" is just a client app that sends (most of) the commands to
ceph-mon for execution; it's --help is problematic to keep up to
date.. We're trying to do better. Patches appreciated, see ticket at
the end..

Background:
http://www.spinics.net/lists/ceph-devel/msg08471.html
http://www.spinics.net/lists/ceph-devel/msg08472.html
http://www.tracker.newdream.net/issues/2894
