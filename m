From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: K/V interface buffer transaction
Date: Wed, 11 Feb 2015 00:36:25 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A6C7D@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A62CE@SACMBXIP02.sdcorp.global.sandisk.com>
 <CA+4uBUa+XBKHkx32hmZAvn4JOLp=o2WJywnA7OWXzSphvEcgjw@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F282A63A6@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502101025100.1652@cobra.newdream.net>
 <CAC6JEv_zcReo1y4JktniD-gcrKRUPLuviHJAtpoEWJ9=aai6Tg@mail.gmail.com>
 <alpine.DEB.2.00.1502101043260.1652@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0060.outbound.protection.outlook.com ([207.46.100.60]:22208
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750965AbbBKAga convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 19:36:30 -0500
In-Reply-To: <alpine.DEB.2.00.1502101043260.1652@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <greg@gregs42.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "Haomai Wang (haomaiwang@gmail.com)" <haomaiwang@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks Greg/Sam/Sage !
For now, we will be doing our testing by sorting the keys and will keep an eye on the duplicates.
Another point, why do we need the K/V store thread pool for processing transactions anymore ?
I got rid of that and calling _do_transaction() directly from the ::queue_trasaction , this is giving me ~3X performance improvement.

Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Tuesday, February 10, 2015 10:44 AM
To: Gregory Farnum
Cc: Somnath Roy; sjust@redhat.com; Haomai Wang (haomaiwang@gmail.com); Ceph Development
Subject: Re: K/V interface buffer transaction

On Tue, 10 Feb 2015, Gregory Farnum wrote:
> On Tue, Feb 10, 2015 at 10:26 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Tue, 10 Feb 2015, Somnath Roy wrote:
> >> Thanks Sam !
> >> So, is it safe to do ordering if in a transaction *no* remove/truncate/create/add call ?
> >> For example, do we need to preserve ordering in case of the below transaction ?
> >> It will be helpful if you can give some insight in what scenario preserving order is *must*.
> >
> > If I'm not mistaken teh only time ordering would matter at all in an
> > transaction is when the same key is updated twice, right?  The whole
> > thing is committed atomically.  If there *are* dups, then the order
> > there obviously should be preserved.
> >
> > Maybe a first pass would be add an assert or something that there
> > are no dup keys and see if anything every falls out of that...
> > hopefully there are none!
>
> I'm pretty sure some of the transaction analysis discussions people
> have had say that we do double-updates at times. IIRC it might have
> been the pglog head getting set twice in most transactions?

Oh yeah, could be.  There was the snapset xattr update, but that was resetting it to an existing value (not the same value inside the same txn).  I forget if there were others.

sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

