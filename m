From: "yangruifeng.09209@h3c.com" <yangruifeng.09209@h3c.com>
Subject: a problem about FileStore::_destroy_collection
Date: Mon, 16 Nov 2015 03:10:31 +0000
Message-ID: <0C3F6DA3760D0C4691E69E5BE224FF495E17E901@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.h3c.com ([60.191.123.56]:30913 "EHLO h3cmg01-ex.h3c.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752624AbbKPDK7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 15 Nov 2015 22:10:59 -0500
Content-Language: zh-CN
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

YW4gRU5PVEVNUFRZIGVycm9yIG15YmUgaGFwcGVuIHdoZW4gcmVtb3ZpbmcgYSBwZyBpbiBwcmV2
aW91cyB2ZXJzaW9uc6OsYnV0IHRoZSBlcnJvciBpcyBoaWRkZW4gaW4gbmV3IHZlcnNpb25zoaMN
Cg0KX2Rlc3Ryb3lfY29sbGVjdGlvbiBtYXliZSByZXR1cm4gMCB3aGVuIGdldF9pbmRleCBvciBw
cmVwX2RlbGV0ZSByZXR1cm4gPCAwOw0KDQppcyB0aGlzIGludGVuZGVkPw0KDQppbnQgRmlsZVN0
b3JlOjpfZGVzdHJveV9jb2xsZWN0aW9uKGNvbGxfdCBjKSANCnsNCiAgaW50IHIgPSAwOyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLy9nbG9iYWwgcg0KICBjaGFyIGZuW1BBVEhfTUFYXTsN
CiAgZ2V0X2NkaXIoYywgZm4sIHNpemVvZihmbikpOw0KICBkb3V0KDE1KSA8PCAiX2Rlc3Ryb3lf
Y29sbGVjdGlvbiAiIDw8IGZuIDw8IGRlbmRsOw0KICB7DQogICAgSW5kZXggZnJvbTsNCiAgICBp
bnQgciA9IGdldF9pbmRleChjLCAmZnJvbSk7ICAgICAgICAgICAgLy9sb2NhbCByDQogICAgaWYg
KHIgPCAwKQ0KICAgICAgZ290byBvdXQ7DQogICAgYXNzZXJ0KE5VTEwgIT0gZnJvbS5pbmRleCk7
DQogICAgUldMb2NrOjpXTG9ja2VyIGwoKGZyb20uaW5kZXgpLT5hY2Nlc3NfbG9jayk7DQoNCiAg
ICByID0gZnJvbS0+cHJlcF9kZWxldGUoKTsNCiAgICBpZiAociA8IDApDQogICAgICBnb3RvIG91
dDsNCiAgfQ0KICByID0gOjpybWRpcihmbik7DQogIGlmIChyIDwgMCkgew0KICAgIHIgPSAtZXJy
bm87DQogICAgZ290byBvdXQ7DQogIH0NCg0KIG91dDoNCiAgLy8gZGVzdHJveSBwYXJhbGxlbCB0
ZW1wIGNvbGxlY3Rpb24sIHRvbw0KICAuLi4NCg0KIG91dF9maW5hbDoNCiAgZG91dCgxMCkgPDwg
Il9kZXN0cm95X2NvbGxlY3Rpb24gIiA8PCBmbiA8PCAiID0gIiA8PCByIDw8IGRlbmRsOw0KICBy
ZXR1cm4gcjsNCn0NCg==
