From: john.hubbard@gmail.com
Subject: [PATCH v3 36/41] fs/binfmt_elf: convert put_page() to
 put_user_page*()
Date: Tue,  6 Aug 2019 18:33:35 -0700
Message-ID: <20190807013340.9706-37-jhubbard@nvidia.com>
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
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

RnJvbTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPgoKRm9yIHBhZ2VzIHRoYXQgd2Vy
ZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCksIHJlbGVhc2UgdGhvc2UgcGFnZXMKdmlh
IHRoZSBuZXcgcHV0X3VzZXJfcGFnZSooKSByb3V0aW5lcywgaW5zdGVhZCBvZiB2aWEgcHV0X3Bh
Z2UoKSBvcgpyZWxlYXNlX3BhZ2VzKCkuCgpUaGlzIGlzIHBhcnQgYSB0cmVlLXdpZGUgY29udmVy
c2lvbiwgYXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzFkOGU3Y2NhMmQKKCJtbTogaW50cm9kdWNl
IHB1dF91c2VyX3BhZ2UqKCksIHBsYWNlaG9sZGVyIHZlcnNpb25zIikuCgpnZXRfZHVtcF9wYWdl
IGNhbGxzIGdldF91c2VyX3BhZ2Ugc28gcHV0X3VzZXJfcGFnZSBtdXN0IGJlIHVzZWQKdG8gbWF0
Y2guCgpTaWduZWQtb2ZmLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4KLS0tCiBmcy9iaW5m
bXRfZWxmLmMgICAgICAgfCAyICstCiBmcy9iaW5mbXRfZWxmX2ZkcGljLmMgfCAyICstCiAyIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9mcy9iaW5mbXRfZWxmLmMgYi9mcy9iaW5mbXRfZWxmLmMKaW5kZXggZDRlMTFiMmUwNGY2Li45
MmU0YTVjYTk5ZDggMTAwNjQ0Ci0tLSBhL2ZzL2JpbmZtdF9lbGYuYworKysgYi9mcy9iaW5mbXRf
ZWxmLmMKQEAgLTIzNzcsNyArMjM3Nyw3IEBAIHN0YXRpYyBpbnQgZWxmX2NvcmVfZHVtcChzdHJ1
Y3QgY29yZWR1bXBfcGFyYW1zICpjcHJtKQogCQkJCXZvaWQgKmthZGRyID0ga21hcChwYWdlKTsK
IAkJCQlzdG9wID0gIWR1bXBfZW1pdChjcHJtLCBrYWRkciwgUEFHRV9TSVpFKTsKIAkJCQlrdW5t
YXAocGFnZSk7Ci0JCQkJcHV0X3BhZ2UocGFnZSk7CisJCQkJcHV0X3VzZXJfcGFnZShwYWdlKTsK
IAkJCX0gZWxzZQogCQkJCXN0b3AgPSAhZHVtcF9za2lwKGNwcm0sIFBBR0VfU0laRSk7CiAJCQlp
ZiAoc3RvcCkKZGlmZiAtLWdpdCBhL2ZzL2JpbmZtdF9lbGZfZmRwaWMuYyBiL2ZzL2JpbmZtdF9l
bGZfZmRwaWMuYwppbmRleCBkODZlYmQwZGNjM2QuLjMyMTcyNGIzYmUyMiAxMDA2NDQKLS0tIGEv
ZnMvYmluZm10X2VsZl9mZHBpYy5jCisrKyBiL2ZzL2JpbmZtdF9lbGZfZmRwaWMuYwpAQCAtMTUx
MSw3ICsxNTExLDcgQEAgc3RhdGljIGJvb2wgZWxmX2ZkcGljX2R1bXBfc2VnbWVudHMoc3RydWN0
IGNvcmVkdW1wX3BhcmFtcyAqY3BybSkKIAkJCQl2b2lkICprYWRkciA9IGttYXAocGFnZSk7CiAJ
CQkJcmVzID0gZHVtcF9lbWl0KGNwcm0sIGthZGRyLCBQQUdFX1NJWkUpOwogCQkJCWt1bm1hcChw
YWdlKTsKLQkJCQlwdXRfcGFnZShwYWdlKTsKKwkJCQlwdXRfdXNlcl9wYWdlKHBhZ2UpOwogCQkJ
fSBlbHNlIHsKIAkJCQlyZXMgPSBkdW1wX3NraXAoY3BybSwgUEFHRV9TSVpFKTsKIAkJCX0KLS0g
CjIuMjIuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Clhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0
dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
