From: =?utf-8?B?Uml0dGVyIFPFgmF3b21pcg==?= <Slawomir.Ritter@dreamlab.pl>
Subject: RE: [ceph-users] Problem: silently corrupted RadosGW objects caused
 by slow requests
Date: Mon, 7 Mar 2016 14:34:23 +0100
Message-ID: <156923D1D92AF640829D4E847271EDAE522A4700A1@MXMBON06.grupa.onet>
References: <156923D1D92AF640829D4E847271EDAE522A46F435@MXMBON06.grupa.onet>
	<CAMNMNTxs46Hcaq-ZJZfYfF5m8aL9ETNjtBKr8UrdAxZFM7E=nw@mail.gmail.com>
	<156923D1D92AF640829D4E847271EDAE522A46FD66@MXMBON06.grupa.onet>
	<robbat2-20160303T232148-550781944Z@orbis-terrarum.net>
	<156923D1D92AF640829D4E847271EDAE522A46FF66@MXMBON06.grupa.onet>
 <CADRKj5QYiCWxqxQkhDsFET8CJEfJM9_X1XiEH1_Zcn0Z_jSkNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from onsmg01.portal.onet.pl ([213.180.147.237]:46259 "EHLO
	onsmg01.portal.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbcCGNek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 08:34:40 -0500
In-Reply-To: <CADRKj5QYiCWxqxQkhDsFET8CJEfJM9_X1XiEH1_Zcn0Z_jSkNQ@mail.gmail.com>
Content-Language: pl-PL
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

PiA+IFllcywNCj4gPg0KPiA+IGZpeCBmb3IgIzgyNjkgYWxzbyBoYXMgYmVlbiBpbmNsdWRlZCBp
biBvdXIgdmVyc2lvbjogRHVtcGxpbmcgMC42Ny4xMS4NCj4gPiBHdXlzIGZyb20gIzEzNzY0IGFy
ZSB1c2luZyBwYXRjaGVkIEhhbW1lciB2ZXJzaW9uDQo+IA0KPiBJIGRpZG4ndCBub3RpY2UgdGhh
dCB5b3Ugd2VyZSBhY3R1YWxseSBydW5uaW5nIER1bXBsaW5nICh3aGljaCB3ZQ0KPiBoYXZlbid0
IHN1cHBvcnRlZCBhbmQgYmFja3BvcnRlZCBmaXhlcyBmb3IgYSB3aGlsZSkuIEhlcmUncyBvbmUg
aXNzdWUNCj4gdGhhdCB5b3UgbWlnaHQgaGF2ZSBoaXQ6DQo+IA0KPiBodHRwOi8vdHJhY2tlci5j
ZXBoLmNvbS9pc3N1ZXMvMTE2MDQNCj4gDQo+IFllaHVkYQ0KWWVzLCBpdCBsb29rcyB2ZXJ5IHNp
bWlsaWFyLiBXZSBoYWQgdG8gdXBncmFkZSwgcHJvYmFibHkgdG8gSGFtbWVyIExUUyA6KS4NCldl
IHdpbGwgY2hlY2sgaXQgYWdhaW4gYWZ0ZXIgd2hvbGUgb3BlcmF0aW9uLiBUaG54IGEgbG90Lg0K
DQotLQ0KU1INCg==
