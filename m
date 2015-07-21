From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: upstream/firefly exporting the same snap 2 times results in different
 exports
Date: Tue, 21 Jul 2015 21:48:01 +0200
Message-ID: <55AEA1F1.8030400@profihost.ag>
References: <55AE3B3A.2040902@profihost.ag> <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com> <55AE798F.1010206@profihost.ag> <1828157940.1473499.1437499191528.JavaMail.zimbra@redhat.com> <55AE9BD9.6010801@profihost.ag> <55AEA17A.8040901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:49027 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbbGUTsC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 15:48:02 -0400
In-Reply-To: <55AEA17A.8040901@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org


Am 21.07.2015 um 21:46 schrieb Josh Durgin:
> On 07/21/2015 12:22 PM, Stefan Priebe wrote:
>>
>> Am 21.07.2015 um 19:19 schrieb Jason Dillaman:
>>> Does this still occur if you export the images to the console (i.e.
>>> "rbd export cephstor/disk-116@snap - > dump_file")?
>>>
>>> Would it be possible for you to provide logs from the two "rbd export"
>>> runs on your smallest VM image?  If so, please add the following to
>>> the "[client]" section of your ceph.conf:
>>>
>>>    log file = /valid/path/to/logs/$name.$pid.log
>>>    debug rbd = 20
>>>
>>> I opened a ticket [1] where you can attach the logs (if they aren't
>>> too large).
>>>
>>> [1] http://tracker.ceph.com/issues/12422
>>
>> Will post some more details to the tracker in a few hours. It seems it
>> is related to using discard inside guest but not on the FS the osd is on.
>
> That sounds very odd. Could you verify via 'rados listwatchers' on an
> in-use rbd image's header object that there's still a watch established?

How can i do this exactly?

> Have you increased pgs in all those clusters recently?

Yes i bumped from 2048 to 4096 as i doubled the osds.

Stefan

> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
