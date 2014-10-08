From: "Duan, Jiangang" <jiangang.duan@intel.com>
Subject: RE: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params
Date: Wed, 8 Oct 2014 20:03:23 +0000
Message-ID: <A9F57F2ABA6BB2469F01E127557C6C9B110B4101@SHSMSX104.ccr.corp.intel.com>
References: <54348A89.1060906@redhat.com> <20141008183234.19a24ac1@doppio>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4C1@SACMBXIP02.sdcorp.global.sandisk.com>
 <A9F57F2ABA6BB2469F01E127557C6C9B110B3FB0@SHSMSX104.ccr.corp.intel.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4F5@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40698 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754848AbaJHUD2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 16:03:28 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4F5@SACMBXIP02.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sound good. Thanks. -jiangang

-----Original Message-----
From: Somnath Roy [mailto:Somnath.Roy@sandisk.com] 
Sent: Wednesday, October 08, 2014 10:53 AM
To: Duan, Jiangang; Andreas Bluemle; ceph-devel@vger.kernel.org
Subject: RE: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params

Hi Jiangang,
Give me a day or two, I will gather all the data and share with community.

Thanks & Regards
Somnath

-----Original Message-----
From: Duan, Jiangang [mailto:jiangang.duan@intel.com]
Sent: Wednesday, October 08, 2014 10:47 AM
To: Somnath Roy; Andreas Bluemle; ceph-devel@vger.kernel.org
Subject: RE: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params

Can you guys share the w/ HT and w/o HT data? I want to take a look at that to understand why. 

-jiangang

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Wednesday, October 08, 2014 10:38 AM
To: Andreas Bluemle; ceph-devel@vger.kernel.org
Subject: RE: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params

Thanks Andres for sharing this. I will try those out.
BTW, I am using Ubuntu 14.04 LTS and couldn't find any sysfs entry like  'cpufreq'..

root@stormeap-4:~# ll /sys/devices/system/cpu/cpu10/
cache/            crash_notes       driver/           microcode/        online            subsystem/        topology/
cpuidle/          crash_notes_size  firmware_node/    node0/            power/            thermal_throttle/ uevent

I am using Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz.

Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Andreas Bluemle
Sent: Wednesday, October 08, 2014 9:33 AM
To: ceph-devel@vger.kernel.org
Subject: Re: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params

Hi,

as mentioned during today's meeting, here are the kernel boot parameters which I found to provide the basis for good performance results:

  processor.max_cstate=0
  intel_idle.max_cstate=0

I understand these to basically turn off any power saving modes of the CPU; the CPU's we are using are like
 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz
 Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz

At the BIOS level, we
 - turn off Hyperthraeding
 - turn off Turbo mode (in order ot not leave the specifications)
 - turn on frequency floor override

We also assert that
 /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
 is set to "performance"

Using above we see a constant frequency at the maximum level allowed by the CPU (except Turbo mode).


Best Regards

Andreas Bluemle






On Wed, 8 Oct 2014 02:51:21 +0200
Mark Nelson <mark.nelson@inktank.com> wrote:

> Hi All,
>
> Just a remind that the weekly performance meeting is on Wednesdays at 
> 8AM PST.  Same bat time, same bat channel!
>
> Etherpad URL:
> http://pad.ceph.com/p/performance_weekly
>
> To join the Meeting:
> https://bluejeans.com/268261044
>
> To join via Browser:
> https://bluejeans.com/268261044/browser
>
> To join with Lync:
> https://bluejeans.com/268261044/lync
>
>
> To join via Room System:
> Video Conferencing System: bjn.vc -or- 199.48.152.152 Meeting ID:
> 268261044
>
> To join via Phone:
> 1) Dial:
>            +1 408 740 7256
>            +1 888 240 2560(US Toll Free)
>            +1 408 317 9253(Alternate Number)
>            (see all numbers - http://bluejeans.com/numbers)
> 2) Enter Conference ID: 268261044
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>
>



--
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
