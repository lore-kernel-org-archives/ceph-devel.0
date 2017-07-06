From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 15:39:59 -0400
Message-ID: <CA+aFP1B4iDjCLtpLsdPseuVfrysiatr3Bwb-i5OfZP8dt-WRpg@mail.gmail.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
	<CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
	<c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
	<CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
	<a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
	<CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
	<e39eba47-ae4d-05bb-41cd-928565324d6c@corp.ovh.com>
	<CA+aFP1CXkF914u1qboCC1OnK3Qqqs7w0NctDxG82u=gpmUcxmA@mail.gmail.com>
	<20170706192508.GG9832@mailware>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20170706192508.GG9832@mailware>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <branch-WWSZ/45jja/Y+gB93Hw7NA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

T24gVGh1LCBKdWwgNiwgMjAxNyBhdCAzOjI1IFBNLCBQaW90ciBEYcWCZWsgPGJyYW5jaEBwcmVk
aWN0b3Iub3JnLnBsPiB3cm90ZToKPiBJcyB0aGF0IGRlZXAgY29weSBhbiBlcXVpdmFsZW50IG9m
IHdoYXQKPiBKZXdlbCBsaWJyYmQgZGlkIGF0IHVuc3BlY2lmaWVkIHBvaW50IG9mIHRpbWUsIG9y
IGV4dHJhIG9uZT8KCkl0J3MgZXF1aXZhbGVudCAvIHJlcGxhY2VtZW50IC0tIG5vdCBhbiBhZGRp
dGlvbmFsIGNvcHkuIFRoaXMgd2FzCmNoYW5nZWQgdG8gc3VwcG9ydCBzY2F0dGVyL2dhdGhlciBJ
TyBBUEkgbWV0aG9kcyB3aGljaCB0aGUgbGF0ZXN0CnZlcnNpb24gb2YgUUVNVSBub3cgZGlyZWN0
bHkgdXRpbGl6ZXMgKGVsaW1pbmF0aW5nIHRoZSBuZWVkIGZvciBhCmJvdW5jZS1idWZmZXIgY29w
eSBvbiBldmVyeSBJTykuCgpPbmNlIHdlIGdldCB0aGF0IGxpYnJhZG9zIGlzc3VlIHJlc29sdmVk
LCB0aGF0IGluaXRpYWwgbGlicmJkIElPCmJ1ZmZlciBjb3B5IHdpbGwgYmUgZHJvcHBlZCBhbmQg
bGlicmJkIHdpbGwgYmVjb21lIHplcm8tY29weSBmb3IgSU8KKGF0IGxlYXN0IHRoYXQncyB0aGUg
Z29hbCkuIFRoYXQncyB3aHkgSSBhbSByZWNvbW1lbmRpbmcgdGhhdCB5b3UganVzdAphc3N1bWUg
bm9ybWFsIEFJTyBzZW1hbnRpY3MgYW5kIG5vdCB0cnkgdG8gb3B0aW1pemUgZm9yIEx1bWlub3Vz
IHNpbmNlCnBlcmhhcHMgdGhlIG5leHQgcmVsZWFzZSB3aWxsIGhhdmUgdGhhdCBpbXBsZW1lbnRh
dGlvbiBkZXRhaWwgb2YgdGhlCmV4dHJhIGNvcHkgcmVtb3ZlZC4KCi0tIApKYXNvbgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpjZXBoLXVzZXJzIG1haWxp
bmcgbGlzdApjZXBoLXVzZXJzQGxpc3RzLmNlcGguY29tCmh0dHA6Ly9saXN0cy5jZXBoLmNvbS9s
aXN0aW5mby5jZ2kvY2VwaC11c2Vycy1jZXBoLmNvbQo=
