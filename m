From: Erwan Velu <evelu@redhat.com>
Subject: Re: New messages in OSD logs.
Date: Wed, 20 Apr 2016 04:47:43 -0400 (EDT)
Message-ID: <2067877477.80383590.1461142063409.JavaMail.zimbra@redhat.com>
References: <57121CDE.3010908@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:48114 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933014AbcDTIrr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2016 04:47:47 -0400
In-Reply-To: <57121CDE.3010908@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I have the exact same trace while running a test on teuthology.

----- Mail original -----
De: "Willem Jan Withagen" <wjw@digiware.nl>
=C3=80: "Ceph Development" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Samedi 16 Avril 2016 13:07:10
Objet: New messages in OSD logs.

Hi

I've recently rebased my fork, and also upgrae FreeBSD to more recent c=
ode.
Now I'm running into this:

2016-04-16 03:03:55.891466 805617000 -1
filestore(testdir/test-erasure-eio/0) WARNING: max attr value size (102=
4)
is smaller than osd_max_object_name_len (2048). Your backend filesystem
appears to not support attrs large enough
to handle the configured max rados name size. You may get unexpected
ENAMETOOLONG errors on rados operations or buggy behavior

and later on:

2016-04-16 03:04:03.287073 805617000  2 osd.0 0 boot
2016-04-16 03:04:03.287846 805617000 -1 osd.0 0 backend (filestore) is=20
unable to support max object name[space] le
n
2016-04-16 03:04:03.287873 805617000 -1 osd.0 0    osd max object name=20
len =3D 2048
2016-04-16 03:04:03.287894 805617000 -1 osd.0 0    osd max object=20
namespace len =3D 256
2016-04-16 03:04:03.287931 805617000 -1 osd.0 0 (63) File name too long
2016-04-16 03:04:03.303432 805617000  1 journal close=20
testdir/test-erasure-eio/0/journal
2016-04-16 03:04:03.310280 805617000 -1 ^[[0;31m ** ERROR: osd init=20
failed: (63) File name too long^[[0m

And the OSD dies....

I guess that this has the do with the changes in the LFN modules, and i=
s=20
also the reason for the debate about ext4 support.

Uptill now unittest_chain_xattr did work, but that now also fails.
But it fails in a strange way where it tries to delete attributes with=20
numerical ends that are certainly not in the attributes.
Maximum xattr name length in FreeBSD seems to be 256 chars, which wasn'=
t=20
a problem yet.

So is there any chance of continuing on my "old" way to finish a first=20
version of the port?

Or am I just seeing things, and should I start looking at the FreeBSD=20
side of things?


Thanx,
--WjW
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
