From: Greg Farnum <greg@inktank.com>
Subject: CephFS First product release discussion
Date: Tue, 5 Mar 2013 09:03:15 -0800
Message-ID: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:34675 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab3CERDV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 12:03:21 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so32800daj.8
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 09:03:20 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, "=?utf-8?Q?ceph-users=40lists.ceph.com?=" <ceph-users@lists.ceph.com>

This is a companion discussion to the blog post at http://ceph.com/dev-=
notes/cephfs-mds-status-discussion/ =E2=80=94 go read that!

The short and slightly alternate version: I spent most of about two wee=
ks working on bugs related to snapshots in the MDS, and we started real=
izing that we could probably do our first supported release of CephFS a=
nd the related infrastructure much sooner if we didn't need to support =
all of the whizbang features. (This isn't to say that the base feature =
set is stable now, but it's much closer than when you turn on some of t=
he other things.) I'd like to get feedback from you in the community on=
 what minimum supported feature set would prompt or allow you to start =
using CephFS in real environments =E2=80=94 not what you'd *like* to se=
e, but what you *need* to see. This will allow us at Inktank to priorit=
ize more effectively and hopefully get out a supported release much mor=
e quickly! :)

The current proposed feature set is basically what's left over after we=
've trimmed off everything we can think to split off, but if any of the=
 proposed included features are also particularly important or don't ma=
tter, be sure to mention them (NFS export in particular =E2=80=94 it wo=
rks right now but isn't in great shape due to NFS filehandle caching).

Thanks,
-Greg

Software Engineer #42 @ http://inktank.com | http://ceph.com =20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
