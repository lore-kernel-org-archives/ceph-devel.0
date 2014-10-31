From: Ding Dinghua <dingdinghua85@gmail.com>
Subject: Fix dead looping in Objecter::handle_osd_map
Date: Fri, 31 Oct 2014 13:23:15 +0800
Message-ID: <CANf+_kJEFtzt3r8Y0XuZsodw4AiFem8oezV4A+T-FnMcB18oFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1132ed38aa9f3f0506b131d5
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61252 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaJaFXR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Oct 2014 01:23:17 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so5295428lbg.8
        for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 22:23:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--001a1132ed38aa9f3f0506b131d5
Content-Type: text/plain; charset=UTF-8

Hi all:
        I hit this bug when I was using ceph-fuse client. I mount a
ceph-fuse client, and left it idle for a long time, then when I copy
some files to ceph,  ceph-fuse hang,  the following log shows that
Objecter::handle_osd_map is dead-looping:

handle_osd_map missing epoch 6445, jumping to 6579
handle_osd_map missing epoch 6445, jumping to 6579
handle_osd_map missing epoch 6445, jumping to 6579
handle_osd_map missing epoch 6445, jumping to 6579
handle_osd_map missing epoch 6445, jumping to 6579
handle_osd_map missing epoch 6445, jumping to 6579
handle_osd_map missing epoch 6445, jumping to 6579
handle_osd_map missing epoch 6445, jumping to 6579

the attached patch should have fixed the bug.


-- 
Ding Dinghua

--001a1132ed38aa9f3f0506b131d5
Content-Type: application/octet-stream;
	name="0001-e-shouldn-t-be-zero-in-Objecter-handle_osd_map.patch"
Content-Disposition: attachment;
	filename="0001-e-shouldn-t-be-zero-in-Objecter-handle_osd_map.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i1x3fstg0

RnJvbSA2NzU2YmIwMWEwNzQyOGUyN2EwNGQ3MzEzM2MxOTU4YTYzMTM0YTUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBkaW5nZGluZ2h1YSA8ZGluZ2RpbmdodWFAMzYwLmNuPgpEYXRl
OiBUaHUsIDMwIE9jdCAyMDE0IDE0OjU4OjA1ICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIGUg
c2hvdWxkbid0IGJlIHplcm8gaW4gT2JqZWN0ZXI6OmhhbmRsZV9vc2RfbWFwCgotLS0KIHNyYy9v
c2RjL09iamVjdGVyLmNjIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL29zZGMvT2JqZWN0ZXIuY2MgYi9z
cmMvb3NkYy9PYmplY3Rlci5jYwppbmRleCAxZDY0NDhiLi41Njk5OGZlIDEwMDY0NAotLS0gYS9z
cmMvb3NkYy9PYmplY3Rlci5jYworKysgYi9zcmMvb3NkYy9PYmplY3Rlci5jYwpAQCAtNzc2LDcg
Kzc3Niw3IEBAIHZvaWQgT2JqZWN0ZXI6OmhhbmRsZV9vc2RfbWFwKE1PU0RNYXAgKm0pCiAJICBs
b2dnZXItPmluYyhsX29zZGNfbWFwX2Z1bGwpOwogCX0KIAllbHNlIHsKLQkgIGlmIChlICYmIGUg
PiBtLT5nZXRfb2xkZXN0KCkpIHsKKwkgIGlmIChlID4gbS0+Z2V0X29sZGVzdCgpKSB7CiAJICAg
IGxkb3V0KGNjdCwgMykgPDwgImhhbmRsZV9vc2RfbWFwIHJlcXVlc3RpbmcgbWlzc2luZyBlcG9j
aCAiCiAJCQkgIDw8IG9zZG1hcC0+Z2V0X2Vwb2NoKCkrMSA8PCBkZW5kbDsKIAkgICAgaW50IHIg
PSBfbWF5YmVfcmVxdWVzdF9tYXAoKTsKLS0gCjEuNy4xCgo=
--001a1132ed38aa9f3f0506b131d5
Content-Type: application/octet-stream;
	name="0002-Fix-a-bug-of-dead-looping-in-Objecter-handle_osd_map.patch"
Content-Disposition: attachment;
	filename="0002-Fix-a-bug-of-dead-looping-in-Objecter-handle_osd_map.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i1x3fsu81

RnJvbSBkNmY0NWIyYWQxN2IwMGI1ZmRhMTkwZTllMmQ5ZjJmNTBhYTNiZjVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBkaW5nZGluZ2h1YSA8ZGluZ2RpbmdodWFAMzYwLmNuPgpEYXRl
OiBUaHUsIDMwIE9jdCAyMDE0IDE0OjU4OjQyICswODAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIEZp
eCBhIGJ1ZyBvZiBkZWFkIGxvb3BpbmcgaW4gT2JqZWN0ZXI6OmhhbmRsZV9vc2RfbWFwCgpJZiBj
dXJyZW50IG1hcCBlcG9jaCBpcyBsZXNzIHRoYW4gb2xkZXN0IGVwb2NoLCBjdXJyZW50IG1hcCBl
cG9jaApzaG91bGQgc3RlcCB1cCB0byBvbGRlc3QgZXBvY2guCi0tLQogc3JjL29zZGMvT2JqZWN0
ZXIuY2MgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvb3NkYy9PYmplY3Rlci5jYyBiL3NyYy9vc2RjL09i
amVjdGVyLmNjCmluZGV4IDU2OTk4ZmUuLmZmZDFhNGYgMTAwNjQ0Ci0tLSBhL3NyYy9vc2RjL09i
amVjdGVyLmNjCisrKyBiL3NyYy9vc2RjL09iamVjdGVyLmNjCkBAIC03NzYsNyArNzc2LDcgQEAg
dm9pZCBPYmplY3Rlcjo6aGFuZGxlX29zZF9tYXAoTU9TRE1hcCAqbSkKIAkgIGxvZ2dlci0+aW5j
KGxfb3NkY19tYXBfZnVsbCk7CiAJfQogCWVsc2UgewotCSAgaWYgKGUgPiBtLT5nZXRfb2xkZXN0
KCkpIHsKKwkgIGlmIChlID49IG0tPmdldF9vbGRlc3QoKSkgewogCSAgICBsZG91dChjY3QsIDMp
IDw8ICJoYW5kbGVfb3NkX21hcCByZXF1ZXN0aW5nIG1pc3NpbmcgZXBvY2ggIgogCQkJICA8PCBv
c2RtYXAtPmdldF9lcG9jaCgpKzEgPDwgZGVuZGw7CiAJICAgIGludCByID0gX21heWJlX3JlcXVl
c3RfbWFwKCk7Ci0tIAoxLjcuMQoK
--001a1132ed38aa9f3f0506b131d5--
