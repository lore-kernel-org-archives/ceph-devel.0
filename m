From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Jewel v10.2.10, anyone?
Date: Thu, 7 Sep 2017 20:01:11 +0200
Message-ID: <3238ddbb-dfac-cc92-bb7a-58580291cf23@suse.cz>
References: <7ca238e9-0cd0-d3c6-73c2-76643d7f2ec0@suse.cz>
 <CAKEPnAaYBpSA-k8p4K=qrDzqLBKwyDQGaavOb1Y9hXunjejRCw@mail.gmail.com>
 <9197A99E-AC8C-4BC6-A446-96472053F650@99cloud.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751634AbdIGSBN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 7 Sep 2017 14:01:13 -0400
In-Reply-To: <9197A99E-AC8C-4BC6-A446-96472053F650@99cloud.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YuShengzuo <yu.shengzuo@99cloud.net>, shasha lu <lushasha08@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Can we merge following request into Jewel,
> https://github.com/ceph/ceph/pull/15140 ?
> 
> It is so badly to restart rbd-mirror every time after failover.

Sorry, that one is too complex to backport this late in the Jewel 
release cycle.

Nathan
