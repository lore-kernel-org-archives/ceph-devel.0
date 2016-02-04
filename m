From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 09/10] fs: ceph: Replace CURRENT_TIME by
	ktime_get_real_ts()
Date: Thu, 4 Feb 2016 10:00:19 +0800
Message-ID: <A70D88EB-6B14-4553-9C9D-88D54F7BA689@redhat.com>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
 <CAAM7YAm6enhGMJd+BMDAuAzXCMxVwb24Ch951A3_ygGUhXivxQ@mail.gmail.com>
 <20160203161720.GA9546@deepa-ubuntu> <3267742.ulDeDOimis@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <3267742.ulDeDOimis@wuerfel>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Theodore Ts'o <tytso@mit.edu>, Sage Weil <sage@redhat.com>, Zheng Yan <ukernel@gmail.com>, Dave Chinner <david@fromorbit.com>, linux-kernel <linux-kernel@vger.kernel.org>, y2038@lists.linaro.org, Deepa Dinamani <deepa.kernel@gmail.com>, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Cj4gT24gRmViIDQsIDIwMTYsIGF0IDA1OjI3LCBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRl
PiB3cm90ZToKPiAKPiBPbiBXZWRuZXNkYXkgMDMgRmVicnVhcnkgMjAxNiAwODoxNzoyMyBEZWVw
YSBEaW5hbWFuaSB3cm90ZToKPj4gT24gV2VkLCBGZWIgMDMsIDIwMTYgYXQgMTA6MzQ6MDBQTSAr
MDgwMCwgWWFuLCBaaGVuZyB3cm90ZToKPj4+IE9uIFdlZCwgRmViIDMsIDIwMTYgYXQgMjowNyBQ
TSwgRGVlcGEgRGluYW1hbmkgPGRlZXBhLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+IC0t
LSBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jCj4+Pj4gKysrIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMK
Pj4+PiBAQCAtMTcyMSw3ICsxNzIxLDcgQEAgY2VwaF9tZHNjX2NyZWF0ZV9yZXF1ZXN0KHN0cnVj
dCBjZXBoX21kc19jbGllbnQgKm1kc2MsIGludCBvcCwgaW50IG1vZGUpCj4+Pj4gICAgICAgIGlu
aXRfY29tcGxldGlvbigmcmVxLT5yX3NhZmVfY29tcGxldGlvbik7Cj4+Pj4gICAgICAgIElOSVRf
TElTVF9IRUFEKCZyZXEtPnJfdW5zYWZlX2l0ZW0pOwo+Pj4+IAo+Pj4+IC0gICAgICAgcmVxLT5y
X3N0YW1wID0gQ1VSUkVOVF9USU1FOwo+Pj4+ICsgICAgICAga3RpbWVfZ2V0X3JlYWxfdHMoJnJl
cS0+cl9zdGFtcCk7Cj4+PiAKPj4+IEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBjdXJyZW50X2ZzX3Rp
bWUoKSBoZXJlLiBJIGhhdmUgc3F1YXNoIHRoZSBjaGFuZ2UKPj4+IGludG8gYW5vdGhlciBwYXRj
aAo+PiAKPj4gT2suIEkgbWlzc2VkIHRoaXMgY29tbWl0IGI4ZTY5MDY2ZDhhZmE4ZDI2NzBkYzY5
NzI1MmZmMGU1OTA3YWFmYWQKPj4gZWFybGllciB3aGljaCBzYXlzIHRoYXQgdGhlIHJfc3RhbXAg
aXMgdXNlZCBhcyBjdGltZSBub3cuCj4+IEkgaGFkIGFzc3VtZWQgdGhhdCB0aGlzIGlzIGEgbWVz
c2FnZSB0aW1lc3RhbXAuCj4+IAo+PiBJIHdhcyBub3QgYWJsZSB0byBmaW5kIGFueSBkb2N1bWVu
dGF0aW9uIG9uIHdoYXQgdGhlIHNlcnZlciBkb2VzCj4+IHdpdGggdGhlIG1lc3NhZ2Ugc2VudCBi
eSB0aGUgY2xpZW50LiBXaGVyZSBjYW4gSSBmaW5kIHRoYXQ/Cj4+IAo+PiBTbywgdGhpcyBzaG91
bGQgYWN0dWFsbHkgbG9vayBsaWtlCj4+IAo+PiByZXEtPnJfc3RhbXAgPSBjdXJyZW50X2ZzX3Rp
bWUobWRzYy0+ZnNjLT5zYik7Cj4+IAo+PiBMZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtZSB0byBy
ZXNlbmQuCgpJIGhhdmUgYWxyZWFkeSBzcXVhc2hlZCB0aGUgY2hhbmdlIGludG8gcGF0Y2ggOAoK
PiAKPiBJIHNlZSB0aGF0IHRoZSB0aW1lc3RhbXAgaXMgc2VudCB1c2luZwo+IAo+IAljZXBoX2Vu
Y29kZV9jb3B5KCZwLCAmcmVxLT5yX3N0YW1wLCBzaXplb2YocmVxLT5yX3N0YW1wKSk7Cgp0aGlz
IGNvZGUgaXMgb3V0ZGF0ZWQsIGN1cnJlbnQgY29kZSBpczoKCnsKICAgICAgICAgIHN0cnVjdCBj
ZXBoX3RpbWVzcGVjIHRzOwogICAgICAgICAgY2VwaF9lbmNvZGVfdGltZXNwZWMoJnRzLCAmcmVx
LT5yX3N0YW1wKTsKICAgICAgICAgIGNlcGhfZW5jb2RlX2NvcHkoJnAsICZ0cywgc2l6ZW9mKHRz
KSk7Cn0KPiAKPiBXaGF0IGhhcHBlbnMgd2l0aCB0aGUgdGltZXN0YW1wIGFjcm9zcyByZWJvb3Rz
IGlmIHdlIGNoYW5nZSB0aGUKPiB0eXBlPyBJIGFzc3VtZSB0aGUgZGF0YSB3aWxsIG5vdCBiZSB1
c2VkIGFjcm9zcyByZWJvb3RzLCBpZiBpdAo+IGRvZXMsIHdlIGFscmVhZHkgaGF2ZSBhIHByb2Js
ZW0gb24gbWFjaGluZXMgdGhhdCBjYW4gYm9vdAo+IGJvdGggYmlnLWVuZGlhbiBhbmQgbGl0dGxl
LWVuZGlhbiBrZXJuZWxzLCBvciB0aGF0IGNhbiBib290Cj4gYm90aCAzMi1iaXQgYW5kIDY0LWJp
dCBrZXJuZWxzLgo+IAo+IAlBcm5kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QKWTIwMzhAbGlzdHMubGluYXJvLm9yZwpo
dHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0aW5mby95MjAzOAo=
