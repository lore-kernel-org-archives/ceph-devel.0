From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: on disk encryption
Date: Thu, 31 Jan 2013 16:04:29 -0800
Message-ID: <510B068D.8000706@inktank.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net> <CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com> <50C5A894.8020507@ubuntu.com> <6EACA8977B8949FE9A17B74B37772B4A@inktank.com> <50FF0478.7020702@ubuntu.com> <alpine.DEB.2.00.1301221603360.17154@cobra.newdream.net> <CALFpzo5WBnRa=LTVqnqo+iG4FziyCxJxjYVp=tvE=aYJEBw4zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49012 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab3BAAEa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 19:04:30 -0500
Received: by mail-pb0-f46.google.com with SMTP id mc17so1859243pbc.5
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 16:04:30 -0800 (PST)
In-Reply-To: <CALFpzo5WBnRa=LTVqnqo+iG4FziyCxJxjYVp=tvE=aYJEBw4zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: Sage Weil <sage@inktank.com>, James Page <james.page@ubuntu.com>, Gregory Farnum <greg@inktank.com>, Peter Reiher <reiher@inktank.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, ceph-devel@vger.kernel.org

Correct.

I wasn't actually involved in this (or any other real) work,
but as I recall the only real trick is how much key management
you want:

   Do we want to be able to recover the key if a good disk
   is rescued from a destroyed server and added to a new
   server?

   Do we want to ensure that the keys are not persisted on
   the server, so that an entire server can be decommissioned
   without having to worry about the data being recovered
   by somebody who knows where to look?

If you are willing to keep the key on the server and lose
the data when the server fails, this is trivial.  If you
are unwilling to keep the key on the server, or if you need
the disk to remain readable after the server is lost, we
need some third party (like the monitors) to maintain the
keys.

We thought these might be important, so we were looking
at how to get the monitors to keep track of the encryption
keys.

On 01/31/2013 03:42 PM, Marcus Sorensen wrote:
> Yes, anyone could do this now by setting up the OSDs on top of
> dm-crypted disks, correct? This would just automate the process, and
> manage keys for us?

