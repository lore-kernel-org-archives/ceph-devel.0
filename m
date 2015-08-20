From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Thu, 20 Aug 2015 15:08:49 +0800
Message-ID: <CACJqLyYhBT8ZikBch0pSeTYT1FgMvTZBOq_55rBrT2Q4-JTOFQ@mail.gmail.com>
References: <55D409F0.3050802@redhat.com>
	<1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
	<1960465945.40252217.1440000351155.JavaMail.zimbra@oxygem.tv>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12211@SACMBXIP01.sdcorp.global.sandisk.com>
	<87804130.40306063.1440003324534.JavaMail.zimbra@oxygem.tv>
	<3649A15A2562B54294DE14BCE5AC79120B593CE4@FMSMSX119.amr.corp.intel.com>
	<90559C83A9C7FA45B5846C975DFA612DDB5365392D@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33893 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbbHTHIu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Aug 2015 03:08:50 -0400
Received: by ykdt205 with SMTP id t205so29242955ykd.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2015 00:08:50 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB5365392D@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Alexandre DERUMIER <aderumier@odiso.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 20, 2015 at 2:35 PM, Da=C5=82ek, Piotr
<Piotr.Dalek@ts.fujitsu.com> wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Blinick, Stephen L
>> Sent: Wednesday, August 19, 2015 6:58 PM
>>
>> [..
>> Regarding the all-HDD or high density HDD nodes, is it certain these=
 issues
>> with tcmalloc don't apply, due to lower performance, or would it pot=
entially
>> be something that would manifest over a longer period of time
>> (weeks/months) of running?   I know we've seen some weirdness attrib=
uted
>> to tcmalloc on our 10-disk 20-node cluster with HDD's &  SSD journal=
s, but it
>> took a few weeks.
>
> And it takes me just a few minutes with rados bench to reproduce this=
 issue on mixed-storage node (SSDs, SAS disks, high-capacity SATA disks=
, etc).
> See here: http://ceph.predictor.org.pl/cpu_usage_over_time.xlsx
> It gets even worse when rebalancing starts...

Cool, it met my thought. I guess the only way to lighten memory
problem is solve this for each heavy memory allocation use case.

>
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
