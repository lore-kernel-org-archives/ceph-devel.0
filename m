From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 15/34] staging/vc04_services: convert
 put_page() to put_user_page*()
Date: Sat, 3 Aug 2019 09:06:21 +0200
Message-ID: <20190803070621.GA2508@kroah.com>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-16-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190802022005.5117-16-jhubbard@nvidia.com>
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
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Suniel Mahesh <sunil.m@techveda.org>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Mihaela Muraru <mihaela.muraru21@gmail.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-d
List-Id: ceph-devel.vger.kernel.org

T24gVGh1LCBBdWcgMDEsIDIwMTkgYXQgMDc6MTk6NDZQTSAtMDcwMCwgam9obi5odWJiYXJkQGdt
YWlsLmNvbSB3cm90ZToKPiBGcm9tOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+
Cj4gCj4gRm9yIHBhZ2VzIHRoYXQgd2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCks
IHJlbGVhc2UgdGhvc2UgcGFnZXMKPiB2aWEgdGhlIG5ldyBwdXRfdXNlcl9wYWdlKigpIHJvdXRp
bmVzLCBpbnN0ZWFkIG9mIHZpYSBwdXRfcGFnZSgpIG9yCj4gcmVsZWFzZV9wYWdlcygpLgo+IAo+
IFRoaXMgaXMgcGFydCBhIHRyZWUtd2lkZSBjb252ZXJzaW9uLCBhcyBkZXNjcmliZWQgaW4gY29t
bWl0IGZjMWQ4ZTdjY2EyZAo+ICgibW06IGludHJvZHVjZSBwdXRfdXNlcl9wYWdlKigpLCBwbGFj
ZWhvbGRlciB2ZXJzaW9ucyIpLgo+IAo+IENjOiBFcmljIEFuaG9sdCA8ZXJpY0BhbmhvbHQubmV0
Pgo+IENjOiBTdGVmYW4gV2FocmVuIDxzdGVmYW4ud2FocmVuQGkyc2UuY29tPgo+IENjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgo+IENjOiBNaWhhZWxh
IE11cmFydSA8bWloYWVsYS5tdXJhcnUyMUBnbWFpbC5jb20+Cj4gQ2M6IFN1bmllbCBNYWhlc2gg
PHN1bmlsLm1AdGVjaHZlZGEub3JnPgo+IENjOiBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9y
Zy51az4KPiBDYzogU2lkb25nIFlhbmcgPHJlYWx3YWtrYUBnbWFpbC5jb20+Cj4gQ2M6IEtpc2hv
cmUgS1AgPGtpc2hvcmUucEB0ZWNodmVkYS5vcmc+Cj4gQ2M6IGxpbnV4LXJwaS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKPiBDYzogZGV2ZWxAZHJpdmVyZGV2Lm9zdW9zbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBKb2hu
IEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+Cj4gLS0tCj4gIC4uLi92YzA0X3NlcnZpY2Vz
L2ludGVyZmFjZS92Y2hpcV9hcm0vdmNoaXFfMjgzNV9hcm0uYyB8IDEwICsrLS0tLS0tLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCkFja2VkLWJ5
OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGlu
ZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZng=
