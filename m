From: Sage Weil <sweil@redhat.com>
Subject: RE: reducing buffer allocations
Date: Thu, 4 Feb 2016 21:03:21 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602042057580.28396@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com> <CY1PR0201MB1897C54EB50EA1194D9DB2DDE8D10@CY1PR0201MB1897.namprd02.prod.outlook.com> <862942027.32511349.1454629757280.JavaMail.zimbra@redhat.com>
 <CY1PR0201MB189786205F79D8880D2982BDE8D20@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1655477260-1454637804=:28396"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39828 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbcBECDH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Feb 2016 21:03:07 -0500
In-Reply-To: <CY1PR0201MB189786205F79D8880D2982BDE8D20@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1655477260-1454637804=:28396
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> This is the approach that Casey and I lean toward, but if the intrusive 
> ptr change is ready now, I'd work on merging it.

Well, it worked well enough to pass unit tests, but it was reasonably 
complicated with the inline ptrs, and I didn't the big change going from 2 
allocations (buffer::raw/buffer and list<ptr> node/ptr) that I expected to 
see.

Hmm, a small_vector<> approach means 1 allocation per buffer, and in most 
cases will mean no additional allocation per bufferlist.  I think this 
will make for much simpler code...

Perhaps we should just start with (1) (combine buffer::raw with the buffer 
itself), since that's a simpler change anyway, and understanding any 
tradeoffs there around whether it is a good idea for larger buffers is 
enough to keep us busy for a bit anyway?

sage



> 
> Matt
> 
> ----- Original Message -----
> > From: "Allen Samuels" <Allen.Samuels@sandisk.com>
> > To: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
> > Sent: Thursday, February 4, 2016 5:43:36 PM
> > Subject: RE: reducing buffer allocations
> >
> > Looks like another place for small_vector ;-)
> >
> >
> > Allen Samuels
> > Software Architect, Fellow, Systems and Software Solutions
> >
> > 2880 Junction Avenue, San Jose, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >
> >
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Thursday, February 04, 2016 2:33 PM
> > To: ceph-devel@vger.kernel.org
> > Subject: reducing buffer allocations
> >
> > https://github.com/ceph/ceph/pull/5534
> >
> > does two things: (1) combine the buffer::raw reference count and
> > buffer into a single allocation (ala make_shared), and (2) convert
> > buffer::list into an intrusive_list, while embedding N (=3)
> > buffer::ptr's in the buffer::raw so that most buffers require only 1
> > allocation (provided they aren't on more than N lists).
> >
> > This needs a rebase, and some benchmarking.  But before I pull it up,
> > is this the right direction?  I saw little benefit from (2) after
> > doing (1), but I was doing a really simple microbenchmark.  Do we want
> > both, or just 1, or is there an alternative we should consider?
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at http://vger.kernel.org/majordomo-info.html
> > PLEASE NOTE: The information contained in this electronic mail message
> > is intended only for the use of the designated recipient(s) named
> > above. If the reader of this message is not the intended recipient,
> > you are hereby notified that you have received this message in error
> > and that any review, dissemination, distribution, or copying of this
> > message is strictly prohibited. If you have received this
> > communication in error, please notify the sender by telephone or
> > e-mail (as shown above) immediately and destroy any and all copies of
> > this message in your possession (whether hard copies or electronically stored copies).
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://www.redhat.com/en/technologies/storage
> 
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-1655477260-1454637804=:28396--
