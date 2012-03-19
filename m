From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Mysteriously poor write performance
Date: Mon, 19 Mar 2012 16:46:50 +0300
Message-ID: <CABYiri9hcWdPv5Xs_X6S+tM6-U_uGq68pnTzetc=cVxK7NiNQg@mail.gmail.com>
References: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
 <Pine.LNX.4.64.1203181121460.580@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33678 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab2CSNrM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 09:47:12 -0400
Received: by wibhj6 with SMTP id hj6so3819686wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 06:47:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203181121460.580@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

More strangely, writing speed drops down by fifteen percent when this
option was set in vm` config(instead of result from
http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg03685.html).
As I mentioned, I`m using 0.43, but due to crashed osds, ceph has been
recompiled with e43546dee9246773ffd6877b4f9495f1ec61cd55 and
1468d95101adfad44247016a1399aab6b86708d2 - both cases caused crashes
under heavy load.

On Sun, Mar 18, 2012 at 10:22 PM, Sage Weil <sage@newdream.net> wrote:
> On Sat, 17 Mar 2012, Andrey Korolyov wrote:
>> Hi,
>>
>> I`ve did some performance tests at the following configuration:
>>
>> mon0, osd0 and mon1, osd1 - two twelve-core r410 with 32G ram, mon2 =
-
>> dom0 with three dedicated cores and 1.5G, mostly idle. First three
>> disks on each r410 arranged into raid0 and holds osd data when fourt=
h
>> holds os and osd` journal partition, all ceph-related stuff mounted =
on
>> the ext4 without barriers.
>>
>> Firstly, I`ve noticed about a difference of benchmark performance an=
d
>> write speed through rbd from small kvm instance running on one of
>> first two machines - when bench gave me about 110Mb/s, writing zeros
>> to raw block device inside vm with dd was at top speed about 45 mb/s=
,
>> for vm`fs (ext4 with default options) performance drops to ~23Mb/s.
>> Things get worse, when I`ve started second vm at second host and tri=
ed
>> to continue same dd tests simultaneously - performance fairly divide=
d
>> by half for each instance :). Enabling jumbo frames, playing with cp=
u
>> affinity for ceph and vm instances and trying different TCP congesti=
on
>> protocols gave no effect at all - with DCTCP I have slightly smoothe=
r
>> network load graph and that`s all.
>>
>> Can ml please suggest anything to try to improve performance?
>
> Can you try setting
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rbd writeback window =3D 8192000
>
> or similar, and see what kind of effect that has? =C2=A0I suspect it'=
ll speed
> up dd; I'm less sure about ext3.
>
> Thanks!
> sage
>
>
>>
>> ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
