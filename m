From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: Attempt to create a new file in a snapshot crashes the MDS
Date: Fri, 09 Jul 2010 21:38:55 +0200
Message-ID: <1278704335.2253.48.camel@wido-laptop.pcextreme.nl>
References: <87wrt4fok9.wl%aemerson@linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:34910 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0GITi6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 15:38:58 -0400
In-Reply-To: <87wrt4fok9.wl%aemerson@linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@linuxbox.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hi Adam,

Could you add "debug mds = 20" in your ceph.conf and retry?

There should also be a file "core" in /, this is a dump which you can
use to make a backtrace with gdb (if you have the debug symbols).

gdb /usr/bin/cmds /core
gdb> bt

Could you try this?

-- 
Met vriendelijke groet,

Wido den Hollander
CTO
Contact: http://www.pcextreme.nl/contact


On Fri, 2010-07-09 at 19:22 +0000, Adam C. Emerson wrote:
> I know it's not supported, but I tried it out to see what kind of
> error behaviour I would get.
> 
> The following were preformed on a simple ceph filesystem (one monitor,
> one mds, one osd all on the same machine) running current unstable
> with the filesystem mounted via cfuse:
> 
> /mnt# mkdir foo
> /mnt# cd foo
> /mnt/foo# cat > something
> These are the contents of the file.
> /mnt/foo# cd .snap
> /mnt/foo/.snap# mkdir old
> /mnt/foo/.snap# cd ..
> /mnt/foo# cat > something
> These are different contents of the file.
> /mnt/foo# cd .snap
> /mnt/foo/.snap# ls
> old/
> /mnt/foo/.snap# cd old 
> root@seasalt:/mnt/foo/.snap/old# ls
> something
> /mnt/foo/.snap/old# cat something 
> These are the contents of the file.
> /mnt/foo/.snap/old# cat > something
> zsh: invalid argument: something
> /mnt/foo/.snap/old# cat > somthingelse
> These are divergent contents.
> 
> This last command hangs, and in the MDS log I find:
> mds/CDir.cc: In function 'CDentry* CDir::add_null_dentry(const std::string&, snapid_t, snapid_t)':
> mds/CDir.cc:225: FAILED assert(lookup_exact_snap(dname, last) == 0)
> 
> Thank you very much.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

