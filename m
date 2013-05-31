From: christophe courtaut <christophe.courtaut@gmail.com>
Subject: [PATCH] rgw: Do not assume rest connection to be established
Date: Fri, 31 May 2013 10:07:09 +0200
Message-ID: <CAA8043ghxcjqcUha0A+CbWPuSkeSN5RkraT1rJOJJ5r+_wwSVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0111bd1036f7a104ddff1b37
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:37780 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab3EaIHa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 04:07:30 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so2422979obc.37
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 01:07:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--089e0111bd1036f7a104ddff1b37
Content-Type: text/plain; charset=ISO-8859-1

This patch fixes a bug in the wip-rgw-geo-2 branch.

The bug is that if you do not have a region map, the rest connection
will not be established, and reaching this code will lead to a
segmentation fault.

This patch prevents it.

Best regards.

--
Christophe Courtaut

--089e0111bd1036f7a104ddff1b37
Content-Type: application/octet-stream;
	name="0001-Do-not-assum-rest-connection-to-be-established.patch"
Content-Disposition: attachment;
	filename="0001-Do-not-assum-rest-connection-to-be-established.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hhd38yeq0

RnJvbSBmYWUwODZhZmMwNTIwNWZjYzVkZjRmYmY1MjU0MzQyNWQ2N2Q1ZWQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlIENvdXJ0YXV0IDxjaHJpc3RvcGhlLmNvdXJ0
YXV0QGdtYWlsLmNvbT4KRGF0ZTogRnJpLCAzMSBNYXkgMjAxMyAwOTo1NToyNyArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIHJndzogRG8gbm90IGFzc3VtIHJlc3QgY29ubmVjdGlvbiB0byBiZSBlc3Rh
Ymxpc2hlZAoKQWRkZWQgYSBjaGVjayB0byB2ZXJpZnkgdGhhdCByZXN0IGNvbm5lY3Rpb24gaXMg
Y29ycmVjdGx5IGluaXRpYWxpemVkLApwcmV2ZW50aW5nIGEgc2VnbWVudGF0aW9uIGZhdWx0LgoK
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBDb3VydGF1dCA8Y2hyaXN0b3BoZS5jb3VydGF1dEBn
bWFpbC5jb20+Ci0tLQogc3JjL3Jndy9yZ3dfb3AuY2MgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9yZ3cvcmd3X29wLmNjIGIvc3Jj
L3Jndy9yZ3dfb3AuY2MKaW5kZXggMGUzMTNlYy4uMjZhNjVhOSAxMDA2NDQKLS0tIGEvc3JjL3Jn
dy9yZ3dfb3AuY2MKKysrIGIvc3JjL3Jndy9yZ3dfb3AuY2MKQEAgLTg2NSw2ICs4NjUsMTIgQEAg
dm9pZCBSR1dDcmVhdGVCdWNrZXQ6OmV4ZWN1dGUoKQogICAgICAgcmV0dXJuOwogICAgIH0KIAor
ICAgIGlmIChzdG9yZS0+cmVzdF9jb25uID09IDApCisgICAgeworICAgICAgbGRvdXQocy0+Y2N0
LCAwKSA8PCAicmVzdCBjb25uZWN0aW9uIGlzIGludmFsaWQiIDw8IGRlbmRsOworICAgICAgcmV0
ID0gLUVJTlZBTDsKKyAgICAgIHJldHVybjsKKyAgICB9CiAgICAgbGRvdXQocy0+Y2N0LCAwKSA8
PCAic2VuZGluZyBjcmVhdGVfYnVja2V0IHJlcXVlc3QgdG8gbWFzdGVyIHJlZ2lvbiIgPDwgZGVu
ZGw7CiAgICAgcmV0ID0gc3RvcmUtPnJlc3RfY29ubi0+Zm9yd2FyZChzLT51c2VyLnVzZXJfaWQs
IHMtPmluZm8sICZpbl9kYXRhKTsKICAgICBpZiAocmV0IDwgMCkKLS0gCjEuOC4xLjIKCg==
--089e0111bd1036f7a104ddff1b37--
