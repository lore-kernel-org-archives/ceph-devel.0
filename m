From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: New messages in OSD logs.
Date: Fri, 22 Apr 2016 14:55:03 +0200
Message-ID: <0db9f84b-b39f-ee31-82b8-e8cbecbfb953@digiware.nl>
References: <57121CDE.3010908@digiware.nl>
 <CAJ4mKGaq0-=mBCrNNDZoFwhM9zs_40KJJSkiHyj0apkH6W21hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:22141 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbcDVMzj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Apr 2016 08:55:39 -0400
In-Reply-To: <CAJ4mKGaq0-=mBCrNNDZoFwhM9zs_40KJJSkiHyj0apkH6W21hA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 18-4-2016 20:52, Gregory Farnum wrote:
> On Sat, Apr 16, 2016 at 4:07 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi
>>
>> I've recently rebased my fork, and also upgrae FreeBSD to more recent code.
>> Now I'm running into this:
>>
>> 2016-04-16 03:03:55.891466 805617000 -1
>> filestore(testdir/test-erasure-eio/0) WARNING: max attr value size (1024)
>> is smaller than osd_max_object_name_len (2048). Your backend filesystem
>> appears to not support attrs large enough
>> to handle the configured max rados name size. You may get unexpected
>> ENAMETOOLONG errors on rados operations or buggy behavior
>>
>> and later on:
>>
>> 2016-04-16 03:04:03.287073 805617000  2 osd.0 0 boot
>> 2016-04-16 03:04:03.287846 805617000 -1 osd.0 0 backend (filestore) is
>> unable to support max object name[space] le
>> n
>> 2016-04-16 03:04:03.287873 805617000 -1 osd.0 0    osd max object name len =
>> 2048
>> 2016-04-16 03:04:03.287894 805617000 -1 osd.0 0    osd max object namespace
>> len = 256
>> 2016-04-16 03:04:03.287931 805617000 -1 osd.0 0 (63) File name too long
>> 2016-04-16 03:04:03.303432 805617000  1 journal close
>> testdir/test-erasure-eio/0/journal
>> 2016-04-16 03:04:03.310280 805617000 -1 ^[[0;31m ** ERROR: osd init failed:
>> (63) File name too long^[[0m
>>
>> And the OSD dies....
>>
>> I guess that this has the do with the changes in the LFN modules, and is
>> also the reason for the debate about ext4 support.
>>
>> Uptill now unittest_chain_xattr did work, but that now also fails.
>> But it fails in a strange way where it tries to delete attributes with
>> numerical ends that are certainly not in the attributes.
>> Maximum xattr name length in FreeBSD seems to be 256 chars, which wasn't a
>> problem yet.
>>
>> So is there any chance of continuing on my "old" way to finish a first
>> version of the port?
>>
>> Or am I just seeing things, and should I start looking at the FreeBSD side
>> of things?
> 
> I didn't do this work, but I think you should be able to set
> osd_max_object_name_len and get things going. (I'm less sure about the
> unit test.)

Hi,

Wierd things are happening here as far as I can tell....

linux/limits.h defines:
#define XATTR_NAME_MAX   255 /* # chars in an extended attribute name */
#define XATTR_SIZE_MAX 65536 /* size of an extended attribute value (64k) */
#define XATTR_LIST_MAX 65536 /* size of extended attribute namelist (64k) */

Which is exactly the same as is on FreeBSD:
max namesize is 255 chars, content of attributes max 64K

Even wrote some perl to actually test this. And it is true.

So I'm not really understanding why the OSDs are complaining and dying
on the basis of this. Linux OSDs should have the same problem... :(

--WjW




