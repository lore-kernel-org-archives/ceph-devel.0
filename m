From: "Moreno, Orlando" <orlando.moreno@intel.com>
Subject: RE: Ceph FileStore optimization with Intel drive and scrubbing
 optimization
Date: Fri, 30 Jun 2017 01:06:14 +0000
Message-ID: <034AAD465C6CBE4F96D9FB98573A79A6026E8E0A@FMSMSX108.amr.corp.intel.com>
References: <F8851965-497D-464B-94E4-6D2F2C88476A@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17886 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751333AbdF3BGV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Jun 2017 21:06:21 -0400
In-Reply-To: <F8851965-497D-464B-94E4-6D2F2C88476A@alibaba-inc.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@newdream.net>, Mark Nelson <mnelson@redhat.com>, "??(??)" <caijin.caij@alibaba-inc.com>, Jianjian Huo <j.huo@alibaba-inc.com>

SGkgSmFtZXMsDQoNCkRvIHlvdSBrbm93IGhvdyBtYW55IHN5c3RlbXMgd2VyZSBydW5uaW5nIHRo
ZSBSQkQgY2xpZW50cz8NCg0KVGhhbmtzLA0KT3JsYW5kbw0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogY2VwaC1kZXZlbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpj
ZXBoLWRldmVsLW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIExJVSwgRmVpDQpT
ZW50OiBUaHVyc2RheSwgSnVuZSAyOSwgMjAxNyA5OjIwIEFNDQpUbzogQ2VwaCBEZXZlbG9wbWVu
dCA8Y2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc+DQpDYzogU2FnZSBXZWlsIDxzYWdlQG5ld2Ry
ZWFtLm5ldD47IE1hcmsgTmVsc29uIDxtbmVsc29uQHJlZGhhdC5jb20+OyDolKHov5so5p+P5769
KSA8Y2FpamluLmNhaWpAYWxpYmFiYS1pbmMuY29tPjsgSmlhbmppYW4gSHVvIDxqLmh1b0BhbGli
YWJhLWluYy5jb20+DQpTdWJqZWN0OiBDZXBoIEZpbGVTdG9yZSBvcHRpbWl6YXRpb24gd2l0aCBJ
bnRlbCBkcml2ZSBhbmQgc2NydWJiaW5nIG9wdGltaXphdGlvbg0KDQpIaSAgQWxsLA0KICBCZWxv
dyBsaW5rIGlzIHRoZSBzbGlkZXMgd2UgcHJlc2VudGVkIHRvZGF5IGluIENlcGggd2Vla2x5IHBl
cmZvcm1hbmNlIG1lZXRpbmcgcmVnYXJkaW5nIHRvIENlcGggRmlsZXN0b3JlIG9wdGltaXphdGlv
biB3aXRoIEludGVsIGRyaXZlIGFuZCBzY3J1YmJpbmcgb3B0aW1pemF0aW9uLg0KDQogIGh0dHBz
Oi8vd3d3LnNsaWRlc2hhcmUubmV0L2p1cGl0dXJsaXUvY2VwaC1maWxlc3RvcmUtd2l0aC1vcHRh
bmUtZHJpdmUtc2NydWItb3B0aW1pemF0aW9uDQoNCiAgUGxlYXNlIGZlZWwgZnJlZSB0byBsZXQg
dXMga25vdyBpZiB5b3UgaGF2ZSBhbnkgcXVlc3Rpb25zLg0KICANCiAgIFJlZ2FyZHMsDQogICBK
YW1lcyANCiAgIEFsaWJhYmEgU3RvcmFnZSBUZWFtIA0KDQoNCi0tDQpUbyB1bnN1YnNjcmliZSBm
cm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgY2VwaC1kZXZlbCIgaW4g
dGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcgTW9yZSBt
YWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5o
dG1sDQo=
