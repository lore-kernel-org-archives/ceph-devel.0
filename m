From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: tcmalloc issue
Date: Wed, 1 Apr 2015 17:54:32 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1503261646150.31431@cobra.newdream.net>
 <551C1514.3060607@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0061.outbound.protection.outlook.com ([157.56.111.61]:53888
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752142AbbDARyl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 13:54:41 -0400
In-Reply-To: <551C1514.3060607@ubuntu.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>, Sage Weil <sage@newdream.net>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks James !

the tcmalloc bug is reported in the following link.

http://code.google.com/p/gperftools/issues/detail?id=585

So, do you want us to give the steps on how we are hitting the following trace or to reproduce the bug reported in the above link ?

If you are asking about hitting the stack trace I mentioned below, it is just running ceph with lot of IOs for longer period of time.

Let us know.

Regards
Somnath

-----Original Message-----
From: James Page [mailto:james.page@ubuntu.com]
Sent: Wednesday, April 01, 2015 8:56 AM
To: Sage Weil; ceph-maintainers@ceph.com
Cc: Somnath Roy; ceph-devel@vger.kernel.org
Subject: Re: tcmalloc issue

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I've logged:

https://bugs.launchpad.net/ubuntu/+source/google-perftools/+bug/1439277

The upstream fix applies cleanly to the version of gperftools in 14.04
- - I just need a good reproducer for the SRU test case.

If anyone has one, please detail in the bug report above - I'll also ping on the upstream bug (but that is from 2013 so might not get much luck).

On 26/03/15 23:47, Sage Weil wrote:
> Hi James,
>
> Is it possible to get tcmalloc in trusty updated?  See below.
>
> Thanks! sage
>
> On Thu, 26 Mar 2015, Somnath Roy wrote:
>
>> Sage, Here is the tcmalloc issue I was talking in the performance
>> meeting.
>>
>> http://code.google.com/p/gperftools/issues/detail?id=585
>>
>> The tcmalloc is consuming lot of cpus (and eventually slowing down
>> the performance) with the following perf top  trace.
>>
>> 25.73% libtcmalloc.so.4.1.2 [.]
>> tcmalloc::CentralFreeList::FetchFromSpans() 12.52%
>> libtcmalloc.so.4.1.2 [.]
>> tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::F
reeList*,
>> unsigned long, int) 11.62% libtcmalloc.so.4.1.2 [.]
>> tcmalloc::CentralFreeList::ReleaseToSpans(void*) 1.56% [kernel] [k]
>> __copy_user_nocache 1.44% libtcmalloc.so.4.1.2 [.]
>> tcmalloc::CentralFreeList::RemoveRange(void*, void*, int) 1.39%
>> libtcmalloc.so.4.1.2 [.]
>> tcmalloc::CentralFreeList::ReleaseListToSpans(void*) 0.89%
>> libtcmalloc.so.4.1.2 [.] operator new(unsigned long)
>>
>>
>> The TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is alleviating that but the
>> env variable setting for this is a noop in the binary we are having
>> in Ubuntu 14.04. It is fixed in gperftools-2.1.90 release. See the
>> following link.
>>
>> http://code.google.com/p/gperftools/
>>
>> We can request Ubuntu guys to incorporate this version or the latest
>> tcmalloc version which is gperftools-2.4.
>>
>> It will be really helpful if you can push them to incorporate this in
>> 14.04 updates.
>>
>> Thanks & Regards Somnath
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail
>> message is intended only for the use of the designated
>> recipient(s) named above. If the reader of this message is not the
>> intended recipient, you are hereby notified that you have received
>> this message in error and that any review, dissemination,
>> distribution, or copying of this message is strictly prohibited. If
>> you have received this communication in error, please notify the
>> sender by telephone or e-mail (as shown
>> above) immediately and destroy any and all copies of this message in
>> your possession (whether hard copies or electronically stored
>> copies).
>>
>> -- To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>


- --
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVHBUUAAoJEL/srsug59jDfPYP/2zE62fCmvp9o+x7CxtDsALv
JvlEAdtjR7F4epx/IWlrJcRW7Z8EMmXYu7Enlsc4koZhSoIgw92SzBilaSwt+d7V
3M0xhFImlvednXJn8ppSBxIf5qrc8r57jQhnLv1rnw4+JrP+U6C994jmZCERKiN+
Ph9+j+A7yBmIqinjdx9kbes29/wZuUgRCyF5c7Wm2xm4W3aN8ZthNKa7mbXvzO9Y
ZNtXGcKZdKMWHbZYAmU64Sj82YQOWAdG/3FXOf+FmFOXDQG380UKCmd2aDRcqyvd
ySBFrJVoZG2s9wr9lJBhnIebAs48WoRPXhsDXtknncw0L/ZkErF8c8HKUm4WIztM
0fO/Zhue09vLTgOuBOmxcW6g0TW0CFhFPWXdTrb/gRfns6mOcuu57CdsvTePTEvH
iYpWQQaccaqgO5Yt2Y7lNR7JwoEYBEX4CahaxO2XmN9wl9N/RJxMd4AhyxKCuimL
La9YLZszHf+8qGMUjzY3NE6bgXlqUzjuNCE7ROu5rlyobrd4iRi8r4jeuZ37bR+m
0h5SY9UyAISegSwCmtwr457FqeC+V52vlrkYZy06+yxaOaeXd3pP9GZ2o0CLhqcP
cOva6Nt8OIemdKa6H1xm/V7uLqkJXl1xx3zEcONpzijmUS+2L6v4L3yhZQewif3d
Ms0rECbXfF8tmuDxn8MB
=P322
-----END PGP SIGNATURE-----

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

