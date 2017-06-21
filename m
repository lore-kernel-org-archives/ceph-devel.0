From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Subject: Re: Sparse file info in filestore not propagated to
 other OSDs
Date: Wed, 21 Jun 2017 15:47:03 +0200
Message-ID: <91c91567-6986-3cc4-60d1-221c60c80fa7@corp.ovh.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
	<alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
	<d4bde447-f179-aeca-bac5-636fa40ccba5@corp.ovh.com>
	<415c9590-ab96-01b6-3c49-553b0d9529fa@sadziu.pl>
	<alpine.DEB.2.11.1706141340520.3646@piezo.novalocal>
	<e89cc0ed-14f0-b092-784f-784c8c967e9d@corp.ovh.com>
	<CA+aFP1DJ3L3Pg0r4Pj3o7JoNTNnBRRs0u_nnb2JYz4nGxafUTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+aFP1DJ3L3Pg0r4Pj3o7JoNTNnBRRs0u_nnb2JYz4nGxafUTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

T24gMTctMDYtMjEgMDM6MzUgUE0sIEphc29uIERpbGxhbWFuIHdyb3RlOgo+IE9uIFdlZCwgSnVu
IDIxLCAyMDE3IGF0IDM6MDUgQU0sIFBpb3RyIERhxYJlayA8cGlvdHIuZGFsZWtAY29ycC5vdmgu
Y29tPiB3cm90ZToKPj4gSSBzYXcgdGhhdCBSQkQgKGxpYnJiZCkgZG9lcyB0aGF0IC0gcmVwbGFj
aW5nIHdyaXRlcyB3aXRoIGRpc2NhcmRzIHdoZW4KPj4gYnVmZmVyIGNvbnRhaW5zIG9ubHkgemVy
b3MuIFNvbWUgY29kZSB0aGF0IGRvZXMgdGhlIHNhbWUgaW4gbGlicmFkb3MgY291bGQKPj4gYmUg
YWRkZWQgYW5kIGl0IHNob3VsZG4ndCBpbXBhY3QgcGVyZm9ybWFuY2UgbXVjaCwgY3VycmVudCBp
bXBsZW1lbnRhdGlvbiBvZgo+PiBtZW1faXNfemVybyBpcyBmYXN0IGFuZCBzaG91bGRuJ3QgYmUg
YSBiaWcgcHJvYmxlbS4KPiAKPiBJJ20gcHJldHR5IHN1cmUgdGhlIG9ubHkgcGxhY2Ugd2hlcmUg
bGlicmJkIGNvbnZlcnRzIGEgd3JpdGUgdG8gYQo+IGRpc2NhcmQgaXMgYWN0dWFsbHkgdGhlIHNw
ZWNpYWxpemVkICJ3cml0ZXNhbWUiIG9wZXJhdGlvbiB1c2VkIGJ5Cj4gdGNtdS1ydW5uZXIsIGFz
IGFuIG9wdGltaXphdGlvbiBmb3IgRVNYJ3MgaW5pdGlhbGl6YXRpb24gb2YgYSBuZXcKPiBpbWFn
ZS4KClN0aWxsLCBJIHNhdyBpdCEgOy0pCgotLSAKUGlvdHIgRGHFgmVrCnBpb3RyLmRhbGVrQGNv
cnAub3ZoLmNvbQpodHRwczovL3d3dy5vdmguY29tL3VzLwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpjZXBoLXVzZXJzIG1haWxpbmcgbGlzdApjZXBoLXVz
ZXJzQGxpc3RzLmNlcGguY29tCmh0dHA6Ly9saXN0cy5jZXBoLmNvbS9saXN0aW5mby5jZ2kvY2Vw
aC11c2Vycy1jZXBoLmNvbQo=
