From: Wido den Hollander <wido@widodh.nl>
Subject: Re: higher level library for storing large(r) RADOS objects
Date: Thu, 03 May 2012 17:19:40 +0200
Message-ID: <4FA2A20C.2020505@widodh.nl>
References: <4FA2208E.5010208@widodh.nl> <CAC-hyiHftFs7CPnTkFpfR--W+TEAS2GHZss5T2u9CKvy2wPdmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:33351 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab2ECPTt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 May 2012 11:19:49 -0400
In-Reply-To: <CAC-hyiHftFs7CPnTkFpfR--W+TEAS2GHZss5T2u9CKvy2wPdmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On 03-05-12 08:21, Yehuda Sadeh Weinraub wrote:
> On Wed, May 2, 2012 at 11:07 PM, Wido den Hollander<wido@widodh.nl>  wrote:
>> Hi,
>>
>> I've been talking to Josh today and we've been talking a bit about storing
>> large objects in RADOS.
>>
>> One of the problem I currently see with using RADOS is storing really large
>> objects.
>>
>> RADOS objects are stored on the OSD as a whole file, so potentially a single
>> RADOS object could press an OSD over the full_ratio and stalling the whole
>> cluster.
>>
>> This also shows another problem. It this object is heavily used a couple of
>> OSDs will be very busy with the I/O's for this object.
>>
>> So I was thinking about an library on top of RADOS which is kind of similar
>> to RBD, but it's only focused on storing objects.
>>
>> The first object in a pool could have a couple of xattrs:
>>
>> object1
>> - stripe_size: 4096
>> - size: 40960
>>
>> Based on the xattr operation we know where to read or write when asked for a
>> specific offset and length.
>>
>> object1, object1_1, object1_2, until object1_9
>>
>> Potentially this could also be used for the RADOS Gateway? Since that will
>> suffer from the same problem when you want to scale out.
>>
>> With the RAODS Gateway you can't control a user storing a 200G tar file with
>> his backups in it, you never know.
>>
>> It's just a thought but I just wanted to get it out there and check out the
>> opinions.
>>
>> Comments? Suggestions?
>>
>
> Actually, nowadays RGW keeps a map ("manifest") in each object which
> points to where all the parts of that object actually reside. For
> multipart uploads we don't merge the parts, but rather create a
> manifest that points at them. For regular uploads (up to 5GB) we keep
> the first 512K on the head object (where the map resides), and the
> rest is in another rados object. In theory objects can be striped
> using this or similar infrastructure. We don't impose a constant
> stripe size, but the manifest can be extended to handle such cases.
> What I'd really like to see is a rgw library that provides an object
> access api and will access the backend directly. This will be used for
> rgw itself, help clean up its internal structure, and will be useful
> for other applications that don't need to go through the gateway
> itself (but do need the same object access semantics).

That is something I thought about as well. If we could move most of the 
RGW's functionality into librgw we could in theory re-write the RGW in 
Python where you could use bindings for librgw to access the RADOS data.

librgw could then also just store larger objects like I thought about. 
If it's kept clean it could serve just that purpose.

Rewriting the RGW in Python might be just one step to far, I know a lot 
of work has gone into it. However, with Python it could easily run 
stand-alone and you could have just a proxy like nginx, Varnish or even 
Apache in front of it, you could loose the whole FastCGI/fcgi stuff.

Wido

>
> Yehuda
