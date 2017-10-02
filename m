From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Encrypted over WAN?
Date: Mon, 2 Oct 2017 09:02:58 +0100
Message-ID: <bc3240a6-1f91-8711-dc59-d8319825b5fb@suse.de>
References: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34033 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750770AbdJBIDB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 2 Oct 2017 04:03:01 -0400
In-Reply-To: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 10/02/2017 07:18 AM, Two Spirit wrote:
>> The Ceph Object Gateway supports server-side encryption of uploaded objects, with 3 options for the management of encryption keys. Server-side encryption means that the data is sent over HTTP in its unencrypted form, and the Ceph Object Gateway stores that data in the Ceph Storage Cluster in encrypted form.
> 
> It sounds like OSD to OSD traffic is unencrypted.
> 
> 1) Does "stores data in the cluster in encrypted form" mean *only* if
> the --dmcrypt option is used?
> 
> 2) Does that mean the zone  to zone copy across a WAN is also unencrypted?

Ceph does not have on-the-wire encryption.

   -Joao
