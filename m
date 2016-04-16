From: Willem Jan Withagen <wjw@digiware.nl>
Subject: New messages in OSD logs.
Date: Sat, 16 Apr 2016 13:07:10 +0200
Message-ID: <57121CDE.3010908@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:36109 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbcDQVLt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Apr 2016 17:11:49 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 31A1E153413
	for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2016 13:07:21 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:51ec:1a56:1f68:b050] (unknown [IPv6:2001:4cb8:3:1:51ec:1a56:1f68:b050])
	by smtp.digiware.nl (Postfix) with ESMTP id 1AC16153402
	for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2016 13:07:20 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

I've recently rebased my fork, and also upgrae FreeBSD to more recent code.
Now I'm running into this:

2016-04-16 03:03:55.891466 805617000 -1
filestore(testdir/test-erasure-eio/0) WARNING: max attr value size (1024)
is smaller than osd_max_object_name_len (2048). Your backend filesystem
appears to not support attrs large enough
to handle the configured max rados name size. You may get unexpected
ENAMETOOLONG errors on rados operations or buggy behavior

and later on:

2016-04-16 03:04:03.287073 805617000  2 osd.0 0 boot
2016-04-16 03:04:03.287846 805617000 -1 osd.0 0 backend (filestore) is 
unable to support max object name[space] le
n
2016-04-16 03:04:03.287873 805617000 -1 osd.0 0    osd max object name 
len = 2048
2016-04-16 03:04:03.287894 805617000 -1 osd.0 0    osd max object 
namespace len = 256
2016-04-16 03:04:03.287931 805617000 -1 osd.0 0 (63) File name too long
2016-04-16 03:04:03.303432 805617000  1 journal close 
testdir/test-erasure-eio/0/journal
2016-04-16 03:04:03.310280 805617000 -1 ^[[0;31m ** ERROR: osd init 
failed: (63) File name too long^[[0m

And the OSD dies....

I guess that this has the do with the changes in the LFN modules, and is 
also the reason for the debate about ext4 support.

Uptill now unittest_chain_xattr did work, but that now also fails.
But it fails in a strange way where it tries to delete attributes with 
numerical ends that are certainly not in the attributes.
Maximum xattr name length in FreeBSD seems to be 256 chars, which wasn't 
a problem yet.

So is there any chance of continuing on my "old" way to finish a first 
version of the port?

Or am I just seeing things, and should I start looking at the FreeBSD 
side of things?


Thanx,
--WjW
