From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Mon, 1 Aug 2011 06:53:49 -0400
Message-ID: <80E3795B-C981-492F-9312-DC91D57E4017@mit.edu>
References: <4E33D101.1050504@ufm.su> <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu> <4E3432FC.9030204@ufm.su> <20110730165001.GI7361@thunk.org> <Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net> <20110730221900.GK7361@thunk.org> <Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net> <4E353D9E.5080802@ufm.su> <Pine.LNX.4.64.1107310951550.2348@cobra.newdream.net> <4E35B833.6070304@ufm.su> <Pine.LNX.4.64.1107311339530.23447@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:55446 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752242Ab1HAKxx convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Aug 2011 06:53:53 -0400
In-Reply-To: <Pine.LNX.4.64.1107311339530.23447@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org


On Jul 31, 2011, at 4:42 PM, Sage Weil wrote:

> This is link(2)
>=20
>> 2011-07-31 23:06:50.114316 7f23c048c700 filestore(/osd.0) collection=
_remove
>> temp/10000000483.000005d6/head =3D 0
>=20
> This is unlink(2)
>=20
>> 2011-07-31 23:06:50.114384 7f23c048c700 filestore(/osd.0) setattrs
>> 0.69_head/10000000483.000005d6/head '_' len 161 =3D 161
>=20
> The xattr names are prefixed with 'user.ceph.'
>=20
>> 2011-07-31 23:06:50.114406 7f23c048c700 filestore(/osd.0) setattrs
>> 0.69_head/10000000483.000005d6/head 'snapset' len 26 =3D 26
>> 2011-07-31 23:06:50.114413 7f23c048c700 filestore(/osd.0) setattrs
>> 0.69_head/10000000483.000005d6/head =3D 26
>=20
> Does that tell you what to need, Ted?

So let me make sure I understand what happened.  Ceph made sure no file=
 existed with this name, and created with the first write log entry:

2011-07-31 23:06:49.173941 7f23c048c700 filestore(/osd.0) write temp/10=
000000483.000005d6/head 0~1048576 =3D 1048576

It then linked it into this directory:

2011-07-31 23:06:50.114287 7f23c048c700 filestore(/osd.0) collection_ad=
d 0.69_head/10000000483.000005d6/head temp/10000000483.000005d6/head =3D=
 0

=85 and removed it from the temp directory:

2011-07-31 23:06:50.114316 7f23c048c700 filestore(/osd.0) collection_re=
move temp/10000000483.000005d6/head =3D 0

and then created three inodes that totaled approximately 240 bytes in l=
ength or so (including the name and headers)

2011-07-31 23:06:50.114384 7f23c048c700 filestore(/osd.0) setattrs 0.69=
_head/10000000483.000005d6/head '_' len 161 =3D 161
2011-07-31 23:06:50.114406 7f23c048c700 filestore(/osd.0) setattrs 0.69=
_head/10000000483.000005d6/head 'snapset' len 26 =3D 26
2011-07-31 23:06:50.114413 7f23c048c700 filestore(/osd.0) setattrs 0.69=
_head/10000000483.000005d6/head =3D 26

=85 and then presumably the file was closed and that would have been th=
e end of this file being touched by ceph, correct?

Thanks!!

-- Ted--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
