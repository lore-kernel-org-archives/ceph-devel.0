From: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/34] put_user_pages(): miscellaneous call sites
Date: Fri, 2 Aug 2019 11:12:44 +0200
Message-ID: <20190802091244.GD6461@dhcp22.suse.cz>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190802022005.5117-1-jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: john.hubbard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dave Chinner <david-FqsqvQoI3Ljby3iVrkZq2A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ira Weiny <ira.weiny-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, rds-devel-N0ozoZBvEnrZJqsBc5GL+g@public.gmane.org, linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jason Gunthorpe <jgg-uk2M96/98Pc@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, devel-urhm25FSIHzptaDgeN77Px2eb7JE58TQ@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgne
List-Id: ceph-devel.vger.kernel.org

T24gVGh1IDAxLTA4LTE5IDE5OjE5OjMxLCBqb2huLmh1YmJhcmRAZ21haWwuY29tIHdyb3RlOgpb
Li4uXQo+IDIpIENvbnZlcnQgYWxsIG9mIHRoZSBjYWxsIHNpdGVzIGZvciBnZXRfdXNlcl9wYWdl
cyooKSwgdG8KPiBpbnZva2UgcHV0X3VzZXJfcGFnZSooKSwgaW5zdGVhZCBvZiBwdXRfcGFnZSgp
LiBUaGlzIGludm9sdmVzIGRvemVucyBvZgo+IGNhbGwgc2l0ZXMsIGFuZCB3aWxsIHRha2Ugc29t
ZSB0aW1lLgoKSG93IGRvIHdlIG1ha2Ugc3VyZSB0aGlzIGlzIHRoZSBjYXNlIGFuZCBpdCB3aWxs
IHJlbWFpbiB0aGUgY2FzZSBpbiB0aGUKZnV0dXJlPyBUaGVyZSBtdXN0IGJlIHNvbWUgYXV0b21h
Z2ljIHRvIGVuZm9yY2UvY2hlY2sgdGhhdC4gSXQgaXMgc2ltcGx5Cm5vdCBtYW5hZ2VhYmxlIHRv
IGRvIGl0IGV2ZXJ5IG5vdyBhbmQgdGhlbiBiZWNhdXNlIHRoZW4gMykgd2lsbCBzaW1wbHkKYmUg
bmV2ZXIgc2FmZS4KCkhhdmUgeW91IGNvbnNpZGVyZWQgY29jY2luZWxlIG9yIHNvbWUgb3RoZXIg
c2NyaXB0ZWQgd2F5IHRvIGRvIHRoZQp0cmFuc2l0aW9uPyBJIGhhdmUgbm8gaWRlYSBob3cgdG8g
ZGVhbCB3aXRoIGZ1dHVyZSBjaGFuZ2VzIHRoYXQgd291bGQKYnJlYWsgdGhlIGJhbGFuY2UgdGhv
dWdoLgotLSAKTWljaGFsIEhvY2tvClNVU0UgTGFicwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
