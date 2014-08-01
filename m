From: Wido den Hollander <wido@42on.com>
Subject: Re: Non existing monitor
Date: Fri, 01 Aug 2014 12:10:50 +0200
Message-ID: <53DB67AA.9090007@42on.com>
References: <7F4FDDF05D5B3241ABA5EB82D169E31E04B2F97D@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:49294 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003AbaHAKKx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Aug 2014 06:10:53 -0400
In-Reply-To: <7F4FDDF05D5B3241ABA5EB82D169E31E04B2F97D@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>

On 07/30/2014 12:07 PM, Aanchal Agrawal wrote:
> Hi,
>
> We found a case(bug?) in ceph mon code, where in, an attempt to start a non-existing monitor is throwing up a levelDB error saying "failed to create new leveldb store", instead we thought an appropriate message say "No Monitor present with that id" would do, by checking for the monitor existence way ahead.
>
> It seems that 'mon_exists()' checks for the existence of the mon data directory(via 'mon_data_exists()') and also for the non-empty nature of that directory(via 'mon_data_empty()'). The fix seemed pretty simple, as to flag the appropriate message if 'mon_data_exists()' were to set 'exists' to 'false', in case mkfs is not set.
>
> The other behavior that we are seeking clarity, again in case of mkfs not being set is, if 'mon_data_exists()' sets 'exists' to 'true' and 'mon_data_empty()' sets 'exists' to 'false' (meaning the mon data directory is present, but it is empty), then the current code seems to be going ahead in an attempt to open the 'store.db', and when open fails, it tries to create a new 'store.db' (though mkfs is not set) and eventually gives up throwing "unable to read magic from mon data".
>
> The questions we had around this were:
>
> 1) Though in case of mkfs not being set, what is the reason for creating a new levelDB store in case an attempt to open the 'store.db' is a failure, as levelDB anyways seem to be throwing 'magic' error going forward. Are there any use cases for this scenario?

Separate from Ceph it seems like bad behavior of a daemon to start 
creating directories when --mkfs is not supplied.

It should spit our errors about not being able to access it's data 
store, but not start creating them without explicitly being told to do so.

> 2) And also, is it valid to flag "No Monitor present" in case the mon data directory is existing, but with no data('store.db') in it, in case mkfs is not set?
>
> Thanks,
> Aanchal
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
