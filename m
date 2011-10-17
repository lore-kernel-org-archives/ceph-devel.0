From: Christian Brunner <chb@muc.de>
Subject: Re: OSD blocked for more than 120 seconds
Date: Mon, 17 Oct 2011 20:24:04 +0200
Message-ID: <CAO47_-_8UB0rNV81b36x2iCMQM7XWK1E69gi-+pbjk_ok38UAQ@mail.gmail.com>
References: <4E974C87.2070204@tuxadero.com>
	<1318585099.2999.10.camel@wido-laptop>
	<CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com>
	<4E99E68F.9090005@tuxadero.com>
	<CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com>
	<4E9C37F8.9050601@tuxadero.com>
	<Pine.LNX.4.64.1110170820040.22381@cobra.newdream.net>
	<4E9C6EAB.7070003@tuxadero.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61908 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab1JQSYF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 14:24:05 -0400
Received: by vcge1 with SMTP id e1so2282778vcg.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2011 11:24:04 -0700 (PDT)
In-Reply-To: <4E9C6EAB.7070003@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Sage Weil <sage@newdream.net>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

2011/10/17 Martin Mailand <martin@tuxadero.com>:
> Hi Sage,
> the hang was on a btrfs, I do not have a fix for that.
>
> The 'filestore flusher =3D false' does fix the ext4 problems, which w=
here
> reported from Christian, but this option has quite an impact of the o=
sd
> performance.
> The '-o noauto_da_alloc' option did not solve the fsck problem.

Thanks for testing. I'll report this back to RedHat tomorow, maybe
Eric has an idea what causes the problem in this case.

Regards,
Christian

>
> Best Regards,
> =A0Martin
>
>
> Sage Weil schrieb:
>>
>> On Mon, 17 Oct 2011, Martin Mailand wrote:
>>>
>>> Am 17.10.2011 11:40, schrieb Christian Brunner:
>>>>
>>>> Our bugreport with RedHat didn't make any progress for a long time=
,
>>>> but last week RedHat made two sugestions:
>>>>
>>>> - If you configure ceph with 'filestore flusher =3D false', do you=
 see
>>>> any different behavior?
>>>> - If you mount with -o noauto_da_alloc does it change anything?
>>>
>>> Hi,
>>> after a quick test I think 'filestore flusher =3D false' did the tr=
ick.
>>> What does it do?
>>
>> It fixes your hang (previous email), or the subsequent fsck errors?
>>
>> When filestore flusher =3D true (default), after every write the fd =
is
>> handed off to another thread that uses sync_file_range() to push the=
 data
>> out to disk quickly before closing the file. =A0The purpose is to li=
mit the
>> latency for the eventual snapshot or sync. =A0Eric suspected the han=
doff
>> between threads may be what was triggering the bug in ext4.
>>
>> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
