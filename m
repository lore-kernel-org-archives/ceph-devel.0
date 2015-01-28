From: John Spray <john.spray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: chattr +i not working with cephfs
Date: Wed, 28 Jan 2015 18:01:25 +0000
Message-ID: <CAGd4Wr14SQz_0V597ZwBDxEtYrcQuPXUheH9pEZX1SB_3nxEuA@mail.gmail.com>
References: <CA+9C14YA03rUAWs8N9kyPNJWyC3hBmo6SPwoLdOAe4CGA4HY9w@mail.gmail.com>
	<CAGd4Wr3f5+w4Aqv8RAcPHeJWhWwTF-yXpfQGnjkQ9fF6D7dPgw@mail.gmail.com>
	<CAC6JEv_cNro4iNZSxX=n+T6Zp60mEXY+0iJzh4HT-p9+6bizGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC6JEv_cNro4iNZSxX=n+T6Zp60mEXY+0iJzh4HT-p9+6bizGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

T24gV2VkLCBKYW4gMjgsIDIwMTUgYXQgNToyMyBQTSwgR3JlZ29yeSBGYXJudW0gPGdyZWdAZ3Jl
Z3M0Mi5jb20+IHdyb3RlOgo+IE15IGNvbmNlcm4gaXMgd2hldGhlciB3ZSBhcyB0aGUgRlMgYXJl
IHJlc3BvbnNpYmxlIGZvciBkb2luZyBhbnl0aGluZwo+IG1vcmUgdGhhbiBzdG9yaW5nIGFuZCBy
ZXR1cm5pbmcgdGhhdCBpbW11dGFibGUgZmxhZyDigJQgYXJlIHdlIHN1cHBvc2VkCj4gdG8gYmxv
Y2sgd3JpdGVzIHRvIGFueXRoaW5nIHRoYXQgaGFzIGl0IHNldD8gVGhhdCBjb3VsZCBiZSBtdWNo
Cj4gdHJpY2tpZXIuLi4KClRoZSBWRlMgbGF5ZXIgaXMgY2hlY2tpbmcgdGhlIGZsYWcgZm9yIHVz
LCBidXQgc29tZSBmaWxlc3lzdGVtcyBkbwpoYXZlIHBhdGhzIHdoZXJlIHRoZXkgbmVlZCB0byBk
byB0aGVpciBvd24gdG9vIChlLmcuIFhGUyBoYXMgdmFyaW91cwppb2N0bHMgdGhhdCBkbyBleHBs
aWNpdCBjaGVja3MgdG9vKS4gIEl0J3MgYWxzbyB1cCB0byB1cyB0byBwdWJsaXNoCnRoZSBTX0lN
TVVUQUJMRSBiaXQgdG8gdGhlIGlfZmxhZ3MgYXR0cmlidXRlIG9mIHRoZSBnZW5lcmljIGlub2Rl
LApiYXNlZCBvbiB3aGVyZXZlci9ob3dldmVyIHdlIHN0b3JlIHRoZSBmbGFnIG91cnNlbHZlcy4K
CkZ1c2UgZG9lc24ndCBzZWVtIHRvIGhhdmUgYSBwYXRoIGZvciB1cyB0byB1cGRhdGUgaV9mbGFn
cyB0aG91Z2gsIHNvCml0IG1pZ2h0IGJlIHRoYXQgd2UgZWl0aGVyIGhhdmUgdG8gZXh0ZW5kIHRo
YXQgaW50ZXJmYWNlIG9yIGRvIHRoZQpjaGVja2luZyBvdXJzZWx2ZXMgaW4gdXNlcnNwYWNlIGlu
IG9yZGVyIHRvIHN1cHBvcnQgaXQgdGhlcmUuCgpKb2huCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmNlcGgtdXNlcnMgbWFpbGluZyBsaXN0CmNlcGgtdXNl
cnNAbGlzdHMuY2VwaC5jb20KaHR0cDovL2xpc3RzLmNlcGguY29tL2xpc3RpbmZvLmNnaS9jZXBo
LXVzZXJzLWNlcGguY29tCg==
