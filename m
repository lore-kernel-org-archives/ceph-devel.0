From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [filestore][journal][prepare_entry] rebuild
 data_align is 4086, maybe a bug
Date: Thu, 19 Oct 2017 17:11:52 -0700
Message-ID: <CAJ4mKGbTKFTNQP8YSLoo1Hb2Y4CFL71EcwDo3nNTyeoBJLVFrQ@mail.gmail.com>
References: <1CB94550540AE44E9CAAE8CD5AF40BF8AB72B935@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1CB94550540AE44E9CAAE8CD5AF40BF8AB72B935-LYFlsCYEEzr3cnzPNjVLboSsE/coCuR8pWgKQ6/u3Fg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: zhaomingyue <zhao.mingyue-vVzyEvZLFYE@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liuhao <liu.haoA-vVzyEvZLFYE@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

T24gVGh1LCBPY3QgMTksIDIwMTcgYXQgMTI6NTkgQU0sIHpoYW9taW5neXVlIDx6aGFvLm1pbmd5
dWVAaDNjLmNvbT4gd3JvdGU6Cj4gSGk6Cj4KPiB3aGVuIEkgYW5hbHl6ZWQgdGhlIHBlcmZvcm1h
bmNlIG9mIGNlcGgsIEkgZm91bmQgdGhhdCByZWJ1aWxkX2FsaWduZWQgd2FzCj4gdGltZS1jb25z
dW1pbmcsIGFuZCB0aGUgYW5hbHlzaXMgZm91bmQgdGhhdCByZWJ1aWxkIG9wZXJhdGlvbnMgd2Vy
ZQo+IHBlcmZvcm1lZCBldmVyeSB0aW1lLgo+Cj4KPgo+IFNvdXJjZSBjb2RlOgo+Cj4gRmlsZVN0
b3JlOjpxdWV1ZV90cmFuc2FjdGlvbnMKPgo+IOKAkz4gam91cm5hbC0+cHJlcGFyZV9lbnRyeShv
LT50bHMsICZ0YmwpOwo+Cj4gLT4gZGF0YV9hbGlnbiA9ICgoKnApLmdldF9kYXRhX2FsaWdubWVu
dCgpIC0gYmwubGVuZ3RoKCkpICYgfkNFUEhfUEFHRV9NQVNLOwo+Cj4gLT4gcmV0ID0gZWJsLnJl
YnVpbGRfYWxpZ25lZChDRVBIX0RJUkVDVElPX0FMSUdOTUVOVCk7Cj4KPgo+Cj4gTG9nOgo+Cj4g
MjAxNy0xMC0xNyAxOTo0OToyOS43MDYyNDYgN2ZiNDcyYmZlNzAwIDEwIGpvdXJuYWwgIGxlbiA0
MTk2MTMxIC0+IDQyMDI0OTYKPiAoaGVhZCA0MCBwcmVfcGFkIDQwNDYgYmwgNDE5NjEzMSBwb3N0
X3BhZCAyMjM5IHRhaWwgNDApIChibCBhbGlnbm1lbnQgNDA4NikKPgo+Cj4KPiBxdWVzdGlvbjoK
Pgo+IEkgZmluZCDigJxhbGlnbm1lbnQgPTQwODbigJ0sIEkgdGhpbmsgSXQgbWF5YmUgYSBidWcK
Pgo+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIDQwOTYKPgo+IGJlY2F1c2UgQ0VQSF9ESVJFQ1RJT19B
TElHTk1FTlQgaXMgNDA5NgoKV2hhdCBsZWQgeW91IHRvIHRoaXMsIGFuZCB3aGF0IHZlcnNpb24g
b2YgdGhlIGNvZGUgYXJlIHlvdQpydW5uaW5nL2V4YW1pbmluZz8gSSBkb24ndCBzZWUgYW55IGlu
c3RhbmNlIG9mICI0MDg2IiBpbiB0aGUgY29kZWJhc2UsCnNvIHRoZXJlJ3Mgbm90IGEgdHlwbywg
Q0VQSF9ESVJFQ1RJT19BTElHTk1FTlQgaXMgc2V0IHRvIDQwOTYsIGFuZCBvdXIKaW52b2NhdGlv
bnMgb2YgcmVidWlsZF9hbGlnbmVkIGluIG1hc3RlciBkbyBub3QgbG9vayBsaWtlIHRoZSBjb2Rl
CnNuaXBwZXRzIHlvdSd2ZSBnb3QgdGhlcmUgdGhhdCBJIGNhbiBzZWUuCi1HcmVnCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmNlcGgtdXNlcnMgbWFpbGlu
ZyBsaXN0CmNlcGgtdXNlcnNAbGlzdHMuY2VwaC5jb20KaHR0cDovL2xpc3RzLmNlcGguY29tL2xp
c3RpbmZvLmNnaS9jZXBoLXVzZXJzLWNlcGguY29tCg==
