From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 19:54:45 +0200
Message-ID: <937453C8-37D5-4708-B81B-CD97B4AF3BF8@profihost.ag>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB1EF8.4050307@sandia.gov> <4FEB2480.3080404@profihost.ag> <4FEB4179.8050104@sandia.gov>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42089 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab2F0Ryv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 13:54:51 -0400
In-Reply-To: <4FEB4179.8050104@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 27.06.2012 um 19:23 schrieb "Jim Schutt" <jaschut@sandia.gov>:

> On 06/27/2012 09:19 AM, Stefan Priebe wrote:
>> Am 27.06.2012 16:55, schrieb Jim Schutt:
>>> This is my current best tuning for my hardware, which uses
>>> 24 SAS drives/server, and 1 OSD/drive with a journal partition
>>> on the outer tracks and btrfs for the data store.
>> 
>> Which raid level do you use?
> 
> No RAID.  Each OSD directly accesses a single
> disk, via a partition for the journal and a partition
> for the btrfs file store for that OSD.
So you have 24 threads x 24 osds 576 threads running?

> The NICs are Chelsio T4, but I'm not using any of the
> TCP stateful offload features for this testing.
> I don't know if they have ntuple support, but the
> ethtool version I'm using (2.6.33) doesn't mention it.
> 
> For kernels I switch back and forth between latest development
> kernel from Linus's tree, or latest stable kernel, depending
> on where the kernel development cycle is.  I usually switch
> to the development kernel around -rc4 or so.
> 

Crazy that this works for you. Btrfs is crashing to me in 20s while running full speed on ssd.

Stefan
