From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Breakage in Clang compile....
Date: Thu, 9 Feb 2017 19:10:07 +0100
Message-ID: <28691041-11fc-bd69-2d0b-1986fa798aca@digiware.nl>
References: <a5a35bfc-57b2-bf28-9788-04127654e23a@digiware.nl>
 <E5D4D9AF-0529-424A-9C75-759906A4C65D@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:45756 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbdBISKe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 13:10:34 -0500
In-Reply-To: <E5D4D9AF-0529-424A-9C75-759906A4C65D@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <Bassam.Tabbara@quantum.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 9-2-2017 17:18, Bassam Tabbara wrote:
> Hi,
> 
> I’m curious are there specific advantages to compiling Ceph with
> clang vs. gcc? I understand that clang uses less memory, compiles
> faster, and has better errors/diagnostics, but as it relates to Ceph
> is there any specific advantages?
> 
> Is there a plan to switching to clang?

There are a few reasons for also using Clang:
 - Clang finds other types of issues in the code.
	I think the speed, mem-footprint advantages you mention are not
	(yet) the case.
 - FreeBSD has Clang as native compiler, and I'm preparing a Ceph port
   to FreeBSD.

Thanx for fixing this, I saw the PR fly by.

--WjW

> Thanks! Bassam
> 
>> On Feb 9, 2017, at 7:35 AM, Willem Jan Withagen <wjw@digiware.nl>
>> wrote:
>> 
>> Hi,
>> 
>> I think this is a recent addition to the game? And Clang does not
>> really like it.
>> 
>> In file included from 
>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:21: 
>> /home/jenkins/workspace/ceph-master/src/common/perf_histogram.h:80:9:
>>
>> 
error: array initializer must be an initializer list
>> : m_axes_config(other.m_axes_config) { ^ 
>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:98:29:
>>
>> 
note: in instantiation of member function
>> 'PerfHistogram<2>::PerfHistogram' requested here 
>> histogram.reset(new PerfHistogram<>(*other.histogram)); ^ 1 error
>> generated.
>> 
>> --WjW -- To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body of a message to majordomo@vger.kernel.org 
>> More majordomo info at
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwICaQ&c=8S5idjlO_n28Ko3lg6lskTMwneSC-WqZ5EBTEEvDlkg&r=BTMd2ANcDl5P_nTkEam5zzywWdGjHoaoXy4JMG_yHPA&m=PzCl2U7BH52mycDw3PiC7LaCbGCCTewMNBUqu8gGKIQ&s=gR4xXKHg4AFcwEccrIs-KoM7bjGw0aL9CnVF_PQE_fo&e=
>> 
> 

