From: Sage Weil <sweil@redhat.com>
Subject: RE: K/V interface buffer transaction
Date: Tue, 10 Feb 2015 10:26:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502101025100.1652@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A62CE@SACMBXIP02.sdcorp.global.sandisk.com> <CA+4uBUa+XBKHkx32hmZAvn4JOLp=o2WJywnA7OWXzSphvEcgjw@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F282A63A6@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbbBJS0j (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Feb 2015 13:26:39 -0500
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A63A6@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "Haomai Wang (haomaiwang@gmail.com)" <haomaiwang@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 10 Feb 2015, Somnath Roy wrote:
> Thanks Sam !
> So, is it safe to do ordering if in a transaction *no* remove/truncate/create/add call ?
> For example, do we need to preserve ordering in case of the below transaction ?
> It will be helpful if you can give some insight in what scenario preserving order is *must*.

If I'm not mistaken teh only time ordering would matter at all in an 
transaction is when the same key is updated twice, right?  The whole thing 
is committed atomically.  If there *are* dups, then the order there 
obviously should be preserved.

Maybe a first pass would be add an assert or something that there are no 
dup keys and see if anything every falls out of that... hopefully there 
are none!

sage


> 
> Regards
> Somnath
> -----Original Message-----
> From: Samuel Just [mailto:sam.just@inktank.com] 
> Sent: Tuesday, February 10, 2015 9:22 AM
> To: Somnath Roy
> Cc: Sage Weil (sweil@redhat.com); Haomai Wang (haomaiwang@gmail.com); Ceph Development
> Subject: Re: K/V interface buffer transaction
> 
> In general, you do need to preserve the order.  You are free to determine when re-ordering is safe though.
> -Sam
> 
> On Tue, Feb 10, 2015 at 8:59 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > Hi Sage/Haomai,
> > Our K/V store works best if the keys of the objects within a transaction are sorted. We are writing a new K/V Db interface and planning to sort the keys within a transaction. So, this raises one question, do we need to preserve the order of the operation within a transaction ?
> > With the latest Ceph code, we are getting the following operations within a transaction.
> >
> > 2015-02-09 19:00:21.885646 7fde2a573700  0 Before ZSMPut :: p_num_obj 
> > =  9
> > 2015-02-09 19:00:21.885653 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885656 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 83
> > 2015-02-09 19:00:21.885657 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 225
> > 2015-02-09 19:00:21.885660 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _GHOBJTOSEQ_^A1%e6e_head!E63730A9!!1!!rbd_data%e100574b0dc51%e00000000
> > 00000689!head?
> > 2015-02-09 19:00:21.885663 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885664 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 64
> > 2015-02-09 19:00:21.885665 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 178
> > 2015-02-09 19:00:21.885666 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000000361__OBJOMAP__^A0000000011.00000000000000000554
> > 2015-02-09 19:00:21.885668 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885669 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 39
> > 2015-02-09 19:00:21.885671 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 4
> > 2015-02-09 19:00:21.885672 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000000361__OBJOMAP__^A_epoch
> > 2015-02-09 19:00:21.885673 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885674 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 38
> > 2015-02-09 19:00:21.885675 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 713
> > 2015-02-09 19:00:21.885676 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000000361__OBJOMAP__^A_info
> > 2015-02-09 19:00:21.885677 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885679 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 48
> > 2015-02-09 19:00:21.885680 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 12
> > 2015-02-09 19:00:21.885681 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000000361__OBJOMAP__^Acan_rollback_to
> > 2015-02-09 19:00:21.885682 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885683 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 57
> > 2015-02-09 19:00:21.885684 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 12
> > 2015-02-09 19:00:21.885685 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000000361__OBJOMAP__^Arollback_info_trimmed_to
> > 2015-02-09 19:00:21.885686 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885688 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 31
> > 2015-02-09 19:00:21.885689 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 65536
> > 2015-02-09 19:00:21.885690 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000001345_STRIP_^A54
> > 2015-02-09 19:00:21.885691 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885692 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 34
> > 2015-02-09 19:00:21.885693 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 273
> > 2015-02-09 19:00:21.885695 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000001345__OBJATTR__^A_
> > 2015-02-09 19:00:21.885696 7fde2a573700  0 p_obj[p_num_obj].flags = 0
> > 2015-02-09 19:00:21.885697 7fde2a573700  0 p_obj[p_num_obj].key_len = 
> > 40
> > 2015-02-09 19:00:21.885698 7fde2a573700  0 p_obj[p_num_obj].data_len = 
> > 31
> > 2015-02-09 19:00:21.885699 7fde2a573700  0 p_obj[p_num_obj].key = 
> > _SEQ_0000000000001345__OBJATTR__^Asnapset
> >
> > Looking at this it seems we don't need to preserve the order.
> > But, if I can remember correctly, at some point there will be some pglog trim operation will be issued from upstream and that may require some ordering.
> > Please share your thought around this.
> >
> > Thanks & Regards
> > Somnath
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> 
