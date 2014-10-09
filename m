From: Tim Zhang <cofol1986@gmail.com>
Subject: some questions about transactions during write op?
Date: Thu, 9 Oct 2014 18:49:13 +0800
Message-ID: <CAGo8jt=AtDgdRbED9BGcyBjfHsRqGzUakfYkmG8wRVSpG3EkYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:64097 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbaJIKtO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Oct 2014 06:49:14 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so1323040qge.22
        for <ceph-devel@vger.kernel.org>; Thu, 09 Oct 2014 03:49:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi ceph,
I dump the transactions during putting a file (the size is 1M ) into
ceph, below is what I got for locat_t to store pg log and set  infos.
I add some contents to see what the bufferlist has.
my understand for these four ops is:
op 0 is used to store the pglog;
op 1 is used to store epoch and pginfo;
op 2 is used to rm the trimmed pglog key(although it is empty  in my example);
op 3 is used to set pglog.
Is my understanding right?
Here are some more questions:
1 why we need to store epoch and pginfo, isn't pglog enough to track
all the changes?
2 seems op 0 and op 3 is the same, isn't it?
3 I find  the value of  big info in leveldb is always zero, then why
we set this key?
[root@ceph_node0 ~]# ceph-kvstore-tool
/var/lib/ceph/osd/ceph-1/current/omap/ get
_USER_0000000000000001_USER_ 0.3c_biginfo
(_USER_0000000000000001_USER_, 0.3c_biginfo)
0000 : 00 00 00 00 00 00 00 00 00 00 00 00             : ............

---------------------------------------------------------------------
transaction dump for local_t:
           { "osr": "0.35",
             "seq": 3669463,
             "trans_num": 0,
             "ops": [
                   { "op_num": 0,
                     "op_name": "omap_setkeys",
                     "collection": "meta",
                    "oid": "5172dfbb\/pglog_0.35\/0\/\/-1",
                    "attr_lens": { "0000000038.00000000000000000007": 132,
                        "0000000038.00000000000000000007":
"buffer::list(len=132,\n\tbuffer::ptr(0~4 0x8ed5000 in raw 0x8ed5000
len 4096 nref     4),\n\tbuffer::ptr(0~124 0x9168000 in raw 0x9168000
len 496 nref 2),\n\tbuffer::ptr(4~4 0x8ed5004 in raw 0x8ed5000 len
4096 nref 4)\n)"}},
                  { "op_num": 1,
                    "op_name": "omap_setkeys",
                    "collection": "meta",
                    "oid": "16ef7597\/infos\/head\/\/-1",
                    "attr_lens": { "0.35_epoch": 4,
                        "0.35_epoch":
"buffer::list(len=4,\n\tbuffer::ptr(0~4 0x8f24000 in raw 0x8f24000 len
4096 nref 2)\n)",
                        "0.35_info": 568,
                        "0.35_info":
"buffer::list(len=568,\n\tbuffer::ptr(0~568 0x4cae000 in raw 0x4cae000
len 4096 nref 2)\n)"}},
                  { "op_num": 2,
                    "op_name": "omap_rmkeys",
                    "collection": "meta",
                    "oid": "5172dfbb\/pglog_0.35\/0\/\/-1",
                    "keys": ""},
                  { "op_num": 3,
                    "op_name": "omap_setkeys",
                    "collection": "meta",
                    "oid": "5172dfbb\/pglog_0.35\/0\/\/-1",
                    "attr_lens": { "0000000038.00000000000000000007": 132,
  "0000000038.00000000000000000007":
"buffer::list(len=132,\n\tbuffer::ptr(0~4 0x916ec00 in raw 0x916ec00
len 496 nref     4),\n\tbuffer::ptr(0~124 0x916f600 in raw 0x916f600
len 496 nref 2),\n\tbuffer::ptr(4~4 0x916ec04 in raw 0x916ec00 len 496
nref 4)\n)"}}]},
