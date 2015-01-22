From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [PATCH] Rbd: add listwatchers command
Date: Thu, 22 Jan 2015 12:55:20 +0800
Message-ID: <54C082B8.2010807@ubuntukylin.com>
References: <cover.1421849230.git.liwang@ubuntukylin.com> <alpine.DEB.2.00.1501210856200.3895@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:53444 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbAVFF3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 00:05:29 -0500
In-Reply-To: <alpine.DEB.2.00.1501210856200.3895@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

My thoughts, 'rbd info' is intended to describe
the STATIC, intrinsic properties of an image, while
the watchers information are dynamic, something like
'rbd showmapped', what is your opinion?

Cheers,
Li Wang

On 2015/1/22 9:35, Sage Weil wrote:
> On Wed, 21 Jan 2015, Li Wang wrote:
>> Currently, RBD does not provide an easy way to
>> consult who opened a specied image, this complicates
>> the cloud maintenance, sometimes the administrator
>> found that a RBD image could not be deleted with
>> an error 'image has watchers', but no further
>> information available. The RADOS has a command to
>> show the watchers of an object, but the commands
>> at RADOS level are not supposed to be exposed to a
>> cloud administrator, and it is not clear for a
>> non-expert administrator to how to associate an
>> opened RBD with a corresponding watched object.
>> This motivates us to add an RBD command to list the
>> information of the clients who opened a RBD image to
>> facilitate the cloud maintenance.
>
> Perhaps this should just be rolled into the existing 'rbd info' command.
> More people will see it and there's no additional cost over what info is
> already doing...
>
> sage
>
>
>
>
>
>>
>> The patches are at:
>> https://github.com/ceph/ceph/pull/3435
>>
>> Yunchuan Wen (3):
>>    rbd: add listwatchers command to list the watchers of an image
>>    test: add rbd listwatchers to src/test/cli/rbd/help.t
>>    man: add rbd listwatchers to doc/man/8/rbd.rst
>>
>>   doc/man/8/rbd.rst       |  3 +++
>>   src/rbd.cc              | 63 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   src/test/cli/rbd/help.t |  1 +
>>   3 files changed, 65 insertions(+), 2 deletions(-)
>>
>> --
>> 1.9.1
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
