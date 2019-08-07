From: john.hubbard@gmail.com
Subject: [PATCH v3 24/41] orangefs: convert put_page() to
 put_user_page*()
Date: Tue,  6 Aug 2019 18:33:23 -0700
Message-ID: <20190807013340.9706-25-jhubbard@nvidia.com>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Brandenburg <martin@omnibond.com>, linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.willi>
List-Id: ceph-devel.vger.kernel.org

RnJvbTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgoKRm9yIHBhZ2VzIHRoYXQg
d2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCksIHJlbGVhc2UgdGhvc2UgcGFnZXMK
dmlhIHRoZSBuZXcgcHV0X3VzZXJfcGFnZSooKSByb3V0aW5lcywgaW5zdGVhZCBvZiB2aWEgcHV0
X3BhZ2UoKSBvcgpyZWxlYXNlX3BhZ2VzKCkuCgpUaGlzIGlzIHBhcnQgYSB0cmVlLXdpZGUgY29u
dmVyc2lvbiwgYXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzFkOGU3Y2NhMmQKKCJtbTogaW50cm9k
dWNlIHB1dF91c2VyX3BhZ2UqKCksIHBsYWNlaG9sZGVyIHZlcnNpb25zIikuCgpDYzogTWlrZSBN
YXJzaGFsbCA8aHViY2FwQG9tbmlib25kLmNvbT4KQ2M6IE1hcnRpbiBCcmFuZGVuYnVyZyA8bWFy
dGluQG9tbmlib25kLmNvbT4KQ2M6IGRldmVsQGxpc3RzLm9yYW5nZWZzLm9yZwpTaWduZWQtb2Zm
LWJ5OiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+Ci0tLQogZnMvb3JhbmdlZnMv
b3JhbmdlZnMtYnVmbWFwLmMgfCA3ICsrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvb3JhbmdlZnMvb3JhbmdlZnMt
YnVmbWFwLmMgYi9mcy9vcmFuZ2Vmcy9vcmFuZ2Vmcy1idWZtYXAuYwppbmRleCAyYmI5MTZkNjg1
NzYuLmYyZjMzYTE2ZDYwNCAxMDA2NDQKLS0tIGEvZnMvb3JhbmdlZnMvb3JhbmdlZnMtYnVmbWFw
LmMKKysrIGIvZnMvb3JhbmdlZnMvb3JhbmdlZnMtYnVmbWFwLmMKQEAgLTE2OCwxMCArMTY4LDcg
QEAgc3RhdGljIERFRklORV9TUElOTE9DSyhvcmFuZ2Vmc19idWZtYXBfbG9jayk7CiBzdGF0aWMg
dm9pZAogb3JhbmdlZnNfYnVmbWFwX3VubWFwKHN0cnVjdCBvcmFuZ2Vmc19idWZtYXAgKmJ1Zm1h
cCkKIHsKLQlpbnQgaTsKLQotCWZvciAoaSA9IDA7IGkgPCBidWZtYXAtPnBhZ2VfY291bnQ7IGkr
KykKLQkJcHV0X3BhZ2UoYnVmbWFwLT5wYWdlX2FycmF5W2ldKTsKKwlwdXRfdXNlcl9wYWdlcyhi
dWZtYXAtPnBhZ2VfYXJyYXksIGJ1Zm1hcC0+cGFnZV9jb3VudCk7CiB9CiAKIHN0YXRpYyB2b2lk
CkBAIC0yODAsNyArMjc3LDcgQEAgb3JhbmdlZnNfYnVmbWFwX21hcChzdHJ1Y3Qgb3JhbmdlZnNf
YnVmbWFwICpidWZtYXAsCiAKIAkJZm9yIChpID0gMDsgaSA8IHJldDsgaSsrKSB7CiAJCQlTZXRQ
YWdlRXJyb3IoYnVmbWFwLT5wYWdlX2FycmF5W2ldKTsKLQkJCXB1dF9wYWdlKGJ1Zm1hcC0+cGFn
ZV9hcnJheVtpXSk7CisJCQlwdXRfdXNlcl9wYWdlKGJ1Zm1hcC0+cGFnZV9hcnJheVtpXSk7CiAJ
CX0KIAkJcmV0dXJuIC1FTk9NRU07CiAJfQotLSAKMi4yMi4wCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4t
ZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA==
