From: "peng.hse" <peng.hse@xtaotech.com>
Subject: Re: problems to protect rbd from mutiple simultaneous mapping
Date: Tue, 7 Mar 2017 10:16:11 +0800
Message-ID: <58BE17EB.1050105@xtaotech.com>
References: <58BD6D73.6040200@xtaotech.com>
 <CA+aFP1AO1DkYEVSfzHLk=dHSn8cSPE1c3+aWNAzQwwmsOuBsvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:61259 "EHLO
        mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755217AbdCGIwV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Mar 2017 03:52:21 -0500
In-Reply-To: <CA+aFP1AO1DkYEVSfzHLk=dHSn8cSPE1c3+aWNAzQwwmsOuBsvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

what i mean is : the step-1's IO from node1 was received by the OSDs 
before the blacklist barrier,
however, still under progress after the blacklist barrier, which might 
overwrite the data by node2 and
corrupt our data.
How do we avoid this situation?

On 2017年03月07日 07:47, Jason Dillaman wrote:
> On Mon, Mar 6, 2017 at 9:08 AM, peng.hse <peng.hse@xtaotech.com> wrote:
>> 3. assuming the step-1 outstanding IO and step-2 IO targeted the same area
>> of the fs metadata
>>      on the rbd devices. step-2 successfully persist the data and reply to
>> client.
>>      then, the following laggy IO from step-1 might override and corrupt what
>> we have written in step-2.
>>
>> so, how do we prevent this kind of corruption happening?
> ... but in step (2) you successfully blacklisted the client on node1
> (i.e. it is not allowed to talk to the OSDs). Therefore, node1 cannot
> overwrite any data written by node2.
>

