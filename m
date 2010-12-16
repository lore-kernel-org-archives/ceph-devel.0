From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Patch for 512-byte alignment support for direct I/O
Date: Thu, 16 Dec 2010 11:24:39 +0800
Message-ID: <AANLkTim9EGJtD12_XQM=4FgLfQ_eashggu4f4C_AffVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00163630f8dd10a16004977e98d5
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47160 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab0LPDYk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Dec 2010 22:24:40 -0500
Received: by qwa26 with SMTP id 26so2742180qwa.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Dec 2010 19:24:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

--00163630f8dd10a16004977e98d5
Content-Type: text/plain; charset=UTF-8

Hi Sage,

My direct I/O test still failed (and even crashed the whole system)
when reading a file on ceph. Attached is my simple test program.
I tried to fix it with the following patch:
https://github.com/tcloud/ceph-client-standalone/commit/3e9c611b43a9e03e0a80582b2a3d81e5c8d5ff79
Would you help to review it? :)

Thanks,
Henry

--00163630f8dd10a16004977e98d5
Content-Type: text/x-c++src; charset=US-ASCII; name="directio_test.cpp"
Content-Disposition: attachment; filename="directio_test.cpp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghr2w4w50

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdHJpbmcu
aD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsKCWludCBpOwoJaW50IG4gPSAw
OwoJdm9pZCAqYnVmID0gMDsKCWludCBmZCA9IG9wZW4oYXJndlsxXSwgT19SRE9OTFkgfCBPX0RJ
UkVDVCk7CglpZiAoZmQgPCAwKSB7CgkJcHJpbnRmKCJmaWxlIG9wZW4gZXJyb3IgJWRcbiIsIGVy
cm5vKTsKCQlyZXR1cm4gLTE7Cgl9CgoJbiA9IGxzZWVrKGZkLCAwLCBTRUVLX0VORCk7Cglwcmlu
dGYoInNlZWsgJWRcbiIsIG4pOwoJbiA9IGxzZWVrKGZkLCAwLCBTRUVLX0NVUik7CglwcmludGYo
InNlZWsgJWRcbiIsIG4pOwoJbiA9IGxzZWVrKGZkLCA2NjU2LCBTRUVLX1NFVCk7CglwcmludGYo
InNlZWsgJWRcbiIsIG4pOwoKCW4gPSBwb3NpeF9tZW1hbGlnbigmYnVmLCA1MTIsIDgxOTIpOwoJ
cHJpbnRmKCJwb3NpeF9tZW1hbGlnbiByZXQgJWQgYnVmICVwXG4iLCBuLCBidWYpOwoJbWVtc2V0
KGJ1ZiwgMCwgbik7CgoJbiA9IHJlYWQoZmQsIGJ1ZiwgODE5Mik7CglwcmludGYoInJlYWQgJWQg
Ynl0ZXMgKGVyciAlZClcbiIsIG4sIGVycm5vKTsKCWNoYXIqIGJ1ZjEgPSAoY2hhciopYnVmOwoJ
Zm9yIChpID0gMDsgaSA8IG47ICsraSkKCQlwcmludGYoIiVjIiwgYnVmMVtpXSk7CglwcmludGYo
IlxuIik7CglmcmVlKGJ1Zik7CgljbG9zZShmZCk7CglyZXR1cm4gMDsKfQo=
--00163630f8dd10a16004977e98d5--
