From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 20/41] fbdev/pvr2fb: convert put_page() to
 put_user_page*()
Date: Fri, 9 Aug 2019 13:38:31 +0200
Message-ID: <1f1656b4-3411-3237-726f-8fb7b73ae363@samsung.com>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
 <CGME20190807013420epcas1p1a38f499e39127e66501040b7e9e788ba@epcas1p1.samsung.com>
 <20190807013340.9706-21-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190807013340.9706-21-jhubbard@nvidia.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: john.hubbard@gmail.com
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, ceph-devel@vger.ker
List-Id: ceph-devel.vger.kernel.org

Ck9uIDgvNy8xOSAzOjMzIEFNLCBqb2huLmh1YmJhcmRAZ21haWwuY29tIHdyb3RlOgo+IEZyb206
IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4KPiAKPiBGb3IgcGFnZXMgdGhhdCB3
ZXJlIHJldGFpbmVkIHZpYSBnZXRfdXNlcl9wYWdlcyooKSwgcmVsZWFzZSB0aG9zZSBwYWdlcwo+
IHZpYSB0aGUgbmV3IHB1dF91c2VyX3BhZ2UqKCkgcm91dGluZXMsIGluc3RlYWQgb2YgdmlhIHB1
dF9wYWdlKCkgb3IKPiByZWxlYXNlX3BhZ2VzKCkuCj4gCj4gVGhpcyBpcyBwYXJ0IGEgdHJlZS13
aWRlIGNvbnZlcnNpb24sIGFzIGRlc2NyaWJlZCBpbiBjb21taXQgZmMxZDhlN2NjYTJkCj4gKCJt
bTogaW50cm9kdWNlIHB1dF91c2VyX3BhZ2UqKCksIHBsYWNlaG9sZGVyIHZlcnNpb25zIikuCj4g
Cj4gQ2M6IEJhcnRsb21pZWogWm9sbmllcmtpZXdpY3ogPGIuem9sbmllcmtpZUBzYW1zdW5nLmNv
bT4KPiBDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+Cj4gQ2M6IEFsIFZpcm8g
PHZpcm9AemVuaXYubGludXgub3JnLnVrPgo+IENjOiBCaHVtaWthIEdveWFsIDxiaHVtaXJrc0Bn
bWFpbC5jb20+Cj4gQ2M6IEFydmluZCBZYWRhdiA8YXJ2aW5kLnlhZGF2LmNzQGdtYWlsLmNvbT4K
PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51eC1mYmRldkB2
Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52
aWRpYS5jb20+CgpBY2tlZC1ieTogQmFydGxvbWllaiBab2xuaWVya2lld2ljeiA8Yi56b2xuaWVy
a2llQHNhbXN1bmcuY29tPgoKQmVzdCByZWdhcmRzLAotLQpCYXJ0bG9taWVqIFpvbG5pZXJraWV3
aWN6ClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKU2Ftc3VuZyBFbGVjdHJvbmljcwoKPiAt
LS0KPiAgZHJpdmVycy92aWRlby9mYmRldi9wdnIyZmIuYyB8IDMgKy0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aWRlby9mYmRldi9wdnIyZmIuYyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvcHZyMmZiLmMK
PiBpbmRleCA3ZmY0YjZiODQyODIuLjBlNGY5YWE2NDQ0ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L3B2cjJmYi5jCj4gKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9wdnIyZmIu
Ywo+IEBAIC03MDAsOCArNzAwLDcgQEAgc3RhdGljIHNzaXplX3QgcHZyMmZiX3dyaXRlKHN0cnVj
dCBmYl9pbmZvICppbmZvLCBjb25zdCBjaGFyICpidWYsCj4gIAlyZXQgPSBjb3VudDsKPiAgCj4g
IG91dF91bm1hcDoKPiAtCWZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsgaSsrKQo+IC0JCXB1dF9w
YWdlKHBhZ2VzW2ldKTsKPiArCXB1dF91c2VyX3BhZ2VzKHBhZ2VzLCBucl9wYWdlcyk7Cj4gIAo+
ICAJa2ZyZWUocGFnZXMpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWw=
