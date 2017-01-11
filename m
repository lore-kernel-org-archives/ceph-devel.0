From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Any librados C API users out there?
Date: Wed, 11 Jan 2017 12:37:14 -0500
Message-ID: <CA+aFP1B5K-cCcTmp5k4PrfRLFP3=eoVwZk4Fqa=NGd4ZhBGJWg@mail.gmail.com>
References: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051@corp.ovh.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <8d5e71b7-c0f2-0f6f-b38e-03e72f441051-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

KzEKCkknZCBiZSBoYXBweSB0byB0d2VhayB0aGUgaW50ZXJuYWxzIG9mIGxpYnJiZCB0byBzdXBw
b3J0IHBhc3MtdGhyb3VnaApvZiBDIGJ1ZmZlcnMgYWxsIHRoZSB3YXkgdG8gbGlicmFkb3MuIGxp
YnJiZCBjbGllbnRzIGxpa2UgUUVNVSB1c2UgdGhlCkMgQVBJIGFuZCB0aGlzIGN1cnJlbnRseSBy
ZXN1bHRzIGluIHNldmVyYWwgZXh0cmEgY29waWVzIChpbiBsaWJyYmQKYW5kIGxpYnJhZG9zKS4K
Ck9uIFdlZCwgSmFuIDExLCAyMDE3IGF0IDExOjQ0IEFNLCBQaW90ciBEYcWCZWsgPHBpb3RyLmRh
bGVrQGNvcnAub3ZoLmNvbT4gd3JvdGU6Cj4gSGVsbG8sCj4KPiBBcyB0aGUgc3ViamVjdCBzYXlz
IC0gYXJlIGhlcmUgYW55IHVzZXJzL2NvbnN1bWVycyBvZiBsaWJyYWRvcyBDIEFQST8gSSdtCj4g
YXNraW5nIGJlY2F1c2Ugd2UncmUgcmVzZWFyY2hpbmcgaWYgdGhpcyBQUjoKPiBodHRwczovL2dp
dGh1Yi5jb20vY2VwaC9jZXBoL3B1bGwvMTIyMTYgd2lsbCBiZSBhY3R1YWxseSBiZW5lZmljaWFs
IGZvcgo+IGxhcmdlciBncm91cCBvZiB1c2Vycy4gVGhpcyBQUiBhZGRzIGEgYnVuY2ggb2YgbmV3
IEFQSXMgdGhhdCBwZXJmb3JtIG9iamVjdAo+IHdyaXRlcyB3aXRob3V0IGludGVybWVkaWF0ZSBk
YXRhIGNvcHksIHdoaWNoIHdpbGwgcmVkdWNlIGNwdSBhbmQgbWVtb3J5IGxvYWQKPiBvbiBjbGll
bnRzLiBJZiB5b3UncmUgdXNpbmcgbGlicmFkb3MgQyBBUEkgZm9yIG9iamVjdCB3cml0ZXMsIGZl
ZWwgZnJlZSB0bwo+IGNvbW1lbnQgaGVyZSBvciBpbiB0aGUgcHVsbCByZXF1ZXN0Lgo+Cj4KPiAt
LQo+IFBpb3RyIERhxYJlawo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGNlcGgtdXNlcnMgbWFpbGluZyBsaXN0Cj4gY2VwaC11c2Vyc0BsaXN0
cy5jZXBoLmNvbQo+IGh0dHA6Ly9saXN0cy5jZXBoLmNvbS9saXN0aW5mby5jZ2kvY2VwaC11c2Vy
cy1jZXBoLmNvbQoKCgotLSAKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KY2VwaC11c2VycyBtYWlsaW5nIGxpc3QKY2VwaC11c2Vyc0BsaXN0cy5j
ZXBoLmNvbQpodHRwOi8vbGlzdHMuY2VwaC5jb20vbGlzdGluZm8uY2dpL2NlcGgtdXNlcnMtY2Vw
aC5jb20K
