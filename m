From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: rbd rm snap on image with exclusive lock
Date: Wed, 25 Oct 2017 09:56:13 -0400
Message-ID: <CA+aFP1A11JTpZF8e2EreZhvX7U5wGvTZqHdRerg0gkC+jpZmMQ@mail.gmail.com>
References: <6a5fdefb-cd9e-8a29-b668-945312e9827f@corp.ovh.com>
 <CA+aFP1BA-PvFSeJTYbJYmz1guee+N7CvM0E8p_h0pbP=4dO+4g@mail.gmail.com>
 <49a2cf70-fb3b-45bb-fa36-283c4a6bc310@corp.ovh.com>
 <CA+aFP1DHuYzsrsvoowukkGWGowe1P06vyYSk2oqRjXqkRtstjg@mail.gmail.com>
 <b1b7b3c9-679d-5371-5fe5-320348da7cec@corp.ovh.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <b1b7b3c9-679d-5371-5fe5-320348da7cec-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
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

VGhhbmtzIC0tIGxldCBtZSBrbm93LiBJbiB0aGUgZnV0dXJlLCB5b3UgbWF5IHdhbnQgdG8gY29u
c2lkZXIgaGF2aW5nCmxpYnJiZCBjcmVhdGUgYW4gYWRtaW4gc29ja2V0IHNvIHRoYXQgeW91IGNh
biBjaGFuZ2UgKGNlcnRhaW4pCnNldHRpbmdzIG9yIGludGVyYWN0IHcvIHRoZSBwcm9jZXNzIHcv
byByZXN0YXJ0aW5nIGl0LgoKT24gV2VkLCBPY3QgMjUsIDIwMTcgYXQgOTo1NCBBTSwgUGlvdHIg
RGHFgmVrIDxwaW90ci5kYWxla0Bjb3JwLm92aC5jb20+IHdyb3RlOgo+IE9uIDE3LTEwLTI1IDAz
OjMwIFBNLCBKYXNvbiBEaWxsYW1hbiB3cm90ZToKPj4KPj4gSG1tLCBoYXJkIHRvIHNheSBvZmYg
dGhlIHRvcCBvZiBteSBoZWFkLiBJZiB5b3UgY291bGQgZW5hYmxlICJkZWJ1Zwo+PiBsaWJyYmQg
PSAyMCIgbG9nZ2luZyBvbiB0aGUgYnVnZ3kgY2xpZW50IHRoYXQgb3ducyB0aGUgbG9jaywgY3Jl
YXRlIGEKPj4gbmV3IHNuYXBzaG90LCBhbmQgYXR0ZW1wdCB0byBkZWxldGUgaXQsIGl0IHdvdWxk
IGJlIGludGVyZXN0aW5nIHRvCj4+IHZlcmlmeSB0aGF0IHRoZSBpbWFnZSBpcyBiZWluZyBwcm9w
ZXJseSByZWZyZXNoZWQuCj4KPgo+IEknZCBsb3ZlIHRvLCBidXQgdGhhdCB3b3VsZCByZXF1aXJl
IHVzIHRvIHJlc3RhcnQgdGhhdCBjbGllbnQgLSBub3QgYW4KPiBvcHRpb24uIFdlJ2xsIHRyeSB0
byByZXByb2R1Y2UgdGhpcyBzb21laG93IGFueXdheSBhbmQgbGV0IHlvdSBrbm93IGlmCj4gc29t
ZXRoaW5nIGludGVyZXN0aW5nIHNob3dzIHVwLgo+Cj4KPiAtLQo+IFBpb3RyIERhxYJlawo+IHBp
b3RyLmRhbGVrQGNvcnAub3ZoLmNvbQo+IGh0dHBzOi8vd3d3Lm92aC5jb20vdXMvCgoKCi0tIApK
YXNvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpjZXBo
LXVzZXJzIG1haWxpbmcgbGlzdApjZXBoLXVzZXJzQGxpc3RzLmNlcGguY29tCmh0dHA6Ly9saXN0
cy5jZXBoLmNvbS9saXN0aW5mby5jZ2kvY2VwaC11c2Vycy1jZXBoLmNvbQo=
