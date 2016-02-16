From: David Casier <david.casier@aevoo.fr>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Tue, 16 Feb 2016 09:39:28 +0100
Message-ID: <CA+gn+zmCx_Pu6oEUT31SfKRF1A9Pzi1aWTPbXJY7dOgQqCqARQ@mail.gmail.com>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
	<alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
	<CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
	<CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
	<alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
	<5661F3A9.8070703@redhat.com>
	<20151208044640.GL1983@devil.localdomain>
	<CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
	<20160216033538.GB2005@devil.localdomain>
	<CA+gn+z=dGTeLo71h=z=AvoLM-RRq_-RfbJwFamyfxK93bvk+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36522 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcBPIja (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 03:39:30 -0500
Received: by mail-wm0-f47.google.com with SMTP id g62so94071457wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Feb 2016 00:39:29 -0800 (PST)
In-Reply-To: <CA+gn+z=dGTeLo71h=z=AvoLM-RRq_-RfbJwFamyfxK93bvk+Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Chinner <dchinner@redhat.com>
Cc: Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>, Eric Sandeen <esandeen@redhat.com>, =?UTF-8?Q?Beno=C3=AEt_LORIOT?= <benoit.loriot@aevoo.fr>

        "With this model, filestore rearrange the tree very
        frequently : + 40 I/O every 32 objects link/unlink."
It is the consequence of parameters :
filestore_merge_threshold = 2
filestore_split_multiple = 1

Not of ext4 customization.

The large amount of objects in FileStore require indirect access and
more IOPS for every directory.

If root of inode B+tree is a simple block, we have the same problem with XFS

2016-02-16 9:14 GMT+01:00 David Casier <david.casier@aevoo.fr>:
> Hi,
> All inodes, xattrs and extent are stored at the beginning of the disk
> with inode32 XFS ?
>
> 2016-02-16 4:35 GMT+01:00 Dave Chinner <dchinner@redhat.com>:
>> On Mon, Feb 15, 2016 at 04:18:28PM +0100, David Casier wrote:
>>> Hi Dave,
>>> 1TB is very wide for SSD.
>>
>> It fills from the bottom, so you don't need 1TB to make it work
>> in a similar manner to the ext4 hack being described.
>>
>>> Exemple with only 10GiB :
>>> https://www.aevoo.fr/2016/02/14/ceph-ext4-optimisation-for-filestore/
>>
>> It's a nice toy, but it's not something that is going scale reliably
>> for production.  That caveat at the end:
>>
>>         "With this model, filestore rearrange the tree very
>>         frequently : + 40 I/O every 32 objects link/unlink."
>>
>> Indicates how bad the IO patterns will be when modifying the
>> directory structure, and says to me that it's not a useful
>> optimisation at all when you might be creating several thousand
>> files/s on a filesystem. That will end up IO bound, SSD or not.
>>
>> Cheers,
>>
>> Dave.
>> --
>> Dave Chinner
>> dchinner@redhat.com
>
>
>
> --
>
> ________________________________________________________
>
> Cordialement,
>
> David CASIER
>
>
> 3B Rue Taylor, CS20004
> 75481 PARIS Cedex 10 Paris
>
> Ligne directe: 01 75 98 53 85
> Email: david.casier@aevoo.fr
> ________________________________________________________



-- 

________________________________________________________

Cordialement,

David CASIER


3B Rue Taylor, CS20004
75481 PARIS Cedex 10 Paris

Ligne directe: 01 75 98 53 85
Email: david.casier@aevoo.fr
________________________________________________________
