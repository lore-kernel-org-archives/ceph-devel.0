From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Fwd: Questions about ceph OSD
Date: Wed, 3 Nov 2010 10:18:18 +0800
Message-ID: <1288750698.2317.18.camel@osd1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VOL23pZhIldW7OpK3Vfb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:62982 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752581Ab0KCCSS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Nov 2010 22:18:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, colinm@hq.newdream.net, henry_c_chang@tcloudcomputing.com, joshd@hq.newdream.net, samuelj@hq.newdream.net
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yonggang Liu <myidpt@gmail.com>

--=-VOL23pZhIldW7OpK3Vfb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

hi,

Any ideas or suggestions about this? or , To solve this issue,i need
deeply look into what parts ceph codes ,OSD ,CRUSH ,.OSD cluster
expansion .. etc ? Thanks.


Jeff.Wu

--=-VOL23pZhIldW7OpK3Vfb
Content-Disposition: inline
Content-Description: =?gb2312?Q?=D7=AA=B7=A2=B5=C4=D0=C5=BC=FE?= -
 Questions about ceph OSD
Content-Type: message/rfc822

Received: from 263xmail.com (211.150.96.39) by MAIL.tnsoft.com.cn
 (172.16.1.2) with Microsoft SMTP Server id 8.3.106.1; Tue, 2 Nov 2010
 14:47:33 +0800
Received: from vger.kernel.org (localhost.localdomain [127.0.0.1])	by
 263xmail.com (Postfix) with ESMTP id 524AA1E91FFE;	Tue,  2 Nov 2010
 14:49:37 +0800 (CST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand	id
 S1753160Ab0KBGtx (ORCPT <rfc822;wchen@tnsoft.com.cn> + 1 other);	Tue, 2 Nov
 2010 02:49:53 -0400
Received: from [210.22.136.227] ([210.22.136.227]:60632 "EHLO
 MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org	with
 ESMTP id S1752933Ab0KBGtw (ORCPT	<rfc822;ceph-devel@vger.kernel.org>); Tue,
 2 Nov 2010 02:49:52 -0400
Received: from [172.16.10.63] (172.16.10.63) by MAIL.tnsoft.com.cn
 (172.16.1.2) with Microsoft SMTP Server id 8.3.106.1; Tue, 2 Nov 2010
 14:47:14 +0800
From: Jeff Wu <cpwu@tnsoft.com.cn>
To: "sage@newdream.net" <sage@newdream.net>, "ceph-devel@vger.kernel.org"
 <ceph-devel@vger.kernel.org>
Sender: "ceph-devel-owner@vger.kernel.org"
 <ceph-devel-owner@vger.kernel.org>
Date: Tue, 2 Nov 2010 14:49:58 +0800
Subject: Questions about ceph OSD
Thread-Topic: Questions about ceph OSD
Thread-Index: Act6WdP7smCcimzHTjqcSO2SWwql8Q==
Message-ID: <1288680598.2366.253.camel@osd1>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: MAIL.tnsoft.com.cn
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
list-id: <ceph-devel.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi ,

I have recently been working the preliminary research whether ceph 
can use at our cloud computing storage system in the future ,
ceph is a very very excellent file system.But ,Now ,i hit a very
important problem for us:

Normally, as ceph described , all of the data are saved at OSDs with
CRUSHMAP at ceph system.

but my goal is to :
1. add a ext3 disk to ceph system ,but doesn't set it as a OSD;
2. save the normal data at the OSDs of a ceph system;
3. save the special data to a local ext3 disk at a ceph system,
   the ext3 disk is not set as a ceph OSD,but its infos are added to 
  MDS and  MON,when Write the special data at a ceph client ,these
special data are not saved to ceph server OSDs ,but saved at the local
ext3 disk.

like this:
At ceph client:
$ mount.ceph 1.2.3.4:6789:/ /ceph
$ cd /ceph
$ ls
cloud user secret  

when do writing,"cloud and user" folder data are saved to ceph OSDs ,
but "secret" folder data are saved to a local ext3 disk .

My question is:
Q1- If i add a new OSD to the ceph system ,but i do a special CRUSH
placement map . Could this ways solved this problem ?,If can ,How ?

Q2 - If to implement this function as a patch myself, Could you give me
any ideas ? or what parts of ceph codes(server/client) that i need look
into ? 

Thanks for all help and reply .


Jeff.Wu
Transoft.inc ,Sr.software engineer.
　　




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-VOL23pZhIldW7OpK3Vfb--
