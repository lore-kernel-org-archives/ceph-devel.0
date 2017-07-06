From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 14:02:39 -0400
Message-ID: <CA+aFP1CXkF914u1qboCC1OnK3Qqqs7w0NctDxG82u=gpmUcxmA@mail.gmail.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
	<CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
	<c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
	<CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
	<a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
	<CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
	<e39eba47-ae4d-05bb-41cd-928565324d6c@corp.ovh.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <e39eba47-ae4d-05bb-41cd-928565324d6c-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
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
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

T24gVGh1LCBKdWwgNiwgMjAxNyBhdCAxMTo0NiBBTSwgUGlvdHIgRGHFgmVrIDxwaW90ci5kYWxl
a0Bjb3JwLm92aC5jb20+IHdyb3RlOgo+IEhvdyBhYm91dCBhIGh5YnJpZCBzb2x1dGlvbj8gS2Vl
cCB0aGUgb2xkIHJiZF9haW9fd3JpdGUgY29udHJhY3QgKGRvbid0IGNvcHkKPiB0aGUgYnVmZmVy
IHdpdGggdGhlIGFzc3VtcHRpb24gdGhhdCBpdCB3b24ndCBjaGFuZ2UpIGFuZCBpbnN0ZWFkIG9m
Cj4gY29uc3RydWN0aW5nIGJ1ZmZlcmxpc3QgY29udGFpbmluZyBidWZmZXJwdHIgdG8gY29waWVk
IGRhdGEsIGNvbnN0cnVjdCBhCj4gYnVmZmVybGlzdCBjb250YWluaW5nIGJ1ZmZlcnB0ciBtYWRl
IHdpdGggY3JlYXRlX3N0YXRpYyh1c2VyX2J1ZmZlcik/CgpXZSBtdXN0IGJlIHRhbGtpbmcgcGFz
dCBlYWNoIG90aGVyIC0tIHRoZXJlIHdhcyBuZXZlciBzdWNoIGEKcHJlLUx1bXVub3VzIGNvbnRy
YWN0IHNpbmNlICgxKSBpdCBkaWQgY29weSB0aGUgYnVmZmVyIG9uIGV2ZXJ5IElPIGFuZAooMikg
aXQgY291bGQgaGF2ZSBwb3RlbnRpYWxseSBjb3BpZWQgYmVmb3JlIHRoZSAncmJkX2Fpb193cml0
ZScgY2FsbApyZXR1cm5lZCBvciBhZnRlciAoYnV0IGF0IGxlYXN0IGJlZm9yZSB0aGUgY29tcGxl
dGlvbiB3YXMgZmlyZWQpLiBKdXN0CmJlY2F1c2UgaXQgd29ya3Mgc29tZSB0aW1lcyBkb2Vzbid0
IG1lYW4gaXQgd291bGQgYWx3YXlzIHdvcmsgc2luY2UgaXQKd291bGQgYmUgYSByYWNlIGJldHdl
ZW4gdHdvIHRocmVhZHMuCgpVbmZvcnR1bmF0ZWx5LCB1bnRpbCB0aGUgbGlicmFkb3MgaXNzdWUg
aXMgc29sdmVkLCB5b3Ugd2lsbCBzdGlsbCBoYXZlCnRvIGNvcHkgdGhlIGRhdGEgb25jZSB3aGVu
IHVzaW5nIHRoZSBDKysgQVBJLiBUaGUgb25seSBhZHZhbnRhZ2UgaXMKdGhhdCB5b3Ugd291bGQg
YmUgcmVzcG9uc2libGUgZm9yIHRoZSBjb3B5aW5nIGFuZCBpdCB3b3VsZCBvbmx5IG5lZWQKdG8g
YmUgcGVyZm9ybWVkIG9uY2UgaW5zdGVhZCBvZiB0d2ljZS4KCi0tIApKYXNvbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpjZXBoLXVzZXJzIG1haWxpbmcg
bGlzdApjZXBoLXVzZXJzQGxpc3RzLmNlcGguY29tCmh0dHA6Ly9saXN0cy5jZXBoLmNvbS9saXN0
aW5mby5jZ2kvY2VwaC11c2Vycy1jZXBoLmNvbQo=
