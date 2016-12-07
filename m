From: xxhdx1985126 <xxhdx1985126@163.com>
Subject: Question about ReplicatedBackend::sub_op_modify_reply
Date: Wed, 7 Dec 2016 19:38:48 +0800 (CST)
Message-ID: <41f33622.d4cc.158d91430e9.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m13-152.163.com ([220.181.13.152]:59477 "EHLO m13-152.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbcLGLyh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Dec 2016 06:54:37 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

CkhpLCBldmVyeW9uZS4KCgpJJ20gdHJ5aW5nIHRvIHJlYWQgdGhlIHNvdXJjZSBjb2RlIG9mIGNl
cGgsIGFuZCBJIGZvdW5kIHRoYXQgc29tZSBjb2RlIHNlZW1zIHN0cmFuZ2UuCkluIFJlcGxpY2F0
ZWRCYWNrZW5kOjpzdWJfb3BfbW9kaWZ5X3JlcGx5LCB0aGVyZSBpcyB0aGUgZm9sbG93aW5nIGNv
ZGU6CgkJaWYgKHItPmFja190eXBlICYgQ0VQSF9PU0RfRkxBR19PTkRJU0spIHsKCQkJYXNzZXJ0
KGlwX29wLndhaXRpbmdfZm9yX2NvbW1pdC5jb3VudChmcm9tKSk7CgkJCWlwX29wLndhaXRpbmdf
Zm9yX2NvbW1pdC5lcmFzZShmcm9tKTsKCQkJaWYgKGlwX29wLm9wKSB7CgkJCQlvc3RyaW5nc3Ry
ZWFtIHNzOwoJCQkJc3MgPDwgInN1Yl9vcF9jb21taXRfcmVjX2Zyb21fb3NkLiIgPDwgZnJvbS5v
c2Q7CgkJCQlpcF9vcC5vcC0+bWFya19ldmVudChzcy5zdHIoKSk7CgkJCX0KCQl9IGVsc2UgewoJ
CQlhc3NlcnQoaXBfb3Aud2FpdGluZ19mb3JfYXBwbGllZC5jb3VudChmcm9tKSk7CgkJCWlmIChp
cF9vcC5vcCkgewoJCQkJb3N0cmluZ3N0cmVhbSBzczsKCQkJCXNzIDw8ICJzdWJfb3BfYXBwbGll
ZF9yZWNfZnJvbV9vc2QuIiA8PCBmcm9tLm9zZDsKCQkJCWlwX29wLm9wLT5tYXJrX2V2ZW50KHNz
LnN0cigpKTsKCQkJfQoJCX0KCQlpcF9vcC53YWl0aW5nX2Zvcl9hcHBsaWVkLmVyYXNlKGZyb20p
OwpJdCBzZWVtcyB0aGF0IHRoZSBzdGF0ZW1lbnQgImlwX29wLndhaXRpbmdfZm9yX2FwcGxpZWQu
ZXJhc2UoZnJvbSkiIHNob3VsZCBiZSBpbiB0aGUgImVsc2UiIGNsYXVzZSwgb3RoZXJ3aXNlIGl0
ZW1zIGluIHdhaXRpbmdfZm9yX2FwcGxpZWQgY291bGQgYmUgZXJyb3JseSBlcmFzZWQgd2hlbiBh
Y2tfdHlwZSBpcyBDRVBIX09TRF9GTEFHX09ORElTSy4KCldoeSBwdXQgaXQgb3V0c2lkZSB0aGUg
ImVsc2UiIGNsYXVzZT8KVGhhbmsgeW91Oi0p
