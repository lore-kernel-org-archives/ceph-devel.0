From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: qemu librbd patches
Date: Tue, 10 May 2011 01:29:58 -0700
Message-ID: <BANLkTimMy1sUH18iyCmBxJFtm8KCzuGZ3w@mail.gmail.com>
References: <BANLkTim4jTVJH5y6o5rHq8pm_KfH0Jiz0w@mail.gmail.com>
	<b8e9ad3a8d7059ac8be7592fe18b38c8@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56899 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab1EJIaA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 04:30:00 -0400
Received: by bwz15 with SMTP id 15so4631223bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 01:29:58 -0700 (PDT)
In-Reply-To: <b8e9ad3a8d7059ac8be7592fe18b38c8@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: chb@muc.de, ceph-devel@vger.kernel.org

On Mon, May 9, 2011 at 8:22 AM, Josh Durgin <josh.durgin@dreamhost.com> wrote:
> On Mon, 9 May 2011 10:59:41 +0200, Christian Brunner <chb@muc.de>
> wrote:
>> Hi,
>>
>> after upgrading to qemu with josh's librbd patches I'm triggering the
>> following assertion, when I'm running "yum upgrade" inside a guest.
>>
>> I suspect there is a race condition somewhere, but I don't have a clue
>> at the moment.
>
> This is similar to a race condition Stefan encountered
> (http://marc.info/?l=kvm&m=130225223223016&w=2),
> although this crash was during a write whereas his test was just
> reading the image.
>
>>
>> Regards,
>> Christian
>>
>> common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread
>> '0x7fea16b36700'
>> common/Mutex.h: 118: FAILED assert(r == 0)
>
> Usually this assert fails due to a use-after-free. If you've got
> a core file, could you print the lock that hit this assert and
> the data structure containing it?

Btw, probably not related but should be pointed out. There are a few
places in librbd where it fails to take the image context lock, and
it's probably racy. It's probably a big problem when resizing image,
but there might be other issues.

Yehuda
