From: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Subject: HEALTH_ERR when (re)starting ceph-osd's
Date: Thu, 28 Jan 2016 10:48:15 +0000
Message-ID: <0ec5364ea10c41a687edca2bfe7818e6@R01UKEXCASM115.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.111]:36189 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966781AbcA1Kzh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Jan 2016 05:55:37 -0500
Received: from R01UKEXCASM113.r01.fujitsu.local (ex2k13_113.fs.fujitsu.com [10.183.43.169])
	by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id u0SAj6bq029261
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 28 Jan 2016 10:45:23 GMT
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

SGVsbG8sDQoNCkkgaGF2ZW4ndCBub3RpY2VkIGl0IGJlZm9yZSwgYnV0IHNpbmNlIG1lcmdpbmcg
aHR0cHM6Ly9naXRodWIuY29tL2NlcGgvY2VwaC9wdWxsLzcyNTMgSSBzZWUgdGhhdCwgd2hlbiBy
ZXN0YXJ0aW5nIGRhZW1vbnMgb24gaGVhbHRoeSBjZXBoIGNsdXN0ZXIsIGl0IGdvZXMgdG8gSEVB
TFRIX0VSUiBzdGF0ZSB3aXRoICIkKHJhbmRvbV9udW1iZXIpIHBncyBhcmUgc3R1Y2sgaW5hY3Rp
dmUgZm9yIG1vcmUgdGhhbiAzMDAgc2Vjb25kcyIuIA0KSSBsb29rZWQgYXQgdGhlIGNvbW1pdCBh
bmQgaXQgdHVybnMgb3V0IGl0IHdpbGwgYmUgYWx3YXlzIG9jY3VycmluZyBvbiByZXN0YXJ0L2Jv
b3QsIGFzIGJvb3RpbmcgcGdzIGFyZSBpbmFjdGl2ZSAiYnkgZGVmYXVsdCIgKHNpbmNlIG1vbnMg
bmV2ZXIgcmVjZWl2ZWQgYW55IHNpZ24gb2YgbGlmZSBmcm9tIHRoZW0pIC0gbm90IGJlY2F1c2Ug
dGhleSdyZSBhY3R1YWxseSBzdHVjayBpbmFjdGl2ZS4NCk9uZSBzb2x1dGlvbiB0byB0aGlzIHdv
dWxkIGJlIHRvIG1hcmsgcGdfc3RhdC5sYXN0XyogZmllbGRzIHRvIHRoZSBwb2ludCB3aGVyZSBp
dCB3ZXJlIGZpcnN0IHNlZW4sIHNvIHRoZXkgd2lsbCBiZWNvbWUgc3R1Y2sgKG1vbl9wZ19zdHVj
a190aHJlc2hvbGQpIHNlY29uZHMgYWZ0ZXIgZmlyc3QgcmVnaXN0ZXJpbmcsIGFuZCBub3Qgcmln
aHQgYXdheS4NCkFub3RoZXIsIGxlc3MgaW52YXNpdmUgb25lLCBpcyB0byBqdXN0IGxldCB1c2Vy
IGRpc2FibGUgdGhpcyB3YXJuaW5nLg0KDQpXaGF0IGRvIHlvdSB0aGluaz8NCg0KV2l0aCBiZXN0
IHJlZ2FyZHMgLyBQb3pkcmF3aWFtDQpQaW90ciBEYcWCZWsNCg0K
