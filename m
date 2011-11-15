From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: ceph and ext4
Date: Tue, 15 Nov 2011 10:43:58 -0800
Message-ID: <CAC-hyiH9pUOhyxJXa0Nmig=hT5v3O04gZvoeWv0xOhDTzzSdyQ@mail.gmail.com>
References: <4EC10664.1080501@tuxadero.com>
	<CAO47_-9nfO32nwOAQMVdqw6iWGWK+FWb+MD=WeOz_vr4YrrKmw@mail.gmail.com>
	<20111115142246.GA7516@thunk.org>
	<246EA1CC-3C33-4D41-80C0-2331C426EBB0@whamcloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48207 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144Ab1KOSn7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 13:43:59 -0500
In-Reply-To: <246EA1CC-3C33-4D41-80C0-2331C426EBB0@whamcloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger@whamcloud.com>, Christian Brunner <chb@muc.de>, Martin Mailand <martin@tuxadero.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Jian Yu <yujian@whamcloud.com>

On Tue, Nov 15, 2011 at 8:43 AM, Andreas Dilger <adilger@whamcloud.com> wrote:
> Coincidentally, we have someone working in those patches again. The main obstacle for accepting the previous patch as-is was that Ted wanted to add support for "medium-sized" xattrs that are addressed as a string of blocks, instead of via an inode.
>
> This will allow xattrs up to 64kB in size (in total) to be stored as efficiently as an external xattr block.
>

Ted, is having that is a hard requirement? Can this
functionality/optimization be added later so that we can leverage ext4
in the mean time, even if not in the most optimal way?

Thanks,
Yehuda
