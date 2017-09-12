From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Jewel v10.2.10, anyone?
Date: Tue, 12 Sep 2017 22:22:18 +0200
Message-ID: <5bd214a4-89d3-294d-561c-075398bc9161@suse.cz>
References: <7ca238e9-0cd0-d3c6-73c2-76643d7f2ec0@suse.cz>
 <CAKEPnAaYBpSA-k8p4K=qrDzqLBKwyDQGaavOb1Y9hXunjejRCw@mail.gmail.com>
 <5f99f37a-14a5-dc4b-0573-bec029602cdd@suse.cz>
 <CAFMfnwoyB4y5d6pHXG-kv0rFauiKeDV918EcAiBtOdVq2GtKCg@mail.gmail.com>
 <8efc8e04-bed6-a47a-76dc-0172478cbf70@suse.cz>
 <CADRKj5SCPDcDsrxvgLtOML+U6F8GN_e8dMjBTUdDZRK7CHXsxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750869AbdILUWU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 12 Sep 2017 16:22:20 -0400
In-Reply-To: <CADRKj5SCPDcDsrxvgLtOML+U6F8GN_e8dMjBTUdDZRK7CHXsxA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: Kyle Bader <kyle.bader@gmail.com>, shasha lu <lushasha08@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda:

The rgw suite has been very well-behaved during the preparation of this 
jewel point release. The jewel backports of all the issues you mentioned 
(below) have been merged, except for the very first one - 
http://tracker.ceph.com/issues/17164 - which has only been in "Pending 
Backport" status for a very short time.

On behalf of the rgw team, do you think 10.2.10 is ready to go to QE?

Thanks,
Nathan

On 09/12/2017 09:03 AM, Yehuda Sadeh-Weinraub wrote:
> http://tracker.ceph.com/issues/17164  *
> http://tracker.ceph.com/issues/17964  *
> http://tracker.ceph.com/issues/18077
> http://tracker.ceph.com/issues/18639  *
> http://tracker.ceph.com/issues/19285
> http://tracker.ceph.com/issues/19817  *
> http://tracker.ceph.com/issues/19922
> http://tracker.ceph.com/issues/20107  *
> http://tracker.ceph.com/issues/20190
> http://tracker.ceph.com/issues/20244  *
> http://tracker.ceph.com/issues/20275
> http://tracker.ceph.com/issues/20357
> http://tracker.ceph.com/issues/20423
> http://tracker.ceph.com/issues/20539
> http://tracker.ceph.com/issues/20542  *
> http://tracker.ceph.com/issues/20663
> http://tracker.ceph.com/issues/20686  *
> http://tracker.ceph.com/issues/20688
> http://tracker.ceph.com/issues/20774  *
> http://tracker.ceph.com/issues/20779  *
> http://tracker.ceph.com/issues/20861  *
> http://tracker.ceph.com/issues/20951
> http://tracker.ceph.com/issues/21141
