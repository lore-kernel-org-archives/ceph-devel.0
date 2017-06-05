From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Errocodes over the line....
Date: Mon, 5 Jun 2017 09:09:06 +0200
Message-ID: <de489da4-28f7-a62d-385b-de5aa5ddf95a@digiware.nl>
References: <fd007197-fa5f-a036-e1ae-ee0097320510@withagen.nl>
 <alpine.DEB.2.11.1705300128170.3646@piezo.novalocal>
 <dbf4fcb0-6077-5f35-9300-59bb841f2a74@digiware.nl>
 <alpine.DEB.2.11.1706050123390.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:23728 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdFEHJG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 03:09:06 -0400
In-Reply-To: <alpine.DEB.2.11.1706050123390.3646@piezo.novalocal>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/06/2017 03:25, Sage Weil wrote:
> On Sun, 4 Jun 2017, Willem Jan Withagen wrote:
>> On 30/05/2017 03:30, Sage Weil wrote:
>>> It does.  There is a helper somewhere that maps error codes in MOSDOpReply 
>>> that go over the wire that was added for an AIX port a year or two ago.  
>>> look for errorcode32_t and ceph_to_host_errno etc
>>
>> 'mmm
>>
>> It looks like it is the other way around as what I'm looking for...
>> These are the linux errno's translated to AIX/Darwin codes. So the
>> native OS does not get upset when playing client. These .cc files are
>> not even compiled in the standard ceph tree, as far as I can see.
>>
>> So I guess what I'm looking for is to issue the correct errorcodes on
>> the line when also acting as server. And as far as I can imagine will
>> need both: ceph_to_host_errno() and host_to_ceph_errno() and start
>> glueing that in.
>> Now the question is: I that restricted to one location to insert as
>> well, or go I need to go chasing all places where the errcode is de/encoded.
> 
> 1. Write the ceph_to_host_errno and host_to_ceph_errno methods
> 2. Fix the errorcode32_t to use them for encode *and* decode.
> 3. Identify the handful of places where we send errcodes over the wire 
> (mostly MOSDOpReply and friends) and switch the type to errorcode32_t so 
> that it is translated during encode/decode.
> 
> Happy to help with 2 and 3 once we have 1 in place!

Great,

Started working on 1, only to realise how disjunct they are.
I guess 3 will be the hardest not to miss any spots.

As our Austrian-American friend says: I'll be back.

--WjW

>>> On Mon, 29 May 2017, Willem Jan Withagen wrote:
>>>
>>>> Hi Sage
>>>>
>>>> I came accros the following, dataing september 2011, writen by you:
>>>> ====
>>>> These error codes pass over the wire, so we should make sure the actual
>>>> values are consistent across the platforms, so a FreeBSD client can talk
>>>> to a Linux server, or vice-versa.
>>>>
>>>> I'm not sure if that's the case for other error codes...?
>>>> ====
>>>>
>>>> Now the trick question is: Does ENODATA travel over the wire?
>>>>
>>>> Because the way I designed it now
>>>> 	ENOATTR on FreeBSD is 87
>>>> 	ENODATA on Linux is 61
>>>>
>>>> So that is not going to match, if it is communicated.
>>>>
>>>> --WjW
>>>>
>>>>
>>
>>

