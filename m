From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 10/34] genwqe: convert put_page() to put_user_page*()
Date: Sat, 3 Aug 2019 09:06:40 +0200
Message-ID: <20190803070640.GB2508@kroah.com>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-11-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190802022005.5117-11-jhubbard@nvidia.com>
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
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, linux-arm-kerne
List-Id: ceph-devel.vger.kernel.org

T24gVGh1LCBBdWcgMDEsIDIwMTkgYXQgMDc6MTk6NDFQTSAtMDcwMCwgam9obi5odWJiYXJkQGdt
YWlsLmNvbSB3cm90ZToKPiBGcm9tOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+
Cj4gCj4gRm9yIHBhZ2VzIHRoYXQgd2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCks
IHJlbGVhc2UgdGhvc2UgcGFnZXMKPiB2aWEgdGhlIG5ldyBwdXRfdXNlcl9wYWdlKigpIHJvdXRp
bmVzLCBpbnN0ZWFkIG9mIHZpYSBwdXRfcGFnZSgpIG9yCj4gcmVsZWFzZV9wYWdlcygpLgo+IAo+
IFRoaXMgaXMgcGFydCBhIHRyZWUtd2lkZSBjb252ZXJzaW9uLCBhcyBkZXNjcmliZWQgaW4gY29t
bWl0IGZjMWQ4ZTdjY2EyZAo+ICgibW06IGludHJvZHVjZSBwdXRfdXNlcl9wYWdlKigpLCBwbGFj
ZWhvbGRlciB2ZXJzaW9ucyIpLgo+IAo+IFRoaXMgY2hhbmdlcyB0aGUgcmVsZWFzZSBjb2RlIHNs
aWdodGx5LCBiZWNhdXNlIGVhY2ggcGFnZSBzbG90IGluIHRoZQo+IHBhZ2VfbGlzdFtdIGFycmF5
IGlzIG5vIGxvbmdlciBjaGVja2VkIGZvciBOVUxMLiBIb3dldmVyLCB0aGF0IGNoZWNrCj4gd2Fz
IHdyb25nIGFueXdheSwgYmVjYXVzZSB0aGUgZ2V0X3VzZXJfcGFnZXMoKSBwYXR0ZXJuIG9mIHVz
YWdlIGhlcmUKPiBuZXZlciBhbGxvd2VkIGZvciBOVUxMIGVudHJpZXMgd2l0aGluIGEgcmFuZ2Ug
b2YgcGlubmVkIHBhZ2VzLgo+IAo+IENjOiBGcmFuayBIYXZlcmthbXAgPGhhdmVyQGxpbnV4LnZu
ZXQuaWJtLmNvbT4KPiBDYzogIkd1aWxoZXJtZSBHLiBQaWNjb2xpIiA8Z3BpY2NvbGlAbGludXgu
dm5ldC5pYm0uY29tPgo+IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+IENjOiBH
cmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgo+IFNpZ25lZC1v
ZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9taXNjL2dlbndxZS9jYXJkX3V0aWxzLmMgfCAxNyArKystLS0tLS0tLS0tLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCkFja2VkLWJ5OiBH
cmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
