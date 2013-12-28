From: =?ISO-8859-1?Q?Bj=F8rnar_Ness?= <bjornar.ness@gmail.com>
Subject: Patch for rados tool to allow listomapvals to list all k/v pairs
Date: Sat, 28 Dec 2013 14:59:32 +0100
Message-ID: <CAJO99Tmj3itMZWpjoO6tmjk7Tz9WJSjDtKwwF-BE9W1iWODkdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c34aeac101fc04ee989e2c
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35095 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab3L1N7e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Dec 2013 08:59:34 -0500
Received: by mail-wg0-f43.google.com with SMTP id k14so8988446wgh.22
        for <ceph-devel@vger.kernel.org>; Sat, 28 Dec 2013 05:59:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--001a11c34aeac101fc04ee989e2c
Content-Type: text/plain; charset=ISO-8859-1

Current code only lists first 512 k/v pairs, attached patch.

-- 
Bj(/)rnar

--001a11c34aeac101fc04ee989e2c
Content-Type: text/x-diff; charset=US-ASCII; name="rados_listomapvals_everything.patch"
Content-Disposition: attachment;
	filename="rados_listomapvals_everything.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hpqxr7rd0

ZGlmZiAtLWdpdCBhL3NyYy90b29scy9yYWRvcy9yYWRvcy5jYyBiL3NyYy90b29scy9yYWRvcy9y
YWRvcy5jYwppbmRleCBhNWE5MjFjLi5iYmQ3YmEyIDEwMDY0NAotLS0gYS9zcmMvdG9vbHMvcmFk
b3MvcmFkb3MuY2MKKysrIGIvc3JjL3Rvb2xzL3JhZG9zL3JhZG9zLmNjCkBAIC0xNzYwLDYgKzE3
NjAsNyBAQCBzdGF0aWMgaW50IHJhZG9zX3Rvb2xfY29tbW9uKGNvbnN0IHN0ZDo6bWFwIDwgc3Rk
OjpzdHJpbmcsIHN0ZAogICAgICAgICAgICAgPDwgY3BwX3N0cmVycm9yKHJldCkgPDwgc3RkOjpl
bmRsOwogICAgICAgIHJldHVybiAxOwogICAgICAgfQorICAgICAgcmV0ID0gdmFsdWVzLnNpemUo
KTsKICAgICAgIGZvciAobWFwPHN0cmluZywgYnVmZmVybGlzdD46OmNvbnN0X2l0ZXJhdG9yIGl0
ID0gdmFsdWVzLmJlZ2luKCk7CiAgICAgICAgICAgaXQgIT0gdmFsdWVzLmVuZCgpOyArK2l0KSB7
CiAgICAgICAgLy8gZHVtcCBrZXkgaW4gaGV4IGlmIGl0IGNvbnRhaW5zIG5vbnByaW50YWJsZSBj
aGFyYWN0ZXJzCkBAIC0xNzcxLDYgKzE3NzIsNyBAQCBzdGF0aWMgaW50IHJhZG9zX3Rvb2xfY29t
bW9uKGNvbnN0IHN0ZDo6bWFwIDwgc3RkOjpzdHJpbmcsIHN0ZAogICAgICAgICAga2V5YmwuaGV4
ZHVtcChjb3V0KTsKICAgICAgICB9IGVsc2UgewogICAgICAgICAgY291dCA8PCBpdC0+Zmlyc3Q7
CisgICAgICBsYXN0X3JlYWQgPSBpdC0+Zmlyc3Q7CiAgICAgICAgfQogICAgICAgIGNvdXQgPDwg
c3RkOjplbmRsOwogICAgICAgIGNvdXQgPDwgInZhbHVlOiAoIiA8PCBpdC0+c2Vjb25kLmxlbmd0
aCgpIDw8ICIgYnl0ZXMpIDpcbiI7Cg==
--001a11c34aeac101fc04ee989e2c--
