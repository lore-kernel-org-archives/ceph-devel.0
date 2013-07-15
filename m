From: majianpeng <majianpeng@gmail.com>
Subject: Re: Re: [PATCH] ceph: Don't do set_layout for file which has been written.
Date: Mon, 15 Jul 2013 10:31:03 +0800
Message-ID: <201307151030534419160@gmail.com>
References: <201307111004467716774@gmail.com>,
	<alpine.DEB.2.00.1307111154260.5149@cobra.newdream.net> <201307120851431485280@gmail.com>,
	<alpine.DEB.2.00.1307121358570.25223@cobra.newdream.net>
Reply-To: majianpeng <majianpeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49829 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab3GOCbe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Jul 2013 22:31:34 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so10744102pac.29
        for <ceph-devel@vger.kernel.org>; Sun, 14 Jul 2013 19:31:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Pk9uIEZyaSwgMTIgSnVsIDIwMTMsIG1hamlhbnBlbmcgd3JvdGU6DQo+PiA+T24gVGh1LCAxMSBK
dWwgMjAxMywgbWFqaWFucGVuZyB3cm90ZToNCj4+ID4+IENlcGhmcyBkb24ndCBjaGFuZ2UgdGhl
IGxheW91dCB3aGljaCBoYXMgYmVlbiB3cml0dGVuLlNvIGFkZCB0aGlzIGNoZWNrDQo+PiA+PiBi
ZWZvcmUgZG8uDQo+PiA+DQo+PiA+VGhpcyBjb3VsZCBjb25jZWl2YWFibHkgY2hhbmdlIGluIHRo
ZSBmdXR1cmUsIGFuZCBJJ20gbm90IHN1cmUgdGhlcmUgaXMgDQo+PiA+aGFybSBpcyB0aGUgTURT
IHJvdW5kIHRyaXAgdG8gZ2V0IHRoZSBlcnJvciBjb2RlIGhlcmUuLi4/DQo+PiA+DQo+PiBTb3Jy
eSwgaSBjYW4ndCB1bmRlcnN0YW5kIHdoYXQncyB5b3VyIHNhaWQuIENhbiB5b3UgZXhwbGFpbiBp
biBkZXRhaWw/DQo+DQo+U29ycnkuICBJIG1lYW4gdGhhdCBzb21lZGF5IHRoZSBNRFMgbWlnaHQg
YmUgYWJsZSB0byBhZGp1c3QgdGhlIGxheW91dCBvZiANCj5hbiBleGlzdGluZyBmaWxlLiAgVGhh
dCBpcyBwcm9iYWJseSBub3Qgc29tZXRoaW5nIHRoYXQgd2lsbCBoYXBwZW4gYW55IA0KPnRpbWUg
c29vbiwgdGhvdWdoLiAgSXQgaXMgcHJvYmFibHkgd29ydGggbWVyZ2luZyB0aGlzIChhbG9uZyB3
aXRoIHRoZSANCj5HRVRMQVlPVVQgaGFsZikgZm9yIG5vdy4NCj4NCk9LLCBJIHNlZS4gVGhhbmtz
IHlvdXIgdGltZSENCg0KSmlhbnBlbmcNCj5zYWdl

