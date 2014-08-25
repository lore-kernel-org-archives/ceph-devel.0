From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: RE: Deadlock in ceph journal
Date: Mon, 25 Aug 2014 03:32:12 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C8B890A@SHSMSX101.ccr.corp.intel.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1408192149330.28244@cobra.newdream.net>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF69@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1408200832440.28244@cobra.newdream.net>
 <6AA21C22F0A5DA478922644AD2EC308C8B7FF7@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408202051540.28244@cobra.newdream.net>
 <6AA21C22F0A5DA478922644AD2EC308C8B8342@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408210822430.31169@cobra.newdream.net>
 <53F692AE.90007@catalyst.net.nz>
 <alpine.DEB.2.00.1408211749040.31169@cobra.newdream.net>
 <53F7C1C3.8000303@catalyst.net.nz>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F264745A2@SACMBXIP01.sdcorp.global.sandisk.com>
 <53F7C669.9010800@catalyst.net.nz>
 <6AA21C22F0A5DA478922644AD2EC308C8B8831@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408241914450.30994@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_6AA21C22F0A5DA478922644AD2EC308C8B890ASHSMSX101ccrcorpi_"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5345 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805AbaHYDcs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Aug 2014 23:32:48 -0400
In-Reply-To: <alpine.DEB.2.00.1408241914450.30994@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, Somnath Roy <Somnath.Roy@sandisk.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--_002_6AA21C22F0A5DA478922644AD2EC308C8B890ASHSMSX101ccrcorpi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attachment is the patch.

Jianpeng

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Monday, August 25, 2014 10:15 AM
> To: Ma, Jianpeng
> Cc: Mark Kirkwood; Somnath Roy; Samuel Just (sam.just@inktank.com);
> ceph-devel@vger.kernel.org
> Subject: RE: Deadlock in ceph journal
>=20
> Sounds good. Can you send a patch?
>=20
> sage
>=20
>=20
> On Mon, 25 Aug 2014, Ma, Jianpeng wrote:
>=20
> > Hi all,
> >    At weekend, I read the kernel code about aio & direction. For close(=
), it
> don't wait aio to complete.
> > But for fsync(), it will wait all aio to complete.
> >    Mark used this patch(which using fsync() on write_thread_entry) and =
the
> result is looks good.
> >    I want to revert the patch which don't use aio when closing journal.=
 And
> using fsync(). It make the code simple.
> >    How about this?
> >
> > Thanks!
> > Jianpeng
> >
> > > ceph-devel@vger.kernel.org
> > > Subject: Re: Deadlock in ceph journal
> > >
> > > On 23/08/14 10:22, Somnath Roy wrote:
> > > > I think it is using direct io for non-aio mode as well.
> > > >
> > > > Thanks & Regards
> > > > Somnath
> > > >
> > >
> > > > One thing that does still concern me - if I understand what is
> > > > happening here
> > > correctly: we write to the journal using aio until we want to stop
> > > doing writes (presumably pre closing it), then use normal io to write=
 at that
> point.
> > > >
> > > > Given that we appear to be using direct io whenever we use aio,
> > > > does this
> > > mean we end up mixing direct and buffered io to the journal [1] (or
> > > is the normal i.e non aio write still using direct io)?
> > > >
> > > >
> > >
> > > Thanks Somnath,
> > >
> > > I think you are correct (I missed the bit in FileJournal::_open that
> > > seems to cover this):
> > >
> > >
> > >    if (forwrite) {
> > >      flags =3D O_RDWR;
> > >      if (directio)
> > >        flags |=3D O_DIRECT | O_DSYNC;
> > >
> > >
> > > i.e the journal is opened with DIRECT, so all writes (async or not)
> > > will be direct.
> > >
> > > Cheers
> > >
> > > Mark
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

--_002_6AA21C22F0A5DA478922644AD2EC308C8B890ASHSMSX101ccrcorpi_
Content-Type: application/octet-stream;
	name="0001-os-FileJournal-Before-write_thread_entry-exit-using-.patch"
Content-Description: 0001-os-FileJournal-Before-write_thread_entry-exit-using-.patch
Content-Disposition: attachment;
	filename="0001-os-FileJournal-Before-write_thread_entry-exit-using-.patch";
	size=1700; creation-date="Mon, 25 Aug 2014 03:29:50 GMT";
	modification-date="Mon, 25 Aug 2014 03:31:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1NmEzMjY3ZmUzOThhYTc4MmFmNzE3NDYwMzMyZWE5MzYwZDczNzI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYSBKaWFucGVuZyA8amlhbnBlbmcubWFAaW50ZWwuY29tPgpE
YXRlOiBNb24sIDI1IEF1ZyAyMDE0IDExOjIwOjQ4ICswODAwClN1YmplY3Q6IFtQQVRDSF0gb3Mv
RmlsZUpvdXJuYWw6IEJlZm9yZSB3cml0ZV90aHJlYWRfZW50cnkgZXhpdCwgdXNpbmcgZnN5bmMo
KQogdG8gbWFrZSBzdXJlIGFsbCBkYXRhIHRvIGRpc2suCgpDb21taXQoZTg3MGZkMDhjZSkgdGhl
IGFpbSBpcyAgbWFrZSBzdXJlIGFsbCBhaW8gZGF0YSB0byBkaXNrIHdoZW4gY2xvc2luZwpqb3Vy
bmFsLiBUaGUgZnN5bmMoKSBjYW4gYWNoaWV2ZSB0aGUgc2FtZSBlZmZlY3QuIEZvciBhaW8rZGly
ZWN0aW8sCmFmdGVyIGlvX3N1Ym1pdCwgdGhlIGNvbnRlbnQgaXMgaW4gcmVxdWVzdC1xdWV1ZSBv
ZiBibG9jayBkZXZpY2UuCkZzeW5jKCkgd2lsbCBzZW5kIGEgZmx1c2ggcmVxdWVzdCB0byB3YWl0
IGFsbCByZXF1ZXN0cyBvZiBibG9jayBxdWV1ZSB0bwpjb21wbGV0ZS4KClNpZ25lZC1vZmYtYnk6
IE1hIEppYW5wZW5nIDxqaWFucGVuZy5tYUBpbnRlbC5jb20+Ci0tLQogc3JjL29zL0ZpbGVKb3Vy
bmFsLmNjIHwgNyArKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9vcy9GaWxlSm91cm5hbC5jYyBiL3NyYy9vcy9G
aWxlSm91cm5hbC5jYwppbmRleCBkNmRkYzdmLi4xZjNhMDliIDEwMDY0NAotLS0gYS9zcmMvb3Mv
RmlsZUpvdXJuYWwuY2MKKysrIGIvc3JjL29zL0ZpbGVKb3VybmFsLmNjCkBAIC0xMTI1LDkgKzEx
MjUsNyBAQCB2b2lkIEZpbGVKb3VybmFsOjp3cml0ZV90aHJlYWRfZW50cnkoKQogICAgIH0KICAg
ICAKICNpZmRlZiBIQVZFX0xJQkFJTwotICAgIC8vV2UgaG9wZSB3cml0ZV9maW5pc2hfdGhyZWFk
X2VudHJ5IHJldHVybiB1bnRpbCB0aGUgbGFzdCBhaW9zIGNvbXBsZXRlCi0gICAgLy93aGVuIHNl
dCB3cml0ZV9zdG9wLiBCdXQgaXQgY2FuJ3QuIFNvIGRvbid0IHVzZSBhaW8gbW9kZSB3aGVuIHNo
dXRkb3duLgotICAgIGlmIChhaW8gJiYgIXdyaXRlX3N0b3ApIHsKKyAgICBpZiAoYWlvKSB7CiAg
ICAgICBNdXRleDo6TG9ja2VyIGxvY2tlcihhaW9fbG9jayk7CiAgICAgICAvLyBzaG91bGQgd2Ug
YmFjayBvZmYgdG8gbGltaXQgYWlvcyBpbiBmbGlnaHQ/ICB0cnkgdG8gZG8gdGhpcwogICAgICAg
Ly8gYWRhcHRpdmVseSBzbyB0aGF0IHdlIHN1Ym1pdCBsYXJnZXIgYWlvcyBvbmNlIHdlIGhhdmUg
bG90cyBvZgpAQCAtMTE3OCw3ICsxMTc2LDcgQEAgdm9pZCBGaWxlSm91cm5hbDo6d3JpdGVfdGhy
ZWFkX2VudHJ5KCkKICAgICB9CiAKICNpZmRlZiBIQVZFX0xJQkFJTwotICAgIGlmIChhaW8gJiYg
IXdyaXRlX3N0b3ApCisgICAgaWYgKGFpbykKICAgICAgIGRvX2Fpb193cml0ZShibCk7CiAgICAg
ZWxzZQogICAgICAgZG9fd3JpdGUoYmwpOwpAQCAtMTE4OCw2ICsxMTg2LDcgQEAgdm9pZCBGaWxl
Sm91cm5hbDo6d3JpdGVfdGhyZWFkX2VudHJ5KCkKICAgICBwdXRfdGhyb3R0bGUob3JpZ19vcHMs
IG9yaWdfYnl0ZXMpOwogICB9CiAKKyAgZnN5bmMoZmQpOwogICBkb3V0KDEwKSA8PCAid3JpdGVf
dGhyZWFkX2VudHJ5IGZpbmlzaCIgPDwgZGVuZGw7CiB9CiAKLS0gCjEuOS4xCgo=

--_002_6AA21C22F0A5DA478922644AD2EC308C8B890ASHSMSX101ccrcorpi_--
