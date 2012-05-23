From: Frank <frankwoo.scc@gmail.com>
Subject: I have some problem to mount ceph file system
Date: Wed, 23 May 2012 08:51:56 +0000 (UTC)
Message-ID: <loom.20120523T104810-478@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60918 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab2EWIzK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 May 2012 04:55:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SX7LV-0000NA-6a
	for ceph-devel@vger.kernel.org; Wed, 23 May 2012 10:55:06 +0200
Received: from 61-222-86-99.HINET-IP.hinet.net ([61.222.86.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 10:55:05 +0200
Received: from frankwoo.scc by 61-222-86-99.HINET-IP.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 10:55:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello=20
I have a question about ceph.

When I mount ceph, I do the command as follow :

# mount -t ceph -o name=3Dadmin,secret=3DXXXXXX 10.1.0.1:6789/ /mnt/cep=
h -vv

now I create an user "foo" and make a secretkey by ceph-authtool like t=
hat :

# ceph-authtool /etc/ceph/keyring.bin -n client.foo --gen-key

then I add the key into ceph :

# ceph auth add client.foo osd 'allow *' mon 'allow *' mds 'allow' -i=20
/etc/ceph/keyring.bin

so i can mount ceph by foo :

# mount -t ceph -o name=3Dfoo,secret=3DXOXOXO 10.1.0.1:6789/ /mnt/ceph =
-vv

my question is if i don't want "foo" that has permission to mount 10.1.=
0.1:6789/

HOW TO DO IT=EF=BC=9F

if there is a directory "foo"

I want he can mount 10.1.0.1:6789:/foo/

but have no access to mount 10.1.0.1:6789:/


Thanks,
=46rank

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
