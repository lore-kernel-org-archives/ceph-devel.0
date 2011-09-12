From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve qemu-img conversion performance
Date: Mon, 12 Sep 2011 00:42:52 -0700
Message-ID: <CAC-hyiFbQYq_PVcKAELRos4vXTD+OmMhYaQp=B_bjY3ZXoh7Kg@mail.gmail.com>
References: <cover.1315436097.git.yehuda@hq.newdream.net>
	<4E68CD7E.2050704@redhat.com>
	<Pine.LNX.4.64.1109080933150.9266@cobra.newdream.net>
	<4E69CBDB.1000401@redhat.com>
	<Pine.LNX.4.64.1109112004390.25151@cobra.newdream.net>
	<CAC-hyiHKmD9_z69XxRUE_3iZ--Vnb+q2B8kwQ985PHZP_2_jZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60199 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1ILHmx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2011 03:42:53 -0400
Received: by fxe4 with SMTP id 4so662999fxe.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2011 00:42:52 -0700 (PDT)
In-Reply-To: <CAC-hyiHKmD9_z69XxRUE_3iZ--Vnb+q2B8kwQ985PHZP_2_jZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On Sun, Sep 11, 2011 at 8:17 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Sun, Sep 11, 2011 at 8:14 PM, Sage Weil <sage@newdream.net> wrote:
>> On Fri, 9 Sep 2011, Kevin Wolf wrote:
>>> Am 08.09.2011 18:36, schrieb Sage Weil:
>>> > On Thu, 8 Sep 2011, Kevin Wolf wrote:
>>> >> Am 08.09.2011 01:06, schrieb Yehuda Sadeh:
>>> >>> The following set of patches improve the qemu-img conversion pr=
ocess
>>> >>> performance. When using a higher latency backend, small writes =
have a
>>> >>> severe impact on the time it takes to do image conversion.
>>> >>> We switch to using async writes, and we avoid splitting writes =
due to
>>> >>> holes when the holes are small enough.
>>> >>>
>>> >>> Yehuda Sadeh (2):
>>> >>> =A0 qemu-img: async write to block device when converting image
>>> >>> =A0 qemu-img: don't skip writing small holes
>>> >>>
>>> >>> =A0qemu-img.c | =A0 34 +++++++++++++++++++++++++++-------
>>> >>> =A01 files changed, 27 insertions(+), 7 deletions(-)
>>> >>>
>>> >>
>>> >> This doesn't seem to be against git master or the block tree. Pl=
ease rebase.
>>> >>
>>> >> I think that commit a22f123c may obsolete your patch 2/2.
>>> >
>>> > With git.kernel.org down, where should I be looking for the lates=
t
>>> > upstream?
>>>
>>> qemu has never been on kernel.org. The interesting repositories for=
 you are:
>>>
>>> * Upstream: git://git.qemu.org/qemu.git master
>>> * Block development branch: git://repo.or.cz/qemu/kevin.git block
>>
>> Oh right. =A0I've been working from qemu-kvm.git.
>>
>> I've done some (still minimal) testing, and it looks like the combin=
ation
>> of a22f123c and the new writeback/flush stuff in librbd gets the sam=
e
>> result as doing async io explicitly from qemu-img.c. =A0Want to take=
 a look,
>> Yehuda? =A0It still defaults to off, so you'll need to add
>> rbd_writeback_window=3D8000000 or similar to the rbd device string.
>>
>
> I'll take a look. I do have a rebased version for the qemu-img async
> patch, and I think qemu can benefit from that anyway.
>
I tested latest librbd with 8k rbd_writeback_window against Kevin's
block branch and it seems that the conversion performance surpasses
what I had seen with my qemu-img changes.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
