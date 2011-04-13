From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: osd stops
Date: Wed, 13 Apr 2011 12:38:34 -0700
Message-ID: <FF91E350E7D94E96808037434D4914C0@gmail.com>
References: <174374365.14569.1302696771139.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37830 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab1DMTii (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2011 15:38:38 -0400
Received: by iwn34 with SMTP id 34so834125iwn.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2011 12:38:37 -0700 (PDT)
In-Reply-To: <174374365.14569.1302696771139.JavaMail.root@mail.linserv.se>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel@vger.kernel.org

On Wednesday, April 13, 2011 at 5:12 AM, Martin Wilderoth wrote:
The statistics of the disks, this is after the crash of osd2 and osd4.
> 
> /dev/sdc 143373312 124954676 18418636 88% /data/osd0
> /dev/sdd 143373312 137639524 5733788 97% /data/osd1
> 
> /dev/sdc 143373312 120350584 23022728 84% /data/osd2
> /dev/sdd 143373312 141986188 1387124 100% /data/osd3
> 
> /dev/sdc 143373312 112025716 31347596 79% /data/osd4
> /dev/sdd 143373312 115163124 28210188 81% /data/osd5
> 
> I will send some statistic of the ext3 as well

Am I reading this right, each of those disks is ~137MB? Those are some very small disks; I actually don't think you'll have much luck with the OSDs on something that small just because random balancing on disks that small won't work out very well -- there's too much variation when the total disk is only ~30 times larger than the default stripe size.
-Greg



