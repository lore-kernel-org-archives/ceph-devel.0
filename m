From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Infiniband 40GB
Date: Wed, 06 Jun 2012 13:02:31 +0200
Message-ID: <4FCF38C7.8000802@profihost.ag>
References: <4FCB1C0A.4050504@profihost.ag> <201206041147.22993.a.ott@m-privacy.de> <4FCF358C.6080301@profihost.ag> <201206061257.34525.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45415 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab2FFLCe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 07:02:34 -0400
In-Reply-To: <201206061257.34525.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

Am 06.06.2012 12:57, schrieb Amon Ott:
> On Wednesday 06 June 2012 wrote Stefan Priebe - Profihost AG:
>> Hi Amon,
>>
>> i've added your patch:
>> # strings /lib/libc-2.11.3.so |grep -i syncfs
>> syncfs
>>
>> But configure of ceph still claims there is no syncfs support.
>>
>> # ./configure |grep -i sync
>> checking for syncfs... no
>> checking for sync_file_range... yes
>>
>> Any ideas?
>
> Did you also install the new libc6-dev, which contains the new header files?

Yes.

/usr/include/unistd.h:
extern int syncfs (int __fd) __THROW;

/usr/include/gnu/stubs-64.h:
#define __stub_syncfs

Stefan
