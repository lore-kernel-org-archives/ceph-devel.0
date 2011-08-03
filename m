From: Christian Brunner <chb@muc.de>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Wed, 3 Aug 2011 16:16:55 +0200
Message-ID: <CAO47_-9DmxqfBsBF2K_8ScX_4d-HPz01QeQ-2FFwZS-nCDEOsw@mail.gmail.com>
References: <4E33D101.1050504@ufm.su>
	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
	<4E3432FC.9030204@ufm.su>
	<20110730165001.GI7361@thunk.org>
	<Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>
	<20110730221900.GK7361@thunk.org>
	<Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net>
	<4E353D9E.5080802@ufm.su>
	<Pine.LNX.4.64.1107310951550.2348@cobra.newdream.net>
	<4E35B833.6070304@ufm.su>
	<Pine.LNX.4.64.1107311339530.23447@cobra.newdream.net>
	<80E3795B-C981-492F-9312-DC91D57E4017@mit.edu>
	<Pine.LNX.4.64.1108010918580.6290@cobra.newdream.net>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63519 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab1HCOQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2011 10:16:56 -0400
Received: by qyk38 with SMTP id 38so181324qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2011 07:16:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108010918580.6290@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Theodore Tso <tytso@mit.edu>, Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

2011/8/1 Sage Weil <sage@newdream.net>:
> On Mon, 1 Aug 2011, Theodore Tso wrote:
>> On Jul 31, 2011, at 4:42 PM, Sage Weil wrote:
>>
>> > This is link(2)
>> >
>> >> 2011-07-31 23:06:50.114316 7f23c048c700 filestore(/osd.0) collect=
ion_remove
>> >> temp/10000000483.000005d6/head =3D 0
>> >
>> > This is unlink(2)
>> >
>> >> 2011-07-31 23:06:50.114384 7f23c048c700 filestore(/osd.0) setattr=
s
>> >> 0.69_head/10000000483.000005d6/head '_' len 161 =3D 161
>> >
>> > The xattr names are prefixed with 'user.ceph.'
>> >
>> >> 2011-07-31 23:06:50.114406 7f23c048c700 filestore(/osd.0) setattr=
s
>> >> 0.69_head/10000000483.000005d6/head 'snapset' len 26 =3D 26
>> >> 2011-07-31 23:06:50.114413 7f23c048c700 filestore(/osd.0) setattr=
s
>> >> 0.69_head/10000000483.000005d6/head =3D 26
>> >
>> > Does that tell you what to need, Ted?
>>
>> So let me make sure I understand what happened. =A0Ceph made sure no=
 file existed with this name, and created with the first write log entr=
y:
>>
>> 2011-07-31 23:06:49.173941 7f23c048c700 filestore(/osd.0) write temp=
/10000000483.000005d6/head 0~1048576 =3D 1048576
>
> The fd was actually closed here.
>
>> It then linked it into this directory:
>>
>> 2011-07-31 23:06:50.114287 7f23c048c700 filestore(/osd.0) collection=
_add 0.69_head/10000000483.000005d6/head temp/10000000483.000005d6/head=
 =3D 0
>>
>> ? and removed it from the temp directory:
>>
>> 2011-07-31 23:06:50.114316 7f23c048c700 filestore(/osd.0) collection=
_remove temp/10000000483.000005d6/head =3D 0
>>
>> and then created three inodes that totaled approximately 240 bytes i=
n length or so (including the name and headers)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xattrs
>>
>> 2011-07-31 23:06:50.114384 7f23c048c700 filestore(/osd.0) setattrs 0=
=2E69_head/10000000483.000005d6/head '_' len 161 =3D 161
>> 2011-07-31 23:06:50.114406 7f23c048c700 filestore(/osd.0) setattrs 0=
=2E69_head/10000000483.000005d6/head 'snapset' len 26 =3D 26
>> 2011-07-31 23:06:50.114413 7f23c048c700 filestore(/osd.0) setattrs 0=
=2E69_head/10000000483.000005d6/head =3D 26
>>
>> ? and then presumably the file was closed and that would have been t=
he
>> end of this file being touched by ceph, correct?
>
> Yep!

I tried to reproduce this without ceph, but wasn't able to...

In the meantime it seams, that I can also see the side effects on the
librbd side: I get an "librbd: data error!" when I do an "rbd copy".

When I look at the librbd code this is related to a sparse_read not
returning the right size of the object.

I don't know if it helps, but I think that the problem is also related
to sparse file usage.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
