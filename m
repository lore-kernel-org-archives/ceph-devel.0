From: Jeff Layton <jlayton@redhat.com>
Subject: new statx() like interface for libcephfs
Date: Tue, 28 Jun 2016 14:17:05 -0400
Message-ID: <1467137825.32374.29.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36066 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbcF1SRJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 14:17:09 -0400
Received: by mail-qk0-f170.google.com with SMTP id z142so20648664qkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 11:17:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, Ganesha NFS List <nfs-ganesha-devel@lists.sourceforge.net>, David Howells <dhowells@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I have a patchset queued up for ceph that adds btime (birthtime)
support to it. What was lacking though was a mechanism to get the btime
out of the inode.

Rather than cook up a brand new interface just for the btime, I decided
to "borrow" the work that David Howells did with the new proposed
statx() interface. The pull request to add this to ceph is up here:

=C2=A0 =C2=A0 =C2=A0https://github.com/ceph/ceph/pull/9965

Sage has already closed it out which I take to mean that he has pulled
the patches into a staging branch for eventual merge.

It occurs to me though that I didn't ask anyone who is working on the
samba vfs or ganesha fsal code whether they think this interface is
acceptable.

Since Samba and Ganesha are the targeted users of this interface, it'd
be good to have developers from both communities take a look and see if
there are any problems here.

Does anyone see any issues with the above pull request?
--=20
Jeff Layton <jlayton@redhat.com>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
