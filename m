From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: upstream/firefly exporting the same snap 2 times results in different
 exports
Date: Tue, 21 Jul 2015 12:46:02 -0700
Message-ID: <55AEA17A.8040901@redhat.com>
References: <55AE3B3A.2040902@profihost.ag> <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com> <55AE798F.1010206@profihost.ag> <1828157940.1473499.1437499191528.JavaMail.zimbra@redhat.com> <55AE9BD9.6010801@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36849 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbbGUTp5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jul 2015 15:45:57 -0400
In-Reply-To: <55AE9BD9.6010801@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>, Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 07/21/2015 12:22 PM, Stefan Priebe wrote:
>
> Am 21.07.2015 um 19:19 schrieb Jason Dillaman:
>> Does this still occur if you export the images to the console (i.e.
>> "rbd export cephstor/disk-116@snap - > dump_file")?
>>
>> Would it be possible for you to provide logs from the two "rbd export"
>> runs on your smallest VM image?  If so, please add the following to
>> the "[client]" section of your ceph.conf:
>>
>>    log file = /valid/path/to/logs/$name.$pid.log
>>    debug rbd = 20
>>
>> I opened a ticket [1] where you can attach the logs (if they aren't
>> too large).
>>
>> [1] http://tracker.ceph.com/issues/12422
>
> Will post some more details to the tracker in a few hours. It seems it
> is related to using discard inside guest but not on the FS the osd is on.

That sounds very odd. Could you verify via 'rados listwatchers' on an
in-use rbd image's header object that there's still a watch established?

Have you increased pgs in all those clusters recently?

Josh
