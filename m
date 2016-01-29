From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ceph Tech Talk - High-Performance Production
	Databases on Ceph
Date: Fri, 29 Jan 2016 13:25:13 -0800
Message-ID: <CAJ4mKGbwV8VH-MAfZ_H_PO667JCLsxjJLRLC-4HBKJ1TaGCe7g@mail.gmail.com>
References: <CAAZbbf3WKYiLtihz21pnQ-HUXXvLWmreYdQ_1XEaYe=VSDPUHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAZbbf3WKYiLtihz21pnQ-HUXXvLWmreYdQ_1XEaYe=VSDPUHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

VGhpcyBpcyBzdXBlciBjb29sIOKAlCB0aGFua3MsIFRob3J2YWxkLCBmb3IgdGhlIHJlYWxpc3Rp
YyBwaWN0dXJlIG9mCmhvdyBkYXRhYmFzZXMgYmVoYXZlIG9uIHJiZCEKCk9uIFRodSwgSmFuIDI4
LCAyMDE2IGF0IDExOjU2IEFNLCBQYXRyaWNrIE1jR2FycnkgPHBtY2dhcnJ5QHJlZGhhdC5jb20+
IHdyb3RlOgo+IEhleSBjZXBoZXJzLAo+Cj4gSGVyZSBhcmUgdGhlIGxpbmtzIHRvIGJvdGggdGhl
IHZpZGVvIGFuZCB0aGUgc2xpZGVzIGZyb20gdGhlIENlcGggVGVjaAo+IFRhbGsgdG9kYXkuIFRo
YW5rcyBhZ2FpbiB0byBUaG9ydmFsZCBhbmQgTWVkYWxsaWEgZm9yIHN0ZXBwaW5nIGZvcndhcmQK
PiB0byBwcmVzZW50Lgo+Cj4gVmlkZW86IGh0dHBzOi8veW91dHUuYmUvT3FsQzdTM2NVS3MKPgo+
IFNsaWRlczogaHR0cDovL3d3dy5zbGlkZXNoYXJlLm5ldC9Jbmt0YW5rX0NlcGgvMjAxNmphbjI4
LWhpZ2gtcGVyZm9ybWFuY2UtcHJvZHVjdGlvbi1kYXRhYmFzZXMtb24tY2VwaC01NzYyMDAxNAo+
Cj4KPiAtLQo+Cj4gQmVzdCBSZWdhcmRzLAo+Cj4gUGF0cmljayBNY0dhcnJ5Cj4gRGlyZWN0b3Ig
Q2VwaCBDb21tdW5pdHkgfHwgUmVkIEhhdAo+IGh0dHA6Ly9jZXBoLmNvbSAgfHwgIGh0dHA6Ly9j
b21tdW5pdHkucmVkaGF0LmNvbQo+IEBzY3V0dGxlbW9ua2V5IHx8IEBjZXBoCj4gLS0KPiBUbyB1
bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgY2Vw
aC1kZXZlbCIgaW4KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2Vy
bmVsLm9yZwo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcv
bWFqb3Jkb21vLWluZm8uaHRtbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpjZXBoLXVzZXJzIG1haWxpbmcgbGlzdApjZXBoLXVzZXJzQGxpc3RzLmNlcGgu
Y29tCmh0dHA6Ly9saXN0cy5jZXBoLmNvbS9saXN0aW5mby5jZ2kvY2VwaC11c2Vycy1jZXBoLmNv
bQo=
