From: Mark Nelson <mnelson@redhat.com>
Subject: Re: cmake
Date: Tue, 28 Jun 2016 16:43:57 -0500
Message-ID: <4c5c008f-ad0a-bcb5-7faa-d9971d42ba61@redhat.com>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
 <29a3fbd4-8659-1391-79ce-98a37e5b84c8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45891 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbcF1Vop (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 17:44:45 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8533385542
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 21:44:00 +0000 (UTC)
In-Reply-To: <29a3fbd4-8659-1391-79ce-98a37e5b84c8@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 06/28/2016 03:28 PM, Casey Bodley wrote:
>
> On 06/27/2016 01:50 PM, Sage Weil wrote:
>> We are switching from autotools to cmake on the master branch. Any
>> builds done post-jewel will be cmake and not autotools based.  Jewel and
>> older releases will still be built with autotools the old way.
>>
>> The README.md in the master branch has been updated with new developer
>> build instructions.  Please take a look:
>>
>>     https://github.com/ceph/ceph/blob/master/README.md
>>
>> If you are doing development, please switch to using cmake (i.e.,
>> run do_cmake.sh) now.  Running vstart.sh is a little different and it
>> takes some getting used to.
>>
>> If there is anything that doesn't work that is part of your developer
>> workflow, we need to fix it now, before the autotools support is removed
>> and you're unable to work!  This is hopefully a week or two away.
>>
>> Current status:
>>
>>   - gitbuilders mostly using make-dist instead of 'make dist'
>>     (autotools) to generate release tarballs
>>   - wip-cmake-debian building debs with cmake
>>   - rpm coming shortly
>>   - release build tool update last, followed by a 11.0.0 release.
>>
>> Thank you!
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> To those trying CMake, please note that autoconf generates a
> ceph/src/acconfig.h. You'll want to remove that header, or cmake builds
> will pull it in and get confused.
>
> Build failures in rocksdb are also common for those switching. This
> seems to fix those issues: cd ceph/src/rocksdb; make clean

FWIW, this is a gotcha that folks using automake run into when the 
rocksdb submodule updates.  make clean; make top level doesn't fix it, 
you have to explicitly run make clean in the rocksdb directory.

>
> Casey
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
