From: john.hubbard@gmail.com
Subject: [PATCH v2 26/34] mm/gup_benchmark.c: convert put_page()
 to put_user_page*()
Date: Sun,  4 Aug 2019 15:49:07 -0700
Message-ID: <20190804224915.28669-27-jhubbard@nvidia.com>
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
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, sparclinux@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@>
List-Id: ceph-devel.vger.kernel.org

RnJvbTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgoKRm9yIHBhZ2VzIHRoYXQg
d2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCksIHJlbGVhc2UgdGhvc2UgcGFnZXMK
dmlhIHRoZSBuZXcgcHV0X3VzZXJfcGFnZSooKSByb3V0aW5lcywgaW5zdGVhZCBvZiB2aWEgcHV0
X3BhZ2UoKSBvcgpyZWxlYXNlX3BhZ2VzKCkuCgpUaGlzIGlzIHBhcnQgYSB0cmVlLXdpZGUgY29u
dmVyc2lvbiwgYXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzFkOGU3Y2NhMmQKKCJtbTogaW50cm9k
dWNlIHB1dF91c2VyX3BhZ2UqKCksIHBsYWNlaG9sZGVyIHZlcnNpb25zIikuCgpSZXZpZXdlZC1i
eTogS2VpdGggQnVzY2ggPGtlaXRoLmJ1c2NoQGludGVsLmNvbT4KCkNjOiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+CkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPgpDYzogS2VpdGggQnVzY2ggPGtlaXRoLmJ1c2NoQGludGVs
LmNvbT4KQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVs
LmNvbT4KQ2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CkNjOiBZdWVIYWli
aW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IEpvaG4gSHViYmFyZCA8
amh1YmJhcmRAbnZpZGlhLmNvbT4KLS0tCiBtbS9ndXBfYmVuY2htYXJrLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9t
bS9ndXBfYmVuY2htYXJrLmMgYi9tbS9ndXBfYmVuY2htYXJrLmMKaW5kZXggN2RkNjAyZDdmOGRi
Li41MTVhYzhlZWI2ZWUgMTAwNjQ0Ci0tLSBhL21tL2d1cF9iZW5jaG1hcmsuYworKysgYi9tbS9n
dXBfYmVuY2htYXJrLmMKQEAgLTc5LDcgKzc5LDcgQEAgc3RhdGljIGludCBfX2d1cF9iZW5jaG1h
cmtfaW9jdGwodW5zaWduZWQgaW50IGNtZCwKIAlmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7IGkr
KykgewogCQlpZiAoIXBhZ2VzW2ldKQogCQkJYnJlYWs7Ci0JCXB1dF9wYWdlKHBhZ2VzW2ldKTsK
KwkJcHV0X3VzZXJfcGFnZShwYWdlc1tpXSk7CiAJfQogCWVuZF90aW1lID0ga3RpbWVfZ2V0KCk7
CiAJZ3VwLT5wdXRfZGVsdGFfdXNlYyA9IGt0aW1lX3VzX2RlbHRhKGVuZF90aW1lLCBzdGFydF90
aW1lKTsKLS0gCjIuMjIuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2pl
Y3Qub3JnCmh0dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4t
ZGV2ZWw=
