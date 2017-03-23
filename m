From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Still denc warnings in Clang
Date: Thu, 23 Mar 2017 13:22:47 +0100
Message-ID: <dcf913de-b514-4654-945a-0b7716d7fd3c@digiware.nl>
References: <3793fc2c-b971-7440-6448-219500e6f2a5@digiware.nl>
 <alpine.DEB.2.11.1703231215590.30468@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:56943 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbdCWMXC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Mar 2017 08:23:02 -0400
In-Reply-To: <alpine.DEB.2.11.1703231215590.30468@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 23-3-2017 13:16, Sage Weil wrote:
> Oops, hasn't merged yet!
> 
> 	https://github.com/ceph/ceph/pull/13889
> 
> Needs to go through the QA suite still.

Right,

Haven't kept track of it, so expected it to be merged.
But it'll get here when it gets there. :)

--WjW

> sage
> 
> 
> On Thu, 23 Mar 2017, Willem Jan Withagen wrote:
> 
>> I thought that all these warnings were eradicated by now?
>>
>> --WjW
>>
>> /home/jenkins/workspace/ceph-master/src/include/denc.h:1162:10: warning:
>> binding dereferenced null pointer to reference has undefined behavior
>> [-Wnull-dereference]
>>     denc(*(bool *)nullptr, p);
>>          ^~~~~~~~~~~~~~~~
>> /home/jenkins/workspace/ceph-master/src/include/denc.h:1169:10: warning:
>> binding dereferenced null pointer to reference has undefined behavior
>> [-Wnull-dereference]
>>     denc(*(bool *)nullptr, p);
>>          ^~~~~~~~~~~~~~~~
>> /home/jenkins/workspace/ceph-master/src/include/denc.h:1236:10: warning:
>> binding dereferenced null pointer to reference has undefined behavior
>> [-Wnull-dereference]
>>     denc(*(bool *)nullptr, p);
>>          ^~~~~~~~~~~~~~~~
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

