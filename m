From: Sage Weil <sage@newdream.net>
Subject: Re: K/V interface buffer transaction
Date: Wed, 11 Feb 2015 16:30:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502111630320.3035@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A62CE@SACMBXIP02.sdcorp.global.sandisk.com> <CA+4uBUa+XBKHkx32hmZAvn4JOLp=o2WJywnA7OWXzSphvEcgjw@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F282A63A6@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502101025100.1652@cobra.newdream.net> <CAC6JEv_zcReo1y4JktniD-gcrKRUPLuviHJAtpoEWJ9=aai6Tg@mail.gmail.com> <alpine.DEB.2.00.1502101043260.1652@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F282A7D11@SACMBXIP02.sdcorp.global.sandisk.com>
 <CA+4uBUbJG9qVHS+0zk2YW3g7C3wemUm1fc5a18LtFQaCRtSnqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39021 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbBLAbA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 19:31:00 -0500
In-Reply-To: <CA+4uBUbJG9qVHS+0zk2YW3g7C3wemUm1fc5a18LtFQaCRtSnqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Gregory Farnum <greg@gregs42.com>, "Haomai Wang (haomaiwang@gmail.com)" <haomaiwang@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 11 Feb 2015, Samuel Just wrote:
> Well, the transaction is atomic, so if the key is set twice, you can
> certainly ignore the first one.

It's probably worth looking at what is generating the dup keys, though, 
yeah?

sage


> -Sam
> 
> On Wed, Feb 11, 2015 at 2:20 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > Hi,
> > My code had a bug during printing log. I was using map to store the attribute keys in sorted order and that was discarding the duplicates :-)
> >
> > This is what I found out coming during transaction.
> >
> > 2015-02-05 15:58:12.311738 7f27b5429700  0 queue_transactions :: before _do_transactions
> > 2015-02-05 15:58:12.311754 7f27b5429700  0 _do_transactions::before _do_transaction
> > 2015-02-05 15:58:12.311770 7f27b5429700  0 Transaction::OP_WRITE::cid = 1.a3_head oid = 680256a3/rbd_data.100974b0dc51.0000000000000631/head//1 offset = 3997696 len = 65536
> > 2015-02-05 15:58:12.311800 7f27b5429700  0 Transaction::OP_SETATTR::cid = 1.a3_head oid = 680256a3/rbd_data.100974b0dc51.0000000000000631/head//1 attr_name = _ attr_value_len = 273
> > 2015-02-05 15:58:12.311822 7f27b5429700  0 Transaction::OP_SETATTR::cid = 1.a3_head oid = 680256a3/rbd_data.100974b0dc51.0000000000000631/head//1 attr_name = snapset attr_value_len = 31
> > 2015-02-05 15:58:12.311840 7f27b5429700  0 Transaction::OP_OMAP_SETKEYS::cid = 1.a3_head oid = a3//head//1
> > 2015-02-05 15:58:12.311845 7f27b5429700  0 OMAP_KEY = 0000000102.00000000000000001592 Value = buffer::list(len=178,
> >         buffer::ptr(0~4 0x3efc21000 in raw 0x3efc21000 len 4096 nref 6),
> >         buffer::ptr(0~170 0x3d74840 in raw 0x3d74840 len 688 nref 3),
> >         buffer::ptr(4~4 0x3efc21004 in raw 0x3efc21000 len 4096 nref 6)
> > )
> > 2015-02-05 15:58:12.311931 7f27b5429700  0 Transaction::OP_OMAP_SETKEYS::cid = 1.a3_head oid = a3//head//1
> > 2015-02-05 15:58:12.311938 7f27b5429700  0 OMAP_KEY = _epoch Value = buffer::list(len=4,
> >         buffer::ptr(0~4 0x3efc1f000 in raw 0x3efc1f000 len 4096 nref 3)
> > )
> > 2015-02-05 15:58:12.311943 7f27b5429700  0 OMAP_KEY = _info Value = buffer::list(len=713,
> >         buffer::ptr(0~713 0x3efc1e000 in raw 0x3efc1e000 len 4096 nref 3)
> > )
> > 2015-02-05 15:58:12.311965 7f27b5429700  0 Transaction::OP_OMAP_SETKEYS::cid = 1.a3_head oid = a3//head//1
> > 2015-02-05 15:58:12.311969 7f27b5429700  0 OMAP_KEY = 0000000102.00000000000000001592 Value = buffer::list(len=178,
> >         buffer::ptr(0~4 0x3d75e40 in raw 0x3d75e40 len 688 nref 6),
> >         buffer::ptr(0~170 0x3d75b80 in raw 0x3d75b80 len 688 nref 3),
> >         buffer::ptr(4~4 0x3d75e44 in raw 0x3d75e40 len 688 nref 6)
> > )
> > 2015-02-05 15:58:12.311980 7f27b5429700  0 OMAP_KEY = can_rollback_to Value = buffer::list(len=12,
> >         buffer::ptr(0~12 0x3efc25000 in raw 0x3efc25000 len 4096 nref 3)
> > )
> > 2015-02-05 15:58:12.311985 7f27b5429700  0 OMAP_KEY = rollback_info_trimmed_to Value = buffer::list(len=12,
> >         buffer::ptr(0~12 0x3efc24000 in raw 0x3efc24000 len 4096 nref 3)
> > )
> >
> >
> >
> > So, the OMAP_KEY = 0000000102.00000000000000001592 is coming twice !
> >
> > Is there any reason, why ? What is this attribute by the way ?
> > Can we safely discard the first OP_OMAP_SETKEYS call for the same key ?
> >
> > Thanks & Regards
> > Somnath
> >
> > -----Original Message-----
> > From: Somnath Roy
> > Sent: Tuesday, February 10, 2015 4:36 PM
> > To: 'Sage Weil'; Gregory Farnum
> > Cc: sjust@redhat.com; Haomai Wang (haomaiwang@gmail.com); Ceph Development
> > Subject: RE: K/V interface buffer transaction
> >
> > Thanks Greg/Sam/Sage !
> > For now, we will be doing our testing by sorting the keys and will keep an eye on the duplicates.
> > Another point, why do we need the K/V store thread pool for processing transactions anymore ?
> > I got rid of that and calling _do_transaction() directly from the ::queue_trasaction , this is giving me ~3X performance improvement.
> >
> > Regards
> > Somnath
> >
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Tuesday, February 10, 2015 10:44 AM
> > To: Gregory Farnum
> > Cc: Somnath Roy; sjust@redhat.com; Haomai Wang (haomaiwang@gmail.com); Ceph Development
> > Subject: Re: K/V interface buffer transaction
> >
> > On Tue, 10 Feb 2015, Gregory Farnum wrote:
> >> On Tue, Feb 10, 2015 at 10:26 AM, Sage Weil <sweil@redhat.com> wrote:
> >> > On Tue, 10 Feb 2015, Somnath Roy wrote:
> >> >> Thanks Sam !
> >> >> So, is it safe to do ordering if in a transaction *no* remove/truncate/create/add call ?
> >> >> For example, do we need to preserve ordering in case of the below transaction ?
> >> >> It will be helpful if you can give some insight in what scenario preserving order is *must*.
> >> >
> >> > If I'm not mistaken teh only time ordering would matter at all in an
> >> > transaction is when the same key is updated twice, right?  The whole
> >> > thing is committed atomically.  If there *are* dups, then the order
> >> > there obviously should be preserved.
> >> >
> >> > Maybe a first pass would be add an assert or something that there
> >> > are no dup keys and see if anything every falls out of that...
> >> > hopefully there are none!
> >>
> >> I'm pretty sure some of the transaction analysis discussions people
> >> have had say that we do double-updates at times. IIRC it might have
> >> been the pglog head getting set twice in most transactions?
> >
> > Oh yeah, could be.  There was the snapset xattr update, but that was resetting it to an existing value (not the same value inside the same txn).  I forget if there were others.
> >
> > sage
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
