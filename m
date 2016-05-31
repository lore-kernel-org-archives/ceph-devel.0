From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Sizes of attributes and attributenames....
Date: Tue, 31 May 2016 15:15:39 +0200
Message-ID: <b1234938-8f3c-5c28-7a04-7a3cd00438a3@digiware.nl>
References: <eeeec6f0-3aff-e1e1-8e85-5e7922fa2e15@digiware.nl>
 <alpine.DEB.2.11.1605310854550.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:34078 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbcEaNZt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 09:25:49 -0400
In-Reply-To: <alpine.DEB.2.11.1605310854550.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ldachary@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 31-5-2016 14:55, Sage Weil wrote:
> On Tue, 31 May 2016, Willem Jan Withagen wrote:
>>
>> Hi,
>>
>> I'm getting bitten in tests/ceph-disk.sh by.
>>
>>  2 osd.0 0 boot
>> -1 osd.0 0 backend (filestore) is unable to support max object
>> name[space] len
>> -1 osd.0 0    osd max object name len = 2048
>> -1 osd.0 0    osd max object namespace len = 256
>> -1 osd.0 0 (63) File name too long
>>  1 journal close test-ceph-disk/dir/journal
>> -1  ** ERROR: osd init failed: (63) File name too long	
>>
>> And it seems that I did have this fixed in one run or another, but now
>> it raises it scary head again.
>> Now I think it is posible to fix this by starting vstart -short, but
>> that does not cut it with other tests, so it seems.
> 
> I think we either need to do --short unconditionally for the make check 
> vstart tests, or have an environment variable that does it conditionally.  
> I'm inclined to do it unconditionally...  Loic, does that seem 
> reasonable?  That way make check can work reliably on ext4.

I've now "fixed" it, rather bluntly, in:
common/config_opts.h, like:

#if defined(__FreeBSD__)
// Assuming ZFS
OPTION(filestore_max_inline_xattr_size_other, OPT_U32, 2048)
#else
OPTION(filestore_max_inline_xattr_size_other, OPT_U32, 512)
#endif

While that works for my porting and testing, I would definitely not
consider that a permanent band-aid.

If this would be the way to go, then it is perhaps smart to also add
some filestore_*_zfs options, and work from there.
Even if it is only for the time being, it is for me a workable option.

But as far as I can tell you are aiming for the names of attributes to
be max 2048? and filenames 256? is it that simple?

Thinking about this leads me to a more roadmap type question:
Now the future problem occurs if people are going to connect OSDs to the
cluster that are of different origine. Like we now have a few nodes running:
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04.4 LTS"
running on btrfs (that is the way things started here, me being a ZFS fan)

How would they interact with systems running XFS, BlueStore or
FreeBSD/ZFS.?
Either there is a least common denominator, thus reducing everything to
the worst available length.
Or there is a "serious" conversion glue layer
Or it is not really wanted/supported/allowed in all mixes and combinations.

Just curious....

--WjW


