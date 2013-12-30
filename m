From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: ceph and scsi reservation-like locking
Date: Mon, 30 Dec 2013 13:43:14 -0800
Message-ID: <52C1E8F2.6060107@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B68567948@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f170.google.com ([209.85.161.170]:56659 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab3L3VoE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 16:44:04 -0500
Received: by mail-gg0-f170.google.com with SMTP id 24so2405333gge.29
        for <ceph-devel@vger.kernel.org>; Mon, 30 Dec 2013 13:44:03 -0800 (PST)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B68567948@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/28/2013 06:34 PM, James Harper wrote:
> Is the rbd locking feature-compatible with scsi3 persistent reservations?

It wasn't designed with scsi-3 exactly in mind, but using exclusive
locks and fencing might suffice.

To fence a client, you'd get its address from rbd_list_lockers() and
blacklist it with the 'ceph osd blacklist add' command, which can be
done via rados_mon_command() these days.

Blacklisting adds an entry in the osdmap so osds return an error when
blacklisted clients try to access them. By default a blacklist entry
expires after 1 hour.

> To use ceph as a storage backend for a Hyper-V cluster directly (rather than through an iscsi gateway), it looks like I'll need a virtual scsi3 device that supports persistent reservations.

I'm not sure exactly what parts of persistent reservations Hyper-V
relies on - let us know how it goes!

Josh
