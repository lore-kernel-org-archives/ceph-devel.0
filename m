From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Accessing file layout information
Date: Mon, 15 Dec 2014 13:10:40 -0800
Message-ID: <CAC6JEv9qTO6_aiYjj-JqJvExjH3dM4Ha39AiJNxk9zVMFCxNHQ@mail.gmail.com>
References: <A22702E7-D4A3-43D0-AB43-ADF64A2AADDA@ornl.gov>
	<CAC6JEv934fo6uR+vL05RDLtkS3-TNb9F8J_hDshgKeU593ivKA@mail.gmail.com>
	<65EB70CE-E2FD-4A38-A137-497C2CD0F124@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:44552 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaLOVKm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 16:10:42 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so5756423igi.6
        for <ceph-devel@vger.kernel.org>; Mon, 15 Dec 2014 13:10:41 -0800 (PST)
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com. [209.85.223.181])
        by mx.google.com with ESMTPSA id bd5sm5417660igb.14.2014.12.15.13.10.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 13:10:40 -0800 (PST)
Received: by mail-ie0-f181.google.com with SMTP id tp5so11572689ieb.12
        for <ceph-devel@vger.kernel.org>; Mon, 15 Dec 2014 13:10:40 -0800 (PST)
In-Reply-To: <65EB70CE-E2FD-4A38-A137-497C2CD0F124@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: ceph-devel Development <ceph-devel@vger.kernel.org>

On Mon, Dec 15, 2014 at 12:06 PM, Atchley, Scott <atchleyes@ornl.gov> wrote:
> On Dec 15, 2014, at 2:42 PM, Gregory Farnum <greg@gregs42.com> wrote:
>
>> On Mon, Dec 15, 2014 at 10:54 AM, Atchley, Scott <atchleyes@ornl.gov> wrote:
>>> Hi all,
>>>
>>> For a given file in cephfs, I would like to determine:
>>>
>>> 1) the number of PGs
>>> 2) the PG IDs
>>> 3) the offsets handles by each PG
>>> 4) the stripe unit (i.e. bytes per block of data)
>>>
>>> preferably using a C API.
>>>
>>> I found the getfattr command line tool which provides (1) and (4).
>>>
>>> It appears that cephfs command line tool provides some of the info, but the manpage is not clear as to what is provided by show_layout versus show_location. Does show_layout provide (1) and (4)? Does show_location include (2) and (3)?
>>>
>>> I found a Java CephFileExtent() that provides (1) and a list of OSDs for the stripe unit that contains the provided file extent.
>>
>> What exactly are you trying to accomplish here? I can imagine some
>> limited scenarios where you want to map to PGs, but in general you're
>> a lot more interested in either the objects associated with the file,
>> or the OSDs that host them. I think you can get objects and OSDs out
>> of the latest libcephfs api.
>
> We implemented a file transfer tool for Lustre that transfers data by object rather than by file. The scheduling of the object transfers is done in a way to defer transfers from congested servers in hopes that they will be less congested in the near future (given our bulk-synchronous workload, congestion of a set of servers is generally temporary).
>
> I would rather know OSDs versus PGs, but I did not assume that the info was available.

Yeah, look at ceph_get_file_extent_osds in libcephfs. :)

>
>>> On the architecture page (http://ceph.com/docs/next/architecture/) under DATA STRIPING, does cephfs client use the same set of PGs used for Object Set 1 for Object Set 2 or does it use a different PGs?
>>
>> Assuming you mean does it use the same PGs for each file's objects,
>> the answer is no, definitely not.
>> -Greg
>
> No, I assume the Object Set 1 on that page indicates four objects on four different PGs. Within Object Set 1, Object 0 holds stripe units 0, 4, 8, and 12. Object 1 holds stripe units 1, 5, 9, and 13 and so on. Each Object 0-3 are stored on different PGs. Is this correct so far?
>
> My question above is about Object Set 2, which holds Objects 4-7? Is Object 4 on the same PG as Object 0? Is Object 5 on the same PG as Object 1? Etc? Or does Object Set 2 (holding Objects 4-7) use different PGs?

The sets use completely different names which are (generally) going to
be placed completely differently. They're just <inode number>.<object
number>, where the inode number is in hex and the object number is
zero-padded up to some size.
-Greg
