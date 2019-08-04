From: john.hubbard@gmail.com
Subject: [PATCH v2 25/34] mm/frame_vector.c: convert put_page()
 to put_user_page*()
Date: Sun,  4 Aug 2019 15:49:06 -0700
Message-ID: <20190804224915.28669-26-jhubbard@nvidia.com>
References: <20190804224915.28669-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20190804224915.28669-1-jhubbard@nvidia.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Mel Gorman <mgorman@suse.de>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>
List-Id: ceph-devel.vger.kernel.org

RnJvbTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgoKRm9yIHBhZ2VzIHRoYXQg
d2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCksIHJlbGVhc2UgdGhvc2UgcGFnZXMK
dmlhIHRoZSBuZXcgcHV0X3VzZXJfcGFnZSooKSByb3V0aW5lcywgaW5zdGVhZCBvZiB2aWEgcHV0
X3BhZ2UoKSBvcgpyZWxlYXNlX3BhZ2VzKCkuCgpUaGlzIGlzIHBhcnQgYSB0cmVlLXdpZGUgY29u
dmVyc2lvbiwgYXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzFkOGU3Y2NhMmQKKCJtbTogaW50cm9k
dWNlIHB1dF91c2VyX3BhZ2UqKCksIHBsYWNlaG9sZGVyIHZlcnNpb25zIikuCgpDYzogRGFuIFdp
bGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+CkNjOiBKYW4gS2FyYSA8amFja0BzdXNl
LmN6PgpDYzogTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPgpDYzogVmxhc3RpbWlsIEJhYmth
IDx2YmFia2FAc3VzZS5jej4KU2lnbmVkLW9mZi1ieTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBu
dmlkaWEuY29tPgotLS0KIG1tL2ZyYW1lX3ZlY3Rvci5jIHwgNCArLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vZnJhbWVf
dmVjdG9yLmMgYi9tbS9mcmFtZV92ZWN0b3IuYwppbmRleCBjNjRkY2E2ZTI3YzIuLmY1OTBiYWRh
Yzc3NiAxMDA2NDQKLS0tIGEvbW0vZnJhbWVfdmVjdG9yLmMKKysrIGIvbW0vZnJhbWVfdmVjdG9y
LmMKQEAgLTEyMCw3ICsxMjAsNiBAQCBFWFBPUlRfU1lNQk9MKGdldF92YWRkcl9mcmFtZXMpOwog
ICovCiB2b2lkIHB1dF92YWRkcl9mcmFtZXMoc3RydWN0IGZyYW1lX3ZlY3RvciAqdmVjKQogewot
CWludCBpOwogCXN0cnVjdCBwYWdlICoqcGFnZXM7CiAKIAlpZiAoIXZlYy0+Z290X3JlZikKQEAg
LTEzMyw4ICsxMzIsNyBAQCB2b2lkIHB1dF92YWRkcl9mcmFtZXMoc3RydWN0IGZyYW1lX3ZlY3Rv
ciAqdmVjKQogCSAqLwogCWlmIChXQVJOX09OKElTX0VSUihwYWdlcykpKQogCQlnb3RvIG91dDsK
LQlmb3IgKGkgPSAwOyBpIDwgdmVjLT5ucl9mcmFtZXM7IGkrKykKLQkJcHV0X3BhZ2UocGFnZXNb
aV0pOworCXB1dF91c2VyX3BhZ2VzKHBhZ2VzLCB2ZWMtPm5yX2ZyYW1lcyk7CiAJdmVjLT5nb3Rf
cmVmID0gZmFsc2U7CiBvdXQ6CiAJdmVjLT5ucl9mcmFtZXMgPSAwOwotLSAKMi4yMi4wCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1h
aWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54
ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA==
