From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 26/34] mm/gup_benchmark.c: convert
 put_page() to put_user_page*()
Date: Fri, 2 Aug 2019 08:19:52 -0600
Message-ID: <20190802141952.GA18214@localhost.localdomain>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-27-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190802022005.5117-27-jhubbard@nvidia.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: john.hubbard@gmail.com
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kerne
List-Id: ceph-devel.vger.kernel.org

T24gVGh1LCBBdWcgMDEsIDIwMTkgYXQgMDc6MTk6NTdQTSAtMDcwMCwgam9obi5odWJiYXJkQGdt
YWlsLmNvbSB3cm90ZToKPiBGcm9tOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+
Cj4gCj4gRm9yIHBhZ2VzIHRoYXQgd2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCks
IHJlbGVhc2UgdGhvc2UgcGFnZXMKPiB2aWEgdGhlIG5ldyBwdXRfdXNlcl9wYWdlKigpIHJvdXRp
bmVzLCBpbnN0ZWFkIG9mIHZpYSBwdXRfcGFnZSgpIG9yCj4gcmVsZWFzZV9wYWdlcygpLgo+IAo+
IFRoaXMgaXMgcGFydCBhIHRyZWUtd2lkZSBjb252ZXJzaW9uLCBhcyBkZXNjcmliZWQgaW4gY29t
bWl0IGZjMWQ4ZTdjY2EyZAo+ICgibW06IGludHJvZHVjZSBwdXRfdXNlcl9wYWdlKigpLCBwbGFj
ZWhvbGRlciB2ZXJzaW9ucyIpLgo+IAo+IENjOiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVy
QG9yYWNsZS5jb20+Cj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+Cj4gQ2M6IEtlaXRoIEJ1c2NoIDxrZWl0aC5idXNjaEBpbnRlbC5jb20+Cj4gQ2M6
IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4KPiBD
YzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiBDYzogWXVlSGFpYmluZyA8
eXVlaGFpYmluZ0BodWF3ZWkuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1
YmJhcmRAbnZpZGlhLmNvbT4KCkxvb2tzIGZpbmUuCgpSZXZpZXdlZC1ieTogS2VpdGggQnVzY2gg
PGtlaXRoLmJ1c2NoQGludGVsLmNvbT4KCj4gIG1tL2d1cF9iZW5jaG1hcmsuYyB8IDIgKy0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL21tL2d1cF9iZW5jaG1hcmsuYyBiL21tL2d1cF9iZW5jaG1hcmsuYwo+IGluZGV4IDdk
ZDYwMmQ3ZjhkYi4uNTE1YWM4ZWViNmVlIDEwMDY0NAo+IC0tLSBhL21tL2d1cF9iZW5jaG1hcmsu
Ywo+ICsrKyBiL21tL2d1cF9iZW5jaG1hcmsuYwo+IEBAIC03OSw3ICs3OSw3IEBAIHN0YXRpYyBp
bnQgX19ndXBfYmVuY2htYXJrX2lvY3RsKHVuc2lnbmVkIGludCBjbWQsCj4gIAlmb3IgKGkgPSAw
OyBpIDwgbnJfcGFnZXM7IGkrKykgewo+ICAJCWlmICghcGFnZXNbaV0pCj4gIAkJCWJyZWFrOwo+
IC0JCXB1dF9wYWdlKHBhZ2VzW2ldKTsKPiArCQlwdXRfdXNlcl9wYWdlKHBhZ2VzW2ldKTsKPiAg
CX0KPiAgCWVuZF90aW1lID0ga3RpbWVfZ2V0KCk7Cj4gIAlndXAtPnB1dF9kZWx0YV91c2VjID0g
a3RpbWVfdXNfZGVsdGEoZW5kX3RpbWUsIHN0YXJ0X3RpbWUpOwo+IC0tIApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0
CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZng=
