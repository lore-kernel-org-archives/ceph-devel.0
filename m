From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Questions about ceph OSD
Date: Tue, 2 Nov 2010 14:49:58 +0800
Message-ID: <1288680598.2366.253.camel@osd1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:60632 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752933Ab0KBGtw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Nov 2010 02:49:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net, ceph-devel@vger.kernel.org

Hi ,

I have recently been working the preliminary research whether ceph=20
can use at our cloud computing storage system in the future ,
ceph is a very very excellent file system.But ,Now ,i hit a very
important problem for us:

Normally, as ceph described , all of the data are saved at OSDs with
CRUSHMAP at ceph system.

but my goal is to :
1. add a ext3 disk to ceph system ,but doesn't set it as a OSD;
2. save the normal data at the OSDs of a ceph system;
3. save the special data to a local ext3 disk at a ceph system,
   the ext3 disk is not set as a ceph OSD,but its infos are added to=20
  MDS and  MON,when Write the special data at a ceph client ,these
special data are not saved to ceph server OSDs ,but saved at the local
ext3 disk.

like this:
At ceph client:
$ mount.ceph 1.2.3.4:6789:/ /ceph
$ cd /ceph
$ ls
cloud user secret =20

when do writing,"cloud and user" folder data are saved to ceph OSDs ,
but "secret" folder data are saved to a local ext3 disk .

My question is:
Q1- If i add a new OSD to the ceph system ,but i do a special CRUSH
placement map . Could this ways solved this problem ?,If can ,How ?

Q2 - If to implement this function as a patch myself, Could you give me
any ideas ? or what parts of ceph codes(server/client) that i need look
into ?=20

Thanks for all help and reply .


Jeff.Wu
Transoft.inc ,Sr.software engineer.
=E3=80=80=E3=80=80




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
