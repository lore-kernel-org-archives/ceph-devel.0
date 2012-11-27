From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Hadoop and Ceph client/mds view of modification time
Date: Tue, 27 Nov 2012 13:05:45 -0600
Message-ID: <50B50F09.1000302@inktank.com>
References: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com> <50B4EE31.5020908@inktank.com> <alpine.DEB.2.00.1211270857370.30109@cobra.newdream.net> <D8FEE2D6-D5EF-41AB-83E6-11518DBB6B38@inktank.com> <alpine.DEB.2.00.1211271000040.32061@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38821 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab2K0TFt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 14:05:49 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so9214201iay.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 11:05:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211271000040.32061@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: David Zafman <david.zafman@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

On 11/27/2012 12:01 PM, Sage Weil wrote:
> On Tue, 27 Nov 2012, David Zafman wrote:
>>
>> On Nov 27, 2012, at 9:03 AM, Sage Weil <sage@inktank.com> wrote:
>>
>>> On Tue, 27 Nov 2012, Sam Lang wrote:
>>>
>>>> 3. When a client acquires the cap for a file, have the mds provide its current
>>>> time as well.  As the client updates the mtime, it uses the timestamp provided
>>>> by the mds and the time since the cap was acquired.
>>>> Except for the skew caused by the message latency, this approach allows the
>>>> mtime to be based off the mds time, so it will be consistent across clients
>>>> and the mds.  It does however, allow a client to set an mtime to the future
>>>> (based off of its local time), which might be undesirable, but that is more
>>>> like how  NFS behaves.  Message latency probably won't be much of an issue
>>>> either, as the granularity of mtime is a second. Also, the client can set its
>>>> cap acquired timestamp to the time at which the cap was requested, ensuring
>>>> that the relative increment includes the round trip latency so that the mtime
>>>> will always be set further ahead. Of course, this approach would be a lot more
>>>> intrusive to implement. :-)
>>>
>>> Yeah, I'm less excited about this one.
>>>
>>> I think that giving consistent behavior from a single client despite clock
>>> skew is a good goal.  That will make things like pjd's test behave
>>> consistently, for example.
>>>
>>
>> My suggestion is that a client writing to a file will try to use it's
>> local clock unless it would cause the mtime to go backward.  In that
>> case it will simply perform the minimum mtime advance possible (1
>> second?).  This handles the case in which one client created a file
>> using his clock (per previous suggested change), then another client
>> writes with a clock that is behind.

We can choose to not decrement at the client, but because mtime is a 
time_t (seconds since epoch), we can't increment by 1 for each write. 
1000 writes each taking 0.01s would move the mtime 990 seconds into the 
future.

>
> That's a possibility (if it's 1ms or 1ns, at least :). We need to verify
> what POSIX says about that, though: if you utimes(2) an mtime into the
> future, what happens on write(2)?

According to http://pubs.opengroup.org/onlinepubs/009695399/, writes 
only require an update to mtime, it doesn't specify what the update 
should be:

"Upon successful completion, where nbyte is greater than 0, write() 
shall mark for update the st_ctime and st_mtime fields of the file, and 
if the file is a regular file, the S_ISUID and S_ISGID bits of the file 
mode may be cleared."

In NFS, the server sets the mtime.  Its relatively common to see 
"Warning: file 'foo' has modification time in the future" if you're 
compiling on nfs and your client and nfs server clocks are skewed.  So 
allowing the mtime to be set in the near future would at least follow 
the principle of least surprise for most folks.

-sam

>
> sage
>

