From: Owen Synge <osynge@suse.com>
Subject: Re: call for comments -> "ceph-disk" making OSD directories on typos
 and is inconsistent (useability).
Date: Fri, 01 Aug 2014 19:26:43 +0200
Message-ID: <53DBCDD3.6030608@suse.com>
References: <53DB539C.8090306@suse.com> <alpine.DEB.2.00.1408010808020.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:54486 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbaHAR1T (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 1 Aug 2014 13:27:19 -0400
In-Reply-To: <alpine.DEB.2.00.1408010808020.18917@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 08/01/2014 05:10 PM, Sage Weil wrote:
> On Fri, 1 Aug 2014, Owen Synge wrote:
>> Dear all,
>>
>> By default "ceph-disk" will do the following:
>>
>> # ceph-disk -vvvv prepare  --fs-type xfs --cluster ceph -- /dev/sdk
>> DEBUG:ceph-disk:Preparing osd data dir /dev/sdk
>>
>> No block device "/dev/sdk" exists so "ceph-disk" decides a block device
>> is not wanted and makes a directory for an OSD.
>>
>> I think as policy "ceph-disk" should not assume by default, that a non
>> existent target is correct, make a directory for the "disk" type OSD to
>> reside in, and set it up as a "disk" type OSD.
>>
>> Hence I proposed this patch:
>>
>> https://github.com/ceph/ceph/pull/2160
> 
> In a vacuum, this seems like the cleanest approach...

I agree, and think for major releases going forward this should be how
ceph-disk works.

For maintenance releases for firefly and before, should we follow Loic
Dachary's suggestion of only refusing to make a data dir if it starts
with "/dev"?

I am happy to write an additional patch to support this mode of
operation for maintenance releases, even though I think the idea of
making directory targets if the target does not exist is not a good idea
even for backward compatibility.

>> As a second best option I would be happier with an explicit "don?t fail
>> if target is not present and just make a directory at the target". But
>> then you get on to the question of deeper directory structures being
>> handled:
>>
>> The current behavior with deeper directory structures is currently
>> inconsistent as this output shows:
>>
>> # ceph-disk prepare --fs-type xfs --cluster ceph -- /mnt/vdu/vdu
>> Traceback (most recent call last):
>>   File "/usr/sbin/ceph-disk", line 2605, in <module>
>>     main()
>>   File "/usr/sbin/ceph-disk", line 2583, in main
>>     args.func(args)
>>   File "/usr/sbin/ceph-disk", line 1311, in main_prepare
>>     os.mkdir(args.data)
>> OSError: [Errno 2] No such file or directory: '/mnt/vdu/vdu'
>>
>> I think as a third best option would be to only make directories the
>> "--data-dir" parameter is used, but still suffers the deeper directory
>> structures question.
>>
>> I am still unsure if I like the idea of creating directories for deeper
>> directory structures, as again the potential for typos leading to vastly
>> different directory paths with a single misplaced character, and for
>> consistency would rather "ceph-disk" just failed if the target is not
>> available.
>>
>> Although I propose failing fast and clearly with a clear error message
>> when a target does not exist, removing the assumption that all non
>> existent targets are valid and "disk" based OSD's and to try and make an
>> "appropriate" directory, I do see 2 issues with this change:
>>
>> (A) This is a change to the current default behavior so effecting
>> deployment frameworks.
>> (B) This would effect "ceph-deploy" which under some circumstances uses
>> this behavior.
>>
>> I propose the following patch to mitigate side effect (B).
>>
>> https://github.com/ceph/ceph-deploy/pull/224
> 
> Is the problem that ceph-deploy will let you specify a directory /foo/bar 

Yes it will.

> and create bar for you?

No it wont, only ceph-disk does this.

If ceph-disk fails when the target directory /foo/bar is missing, then
ceph-deploy is not backwards compatible.

Since this is only desirable (if it is desirable to make a target
directory) then it is only desirable if the target is a target directory
and not a block device.

Since the original error prompting this discovery was a block device eg
"/dev/sdk" that was thought to exist but did not, I enclosed the rather
big assumption that ceph-deploy would assume all files under "/dev" are
block devices.

> Given that I don't think the directory use case is a common as the 
> device one, perhaps simply requiring that that directory already exist 
> (user can do mkdir -p $dir) will get us to the cleanest point.  I think 
> one of the more common use cases for this is when the user has their own 
> mount they want to set up, in which case it'll be an existing 
> directory (mount point).

I agree.

> The other main use case that comes to mind is the 'quickly deploy in a 
> bunch of dirs for testing', and in that case we can simply add mkdir to 
> the instructions...?

I agree.

Based on your assumptions:

https://github.com/ceph/ceph-deploy/pull/224

should be refused if:

https://github.com/ceph/ceph/pull/2160

is accepted.

Only if it is desired to keep the functionality of making directories
for backwards compatibility would you want to keep "224".

I am not in favor of making directory targets if the target does not
exist, but if this is desired functionality, accepting "224" is better
than the current situation for ceph-deploy users. After seeing Loic
Dachary's suggestion of "ceph-disk" only refusing to make a data dir if
it starts with "/dev" it seems a more universal solution than "224" but
does continue the assumption that you want to make directory targets if
the target does not exist.

Since I am not in favor of making directory targets if the target does
not exist, accepting "2160" and refusing "224" would be my preference
going forward.

Best regards

Owen




> 
>>
>> I see no way to resolve issue (A) in general if my proposal for change
>> is selected.
>>
>> I have discussed this issue with "alfredodeza" on IRC both privately and
>> later on the "ceph-devel" IRC channel and he is "really divided here"
>> hence we decided I would bring this up for discussion on this mailing list.
>>
>> Best regards
>>
>> Owen
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
