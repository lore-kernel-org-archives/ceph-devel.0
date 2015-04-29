From: Wido den Hollander <wido@42on.com>
Subject: Re: Default config value for osd_disk_thread_ioprio_class
Date: Wed, 29 Apr 2015 20:55:30 +0200
Message-ID: <55412922.7020300@42on.com>
References: <5540CA47.8010201@pcextreme.nl> <5540CD3C.4080409@42on.com> <alpine.DEB.2.00.1504290949400.24030@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:43991 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbbD2Sze (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 14:55:34 -0400
In-Reply-To: <alpine.DEB.2.00.1504290949400.24030@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/29/2015 06:49 PM, Sage Weil wrote:
> On Wed, 29 Apr 2015, Wido den Hollander wrote:
>> On 04/29/2015 02:10 PM, Wido den Hollander wrote:
>>> Hi,
>>>
>>> In the process of upgrading a cluster from Giant to Hammer I saw this
>>> on the OSD logs:
>>>
>>> 2015-04-29 14:02:37.015454 7f887875e900 -1 osd.456 43089
>>> set_disk_tp_priority(22) Invalid argument:
>>> osd_disk_thread_ioprio_class is  but only the following values are
>>> allowed: idle, be or rt
>>>
>>> That is correct, since config_opts.h says:
>>>
>>> OPTION(osd_disk_thread_ioprio_class, OPT_STR, "") // rt realtime be
>>> best effort idle
>>>
>>> It's nothing bad, but it would be nicer if we got rid of it.
>>>
>>> What to do here? Allow "" as a config setting and then ignore it or
>>> set the default to rt, be or idle?
>>>
>>
>> I see there actually is a check for it:
>>
>>   if (cct->_conf->osd_disk_thread_ioprio_class.empty() ||
>>       cct->_conf->osd_disk_thread_ioprio_priority < 0)
>>     return;
>>
>> So empty() does not return True there while it should since the setting
>> is set to ""?
> 
> Hrm, "" should be empty()....
> 

So I thought and verified with a simple C++ test.

So this seems like a bug. I filed one: http://tracker.ceph.com/issues/11505

Wido

> s
> 
>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> -- 
>> Wido den Hollander
>> 42on B.V.
>> Ceph trainer and consultant
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
