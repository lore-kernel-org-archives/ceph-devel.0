From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Thu, 8 Mar 2012 18:28:25 -0800
Message-ID: <BE584457-833A-4812-B74B-6764D292CCB8@cs.ucsc.edu>
References: <4F516A20.8060901@cs.ucsc.edu> <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net> <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu> <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com> <E6A73CCF-3C17-42C1-BA41-33E1CADA6675@cs.ucsc.edu> <E71CA82A2DB647E193C249D30CA491A8@dreamhost.com> <4B306D7B-E017-445D-8F76-AB0EDC7B61D7@cs.ucsc.edu> <B062F95691EF4CE8AB4FC02F2727C038@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:48766 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab2CIC22 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 21:28:28 -0500
In-Reply-To: <B062F95691EF4CE8AB4FC02F2727C038@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>


On Mar 8, 2012, at 6:16 PM, Greg Farnum wrote:

>> /* Returns a configuration value as a string.
>> * If len is positive, that is the maximum number of bytes we'll writ=
e into the
>> * buffer. If len =3D=3D -1, we'll call malloc() and set *buf.
>> * Returns 0 on success, error code otherwise. Returns ENAMETOOLONG i=
f the
>> * buffer is too short. */
>=20
> Ah. Two things from that:
> 1) "If len =3D=3D -1". Which it isn't, here.
> 2) There is no voodoo, that just isn't going to work. Either it was c=
reated incorrectly in reference to md_config_t::get_val, or else code g=
ot moved around without updating that documentation. :/ Options includi=
ng char ** (as you said), char *& (ewww), or=85not doing that?
>=20
> Anybody have thoughts on the right solution?

I am partial to APIs that put the burden on the caller to free/expand t=
he buffer in response to -ENAMETOOLONG. /2cents

-Noah--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
