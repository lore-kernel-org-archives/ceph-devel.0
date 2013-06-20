From: christophe courtaut <christophe.courtaut@gmail.com>
Subject: [PATCH] rgw: Added an encoder for time_t to fix compilation
Date: Thu, 20 Jun 2013 15:57:19 +0200
Message-ID: <CAA8043gcmGmpNba7OEbh8Vo7-SgUN_R_CcGpsi_Vt9pgmmhirw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b2ed7c14de23f04df965412
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:34264 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965557Ab3FTN5k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 09:57:40 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so8094100oah.11
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jun 2013 06:57:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--047d7b2ed7c14de23f04df965412
Content-Type: text/plain; charset=ISO-8859-1

On the rgw-wip-geo-2 branch, the encode decode function are called
with time_t now,
but there is no encode/decode function created for time_t type.

http://tracker.ceph.com/issues/5402 refs #5402

This patch adds a WRITE_RAW_ENCODER to support this type.

--
Christophe Courtaut

--047d7b2ed7c14de23f04df965412
Content-Type: application/octet-stream;
	name="0001-rgw-Added-an-encoder-for-time_t-to-fix-compilation.patch"
Content-Disposition: attachment;
	filename="0001-rgw-Added-an-encoder-for-time_t-to-fix-compilation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hi60j20d0

RnJvbSAxMjVjZWNkMzExOTRhOGM5MjEwNzFiZWQwYjFkM2VjNDBiMDg2YTlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlIENvdXJ0YXV0IDxjaHJpc3RvcGhlLmNvdXJ0
YXV0QGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAyMCBKdW4gMjAxMyAxNTo1MDozNCArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIHJndzogQWRkZWQgYW4gZW5jb2RlciBmb3IgdGltZV90IHRvIGZpeCBjb21w
aWxhdGlvbgoKVGhlIGVuY29kZSBkZWNvZGUgZnVuY3Rpb24gYXJlIGNhbGxlZCB3aXRoIHRpbWVf
dCBub3csCmJ1dCB0aGVyZSBpcyBubyBlbmNvZGUvZGVjb2RlIGZ1bmN0aW9uIGNyZWF0ZWQgZm9y
IHRpbWVfdCB0eXBlLgoKaHR0cDovL3RyYWNrZXIuY2VwaC5jb20vaXNzdWVzLzU0MDIgcmVmcyAj
NTQwMgoKVGhpcyBwYXRjaCBhZGRzIGEgV1JJVEVfUkFXX0VOQ09ERVIgdG8gc3VwcG9ydCB0aGlz
IHR5cGUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIENvdXJ0YXV0IDxjaHJpc3RvcGhlLmNv
dXJ0YXV0QGdtYWlsLmNvbT4KLS0tCiBzcmMvaW5jbHVkZS9lbmNvZGluZy5oIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9zcmMvaW5jbHVkZS9lbmNv
ZGluZy5oIGIvc3JjL2luY2x1ZGUvZW5jb2RpbmcuaAppbmRleCBlYjQ0NWUzLi40ZTlmNzIyIDEw
MDY0NAotLS0gYS9zcmMvaW5jbHVkZS9lbmNvZGluZy5oCisrKyBiL3NyYy9pbmNsdWRlL2VuY29k
aW5nLmgKQEAgLTY3LDYgKzY3LDcgQEAgV1JJVEVfUkFXX0VOQ09ERVIoY2hhcikKIFdSSVRFX1JB
V19FTkNPREVSKGNlcGhfbGU2NCkKIFdSSVRFX1JBV19FTkNPREVSKGNlcGhfbGUzMikKIFdSSVRF
X1JBV19FTkNPREVSKGNlcGhfbGUxNikKK1dSSVRFX1JBV19FTkNPREVSKHRpbWVfdCkKIAogLy8g
RklYTUU6IHdlIG5lZWQgdG8gY2hvb3NlIHNvbWUgcG9ydGFibGUgZmxvYXRpbmcgcG9pbnQgZW5j
b2RpbmcgaGVyZQogV1JJVEVfUkFXX0VOQ09ERVIoZmxvYXQpCi0tIAoxLjguMS4yCgo=
--047d7b2ed7c14de23f04df965412--
