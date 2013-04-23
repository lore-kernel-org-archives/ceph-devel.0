From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Tue, 23 Apr 2013 16:56:02 +0200
Message-ID: <E6E1667B-879F-4BF4-85DE-308C01BB7930@openminds.be>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com> <51704AF4.7060908@42on.com> <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com> <67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be> <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:51840 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab3DWO4J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Apr 2013 10:56:09 -0400
In-Reply-To: <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>

Hi,

I've quickly tested this, and its works correctly on  a small setup: 
- cluster: 3 machines, 9 osds as cluster, a very old ceph release (was a testsetup i had laying around) 
- client host dom0: debian wheezy 3.2 kernel, xen 4.1 from debian, blktap dkms from debian
- client dom0: a simple quick debootstrap, and a low amount of memory to bypass buffers
- all wired together through a simple gig network, nothing fancy
- no tuning at all at any level
- compiled as indicated below

Some quick stupid benches below:

Bonnie (ext3)

Version  1.96       ------Sequential Output------ --Sequential Input- --Random-
Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
rbdtest        300M   274  98 17452   4  8081   1   727  99 94701   9 649.7   8
Latency             68696us    3419ms    1712ms   12597us   14505us     823ms
Version  1.96       ------Sequential Create------ --------Random Create--------
rbdtest             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 20866  40 +++++ +++ 25937  34 18965  36 +++++ +++ 19078  25
Latency             17850us     661us     670us   15308us      23us      73us
1.96,1.96,rbdtest,1,1366725798,300M,,274,98,17452,4,8081,1,727,99,94701,9,649.7,8,16,,,,,20866,40,+++++,+++,25937,34,18965,36,+++++,+++,19078,25,68696us,3419ms,1712ms,12597us,14505us,823ms,17850us,661us,670us,15308us,23us,73us

Iozone (snippet, this is about the performance I get at the other sizes also, except read performance seems to drop after a while)

                                                            random  random    bkwd   record   stride                                   
              KB  reclen   write rewrite    read    reread    read   write    read  rewrite     read   fwrite frewrite   fread  freread
           65536      64   40598    9072    44273    83811   45508   35023   68808  3334003   130052    51170    14997   43470    81707
           65536     128   37153   13131    86507    92858   84661   41665   16636  3588446   116051    27582    39906   35435    57426
           65536     256   24175   45743    18685    97440  144667   39326   27777  3442738   200095    47460    21743   79367   107165
           65536     512   42953   28775    95780    54974  215821   36543   32774  3413877   343260    40613    20087  980947  2697292
           65536    1024   43360   47328  1709920  5051713 5042816   38018   88782  3489856  5024565    47151    45020 5036533  5114787
           65536    2048   13168   39873  4982578  5113550 5100456   28686 4993258  3109063  5024565    14277    50709 4971224  5085452
           65536    4096   12283   19615   299031  4403132 4444640   30234 4400735  2835581  4998524    53654    48808 4359487  4431741
           65536    8192   51552   12918  3921516  3938033 3951790   51662 3914925  2413309  3919335    58271    41831 3910525  3942947
           65536   16384   46308   10670  3955601  3976199 3959418   32890 3945608    19116  3829833    67583    45037 3916152  3874477

Thx for the work you've put in this! Seems to work nicely at first glance, but I'll do some more tests later on (with a more recent ceph cluster)... 

Rgds,
Bernard
Openminds 

On 23 Apr 2013, at 12:02, Sylvain Munaut <s.munaut@whatever-company.com> wrote:

> Hi,
> 
>> We can test this, but just a couple of lines of input might be needed to get us going with this without digging through all the code.
> 
> Ok, so I added proper argument parsing (using the same format as the
> qemu rbd driver) now, so it's easier to test.
> 
> First off, you need a working blktap setup for your distribution.
> So for example, you should be able to use
> "tap2:tapdisk:aio:/path/to/image.raw"  as a vbd.
> 
> Starting for there you need to :
> 
> - Download and compile the rbd branch of git://github.com/smunaut/blktap.git
>   You will need the ceph development files/packages for this ( for
> debian librados-dev librbd-dev )
> 
> $ git clone git://github.com/smunaut/blktap.git
> $ cd blktap
> $ git checkout -b rbd origin/rbd
> $ ./autogen.sh
> $ ./configure
> $ make
> 
> - Replace the installed tapdisk binary with the new one
> 
> $ sudo cp ./drivers/.libs/tapdisk  /usr/bin/tapdisk
> 
> - Add 'rbd' as supported format in 'xm'
>   For some reason 'xm' checks the image format itself before handing
> off to the tap-ctl ...
> 
>   Edit /usr/lib/xen-4.1/lib/python/xen/xend/server/BlktapController.py
> and add 'rbd' in the blktap2_disk_types list at the top.
>   (location of file will vary depending on xen version and distribution)
> 
> - Setup a proper /etc/ceph/ceph.conf containing at least the mon addresses
>   Also make sure you have a /etc/ceph/keyring with the user key if
> you use cephx
> 
> Once that's done, you should be able to attach disk to a running VM using :
> 
> $ xm block-attach test_vm tap2:tapdisk:rbd:rbd/test xvda2 w
> 
> "rbd/test" above is the pool_name/image_name
> You can add the same options as with the qemu driver.
> 
> 
> Cheers,
> 
>    Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

