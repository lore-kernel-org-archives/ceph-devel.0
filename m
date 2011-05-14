From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: rbd
Date: Sat, 14 May 2011 15:36:02 +0300
Message-ID: <4DCE7732.1060006@ufm.su>
References: <201105121353.44166.ufm@ufm.su>	<Pine.LNX.4.64.1105120833410.19492@cobra.newdream.net>	<Pine.LNX.4.64.1105121001160.19492@cobra.newdream.net>	<Pine.LNX.4.64.1105130850400.12286@cobra.newdream.net> <Pine.LNX.4.64.1105131208450.12286@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:43758 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757168Ab1ENMgI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 14 May 2011 08:36:08 -0400
In-Reply-To: <Pine.LNX.4.64.1105131208450.12286@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/13/2011 10:11 PM, Sage Weil wrote:
> Fyodor,
>
> On Fri, 13 May 2011, Sage Weil wrote:
>> On Thu, 12 May 2011, Sage Weil wrote:
>>> On Thu, 12 May 2011, Sage Weil wrote:
>>>> equation.  I'm running iozone on ext3 now and not having any problems.
>>> I take it back.. I just reproduced a similar error on ext2:
>>>
>>>                                                              random  random
>>> bkwd   record   stride
>>>                KB  reclen   write rewrite    read    reread    read   write
>>> read  rewrite     read   fwrite frewrite   fread  freread
>>>           4194304      64    3570    3040    12640    13725
>>>
>>> Error in file: Found ?aaaaaaaaaaaaaaaa? Expecting ?3838383838383838? addr
>>> 40a00000
>>> Error in file: Position 2813329408
>>> Record # 42928 Record size 64 kb
>>> where 40a00000 loop 0
>>>
>>> I opened a tracker issue http://tracker.newdream.net/issues/1086
>> Just an update: we've identified the problem but a fix is still in the
>> works.  The bio coming down is spanning an object boundary, and we're
>> having trouble getting the block layer to either not do that or to handle
>> the bio splitting properly.
> Can you try the req_coll branch of
> git://ceph.newdream.net/git/ceph-client.git and see if that fixes things
> for you?  There's a memory leak fix and a fix for the split bio completion
> stuff.  If it checks out I want to send this to Linus quickly so it'll be
> included in 2.6.39 (which is imminent).
root@stb1:~# uname -a
Linux stb1 2.6.39-rc7-ufm-ceph #1 SMP Sat May 14 13:50:12 EEST 2011 
x86_64 x86_64 x86_64 GNU/Linux
root@stb1:~# modprobe rbd
root@stb1:~# echo "77.120.112.193 name=admin rbd tmt" > /sys/bus/rbd/add
root@stb1:~# mkfs.ocfs2 -M local -T vmstore --fs-features=local,sparse 
/dev/rbd0
mkfs.ocfs2 1.6.3
Overwriting existing ocfs2 partition.
Proceed (y/N): y
Filesystem Type of vmstore
Label:
Features: local sparse backup-super unwritten inline-data 
strict-journal-super xattr refcount
Block size: 4096 (12 bits)
Cluster size: 1048576 (20 bits)
Volume size: 1073741824000 (1024000 clusters) (262144000 blocks)
Cluster groups: 32 (tail covers 24064 clusters, rest cover 32256 clusters)
Extent allocator size: 3221225472 (768 groups)
Journal size: 134217728
Node slots: 1
Creating bitmaps: done
Initializing superblock: done
Writing system files: done
Writing superblock: done
Writing backup superblock: 5 block(s)
Formatting Journals: done
Growing extent allocator: done
Formatting slot map: done
Formatting quota files: done
Writing lost+found: done
mkfs.ocfs2 successful

root@stb1:~# mount /dev/rbd0 /mnt
root@stb1:~# cd /mnt
root@stb1:/mnt# iozone -a -n4g -g20g
         Iozone: Performance Test of File I/O
                 Version $Revision: 3.373 $
                 Compiled for 64 bit mode.
                 Build: linux-AMD64

         Contributors:William Norcott, Don Capps, Isom Crawford, Kirby 
Collins
                      Al Slater, Scott Rhine, Mike Wisner, Ken Goss
                      Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
                      Randy Dunlap, Mark Montague, Dan Million, Gavin 
Brebner,
                      Jean-Marc Zucconi, Jeff Blomberg, Benny Halevy, 
Dave Boone,
                      Erik Habbinga, Kris Strecker, Walter Wong, Joshua 
Root,
                      Fabrice Bacchella, Zhenghua Xue, Qin Li, Darren 
Sawyer.

         Run began: Sat May 14 14:39:03 2011

         Auto Mode
         Using minimum file size of 4194304 kilobytes.
         Using maximum file size of 20971520 kilobytes.
         Command line used: iozone -a -n4g -g20g
         Output is in Kbytes/sec
         Time Resolution = 0.000001 seconds.
         Processor cache size set to 1024 Kbytes.
         Processor cache line size set to 32 bytes.
         File stride size set to 17 * record size.
                                                             random  
random    bkwd   record   stride
               KB  reclen   write rewrite    read    reread    read   
write    read  rewrite     read   fwrite frewrite   fread  freread
          4194304      64  134566  135254    53718    52836   14839   78946

And now it is 20 minutes in this state.In the logs clean. Incoming 
network traffic- 3Mbytes/s
But, we newer see this test before, likely an extremely low speed test 
"bkwd read" this is another problem.

As you can see - trouble with "Error in file" solved. :)

WBR,
     Fyodor.

