From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 08 Jun 2012 00:12:14 +0200
Message-ID: <21956274.ZS8TD6a5Rv@tolkien>
References: <21601270.dfB0BsVfyn@pc10> <3039502.NLSCFOhhFU@pc10> <CALFpzo6sPgf+iK_1asQM0zW_mmmoW0yMjWC8PCc7=qCH=BVdYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:35637 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933184Ab2FGWMV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jun 2012 18:12:21 -0400
In-Reply-To: <CALFpzo6sPgf+iK_1asQM0zW_mmmoW0yMjWC8PCc7=qCH=BVdYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thursday 07 June 2012 15:53:18 Marcus Sorensen wrote:
> Maybe I did something wrong with your iotester, but I had to mkdir
> ./iotest to get it to run. I straced and found that it died on 'no
> such file'.

It's a bit quick and dirty... You are supposed to pass the directory where it 
is to put its test files on the commandline, like

./iotester /mnt/filesystem_to_test

	Guido
