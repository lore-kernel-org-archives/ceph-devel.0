From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: can mds prepare inodes?
Date: Thu, 14 Apr 2011 09:05:17 -0700
Message-ID: <BANLkTinM2hPUGPPpsW1gJhd-Dp6AgRAqXg@mail.gmail.com>
References: <BANLkTiniJAbPZpbGZEpucN4O1sWQKvjyvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38668 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758736Ab1DNQFU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 12:05:20 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8F091C06A
	for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 09:05:19 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3C232C068
	for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 09:05:19 -0700 (PDT)
Received: by eyx24 with SMTP id 24so498405eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 09:05:17 -0700 (PDT)
In-Reply-To: <BANLkTiniJAbPZpbGZEpucN4O1sWQKvjyvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 14, 2011 at 2:46 AM, huang jun <hjwsm1989@gmail.com> wrote:
> hi developers,
> =A0 I have a question about the prealloc_inos variable in SessionMap.=
h
> =A0 when the client first request to allocate an inode,
> prepare_new_inode function will prepare new inodes to the session. so
> if =A0the client's first request is to make a dir, the MDS always
> return =A0a =A0safe message to the client, but why it =A0do not answe=
r
> unsafe to th client?

The point of preallocating inode numbers is so that the MDS can return
success to the client without having to wait for a disk access. It
does these by writing to disk that the preallocated inodes belong to
the client before the client asks for them -- this way even if there
is a crash of some kind nobody else will try and claim the
preallocated inode numbers.

> =A0i want to =A0prepare new inodes to the session in
> handle_client_stat,can i do that? in other words, should i allocate
> inodes when client mounted on the ceph cluster?
I'm not quite sure what you're saying -- you want to allocate a new
inode when the client does a stat? Generally whatever you want to do
you should try and reuse the existing machinery to prevent code
replication...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
