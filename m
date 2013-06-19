From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH] ceph: avoid meaningless calling ceph_caps_revoking if sync_mode == WB_SYNC_ALL.
Date: Wed, 19 Jun 2013 15:12:06 +0800
Message-ID: <201306191512024406391@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50518 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393Ab3FSHMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 03:12:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

U2lnbmVkLW9mZi1ieTogSmlhbnBlbmcgTWEgPG1hamlhbnBlbmdAZ21haWwuY29tPg0KLS0tDQog
ZnMvY2VwaC9hZGRyLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvY2VwaC9hZGRyLmMgYi9mcy9jZXBo
L2FkZHIuYw0KaW5kZXggM2U2OGFjMS4uMjVmYThiOCAxMDA2NDQNCi0tLSBhL2ZzL2NlcGgvYWRk
ci5jDQorKysgYi9mcy9jZXBoL2FkZHIuYw0KQEAgLTY3Nyw4ICs2NzcsOCBAQCBzdGF0aWMgaW50
IGNlcGhfd3JpdGVwYWdlc19zdGFydChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCiAJ
ICogaW50ZWdyaXR5IHdyaXRlIChlLmcuLCBPX1NZTkMgd3JpdGUgb3IgZnN5bmMoKSksIG9yIGlm
IG91cg0KIAkgKiBjYXAgaXMgYmVpbmcgcmV2b2tlZC4NCiAJICovDQotCWRvX3N5bmMgPSB3YmMt
PnN5bmNfbW9kZSA9PSBXQl9TWU5DX0FMTDsNCi0JaWYgKGNlcGhfY2Fwc19yZXZva2luZyhjaSwg
Q0VQSF9DQVBfRklMRV9CVUZGRVIpKQ0KKwlpZiAoKHdiYy0+c3luY19tb2RlID09IFdCX1NZTkNf
QUxMKSB8fA0KKwkJY2VwaF9jYXBzX3Jldm9raW5nKGNpLCBDRVBIX0NBUF9GSUxFX0JVRkZFUikp
DQogCQlkb19zeW5jID0gMTsNCiAJZG91dCgid3JpdGVwYWdlc19zdGFydCAlcCBkb3N5bmM9JWQg
KG1vZGU9JXMpXG4iLA0KIAkgICAgIGlub2RlLCBkb19zeW5jLA0KLS0gDQoxLjguMy5yYzEuNDQu
Z2IzODdjNzcNCg==

