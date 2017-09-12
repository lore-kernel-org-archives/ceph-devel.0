From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Jewel v10.2.10, anyone?
Date: Tue, 12 Sep 2017 11:29:45 +0200
Message-ID: <bba21c07-f407-a811-681d-67a4f36c5d32@suse.cz>
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
Received: from mx2.suse.de ([195.135.220.15]:35039 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbdILJ3r (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 12 Sep 2017 05:29:47 -0400
In-Reply-To: <CADRKj5SCPDcDsrxvgLtOML+U6F8GN_e8dMjBTUdDZRK7CHXsxA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: Kyle Bader <kyle.bader@gmail.com>, shasha lu <lushasha08@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda:

> Sorry, missed this thread. I just went through the entire long list of
> rgw pending to jewel backports list. The following are ready to be
> merged now but are not there yet. I marked with (*) the higher
> priority ones.

OK, I updated your list with the current status of each backport:

> http://tracker.ceph.com/issues/17164 * non-trivial backport, not yet staged
> http://tracker.ceph.com/issues/17964 * merged
> http://tracker.ceph.com/issues/18077   merged
> http://tracker.ceph.com/issues/18639 * merged
> http://tracker.ceph.com/issues/19285   staged, testing
> http://tracker.ceph.com/issues/19817 * merged
> http://tracker.ceph.com/issues/19922   merged
> http://tracker.ceph.com/issues/20107 * staged, testing
> http://tracker.ceph.com/issues/20190   merged
> http://tracker.ceph.com/issues/20244 * staged, testing
> http://tracker.ceph.com/issues/20275   staged, testing
> http://tracker.ceph.com/issues/20357   staged, testing
> http://tracker.ceph.com/issues/20423   staged, testing
> http://tracker.ceph.com/issues/20539   staged, testing
> http://tracker.ceph.com/issues/20542 * staged, testing
> http://tracker.ceph.com/issues/20663   staged, testing
> http://tracker.ceph.com/issues/20686 * staged, testing
> http://tracker.ceph.com/issues/20688   staged, testing
> http://tracker.ceph.com/issues/20774 * staged, testing
> http://tracker.ceph.com/issues/20779 * staged, testing
> http://tracker.ceph.com/issues/20861 * staged, testing
> http://tracker.ceph.com/issues/20951   staged, testing
> http://tracker.ceph.com/issues/21141   staged, testing

I'm now running another integration round for RGW, including all the 
backports marked "staged, testing" in your list.

Nathan
