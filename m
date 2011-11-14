From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph and ext4
Date: Mon, 14 Nov 2011 12:08:41 -0800
Message-ID: <CAF3hT9BVUiu0KUE2N4mNORA1P6HWurbU9xn_B-7=u5Z_O=ujRg@mail.gmail.com>
References: <4EC10664.1080501@tuxadero.com>
	<CAMvP8PAuBbG_hcgjD+WJGRFo=p59Um3HAAoRN5zjuRPWjsLh1A@mail.gmail.com>
	<4EC118A1.1030008@tuxadero.com>
	<CAF3hT9APJBfjqfkKd_r3-vydtC0B2EHx2aG1OGwipmF-B+mdZg@mail.gmail.com>
	<Pine.LNX.4.64.1111141157500.29742@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab1KNUIm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 15:08:42 -0500
Received: by iage36 with SMTP id e36so7588752iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 12:08:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1111141157500.29742@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Martin Mailand <martin@tuxadero.com>, Tomasz Paszkowski <ss7pro@gmail.com>, ceph-devel@vger.kernel.org

On Mon, Nov 14, 2011 at 12:03 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 14 Nov 2011, Gregory Farnum wrote:
>> On Mon, Nov 14, 2011 at 5:33 AM, Martin Mailand <martin@tuxadero.com=
> wrote:
>> > Hi Tomasz,
>> > as far as I know it still has this limit.
>> > But it should be relatively safe to use it.
>> >
>> > http://marc.info/?l=3Dceph-devel&m=3D131942130322957&w=3D2
>> >
>> > If we hit the 4KB limit of xattrs in ext4 how does it show up in t=
he rbd
>> > layer?
>> >
>> > How does it show up in the fs layer, would the fs still be clean?
>>
>> Right now it would show up very badly, unfortunately. (And yes, the
>> limit is still there.) You'd notice, though you might manage to
>> corrupt some of your data first. :/
>
> Well, the osd's are now more careful about being fail-stop, so if the=
y hit
> the xattr limit they crash. =A0So there won't be data corruption per =
se,
> except that you won't be able to start the OSD up again because the
> journal replay will keep hitting the limit.
Is that even merged for .38? I don't think anybody will get that until
our current master becomes .39...
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
