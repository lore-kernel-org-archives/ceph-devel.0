From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: SIGTERM and osd close
Date: Fri, 1 Jul 2016 08:18:27 +1000
Message-ID: <CAF-wwdHru3O3OPNrsB-GRTiGYFBueGU_ya=H38sGG7zZjqCvWw@mail.gmail.com>
References: <CY1PR0201MB182059A3B8115A640EB69BA985240@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB2115AA87DE1F8A1929FB6887F4240@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38027 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcF3WS3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2016 18:18:29 -0400
Received: by mail-wm0-f49.google.com with SMTP id r201so4962937wme.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2016 15:18:29 -0700 (PDT)
In-Reply-To: <BL2PR02MB2115AA87DE1F8A1929FB6887F4240@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jul 1, 2016 at 4:44 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> You need to call it from BlueStore::umount() I guess for cleanup work..
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ramesh Chander
> Sent: Thursday, June 30, 2016 8:46 AM
> To: ceph-devel@vger.kernel.org
> Subject: SIGTERM and osd close
>
> Hi All,
>
> When I use stop.sh without any argument, I suppose it calls pkill with SIGTERM on osds as well as other processes.

616   // install signal handlers
617   init_async_signal_handler();
618   register_async_signal_handler(SIGHUP, sighup_handler);
619   register_async_signal_handler_oneshot(SIGINT, handle_osd_signal);
620   register_async_signal_handler_oneshot(SIGTERM, handle_osd_signal);

 65 void handle_osd_signal(int signum)
 66 {
 67   if (osd)
 68     osd->handle_signal(signum);
 69 }

1735 void OSD::handle_signal(int signum)
1736 {
1737   assert(signum == SIGINT || signum == SIGTERM);
1738   derr << "*** Got signal " << sig_str(signum) << " ***" << dendl;
1739   shutdown();
1740 }

2598 int OSD::shutdown()
2599 {

OSD::shutdown() in src/osd/OSD.cc is quite a large function that
performs quite a bit of clean up such as
draining and shutting down thread pool work queues, shutting down
messenger instances, un-registering
admin commands, shutting down the PGs, flushing outstanding ops,
updating the superblock and unmounting
the filestore (as Somnath mentioned this might be where you want to
look), shutting down the MON client and
clearing the peering work queue, in no particular order.

So there is no doubt the OSD (and other daemons such as MON and MDS)
intercepts this signal and performs
a graceful shutdown including many housekeeping tasks.

HTH,
Brad

>
> Does osd handle this signal and take care of closing all components?
>
> I am specifically interested in if it closes objectstore -> keyvaluedb .
>
> I don't see my code of keyvaluedb shutdown/close being called when I do ./stop.sh
>
> Any argument or way to force this?
>
> -Ramesh
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
