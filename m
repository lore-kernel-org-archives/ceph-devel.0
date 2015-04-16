From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Regarding newstore performance
Date: Thu, 16 Apr 2015 13:17:18 -0500
Message-ID: <552FFCAE.1040303@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD79CFB@SACMBXIP01.sdcorp.global.sandisk.com> <CACJqLybLO=ut70O7Mf_RCnJwzBPAH45OBnGLdHesdnRziCUUiQ@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A0A1@SACMBXIP01.sdcorp.global.sandisk.com> <6F3FA899187F0043BA1827A69DA2F7CC021CE207@shsmsx102.ccr.corp.intel.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A350@SACMBXIP01.sdcorp.global.sandisk.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A4EF@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41665 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbbDPSR3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Apr 2015 14:17:29 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A4EF@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/16/2015 01:17 AM, Somnath Roy wrote:
> Here is the data with omap separated to another SSD and after 1000GB of fio writes (same profile)..
>
> omap writes:
> -------------
>
> Total host writes in this period = 551020111 ------ ~2101 GB
>
> Total flash writes in this period = 1150679336
>
> data writes:
> -----------
>
> Total host writes in this period = 302550388 --- ~1154 GB
>
> Total flash writes in this period = 600238328
>
> So, actual data write WA is ~1.1 but omap overhead is ~2.1 and adding those getting ~3.2 WA overall.

Looks like we can get quite a bit of data out of the rocksdb log as 
well.  Here's a stats dump after a full benchmark run from an SSD backed 
OSD with newstore, fdatasync, and xioxi's tuanbles to increase buffer sizes:

http://www.fpaste.org/212007/raw/

It appears that in this test at least, a lot of data gets moved to L3 
and L4 with associated WA.  Notice the crazy amount of reads as well!

Mark
