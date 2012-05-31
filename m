From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Thu, 31 May 2012 07:35:17 -0700
Message-ID: <B8A0E20B-A551-43C8-9F95-605C7A511777@cs.ucsc.edu>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com> <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [128.114.48.32] ([128.114.48.32]:39048 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab2EaOiE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 10:38:04 -0400
In-Reply-To: <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nam Dang <namd@de.cs.titech.ac.jp>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On May 31, 2012, at 6:20 AM, Nam Dang wrote:

> It turned out my monitor went down without my knowing.
> So my bad, it wasn't because of Ceph.

I believe the segfault here is from client being null dereferenced in the c wrappers. Which patch set are you using?

> 
> Best regards,
> 
> Nam Dang
> Tokyo Institute of Technology
> Tokyo, Japan
> 
> 
> On Thu, May 31, 2012 at 10:08 PM, Nam Dang <namd@de.cs.titech.ac.jp> wrote:
>> Dear all,
>> 
>> I am running a small benchmark for Ceph with multithreading and cephfs-java API.
>> I encountered this issue even when I use only two threads, and I used
>> only open file and creating directory operations.
>> 
>> The piece of code is simply:
>> String parent = filePath.substring(0, filePath.lastIndexOf('/'));
>> mount.mkdirs(parent, 0755); // create parents if the path does not exist
>> int fileID = mount.open(filePath, CephConstants.O_CREAT, 0666); //
>> open the file
>> 
>> Each thread mounts its own ceph mounting point (using
>> mount.mount(null)) and I don't have any interlocking mechanism across
>> the threads at all.
>> It appears the error is SIGSEGV sent off by libcepfs. The message is as follows:
>> 
>> #
>> # A fatal error has been detected by the Java Runtime Environment:
>> #
>> #  SIGSEGV (0xb) at pc=0x00007ff6af978d39, pid=14063, tid=140697400411904
>> #
>> # JRE version: 6.0_26-b03
>> # Java VM: Java HotSpot(TM) 64-Bit Server VM (20.1-b02 mixed mode
>> linux-amd64 compressed oops)
>> # Problematic frame:
>> # C  [libcephfs.so.1+0x139d39]  Mutex::Lock(bool)+0x9
>> #
>> # An error report file with more information is saved as:
>> # /home/namd/cephBench/hs_err_pid14063.log
>> #
>> # If you would like to submit a bug report, please visit:
>> #   http://java.sun.com/webapps/bugreport/crash.jsp
>> # The crash happened outside the Java Virtual Machine in native code.
>> # See problematic frame for where to report the bug.
>> 
>> I have also attached the hs_err_pid14063.log for your reference.
>> An excerpt from the file:
>> 
>> Stack: [0x00007ff6aa828000,0x00007ff6aa929000],
>> sp=0x00007ff6aa9274f0,  free space=1021k
>> Native frames: (J=compiled Java code, j=interpreted, Vv=VM code, C=native code)
>> C  [libcephfs.so.1+0x139d39]  Mutex::Lock(bool)+0x9
>> 
>> Java frames: (J=compiled Java code, j=interpreted, Vv=VM code)
>> j  com.ceph.fs.CephMount.native_ceph_mkdirs(JLjava/lang/String;I)I+0
>> j  com.ceph.fs.CephMount.mkdirs(Ljava/lang/String;I)V+6
>> j  Benchmark$CreateFileStats.executeOp(IILjava/lang/String;Lcom/ceph/fs/CephMount;)J+37
>> j  Benchmark$StatsDaemon.benchmarkOne()V+22
>> j  Benchmark$StatsDaemon.run()V+26
>> v  ~StubRoutines::call_stub
>> 
>> So I think the probably may be due to the locking mechanism of ceph
>> internally. But Dr. Weil previously answered my email stating that the
>> mounting is done independently so multithreading should not lead to
>> this problem. If there is anyway to work around this, please let me
>> know.
>> 
>> Best regards,
>> 
>> Nam Dang
>> Email: namd@de.cs.titech.ac.jp
>> HP: (+81) 080-4465-1587
>> Yokota Lab, Dept. of Computer Science
>> Tokyo Institute of Technology
>> Tokyo, Japan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

