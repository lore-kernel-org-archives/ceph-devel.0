From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: ceph/hadoop benchmarking
Date: Tue, 13 Dec 2011 08:30:34 -0800
Message-ID: <4EE77DAA.5070900@cs.ucsc.edu>
References: <193464577.4390.1319657347846.JavaMail.root@mail-01.cse.ucsc.edu> <Pine.LNX.4.64.1110261425320.18909@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:58530 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab1LMQaM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 11:30:12 -0500
In-Reply-To: <Pine.LNX.4.64.1110261425320.18909@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Comments below

On 10/26/11 2:34 PM, Sage Weil wrote:
> [adding ceph-devel CC]
>
> On Wed, 26 Oct 2011, Noah Watkins wrote:
>> ----- Original Message -----
>>> From: "Sage Weil"<sage@newdream.net>
>>>
>>>>
>>>> There was some packaging/cleanup work mentioned a while back on the
>>>> mailing list. Is anyone working on this?
>>>
>>> Nope.
>>>
>>> I'm not really sure what the "right' way to build/expose/package java
>>> bindings is.. but presumably it's less annoying than what we have now
>>> :)
>>
>> I'm revisiting this now to prepare packages and instructions for the
>> students running benchmarks this quarter, but I wanted to get your
>> input on future goals to not waste too much effort doing short-term
>> stuff. The possible approaches I see:
>>
>> 1) Everything (JNI wrappers + Java) lives in the Ceph tree and build
>>     instructions include applying a patch to Hadoop.
>>
>>     The current solution, and isn't too bad but needs documentation. This
>>     approach can be simplified to avoid patching Hadoop by integrating
>>     Ceph-specific Java code using the CLASSPATH global variable.
>>
>> 2) Everything is sent to Hadoop upstream.
>>
>>     This is convenient because the Hadoop infrastructure already has
>>     the facilities for building and linking native code into Hadoop,
>>     and the only depenendency then becomes a standard ceph-devel
>>     installation.
>>
>>     This was the approach taken with the kernel client version which
>>     also included JNI code (for ioctl).
>>
>> 3) Only JNI wrappers live in the Ceph tree and push Java patch upstream.
>>
>>     This could be better if it is anticipated that libceph will see a lot
>>     of churn in the future, and we'd avoid pushing more changes upstream.
>
> #3 strikes me as the right approach, since there are potentially other
> Java users of libcephfs, and the Hadoop CephFileSystem class will be best
> maintained (and most usable) if it upstream.  There will just be the
> initial pain of getting the packaging right for libcephfs so that it will
> work w/ hadoop out of the box.  (I'm assuming that is possible.. e.g.
> apt-get install ceph, fire up hadoop with the proper config?)

A couple comments about libceph-java: After looking through a bunch of 
Debian Java packages, it seems a common approach to packaging JNI/Java 
code is using the scheme:

   libcephfs-jni  --> .so
   libcephfs-java --> .jar

The debhelper tool and friends seem to do a good job of packaging up the 
Java in this way, but integrating this into Ceph's default Debian 
scripts means that anyone would now need a JDK to build Ceph with 
dpkg-buildpackages.

Is there a way to parametrize the Debian build process so people who 
don't care about Java bindings can proceed? An alternative approach is 
to say have another set of Debian build scripts in src/client/java/debian.

Thanks,
Noah

