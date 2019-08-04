From: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: [PATCH 31/34] nfs: convert put_page() to put_user_page*()
Date: Mon, 5 Aug 2019 00:28:01 +0100
Message-ID: <03a81556-98a7-7edb-5989-b799ec99a072@oracle.com>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-32-jhubbard@nvidia.com>
 <1738cb1e-15d8-0bbe-5362-341664f6efc8@oracle.com>
 <db136399-ed87-56ea-bd6e-e5d29b145eda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <db136399-ed87-56ea-bd6e-e5d29b145eda@nvidia.com>
Content-Language: en-GB
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, calum.mackay@oracle.com, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org, Dan Williams <dan.j.williams@intel.com>, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.o
List-Id: ceph-devel.vger.kernel.org

T24gMDMvMDgvMjAxOSAyOjQxIGFtLCBKb2huIEh1YmJhcmQgd3JvdGU6Cj4gT24gOC8yLzE5IDY6
MjcgUE0sIENhbHVtIE1hY2theSB3cm90ZToKPj4gT24gMDIvMDgvMjAxOSAzOjIwIGFtLCBqb2hu
Lmh1YmJhcmRAZ21haWwuY29tIHdyb3RlOgo+IC4uLgo+PiBTaW5jZSBpdCdzIHN0YXRpYywgYW5k
IG9ubHkgY2FsbGVkIHR3aWNlLCBtaWdodCBpdCBiZSBiZXR0ZXIgdG8gY2hhbmdlIGl0cyB0d28g
Y2FsbGVycyBbbmZzX2RpcmVjdF97cmVhZCx3cml0ZX1fc2NoZWR1bGVfaW92ZWMoKV0gdG8gY2Fs
bCBwdXRfdXNlcl9wYWdlcygpIGRpcmVjdGx5LCBhbmQgcmVtb3ZlIG5mc19kaXJlY3RfcmVsZWFz
ZV9wYWdlcygpIGVudGlyZWx5Pwo+Pgo+PiB0aGFua3MsCj4+IGNhbHVtLgo+Pgo+Pgo+Pj4gIMKg
IMKgIHZvaWQgbmZzX2luaXRfY2luZm9fZnJvbV9kcmVxKHN0cnVjdCBuZnNfY29tbWl0X2luZm8g
KmNpbmZvLAo+Pj4KPiAgIAo+IEhpIENhbHVtLAo+IAo+IEFic29sdXRlbHkhIElzIGl0IE9LIHRv
IGFkZCB5b3VyIHJldmlld2VkLWJ5LCB3aXRoIHRoZSBmb2xsb3dpbmcgaW5jcmVtZW50YWwKPiBw
YXRjaCBtYWRlIHRvIHRoaXMgb25lPwoKVGhhbmtzIEpvaG47IGxvb2tzIGdvb2QuCgpSZXZpZXdl
ZC1ieTogQ2FsdW0gTWFja2F5IDxjYWx1bS5tYWNrYXlAb3JhY2xlLmNvbT4KCj4gCj4gZGlmZiAt
LWdpdCBhL2ZzL25mcy9kaXJlY3QuYyBiL2ZzL25mcy9kaXJlY3QuYwo+IGluZGV4IGIwMGI4OWRk
YTNjNS4uYzBjMWI5ZjJjMDY5IDEwMDY0NAo+IC0tLSBhL2ZzL25mcy9kaXJlY3QuYwo+ICsrKyBi
L2ZzL25mcy9kaXJlY3QuYwo+IEBAIC0yNzYsMTEgKzI3Niw2IEBAIHNzaXplX3QgbmZzX2RpcmVj
dF9JTyhzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRlcikKPiAgICAgICAg
ICByZXR1cm4gbmZzX2ZpbGVfZGlyZWN0X3dyaXRlKGlvY2IsIGl0ZXIpOwo+ICAgfQo+ICAgCj4g
LXN0YXRpYyB2b2lkIG5mc19kaXJlY3RfcmVsZWFzZV9wYWdlcyhzdHJ1Y3QgcGFnZSAqKnBhZ2Vz
LCB1bnNpZ25lZCBpbnQgbnBhZ2VzKQo+IC17Cj4gLSAgICAgICBwdXRfdXNlcl9wYWdlcyhwYWdl
cywgbnBhZ2VzKTsKPiAtfQo+IC0KPiAgIHZvaWQgbmZzX2luaXRfY2luZm9fZnJvbV9kcmVxKHN0
cnVjdCBuZnNfY29tbWl0X2luZm8gKmNpbmZvLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgbmZzX2RpcmVjdF9yZXEgKmRyZXEpCj4gICB7Cj4gQEAgLTUxMCw3ICs1MDUs
NyBAQCBzdGF0aWMgc3NpemVfdCBuZnNfZGlyZWN0X3JlYWRfc2NoZWR1bGVfaW92ZWMoc3RydWN0
IG5mc19kaXJlY3RfcmVxICpkcmVxLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICBwb3MgKz0g
cmVxX2xlbjsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgZHJlcS0+Ynl0ZXNfbGVmdCAtPSBy
ZXFfbGVuOwo+ICAgICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICBuZnNfZGlyZWN0
X3JlbGVhc2VfcGFnZXMocGFnZXZlYywgbnBhZ2VzKTsKPiArICAgICAgICAgICAgICAgcHV0X3Vz
ZXJfcGFnZXMocGFnZXZlYywgbnBhZ2VzKTsKPiAgICAgICAgICAgICAgICAgIGt2ZnJlZShwYWdl
dmVjKTsKPiAgICAgICAgICAgICAgICAgIGlmIChyZXN1bHQgPCAwKQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsKPiBAQCAtOTMzLDcgKzkyOCw3IEBAIHN0YXRpYyBzc2l6ZV90IG5m
c19kaXJlY3Rfd3JpdGVfc2NoZWR1bGVfaW92ZWMoc3RydWN0IG5mc19kaXJlY3RfcmVxICpkcmVx
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICBwb3MgKz0gcmVxX2xlbjsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgZHJlcS0+Ynl0ZXNfbGVmdCAtPSByZXFfbGVuOwo+ICAgICAgICAgICAg
ICAgICAgfQo+IC0gICAgICAgICAgICAgICBuZnNfZGlyZWN0X3JlbGVhc2VfcGFnZXMocGFnZXZl
YywgbnBhZ2VzKTsKPiArICAgICAgICAgICAgICAgcHV0X3VzZXJfcGFnZXMocGFnZXZlYywgbnBh
Z2VzKTsKPiAgICAgICAgICAgICAgICAgIGt2ZnJlZShwYWdldmVjKTsKPiAgICAgICAgICAgICAg
ICAgIGlmIChyZXN1bHQgPCAwKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAK
PiAKPiAKPiB0aGFua3MsCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3Jn
Cmh0dHA6Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaXZlcmRldi1kZXZlbAo=
