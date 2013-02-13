From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: OSD failure on start
Date: Wed, 13 Feb 2013 14:47:24 -0800
Message-ID: <CA+jddaNnTAnKjXjivSugHrErfUbS03xGkfrJU6ET5Pc566ogSw@mail.gmail.com>
References: <CA+jddaPFHhwvyA73BA=58b=MMkF8me5WeSm0LcThp9XLho=k7A@mail.gmail.com>
	<511C0EE7.3090809@scholarstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48589 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965005Ab3BMW6Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 17:58:16 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so1351490lbb.12
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 14:58:14 -0800 (PST)
In-Reply-To: <511C0EE7.3090809@scholarstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@scholarstack.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks.  I'm glad to hear it is fixed in new version.  Wiping the OSD worked.

On Wed, Feb 13, 2013 at 2:08 PM, Mike Dawson
<mike.dawson@scholarstack.com> wrote:
> Mandell,
>
> A few of us saw a similar failure on 0.56.1.
>
> http://tracker.ceph.com/issues/3770
>
> Sam Just patched the issue for 0.56.2. My understanding is Sam's patch
> prevents the issue in the future, but doesn't repair a previously damaged
> OSD.
>
> If you have good replication (or a good backup), I have had luck removing
> the affected OSD, formatting, and re-adding it. I believe Sam may have a
> manual process to fix it if you can't wipe this OSD.
>
> Good Luck,
> Mike
>
>
>
> On 2/13/2013 2:57 PM, Mandell Degerness wrote:
>>
>> I'm getting this error on one of my OSD's when I try to start it.
>>
>> I can gather more complete log data if no-one recognizes the error from
>> this:
>>
>> Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.612847
>> 7f4f607e7780  0 filestore(/mnt/osd96) mount found snaps <>
>> Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.615147
>> 7f4f607e7780  0 filestore(/mnt/osd96) mount: enabling WRITEAHEAD
>> journal mode: btrfs not detected
>> Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.658965
>> 7f4f607e7780  1 journal _open /mnt/osd96/journal fd 30: 8589934592
>> bytes, block size 4096 bytes, directio = 1, aio = 0
>> Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.720091
>> 7f4f607e7780  1 journal _open /mnt/osd96/journal fd 30: 8589934592
>> bytes, block size 4096 bytes, directio = 1, aio = 0
>> Feb 13 19:30:04 node-192-168-8-14 ceph-osd: 2013-02-13 19:30:04.721871
>> 7f4f607e7780 -1 osd/OSD.cc: In function 'OSDMapRef
>> OSD::get_map(epoch_t)' thread 7f4f607e7780 time 2013-02-13
>> 19:30:04.721278
>> osd/OSD.cc: 4029: FAILED assert(_get_map_bl(epoch, bl))
>>
>>   ceph version 0.48.1argonaut
>> (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>>   1: (OSD::get_map(unsigned int)+0x560) [0x7f4f60a411e0]
>>   2: (OSD::init()+0x5a3) [0x7f4f60a53ce3]
>>   3: (main()+0x4462) [0x7f4f6096d182]
>>   4: (__libc_start_main()+0xfd) [0x7f4f5e64b26d]
>>   5: (()+0x16e829) [0x7f4f60968829]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>> Feb 13 19:30:04 node-192-168-8-14 ceph-osd: --- begin dump of recent
>> events ---
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
