From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Wed, 16 Jan 2013 18:06:46 +0100
Message-ID: <49E5320E-C2D4-4B80-A3E7-914F73E487D4@widodh.nl>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com> <CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com> <CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com> <CAPYLRzje19sAjtyRq8PX2zV0=GHpnzWdqOMk04UVUaRn2T7TOg@mail.gmail.com> <CA+-7kDCODuG-mWXEHv_QFdo1Guow55dd55+yPz85hKN+5rU1Gw@mail.gmail.com> <CAPYLRzhu1Tdj_MQnVJOQj6rFpVGDyiokx9k-ysb+jpbh_3F9wA@mail.gmail.com> <CA+-7kDBDWCv=dZN1Avc+BqLfxz5KKGNMHOjZvq5D7SnM6RSjvA@mail.gmail.com> <CA+-7kDCLhNx3QQ3OUGxrKT6VJszyPuPdgceA8C-pqYZRBqKkZQ@mail.gmail.com> <50F686A2.2060901@widodh.nl> <alpine.DEB.2.00.1301160859010.15921@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51053 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab3APRGs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 12:06:48 -0500
In-Reply-To: <alpine.DEB.2.00.1301160859010.15921@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Marcin Szukala <szukala.marcin@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>





Op 16 jan. 2013 om 18:00 heeft Sage Weil <sage@inktank.com> het volgende geschreven:

> On Wed, 16 Jan 2013, Wido den Hollander wrote:
>> 
>> On 01/16/2013 11:50 AM, Marcin Szukala wrote:
>>> Hi all,
>>> 
>>> Any ideas how can I resolve my issue? Or where the problem is?
>>> 
>>> Let me describe the issue.
>>> Host boots up and maps RBD image with XFS filesystems
>>> Host mounts the filesystems from the RBD image
>>> Host starts to write data to the mounted filesystems
>>> Host experiences power failure
>>> Host comes up and map the RBD image
>>> Host mounts the filesystems from the RBD image
>>> All data from all filesystems is lost
>>> Host is able to use the filesystems with no problems.
>>> 
>>> Filesystem is XFS, no errors on filesystem,
>> 
>> That simply does not make sense to me. How can all data be gone and the FS
>> just mount cleanly.
>> 
>> Can you try to format the RBD with EXT4 and see if that makes any difference.
>> 
>> Could you also try to run a "sync" prior to pulling the power from the host to
>> see if that makes any difference.
> 
> A few other quick questions:
> 
> What version of qemu and librbd are you using?  What is the command line 
> that is used to start the VM?  This could be a problem with the qemu 
> and librbd caching configuration.
> 

I don't think he uses Qemu. From what I understand he uses kernel RBD since he uses the words 'map' and 'unmap'

Wido

> Thanks!
> sage
> 
> 
>> 
>> Wido
>> 
>>> Kernel 3.5.0-19-generic
>>> 
>>> root@openstack-1:/etc/init# ceph -s
>>>    health HEALTH_OK
>>>    monmap e1: 3 mons at
>>> {a=10.3.82.102:6789/0,b=10.3.82.103:6789/0,d=10.3.82.105:6789/0},
>>> election epoch 10, quorum 0,1,2 a,b,d
>>>    osdmap e132: 56 osds: 56 up, 56 in
>>>     pgmap v87165: 13744 pgs: 13744 active+clean; 52727 MB data, 102 GB
>>> used, 52028 GB / 52131 GB avail
>>>    mdsmap e1: 0/0/1 up
>>> 
>>> Regards,
>>> Marcin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
