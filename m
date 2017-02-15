From: Loic Dachary <loic@dachary.org>
Subject: Re: Supplying ID to ceph-disk when creating OSD
Date: Wed, 15 Feb 2017 18:12:50 +0100
Message-ID: <7b0f9f25-b9e3-d203-a0b4-24892875c932@dachary.org>
References: <1907009558.10080.1487177956475@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47299 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdBORNJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 12:13:09 -0500
In-Reply-To: <1907009558.10080.1487177956475@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Wido,

On 02/15/2017 05:59 PM, Wido den Hollander wrote:
> Hi,
> 
> Currently we can supply a OSD UUID to 'ceph-disk prepare', but we can't provide a OSD ID.
> 
> With BlueStore coming I think the use-case for this is becoming very valid:
> 
> 1. Stop OSD
> 2. Zap disk
> 3. Re-create OSD with same ID and UUID (with BlueStore)
> 4. Start OSD
> 
> This allows for a in-place update of the OSD without modifying the CRUSHMap. For the cluster's point of view the OSD goes down and comes back up empty.
> 
> There were some drawbacks around this and some dangers, so before I start working on a PR for this, any gotcaches which might be a problem?
> 
> The idea is that users have a very simple way to re-format a OSD in-place while keeping the same CRUSH location, ID and UUID.

Since the mapping UUID <> id is kept in the monitor, re-using the UUID should give you the same OSD id. That is, unless your remove the OSD from the monitor but that's not what you're trying to do right ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
