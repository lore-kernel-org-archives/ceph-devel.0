From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: [PATCH 5/6] osd_client: add support for notify payloads via
 notify event
Date: Tue, 16 Jun 2015 13:22:41 -0400 (EDT)
Message-ID: <1929325146.16215775.1434475361029.JavaMail.zimbra@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <0010a14dcbe868312b9be6c7add8ec9d43fc0a28.1434124007.git.dfuller@redhat.com> <55804033.2000600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:45938 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbbFPRWl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 13:22:41 -0400
In-Reply-To: <55804033.2000600@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

----- Original Message -----
> From: "Mike Christie" <mchristi@redhat.com>
> To: "Douglas Fuller" <dfuller@redhat.com>, ceph-devel@vger.kernel.org
> Sent: Tuesday, June 16, 2015 11:26:43 AM
> Subject: Re: [PATCH 5/6] osd_client: add support for notify payloads via notify event
> 
> On 06/12/2015 10:56 AM, Douglas Fuller wrote:
> > @@ -2533,8 +2548,10 @@ static void handle_watch_notify(struct
> > ceph_osd_client *osdc,
> >  	if (msg->hdr.version >= 2)
> >  		ceph_decode_32_safe(&p, end, return_code, bad);
> >  
> > -	if (msg->hdr.version >= 3)
> > +	if (msg->hdr.version >= 3) {
> >  		ceph_decode_32_safe(&p, end, notifier_gid, bad);
> > +		data = list_first_entry(&msg->data, struct ceph_msg_data, links);
> 
> It's not completely clear how/who can use this data. Would rbd be
> calling ceph_osdc_create_notify_event/ceph_osdc_create_notify_event, or
> is some libceph code (net/ceph)?

rbd would be calling ceph_osdc_create_notify_event and then ceph_osdc_wait_event (which
waits for CEPH_WATCH_EVENT_NOTIFY_COMPLETE).

> If it's rbd, is it supposed to be digging into ceph_msg_data structs?
> Did we want to pass it a pagelist or CEPH_OSD_DATA_TYPE_PAGES type of
> pages array?

Yeah, it would be cleaner to just copy the pages pointer and size. I'll change that.

Either way, the decoding gets hairy and cumbersome. I think we should
extend osd_client to have one or two convenience routines like
ceph_osdc_for_each_notifier or something like that.
