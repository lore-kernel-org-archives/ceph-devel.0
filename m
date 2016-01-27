From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: osd dm-crypt key management, part... deux?
Date: Wed, 27 Jan 2016 16:17:16 +0100
Message-ID: <CA+H5UW3vtjzvYZxd=0LZ8xYCCon7CGJg_GwjvFaBtXTepFdXZg@mail.gmail.com>
References: <alpine.DEB.2.11.1601262106390.6524@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38459 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282AbcA0PRR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 10:17:17 -0500
Received: by mail-wm0-f50.google.com with SMTP id p63so31338026wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 07:17:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601262106390.6524@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jan 27, 2016 at 3:26 PM, Sage Weil <sweil@redhat.com> wrote:

> 2- Implement a simple mon-based strategy upstream.  We've discussed this a
> fair bit in the past, and were getting stuck on the problem of where to
> store the key-fetching-key.  I.e., we want a key on the disk that you use
> to ask the monitor for the LUKS key, which you then provide to LUKS to
> unlock the actual encryption key.  This means that we need a unencrypted
> spot on the device to store it in.  Milan has indicated that putting it in
> a LUKS key slot would be a bad idea and difficult to maintain.  Instead, I
> propose we create a new GPT partition type called OSD_LOCKBOX (or
> similar), with a tiny filesystem and a few files indicating what to do.
> This will make it easy to store the info we need for the mon scheme, and
> to support new key management approaches later (we can put whatever we
> want there as long as it's not too big).
>
> I put some notes here:
>
>         http://pad.ceph.com/p/osd-key-management
>
> Thoughts?
> sage

Hello Sage,

why we cannot simply fetch the LUKS key from a monitor during
the mount phase? LUKS key wouldn't be stored in any file. Instead,
it would be fetched to memory (RAM) and present there only for
time necessary to initialize dm-crypt.

Of course, code responsible for the setup must have an access to
the OSD's keyring. It may be put into lockbox.

Regards,
Radek
