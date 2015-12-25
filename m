From: Dong Wu <archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: why not add (offset,len) to pglog
Date: Fri, 25 Dec 2015 14:23:09 +0800
Message-ID: <CAAL-TMcndHOViDmearR5zb+XyEbvRnaV2ur-AMavfzvyDK=r6w@mail.gmail.com>
References: <CAAL-TMddLQ-fxNnPcZZhtd8Evk6j+h6PiNTu+KapyPsRCeW9bw@mail.gmail.com>
	<CANE=7sUenL8oO_8CWP_VJJ_qWPWM2pLF6UxpFb-9AGFePT46oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANE=7sUenL8oO_8CWP_VJJ_qWPWM2pLF6UxpFb-9AGFePT46oA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?B?5aea5a6BKOeglOWFrSDnpo/lt54p?= <yaoning-BACTKzvjvLCPt1CcHtbs0g@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

VGhhbmtzLCBmcm9tIHRoaXMgcHVsbCByZXF1ZXN0IEkgbGVhcm5lZCB0aGF0IHRoaXMgaXNzdWUg
aXMgbm90CmNvbXBsZXRlZCwgaXMgdGhlcmUgYW55IG5ldyBwcm9ncmVzcyBvZiB0aGlzIGlzc3Vl
PwoKMjAxNS0xMi0yNSAxMjozMCBHTVQrMDg6MDAgWGluemUgQ2hpICjkv6Hms70pIDx4bWR4Y3h6
QGdtYWlsLmNvbT46Cj4gWWVhaCwgVGhpcyBpcyBnb29kIGlkZWEgZm9yIHJlY292ZXJ5LCBidXQg
bm90IGZvciBiYWNrZmlsbC4KPiBAWWFvTmluZyBoYXZlIHB1bGwgYSByZXF1ZXN0IGFib3V0IHRo
aXMKPiBodHRwczovL2dpdGh1Yi5jb20vY2VwaC9jZXBoL3B1bGwvMzgzNyB0aGlzIHllYXIuCj4K
PiAyMDE1LTEyLTI1IDExOjE2IEdNVCswODowMCBEb25nIFd1IDxhcmNoZXIud3Vkb25nQGdtYWls
LmNvbT46Cj4+IEhpLAo+PiBJIGhhdmUgZG91YnQgYWJvdXQgcGdsb2csIHRoZSBwZ2xvZyBjb250
YWlucyAob3Asb2JqZWN0LHZlcnNpb24pIGV0Yy4KPj4gd2hlbiBwZWVyaW5nLCB1c2UgcGdsb2cg
dG8gY29uc3RydWN0IG1pc3NpbmcgbGlzdCx0aGVuIHJlY292ZXIgdGhlCj4+IHdob2xlIG9iamVj
dCBpbiBtaXNzaW5nIGxpc3QgZXZlbiBpZiBkaWZmZXJlbnQgZGF0YSBhbW9uZyByZXBsaWNhcyBp
cwo+PiBsZXNzIHRoZW4gYSB3aG9sZSBvYmplY3QgZGF0YShlZyw0TUIpLgo+PiB3aHkgbm90IGFk
ZCAob2Zmc2V0LGxlbikgdG8gcGdsb2c/IElmIHNvLCB0aGUgbWlzc2luZyBsaXN0IGNhbiBjb250
YWluCj4+IChvYmplY3QsIG9mZnNldCwgbGVuKSwgdGhlbiB3ZSBjYW4gcmVkdWNlIHJlY292ZXIg
ZGF0YS4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj4gY2VwaC11c2VycyBtYWlsaW5nIGxpc3QKPj4gY2VwaC11c2Vyc0BsaXN0cy5jZXBoLmNvbQo+
PiBodHRwOi8vbGlzdHMuY2VwaC5jb20vbGlzdGluZm8uY2dpL2NlcGgtdXNlcnMtY2VwaC5jb20K
Pgo+Cj4KPiAtLQo+IFJlZ2FyZHMsCj4gWGluemUgQ2hpCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmNlcGgtdXNlcnMgbWFpbGluZyBsaXN0CmNlcGgtdXNl
cnNAbGlzdHMuY2VwaC5jb20KaHR0cDovL2xpc3RzLmNlcGguY29tL2xpc3RpbmZvLmNnaS9jZXBo
LXVzZXJzLWNlcGguY29tCg==
