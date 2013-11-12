From: Noah Watkins <noah.watkins-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: how to use rados_exec
Date: Tue, 12 Nov 2013 05:57:19 -0800
Message-ID: <CA+Hcz592nGMGiwafVMxG=8C7WB+fN8jCWg+A1Y5z=GmUqfx=zg@mail.gmail.com>
References: <47c23d46.20e71.1424b8f1407.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <47c23d46.20e71.1424b8f1407.Coremail.wkp4666-KN7UnAbNpbg@public.gmane.org>
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

VGhlIGNsc19jcnlwdG8uY2MgZmlsZSBpbiBzcmMvIGhhc24ndCBiZWVuIGluY2x1ZGVkIGluIHRo
ZSBDZXBoCmNvbXBpbGF0aW9uIGZvciBhIGxvbmcgdGltZS4gVGFrZSBhIGxvb2sgYXQgc3JjL2Ns
cy8qIGZvciBhIGxpc3Qgb2YKbW9kdWxlcyB0aGF0IGFyZSBjb21waWxlZC4gSW4gcGFydGljdWxh
ciwgdGhlcmUgaXMgYSAiSGVsbG8gV29ybGQiCmV4YW1wbGUgdGhhdCBpcyBuaWNlLiBUaGVzZSBz
aG91bGQgd29yayBmb3IgeW91IG91dC1vZi10aGUtYm94LgoKWW91IGNvdWxkIGFsc28gdHJ5IHRv
IGNvbXBpbGUgY2xzX2NyeXB0by5jYyAoZm9sbG93IHRoZSBiYXNpYwpzdHJ1Y3R1cmUgb2Ygc3Jj
L2Nscy9NYWtlZmlsZS5hbSkuCgotTm9haAoKT24gVHVlLCBOb3YgMTIsIDIwMTMgYXQgMTowNSBB
TSwg6bmPIDx3a3A0NjY2QDEyNi5jb20+IHdyb3RlOgo+ICBIaSBhbGwhCj4gICAgICAgIGxvbmcg
dGltZSBubyBzZWUhCj4gICAgICAgIEkgIHdhbnQgdG8gdXNlIHRoZSBmdW5jdGlvbiByYWRvc19l
eGVjLCAgYW5kIEkgZm91bmQgIHRoZSBjbGFzcwo+IGNsc19jcnlwdG8uY2MgIGluIHRoZSAgY29k
ZSBzb3VyY2Ugb2YgY2VwaDsKPiBzbyBJICBydW4gdGhlIGZ1bnRpb24gbGlrZSB0aGlzOgo+Cj4g
ICAgICAgIHJhZG9zX2V4ZWMoaW9jdHgsICJmb29fb2JqZWN0IiwgImNyeXB0byIgLCAibWQ1Iiwg
YnVmLAo+IHNpemVvZihidWYpLGJ1ZjIsIHNpemVvZihidWYyKSApCj4KPiBhbnQgdGhlIGZ1bmN0
aW9uIHJldHVybiAgIG9wZXJhdGlvbiBub3Qgc3VwcG9ydCEKPgo+ICAgICAgSSBjaGVjayB0aGUg
c291cmNlIG9mIGNlcGggLCBhbmQgZmluZCB0aGF0ICBjbHNfY3J5cHRvLmNjIGlzIG5vdAo+IGJ1
aWxk44CCaG93IGNhbiBJIGJ1bGlkIHRoZSBjbGFzcyBhbmQgcnVuIGl0IQo+Cj4KPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gY2VwaC11c2VycyBt
YWlsaW5nIGxpc3QKPiBjZXBoLXVzZXJzQGxpc3RzLmNlcGguY29tCj4gaHR0cDovL2xpc3RzLmNl
cGguY29tL2xpc3RpbmZvLmNnaS9jZXBoLXVzZXJzLWNlcGguY29tCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KY2VwaC11c2VycyBtYWlsaW5nIGxpc3QK
Y2VwaC11c2Vyc0BsaXN0cy5jZXBoLmNvbQpodHRwOi8vbGlzdHMuY2VwaC5jb20vbGlzdGluZm8u
Y2dpL2NlcGgtdXNlcnMtY2VwaC5jb20K
