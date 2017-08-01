From: Sage Weil <sage@newdream.net>
Subject: Re: Mon stats in luminous rc
Date: Tue, 1 Aug 2017 03:05:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708010304040.20435@piezo.novalocal>
References: <D5A4AD67.949E8%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39107 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdHADFQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 23:05:16 -0400
In-Reply-To: <D5A4AD67.949E8%travis.nielsen@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Nielsen <Travis.Nielsen@Quantum.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 31 Jul 2017, Travis Nielsen wrote:
> The ceph status -f json command has changed quite a bit in luminous RC. I
> see the following expected change with the health messages.
> https://github.com/ceph/ceph/pull/15643
> 
> And in the pending release notes there is a new command for
> time-sync-status.
> 
> However, I can't find what happened with the mon stats in the
> health_services section. Where can I find them? In 12.1.0 they were there,
> but not seeing them now in 12.1.1.
> 
> $ ceph health -f json| jq
> {
>   "health": {
>     "health_services": [
>       {
>         "mons": [
>           {
>             "name": "mon0",
>             "kb_total": 16888216,
>             "kb_used": 2345480,
>             "kb_avail": 13553604,
>             "avail_percent": 80,
>             "last_updated": "2017-07-31 15:43:49.107186",
>             "store_stats": {
>               "bytes_total": 1486739,
>               "bytes_sst": 1504,
>               "bytes_log": 1476780,
>               "bytes_misc": 8455,
>               "last_updated": "0.000000"
>             },
>             "health": "HEALTH_OK"
>           },

Ah, these are just gone... I didn't expect anyone to be consuming 
them.  We can add a mon-store-status or similar command to include this 
information if you need it.

sage
