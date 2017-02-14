From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD has the store locked???
Date: Tue, 14 Feb 2017 16:55:57 +0100
Message-ID: <7c322e3d-1c6b-7369-d196-52106dd114e6@digiware.nl>
References: <557f1d59-33c5-3da3-926e-f87160da272b@digiware.nl>
 <598746059.1724.1487085785680.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:37639 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbdBNP4B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 14 Feb 2017 10:56:01 -0500
In-Reply-To: <598746059.1724.1487085785680.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "wido@42on.com" <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 14-2-2017 16:23, wido@42on.com wrote:
> 
> 
>> Op 14 feb. 2017 om 14:57 heeft Willem Jan Withagen <wjw@digiware.nl> het volgende geschreven:
>>
>> Hi,
>>
>> Running ceph_objectstore_tool.py just about all command get the
>> complaint that "OSD has the store locked".
>>
> 
> Is the OSD still running? If so, stop it first.
> 
> Wido
> 
>> Like:
>> Test --op list variants
>> OSD has the store locked
>> ERROR:Bad exit status 1 from
>> /home/jenkins/workspace/ceph-master/build/bin/ceph-objectstore-tool
>> --data-path /home/jenkins/workspace/ceph-master/build/cot_dir/dev/osd0
>> --op list --format json
>>
>> Why would I get "the store locked"??

Hi Wido,

A usual I have to apologize for not supplying all the details.

This is from my FreeBSD ceph-master jenkins testbot, that runs into this
problem over, over and over.
The tests are serialized, so I'd expect to have no OSDs leftover before
a new test is running.

ATM there are no OSDs running.

Who is generating this error:
	ceph_objectstore_tool itself
or	the OSD via one of the com-channels

--WjW


