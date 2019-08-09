From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 38/41] powerpc: convert put_page() to
 put_user_page*()
Date: Fri, 09 Aug 2019 22:20:40 +1000
Message-ID: <875zn6ttrb.fsf@concordia.ellerman.id.au>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
 <20190807013340.9706-39-jhubbard@nvidia.com>
 <87k1botdpx.fsf@concordia.ellerman.id.au>
 <248c9ab2-93cc-6d8b-606d-d85b83e791e5@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <248c9ab2-93cc-6d8b-606d-d85b83e791e5@nvidia.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?utf-8?B?SsOpcsO0?= =?utf-8?B?bWU=?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-ar
List-Id: ceph-devel.vger.kernel.org

Sm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPiB3cml0ZXM6Cj4gT24gOC83LzE5IDEw
OjQyIFBNLCBNaWNoYWVsIEVsbGVybWFuIHdyb3RlOgo+PiBIaSBKb2huLAo+PiAKPj4gam9obi5o
dWJiYXJkQGdtYWlsLmNvbSB3cml0ZXM6Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL21t
L2Jvb2szczY0L2lvbW11X2FwaS5jIGIvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L2lvbW11X2Fw
aS5jCj4+PiBpbmRleCBiMDU2Y2FlMzM4OGIuLmUxMjYxOTNiYTI5NSAxMDA2NDQKPj4+IC0tLSBh
L2FyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9pb21tdV9hcGkuYwo+Pj4gKysrIGIvYXJjaC9wb3dl
cnBjL21tL2Jvb2szczY0L2lvbW11X2FwaS5jCj4+PiBAQCAtMjAzLDYgKzIwMiw3IEBAIHN0YXRp
YyB2b2lkIG1tX2lvbW11X3VucGluKHN0cnVjdCBtbV9pb21tdV90YWJsZV9ncm91cF9tZW1fdCAq
bWVtKQo+Pj4gIHsKPj4+ICAJbG9uZyBpOwo+Pj4gIAlzdHJ1Y3QgcGFnZSAqcGFnZSA9IE5VTEw7
Cj4+PiArCWJvb2wgZGlydHkgPSBmYWxzZTsKPj4gCj4+IEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQg
dGhhdCBpbml0aWFsaXNhdGlvbiBkbyB5b3U/Cj4+IAo+Cj4gTm9wZSwgaXQgY2FuIGdvLiBGaXhl
ZCBsb2NhbGx5LCB0aGFua3MuCgpUaGFua3MuCgo+IERpZCB5b3UgZ2V0IGEgY2hhbmNlIHRvIGxv
b2sgYXQgZW5vdWdoIG9mIHRoZSBvdGhlciBiaXRzIHRvIGZlZWwgY29tZm9ydGFibGUgCj4gd2l0
aCB0aGUgcGF0Y2gsIG92ZXJhbGw/CgpNb3N0bHkgOikgSXQncyBub3QgcmVhbGx5IG15IGFyZWEs
IGJ1dCBhbGwgdGhlIGNvbnZlcnNpb25zIGxvb2tlZApjb3JyZWN0IHRvIG1lIGFzIGJlc3QgYXMg
SSBjb3VsZCB0ZWxsLgoKU28gSSdtIGZpbmUgZm9yIGl0IHRvIGdvIGluIGFzIHBhcnQgb2YgdGhl
IHNlcmllczoKCkFja2VkLWJ5OiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+
IChwb3dlcnBjKQoKY2hlZXJzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lu
dGVsLWdmeA==
