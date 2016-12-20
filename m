From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Computation in the storage
Date: Tue, 20 Dec 2016 01:19:22 +0000
Message-ID: <552D04CE-8030-4340-ADDD-BCAB6A51C161@Teradata.com>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
 <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
 <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com>
 <CAB2gnbVn0U_G12L8XV=hbznB2i_TMo40TpC5cVzJZKOr_MAQ7Q@mail.gmail.com>
 <64D605E0-8851-4F60-B0AB-864CBDA7B3F7@Teradata.com>
 <208C08FF-0104-425C-B7AA-B0930A76F46E@Teradata.com>
 <CAB2gnbUEeS6AynJ0AjdpJ+MbiGSq_HUkBS-KdnXrke1wiJYsyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33562 "EHLO
        rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932110AbcLTBTZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2016 20:19:25 -0500
In-Reply-To: <CAB2gnbUEeS6AynJ0AjdpJ+MbiGSq_HUkBS-KdnXrke1wiJYsyA@mail.gmail.com>
Content-Language: en-US
Content-ID: <B713D319738AFA44AFC317D48C1E9BC0@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Joao Eduardo Luis <joao@suse.de>, "nebil.benmabrouk@orange.com" <nebil.benmabrouk@orange.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

SGkgTm9haCwNCg0KVGhhdOKAmXMgZ3JlYXQgdG8ga25vdy4gVGhhbmtzIGZvciB0aGUgcHJvbXB0
IHJlc3BvbnNlLg0KDQpOaXRpbg0KDQo+IE9uIERlYyAxNiwgMjAxNiwgYXQgMTA6MjIgQU0sIE5v
YWggV2F0a2lucyA8bm9haHdhdGtpbnNAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE5pdGluLA0K
PiANCj4gVGhlIGxpbmtzIG9uIHRoZSBibG9nIGFyZSBvdXQgb2YgZGF0ZS4gTHVhIHN1cHBvcnQg
aGFzIGJlZW4gbWVyZ2VkLg0KPiBTZWUgaHR0cHM6Ly9naXRodWIuY29tL2NlcGgvY2VwaC90cmVl
L21hc3Rlci9zcmMvY2xzL2x1YQ0KPiANCj4gLSBOb2FoDQo+IA0KPiBPbiBGcmksIERlYyAxNiwg
MjAxNiBhdCAxMDowMCBBTSwgS2FtYmxlLCBOaXRpbiBBDQo+IDxOaXRpbi5LYW1ibGVAdGVyYWRh
dGEuY29tPiB3cm90ZToNCj4+IEhpIE5vYWgsDQo+PiANCj4+IEkgbG9va2VkIGF0IHlvdXIgYmxv
ZyBbMF0gYWJvdXQgaW1wbGVtZW50aW5nIFJBRE9TIG9iamVjdCBjbGFzc2VzIHVzaW5nIEx1YSBz
Y3JpcHRzLiBUaGUNCj4+IGxpbmsgWzFdIHRvIHRoZSBzb3VyY2UgY29kZSBpbiBjZXBoIHJlcG9z
aXRvcnkgaXMgbWlzc2luZy4gU2VlbXMgbGlrZSB0aGlzIHN1cHBvcnQgaGFzIGJlZW4NCj4+IHJl
bW92ZWQgZnJvbSB1cHN0cmVhbSBjZXBoLCBhbmQgaXQgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUg
Y2VwaCByZWxlYXNlcyBhcyBvZiBub3cuDQo+PiBDYW4geW91IGNvbmZpcm0/DQo+PiANCj4+IA0K
Pj4gWzBdIGh0dHA6Ly9ub2FoZGVzdS5naXRodWIuaW8vMjAxNS8xMi8xNC90b3dhcmRzLXJhZG9z
LW9iamVjdC1jbGFzcy1tYW5hZ2VtZW50Lmh0bWwNCj4+IFsxXSBodHRwczovL2dpdGh1Yi5jb20v
Y2VwaC9jZXBoL3RyZWUvY2xzLWx1YQ0KPj4gDQo+PiBUaGFua3MsDQo+PiBOaXRpbg0KPj4gDQo+
PiANCj4+PiBPbiBEZWMgNSwgMjAxNiwgYXQgMzowOCBQTSwgS2FtYmxlLCBOaXRpbiBBIDxOaXRp
bi5LYW1ibGVAVGVyYWRhdGEuY29tPiB3cm90ZToNCj4+PiANCj4+PiANCj4+Pj4gT24gRGVjIDQs
IDIwMTYsIGF0IDM6MDIgUE0sIE5vYWggV2F0a2lucyA8bm9haHdhdGtpbnNAZ21haWwuY29tPiB3
cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIEZyaSwgRGVjIDIsIDIwMTYgYXQgMzowNCBQTSwgS2FtYmxl
LCBOaXRpbiBBDQo+Pj4+IDxOaXRpbi5LYW1ibGVAdGVyYWRhdGEuY29tPiB3cm90ZToNCj4+Pj4+
IA0KPj4+Pj4gSXMgYW55Ym9keSB1c2luZyByZWFsIFJBRE9TIG9iamVjdCBjbGFzc2VzIG9uIGNl
cGggY2x1c3RlcnM/IEFueSBvZiB0aGVtIG9uIGdpdGh1Yj8NCj4+Pj4+IEkgd291bGQgbGlrZSB0
byBsb29rIGF0IHNvbWUgb2YgdGhlIHJlYWwgd29ybGQgZXhhbXBsZXMgaWYgaXQgaXMgdGhlcmUu
DQo+Pj4+PiBBbmQgbW9yZSBkb2N1bWVudGF0aW9uIG9mIHRoaXMgZmVhdHVyZSB3b3VsZCBkZWZp
bml0ZWx5IGhlbHAgdG9vLg0KPj4+PiANCj4+Pj4gV2UgdXNlIG9iamVjdCBjbGFzc2VzIFswXSBm
b3IgYSBkaXN0cmlidXRlZCBzaGFyZWQgbG9nIFsxXSBvbiBDZXBoLg0KPj4+PiANCj4+Pj4gWzBd
OiBodHRwczovL2dpdGh1Yi5jb20vbm9haGRlc3UvY2VwaC9ibG9iL3psb2cvamV3ZWwvc3JjL2Ns
cy96bG9nL2Nsc196bG9nLmNjDQo+Pj4+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL25vYWhkZXN1
L3psb2cNCj4+IA0KDQo=
