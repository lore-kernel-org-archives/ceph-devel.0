From: Owen Synge <osynge@suse.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Mon, 30 May 2016 16:50:58 +0200
Message-ID: <574C5352.10107@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
 <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
 <570666AB.8090408@suse.com>
 <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
 <57067F56.2000705@suse.com>
 <alpine.DEB.2.11.1604071143000.19675@cpach.fuggernut.com>
 <57081B3A.20601@suse.com> <570BAC52.4070404@suse.com>
 <alpine.DEB.2.11.1605120905220.23446@cpach.fuggernut.com>
 <573F0A9F.6000704@suse.com> <57457CC7.1080809@suse.com>
 <alpine.DEB.2.11.1605250843590.4873@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51733 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbcE3OvJ (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 30 May 2016 10:51:09 -0400
In-Reply-To: <alpine.DEB.2.11.1605250843590.4873@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, adeza@redhat.com, cjones303@bloomberg.net
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

On 05/25/2016 02:45 PM, Sage Weil wrote:
> On Wed, 25 May 2016, Owen Synge wrote:
>> Great news ceph-deploy master now has the PR merged in so that
>> ceph-deploy can now work without any magic involved with ceph-create-keys.
>>
>> I will now make a patch to ceph proper to remove ceph-create-keys from
>> the init scripts. Hopefully this will move things forward and we can get
>> this patch merged relatively quickly.
>>
>> Please let me know if I am doing anything wrong.
> 
> Great!

I created a bug report against ceph:

    http://tracker.ceph.com/issues/16036

I have a patch now against ceph:

    https://github.com/ceph/ceph/pull/9345

But it seems to be failing on a test, I suspect the issue is in the test
suite as the failing command is:

    ceph osd setcrushmap -i /tmp/cephtool26589/map

Now the mon servers will not definitely have admin keyrings on them this
could cause the above command to fail.

Any help in the right direction appreciated.

> Alfredo, are there changes we need to ceph-ansible for this too?  Puppet?  
> Chef?
> 
> (This is post-jewel, so it can wait a bit if necessary.)

I hope we wont have to block merging this patch until they are all fixed
too?

Best regards

Owen
