From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: OSDs are flapping and marked down wrongly
Date: Mon, 17 Oct 2016 10:19:38 +0200
Message-ID: <20161017081938.GB28088@predictor>
References: <BY2PR02MB3964B80170065D0141B7931F4D00@BY2PR02MB396.namprd02.prod.outlook.com>
 <20161017075141.GA28088@predictor>
 <BY2PR02MB396DD0B2B7541A1DB23123CF4D00@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:58867 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757638AbcJQISC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Oct 2016 04:18:02 -0400
Content-Disposition: inline
In-Reply-To: <BY2PR02MB396DD0B2B7541A1DB23123CF4D00@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Oct 17, 2016 at 08:06:19AM +0000, Somnath Roy wrote:
> Thanks Piotr, Wido for quick response.
> 
> @Wido , yes, I thought of trying with those values but I am seeing in the log messages at least 7 osds are reporting failure , so, didn't try. BTW, I found default mon_osd_min_down_reporters is 2 , not 1 and latest master is not having mon_osd_min_down_reports anymore. Not sure what it is replaced with..
> 
> @Piotr , yes, your PR really helps , thanks !  Regarding each messenger needs to respond to HB is confusing, I know each thread has a HB timeout value and beyond which it will crash with suicide timeout , are you talking about that ?

Not really, as I wrote previously - if you keep filling up the pipeline,
OSDs will fail to respond for heartbeats because they won't process them at
all or will process them, but the output pipeline will be so full that the
response won't get to the recipient in time.
Suicide timeouts occur when disk threads fail to process ops in reasonable
amount of time (hence the name: "suicide").

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
