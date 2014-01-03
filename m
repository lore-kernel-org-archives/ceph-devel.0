From: Noah Watkins <noah.watkins-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: how to use the function ceph_open_layout
Date: Fri, 3 Jan 2014 08:07:56 -0800
Message-ID: <CA+Hcz58PYDCDp5JwhDTx9xayRq6tQBJJpnBJtUHEQrQN1qiCMA@mail.gmail.com>
References: <28fa4e4e.af9f.14356a4e251.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <28fa4e4e.af9f.14356a4e251.Coremail.wkp4666-KN7UnAbNpbg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: =?UTF-8?B?6bmP?= <wkp4666-KN7UnAbNpbg@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

WW91J2xsIG5lZWQgdG8gcmVnaXN0ZXIgdGhlIG5ldyBwb29sIHdpdGggdGhlIE1EUzoKCiAgICBj
ZXBoIG1kcyBhZGRfZGF0YV9wb29sIDxwb29sIGlkPgoKT24gVGh1LCBKYW4gMiwgMjAxNCBhdCA5
OjQ4IFBNLCDpuY8gPHdrcDQ2NjZAMTI2LmNvbT4gd3JvdGU6Cj4gIEhpIGFsbDsKPiB0b2RheSwg
IEkgd2FudCB0byB1c2UgdGhlIGZ1Y3Rpb24gb2YgY2VwaF9vcGVuX2xheW91dCgpIGluIGxpYmNl
cGhGcy5oCj4KPiBJIGNyZWF0IGEgbmV3IHBvb2wgIHN1Y2Nlc3MsCj4gIyByYWRvcyBta3Bvb2wg
ZGF0YTEKPiBhbmQgdGhlbiBJICBlZGl0IHRoZSBjb2RlIGxpa2UgdGhpczoKPgo+IGludCBmZCA9
IGNlcGhfb3Blbl9sYXlvdXQoIGNtb3VudCwgY19wYXRoLCBPX1JET05MWXxPX0NSRUFULCAwNjY2
LiAoMTw8MjIpLAo+IDEsICgxPDwyMikgLCAiZGF0YTEiKQo+Cj4gYW5kIHRoZW4gdGhlIGZkIGlz
IC0yMiEhISEhISEhIQo+Cj4gd2hlbiBJIHVzZSB0aGUgZGF0YSBwb29sICwgaXQgY2FuIHN1Y2Nl
c3MKPiBpbnQgZmQgPSBjZXBoX29wZW5fbGF5b3V0KCBjbW91bnQsIGNfcGF0aCwgT19SRE9OTFl8
T19DUkVBVCwgMDY2Ni4gKDE8PDIyKSwKPiAxLCAoMTw8MjIpICwgImRhdGEiKQo+Cj4gdGhlIGNl
cGhfb3Blbl9sYXlvdXQgc3VwcG9ydCByZWFkL3dyaXRlIHRvIGEgbmV3IHBvb2w/Pz8KPgo+ICAg
ICAgICAgICAgICB0aGlua3MgeW91IGZvciB0aGUgaGVscCEKPiB5b3VzICEKPgo+Cj4KPgo+Cj4K
Pgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGNlcGgtdXNlcnMgbWFpbGluZyBsaXN0Cj4gY2VwaC11c2Vyc0BsaXN0cy5jZXBoLmNvbQo+IGh0
dHA6Ly9saXN0cy5jZXBoLmNvbS9saXN0aW5mby5jZ2kvY2VwaC11c2Vycy1jZXBoLmNvbQo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmNlcGgtdXNlcnMg
bWFpbGluZyBsaXN0CmNlcGgtdXNlcnNAbGlzdHMuY2VwaC5jb20KaHR0cDovL2xpc3RzLmNlcGgu
Y29tL2xpc3RpbmZvLmNnaS9jZXBoLXVzZXJzLWNlcGguY29tCg==
