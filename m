From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: wip-denc
Date: Wed, 14 Sep 2016 16:03:16 +0100
Message-ID: <7c222fa6-0ac1-f6d7-3c8a-bca46848fa66@suse.de>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
 <6cb3ef53-fcac-0d7c-4220-cef16510484d@suse.de>
 <alpine.DEB.2.11.1609141323200.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43369 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760246AbcINPDT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 11:03:19 -0400
In-Reply-To: <alpine.DEB.2.11.1609141323200.19761@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 09/14/2016 02:27 PM, Sage Weil wrote:
> What doesn't work is cases where the decode path has a more complicated
> conditional or compat value (that isn't the class constructor's default).
> In those cases you just need to define the 3 methods separately!

Gotcha. Makes sense.

   -Joao

