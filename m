From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: 'rbd map' asynchronous behavior
Date: Wed, 16 May 2012 12:24:34 +0400
Message-ID: <CABYiri8Z8vnNBwsP=maLc9f9ope45v7CFxHo5hZ6_5SbCYfDSA@mail.gmail.com>
References: <CABYiri-Whv7tGLVb-AcwMKcA1=iMTyguOYokg2xKt9r6hzKRuQ@mail.gmail.com>
 <4FB278D3.1020908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35807 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab2EPIY4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 04:24:56 -0400
Received: by wgbdr13 with SMTP id dr13so450760wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 01:24:54 -0700 (PDT)
In-Reply-To: <4FB278D3.1020908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

>This is most likely due to a recently-fixed problem.
>The fix is found in this commit, although there were
>other changes that led up to it:
>   32eec68d2f   rbd: don't drop the rbd_id too early
>It is present starting in Linux kernel 3.3; it appears
>you are running 2.6?

Nope, it`s just Debian kernel naming - they continue to name 3.x with
2.6 and I`m following them at own build naming. I have tried that on
3.2 first time, and just a couple of minutes ago on my notebook with
3.3.4 over relatively slow vpn connection - rbd failed with almost
same backtrace(I have removed sleep from cycle and bug has been
reproduce immediately after first map-unmap) and kernel has panicked
after approx. four minutes when I stopped 'for...' execution,
unfortunately no bt of panic because of X and lack of configured
netconsole :) The symptoms are the same - 'rbd showmapped' shows
latest volume, but unmap failed with 'xxx is not a block device remove
failed: (22) Invalid argument' and a couple of 'null pointer
dereference' messages in dmesg. I have used /dev/rbd0 instead of
symlinks to reduce probability of involving udev-related timeout on
symlinks creation.

On Tue, May 15, 2012 at 7:40 PM, Josh Durgin <josh.durgin@inktank.com> =
wrote:
> On 05/15/2012 04:49 AM, Andrey Korolyov wrote:
>>
>> Hi,
>>
>> There are strange bug when I tried to map excessive amounts of block
>> devices inside the pool, like following
>>
>> for vol in $(rbd ls); do rbd map $vol; [some-microsleep]; [some
>> operation or nothing, I have stubbed guestfs mount here] ;
>> [some-microsleep]; =C2=A0unmap /dev/rbd/rbd/$vol ; [some-microsleep]=
; done,
>>
>> udev or rbd seems to be somehow late and mapping fails. There is no
>> real-world harm at all, and such case can be easily avoided, but on
>> busy cluster timeout increases and I was able to catch same thing on
>> two-osd config in recovering state. For 0.1 second on healthy cluste=
r,
>> all works okay, for 0.05 it may fail with following trace(just for m=
e,
>> because I am testing on relatively old and crappy hardware, so other=
s
>> may catch that on smaller intervals):
>
>
> udev is asynchronous by nature. The rbd tool itself doesn't wait for
> /dev to be populated because you may not be using the default udev ru=
le
> (or not using udev at all). Our test framework polls for the device t=
o
> make sure 'rbd map' and udev completed:
>
> https://github.com/ceph/teuthology/blob/d6b9bd8b63c8c6c1181ece1f69418=
29d8d1d5152/teuthology/task/rbd.py#L190
>
> Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
