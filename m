From: Gregory Farnum <greg@inktank.com>
Subject: Re: Non existing monitor
Date: Fri, 1 Aug 2014 08:46:28 -0400
Message-ID: <CAPYLRzjRw-wTcv3Q2ZAKjmXKwNsLwL6gsj5BAJfSVSNcEg3New@mail.gmail.com>
References: <7F4FDDF05D5B3241ABA5EB82D169E31E04B2FE35@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:60339 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbaHAMqa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 08:46:30 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so1308659wiv.7
        for <ceph-devel@vger.kernel.org>; Fri, 01 Aug 2014 05:46:28 -0700 (PDT)
In-Reply-To: <7F4FDDF05D5B3241ABA5EB82D169E31E04B2FE35@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>, Samuel Just <sam.just@inktank.com>, Joao Luis <joao.luis@inktank.com>

On Fri, Aug 1, 2014 at 6:03 AM, Aanchal Agrawal
<Aanchal.Agrawal@sandisk.com> wrote:
> Any help on this ...
>
> -----Original Message-----
> From: Aanchal Agrawal
> Sent: Wednesday, July 30, 2014 3:37 PM
> To: 'ceph-devel@vger.kernel.org'
> Cc: Pavan Rallabhandi
> Subject: Non existing monitor
>
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
> 2) And also, is it valid to flag "No Monitor present" in case the mon data directory is existing, but with no data('store.db') in it, in case mkfs is not set?

This is a little unclear to me. Can you describe exactly what commands
you're running and what the response from the monitor is?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
