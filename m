From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: RADOS Object class capabilities
Date: Mon, 9 Jan 2017 17:48:27 +0000
Message-ID: <8119E63B-CEDA-4FA7-BFA6-38090987DCF7@Teradata.com>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
 <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
 <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com>
 <CAB2gnbVn0U_G12L8XV=hbznB2i_TMo40TpC5cVzJZKOr_MAQ7Q@mail.gmail.com>
 <64D605E0-8851-4F60-B0AB-864CBDA7B3F7@Teradata.com>
 <208C08FF-0104-425C-B7AA-B0930A76F46E@Teradata.com>
 <CAB2gnbUEeS6AynJ0AjdpJ+MbiGSq_HUkBS-KdnXrke1wiJYsyA@mail.gmail.com>
 <E41C6528-D51D-4165-87D5-0DBBDF6B9F5F@Teradata.com>
 <515514A8-CE49-48FD-8939-74BE82F30FDE@Teradata.com>
 <1004503707.6221.1483952298347@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33889 "EHLO
        rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S967491AbdAIRs3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 12:48:29 -0500
In-Reply-To: <1004503707.6221.1483952298347@ox.pcextreme.nl>
Content-Language: en-US
Content-ID: <C8245F01FF3E3C4EA63190F5FC206440@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Noah Watkins <noahwatkins@gmail.com>, Joao Eduardo Luis <joao@suse.de>, "nebil.benmabrouk@orange.com" <nebil.benmabrouk@orange.com>, Brad Hubbard <bhubbard@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

DQo+IE9uIEphbiA5LCAyMDE3LCBhdCAxMjo1OCBBTSwgV2lkbyBkZW4gSG9sbGFuZGVyIDx3aWRv
QDQyb24uY29tPiB3cm90ZToNCj4gDQo+IA0KPj4gT3AgOSBqYW51YXJpIDIwMTcgb20gMzo1MiBz
Y2hyZWVmICJLYW1ibGUsIE5pdGluIEEiIDxOaXRpbi5LYW1ibGVAVGVyYWRhdGEuY29tPjoNCj4+
IA0KPj4gDQo+PiBTbyBmYXIgSSBhbSBpbXByZXNzZWQgdG8gZmluZCBvdXQgd2hhdCB0aGUgUkFE
T1Mgb2JqZWN0IGNsYXNzIGNhbiBkby4NCj4+IElzIGl0IHBvc3NpYmxlIHRvIG92ZXJyaWRlIG9u
ZSBvZiB0aGUgUkFET1MgYmFzaWMgZnVuY3Rpb25zIG9yIGl04oCZcyBiZWhhdmlvciBzdWNoIGFz
IG9iamVjdCANCj4+IHJlYWQvd3JpdGUgZm9yIGFsbC9vdGhlciBjbGllbnRzLCBieSBpbXBsZW1l
bnRpbmcgYSBSQURPUyBvYmplY3QgY2xhc3M/DQo+PiANCj4gDQo+IEFmYWlrIG5vdC4gVXNpbmcg
cmFkb3NfZXhlYygpIHlvdSBjYW4gZXhlY3V0ZSBmdW5jdGlvbnMgZnJvbSB0aGUgb2JqZWN0IGNs
YXNzLCBidXQgYSBvYmplY3QgY2xhc3MgZG9uJ3Qgb3ZlcnJpZGUgZXhpc3RpbmcgUkFET1MgZnVu
Y3Rpb25hbGl0eS4NCj4gDQo+IFdpZG8NCg0KVGhhbmtzIGZvciB0aGUgcHJlY2lzZSBhbnN3ZXIu
DQoNClJlZ2FyZHMsDQpOaXRpbg0KDQo+IA0KPj4gSXQgd2lsbCBiZSBxdWlldCBwb3dlcmZ1bCBh
bmQgZGFuZ2Vyb3VzIGlmIGlzIHN1cHBvcnRlZC4NCj4+IA0KPj4gVGhhbmtzICYgUmVnYXJkcywN
Cj4+IE5pdGluDQo+PiANCj4+IE7vv73vv73vv73vv73vv71y77+977+9ee+/ve+/ve+/vWLvv71Y
77+977+9x6d277+9Xu+/vSneunsubu+/vSvvv73vv73vv71677+9XXrvv73vv73vv717YXnvv70d
yofame+/vSxqB++/ve+/vWbvv73vv73vv71o77+977+977+9eu+/vR7vv71377+977+977+9DO+/
ve+/ve+/vWo6K3bvv73vv73vv71377+9au+/vW3vv73vv73vv73vv70H77+977+977+977+9elor
77+977+93aJqIu+/ve+/vSHvv71pDQoNCg==
