From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: problems to protect rbd from mutiple simultaneous mapping
Date: Mon, 6 Mar 2017 21:26:12 -0500
Message-ID: <CA+aFP1BfJCT-HNcm8CXHc62CHF_cji19k0p7ZafKUzw3yW+Rhw@mail.gmail.com>
References: <58BD6D73.6040200@xtaotech.com> <CA+aFP1AO1DkYEVSfzHLk=dHSn8cSPE1c3+aWNAzQwwmsOuBsvA@mail.gmail.com>
 <58BE17EB.1050105@xtaotech.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33245 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbdCGCfw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 21:35:52 -0500
Received: by mail-lf0-f46.google.com with SMTP id a6so80837721lfa.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 18:35:07 -0800 (PST)
In-Reply-To: <58BE17EB.1050105@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "peng.hse" <peng.hse@xtaotech.com>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Each object is "owned" by a PG and each PG operates on each object
in-order within a transaction. Therefore, if the OSDs had received a
write op from node1 before the blacklist from node2, by definition
they would be completed before node2's write ops for the same object
could be started. If it's the reverse scenario, where the write op
from node1 was in-flight on the network and somehow arrived after
node2's blacklist and write op, I would hope and expect that the OSD
properly handled the blacklist and dropped the op.

On Mon, Mar 6, 2017 at 9:16 PM, peng.hse <peng.hse@xtaotech.com> wrote:
> what i mean is : the step-1's IO from node1 was received by the OSDs before
> the blacklist barrier,
> however, still under progress after the blacklist barrier, which might
> overwrite the data by node2 and
> corrupt our data.
> How do we avoid this situation?
>
>
> On 2017年03月07日 07:47, Jason Dillaman wrote:
>>
>> On Mon, Mar 6, 2017 at 9:08 AM, peng.hse <peng.hse@xtaotech.com> wrote:
>>>
>>> 3. assuming the step-1 outstanding IO and step-2 IO targeted the same
>>> area
>>> of the fs metadata
>>>      on the rbd devices. step-2 successfully persist the data and reply
>>> to
>>> client.
>>>      then, the following laggy IO from step-1 might override and corrupt
>>> what
>>> we have written in step-2.
>>>
>>> so, how do we prevent this kind of corruption happening?
>>
>> ... but in step (2) you successfully blacklisted the client on node1
>> (i.e. it is not allowed to talk to the OSDs). Therefore, node1 cannot
>> overwrite any data written by node2.
>>
>



-- 
Jason
