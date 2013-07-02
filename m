From: majianpeng <majianpeng@gmail.com>
Subject: [PATCH 0/3]  implement of updating atime for client has CEPH_CAP_FILE_RD
Date: Tue, 2 Jul 2013 13:45:04 +0800
Message-ID: <201307021345012243134@gmail.com>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Tm93IHVwZGF0ZSBhdGltZSBvZiBmaWxlLCBvbmx5IGZvciBjbGllbnQgaGFkIENFUEhfQ0FQX0ZM
RV9FWENMLkJ1dCBmb3IgYXRpbWUsIGlmIG9uZSBjYW4gcmVhZCBoZSBjYW4gdXBkYXRlIHRoaXMg
YXR0cmlidGUuDQpGb3IgdGhpcyBmZWF0dXJlLGl0IG5lZWQgYm90aCBjbGllbnQgYW5kIG1kcyBt
b2RpZnkuDQpQQVRDSDEsaXQgbW9kaWZ5IHRoZSBtZHMgdG8gc3VwcG9ydC4NClBBVENIMixpdCBt
b2RpZnkgdGhlIGNsaWVudCB0byBzdXBvcnQuDQpQQVRDSDMsIGl0IHN1cHBvcnQgdGhpcyBmZWF0
dXJlIGZvciBzeW5jX3JlYWQgbW9kZS4NCg0KSmlhbnBlbmcgTWEgKDMpOg0KIG1kczogdXBkYXRl
IGF0aW1lIGlmIGNsaWVudCBjYW4gcmVhZA0KICBjZXBoOiB1cGRhdGUgYXRpbWUgYWZ0ZXIgcmVh
ZC1vcGVyYXRpb24uDQogIGNlcGg6IEZvciBjZXBoX3N5bmNfcmVhZCwgdXBkYXRlIHRoZSBhdGlt
ZSBvZiBmaWxlLg0KDQogZnMvY2VwaC9maWxlLmMgfCAxMiArKysrKysrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjEuOC4xLjI=
