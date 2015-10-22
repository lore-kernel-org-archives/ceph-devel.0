From: Ronny Hegewald <ronny.hegewald@online.de>
Subject: Re: [PATCH] mark rbd requiring stable pages
Date: Thu, 22 Oct 2015 23:56:57 +0000
Message-ID: <201510222356.58184.ronny.hegewald@online.de>
References: <201510151850.48348.ronny.hegewald@online.de> <562860F2.8070208@cs.wisc.edu> <CAOi1vP_e1aY4zMyYgRLy=D+jBs44g9++0VKutRm7D6q0OALJ3Q@mail.gmail.com>
Reply-To: Ilya Dryomov <idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51164 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbJVXzy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 19:55:54 -0400
In-Reply-To: <CAOi1vP_e1aY4zMyYgRLy=D+jBs44g9++0VKutRm7D6q0OALJ3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On Thursday 22 October 2015, Ilya Dryomov wrote:
> Well, checksum mismatches are to be expected given what we are doing
> now, but I wouldn't expect any data corruptions.  Ronny writes that he
> saw frequent ext4 corruptions on krbd devices before he enabled stable
> pages, which leads me to believe that the !crc case, for which we won't
> be setting BDI_CAP_STABLE_WRITES, is going to be/remain broken.  Ronny,
> could you describe it in more detail and maybe share some of those osd
> logs with bad crc messages?
> 
This is from a 10 minute period from one of the OSDs. 

23:11:02.423728 ce5dfb70  0 bad crc in data 1657725429 != exp 496797267
23:11:37.586411 ce5dfb70  0 bad crc in data 1216602498 != exp 1888811161
23:12:07.805675 cc3ffb70  0 bad crc in data 3140625666 != exp 2614069504
23:12:44.485713 c96ffb70  0 bad crc in data 1712148977 != exp 3239079328
23:13:24.746217 ce5dfb70  0 bad crc in data 144620426 != exp 3156694286
23:13:52.792367 ce5dfb70  0 bad crc in data 4033880920 != exp 4159672481
23:14:22.958999 c96ffb70  0 bad crc in data 847688321 != exp 1551499144
23:16:35.015629 ce5dfb70  0 bad crc in data 2790209714 != exp 3779604715
23:17:48.482049 c96ffb70  0 bad crc in data 1563466764 != exp 528198494
23:19:28.925357 cc3ffb70  0 bad crc in data 1764275395 != exp 2075504274
23:19:59.039843 cc3ffb70  0 bad crc in data 2960172683 != exp 1215950691

The filesystem corruptions are usually ones with messages of

EXT4-fs error (device rbd4): ext4_mb_generate_buddy:757: group 155, block 
bitmap and bg descriptor inconsistent: 23625 vs 23660 free clusters

These were pretty common, at least every other day, often multiple times a 
day.

Sometimes there was a additional 

JBD2: Spotted dirty metadata buffer (dev = rbd4, blocknr = 0). There's a risk 
of filesystem corruption in case of system crash.

Another type of Filesystem corruption i experienced through kernel 
compilations, that lead to the following messages.

EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #282221) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #273062) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #272270) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #282254) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #273070) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #272308) - 
no `.' or `..'
EXT4-fs error (device rbd3): ext4_lookup:1417: inode #270033: comm rm: deleted 
inode referenced: 270039
last message repeated 2 times
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #271534) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #271275) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #282290) - 
no `.' or `..'
EXT4-fs warning (device rbd3): empty_dir:2488: bad directory (dir #281914) - 
no `.' or `..'
EXT4-fs error (device rbd3): ext4_lookup:1417: inode #270033: comm rm: deleted 
inode referenced: 270039
last message repeated 2 times
kernel: EXT4-fs error (device rbd3): ext4_lookup:1417: inode #273018: comm rm: 
deleted inode referenced: 282221
EXT4-fs error (device rbd3): ext4_lookup:1417: inode #273018: comm rm: deleted 
inode referenced: 282221
EXT4-fs error (device rbd3): ext4_lookup:1417: inode #273018: comm rm: deleted 
inode referenced: 281914
EXT4-fs error (device rbd3): ext4_lookup:1417: inode #273018: comm rm: deleted 
inode referenced: 281914
EXT4-fs error: 243 callbacks suppressed 
EXT4-fs error (device rbd3): ext4_lookup:1417: inode #282002: comm cp: deleted 
inode referenced: 45375
kernel: EXT4-fs error (device rbd3): ext4_lookup:1417: inode #282002: comm cp: 
deleted inode referenced: 45371

The result was that various files and directories in the kernel sourcedir 
couldn't be accessed anymore and even fsck couldn't repair it, so i had to 
finally delete it. But these ones were pretty rare.

Another issue were the data-corruptions in the files itself, that happened 
independently from the filesystem-corruptions.  These happened on most days, 
sometimes only once, sometimes multiple times a day. 

Newly written files that contained corrupted data seem to always have it only 
at one place. These corrupt data replaced the original data from the file, but 
never changed the file-size. The position of this corruptions in the files 
were always different.

Interesting part is that this corrupted parts always followed the same 
pattern. First some few hundred 0x0 bytes, then a few kb (10-30) of random 
binary data, that finished again with a few hundred bytes of 0x0.

In a few cases i could trace this data back to origin from another file that 
was read at the same time from the same programm. But that might be 
accidentially, because other corruptions that happened in the same scenario I 
couldn't trace back this way.

In other cases that corrupt data originated from files that were deleted 
recently (a few minutes ago).

