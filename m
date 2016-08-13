From: Alex Elder <elder@ieee.org>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Sat, 13 Aug 2016 10:18:50 -0500
Message-ID: <847a97cf-04b3-9f29-2884-5c757727b3a2@ieee.org>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
 <CAOi1vP_5gtQXd95M=qspgPeRnTDvxBpC2dknARNv=HXNFKHivQ@mail.gmail.com>
 <4257DB75-0060-4867-A5D5-2AD374722452@Teradata.com>
 <CAOi1vP9mdNYRCD_cTa0=4tN71L1=tA24wXSr2NqhTH9BmUBAuw@mail.gmail.com>
 <82369305-99D9-464E-B14A-D2E91AC7B76F@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36442 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbcHMPSx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Aug 2016 11:18:53 -0400
Received: by mail-io0-f176.google.com with SMTP id b62so48784005iod.3
        for <ceph-devel@vger.kernel.org>; Sat, 13 Aug 2016 08:18:52 -0700 (PDT)
In-Reply-To: <82369305-99D9-464E-B14A-D2E91AC7B76F@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Jason Dillaman <dillaman@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>

On 08/12/2016 01:40 PM, Kamble, Nitin A wrote:
>> It would make this a lot easier if we started generating a unique UUID
>> >>> for the image and each snapshot at image/snapshot creation time.  Jason?
>> >>> 
>>> 
>>> Image UUID seems like the right direction.

Yes.  It's not a snapshot you want, but the basic image, regardless
of the state of its content.  It needs to be created at image
creation time, and no matter how many times the image grows or
shrinks, or how the cluster gets reorganized along the way, that
UUID uniquely defines the image (and it ought not to be possible,
as a rule, to *change* an image's UUID).  Coping an entire image
(or cloning) would require a new UUID (as has been said).

I think the UUID should be defined independent of the cluster as
well.  In that case, there may be a reason to think about a "move"
operation, where it an image is transferred to a new cluster, with
the new one retaining the original UUID and the old one going away.

					-Alex
