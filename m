From: Odintsov Vladislav <VlOdintsov@croc.ru>
Subject: Re: rgw and the next hammer release v0.94.6
Date: Thu, 4 Feb 2016 06:40:49 +0000
Message-ID: <1454568051909.92077@croc.ru>
References: <56B185DD.3050905@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ironport2.croc.moscow ([195.38.23.105]:56097 "EHLO
	ironport2.croc.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbcBDGvO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 01:51:14 -0500
In-Reply-To: <56B185DD.3050905@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi all,

there are at least two issues (backports) and related PRs for RGW for h=
ammer,
is it possible to look at them in this release (0.94.6)?


1. Make RGW_MAX_PUT_SIZE configurable
http://tracker.ceph.com/issues/14569
https://github.com/ceph/ceph/pull/7441

2. rgw: fix wrong etag calculation during POST on S3 bucket
http://tracker.ceph.com/issues/14570
https://github.com/ceph/ceph/pull/7442

It would be very good if these PRs are merged them before 0.94.6 releas=
e.
Thank you.

________________________________
Regards,

Vladislav Odintsov
System Engineer of Croc Cloud Development Team

________________________________________
=46rom: ceph-devel-owner@vger.kernel.org <ceph-devel-owner@vger.kernel.=
org> on behalf of Loic Dachary <loic@dachary.org>
Sent: Wednesday, February 3, 2016 07:45
To: Yehuda Sadeh
Cc: Ceph Development; Nathan Cutler
Subject: rgw and the next hammer release v0.94.6

Hi Yehuda,

The next hammer release as found at https://github.com/ceph/ceph/tree/h=
ammer passed the rgw suite (http://tracker.ceph.com/issues/13356#note-4=
5). Do you think the hammer branch is ready for QE to start their own r=
ound of testing ?

Cheers

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
